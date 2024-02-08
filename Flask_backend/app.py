import os.path

from http import HTTPStatus
from flask import Flask, make_response, request
import json

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

import io
import google.auth
from googleapiclient.http import MediaIoBaseDownload

# If modifying these scopes, delete the file token.json.
SCOPES = ["https://www.googleapis.com/auth/drive.metadata.readonly"]


app = Flask(__name__)

# [1] 분석) 사진을 전송 받음.
## 프론트(요청) -> 스프링(요청) -> 머신러닝
### 요청 : 사진(구글 드라이브) / 키, 몸무게 
### 응답 : 스타일 / 추출 색상

def googleDrive(filename):
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists("token.json"):
        creds = Credentials.from_authorized_user_file("token.json", SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file("credentials.json", SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open("token.json", "w") as token:
            token.write(creds.to_json())

    try:
        service = build("drive", "v3", credentials=creds)

        # Call the Drive v3 API
        results = (
            service.files()
            .list(q="'1grTkjdWs_2lvZp-EyepMoaoi74PHAEfd' in parents and trashed=false and name = '"+filename+"'" ,pageSize=10, fields="nextPageToken, files(id, name)")
            .execute()
        )
        items = results.get("files", [])

        if not items:
            raise FileNotFoundError("일치하는 파일이 없습니다.")
        print("Files:")
        for item in items:
            DownloadByGoogleDrive(file_id=item['id'])
            print(f"{item['name']} ({item['id']})")
    except HttpError as error:
        # TODO(developer) - Handle errors from drive API.
        raise ConnectionError("구글 드라이브 API 문제입니다.")
    return items

def DownloadByGoogleDrive(file_id):
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists("token.json"):
        creds = Credentials.from_authorized_user_file("token.json", SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file("credentials.json", SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open("token.json", "w") as token:
            token.write(creds.to_json())

    try:
    # create drive api client
        service = build("drive", "v3", credentials=creds)

        # pylint: disable=maybe-no-member
        request = service.files().get_media(fileId=file_id)
        file = io.BytesIO()
        downloader = MediaIoBaseDownload(file, request)
        done = False
        while done is False:
            status, done = downloader.next_chunk()
            print(f"Download {int(status.progress() * 100)}.")

    except HttpError as error:
        print(f"An error occurred: {error}")
        file = None

    return file.getvalue()


@app.route('/style/analyze', methods=['POST'])
def analyzeAPI():
    filename = request.json['filename'] # api 호출 시 반환 하는 값
    print(filename)
    
    ## TODO 스타일 분석 머신러닝 파트 추가 ##
    
    try:
        items = googleDrive(filename)
        # 현재 사진 데이터 하나라고 가정.
        message = "정상적임"
        data = {"code": HTTPStatus.OK.value, "httpStatus": "OK", "message":message, "data":{"styleFileId" : items[0]['id']}} # 이름의 필요성 없음. , "name": items[0]['name']
    
    except FileNotFoundError:
        data = {"code": HTTPStatus.NOT_FOUND.value, "httpStatus": "Not Found", "message": "구글 드라이브에 일치하는 파일이 없습니다."}
    
    except ConnectionError:
        data = {"code": HTTPStatus.INTERNAL_SERVER_ERROR.value, "httpStatus": "Internal Server Error", "message":"[오류] 구글 드라이브 API 문제가 발생했습니다."}
    
    
    # 한글 인코딩 
    result = json.dumps(data, ensure_ascii=False) 
    res = make_response(result)
    res.headers['Content-Type'] = 'application/json'
    
    return res


if __name__ == '__main__':
    app.config['JSON_AS_ASCII'] = False
    app.run()
