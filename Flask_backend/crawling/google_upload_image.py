import requests
from bs4 import BeautifulSoup
import os

import google.auth
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from googleapiclient.http import MediaFileUpload

# token 불러오기가 잘 되지 않아 PATH 설정
PATH =  os.getcwd()

SCOPES = ["https://www.googleapis.com/auth/drive"]

def upload_basic(file_name, img_path, gender, index, height, weight, season, style):
    """Insert new file.
    Returns : Id's of the file uploaded

    Load pre-authorized user credentials from the environment.
    TODO(developer) - See https://developers.google.com/identity
    for guides on implementing OAuth2 for the application.
    """
    
    if os.path.exists(PATH+"/token.json"):
        creds = Credentials.from_authorized_user_file(PATH+"/token.json", SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(PATH+"/credentials.json", SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open(PATH+"/token.json", "w") as token:
            token.write(creds.to_json())
            
    try:
        # create drive api client
        service = build("drive", "v3", credentials=creds)
        
        folder_id = "1Ga3D6y5MtjDslvBEm0WgZBFCNtT-3om7"

        file_metadata = {"name": file_name, "parents": [folder_id], "gender": gender, "index": index, "height": height, "weight": weight, "season": season, "style": style}
        media = MediaFileUpload(img_path, mimetype="image/jpg")
        file = (
            service.files()
            .create(body=file_metadata, media_body=media, fields="id")
            .execute()
        )
        print(f'File ID: {file.get("id")}')

    except HttpError as error:
        print(f"An error occurred: {error}")
        file = None

    return file.get("id")

## query 검색 잘됨. 
def googleDrive():
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists(PATH+"/token.json"):
        creds = Credentials.from_authorized_user_file(PATH+"/token.json", SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(PATH+"/credentials.json", SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open(PATH+"/token.json", "w") as token:
            token.write(creds.to_json())

    try:
        service = build("drive", "v3", credentials=creds)

        # Call the Drive v3 API
        results = (
            service.files()
            .list(q="parents in '10neLNimYRBdqqEDqH9-aN8c3KK5gcXa5'", pageSize=1000, fields="nextPageToken, files(id, name)")
            .execute()
        )
        
        ##
        # 1000개 이상의 데이터가 있는 경우
        #
        items = results.get('files', [])
        next_page_token = results.get('nextPageToken')

        # 다음 페이지가 있는 경우 추가 페이지 요청
        while next_page_token:
            results = service.files().list(q="parents in '10neLNimYRBdqqEDqH9-aN8c3KK5gcXa5'", pageSize=1000, pageToken=next_page_token).execute()
            items.extend(results.get('files', []))
            next_page_token = results.get('nextPageToken')

        if not items:
            raise FileNotFoundError("일치하는 파일이 없습니다.")
        print("Files:")
        count = 0
        
        for item in items:
            count += 1
            print(f"{count}: {item['name']} ({item['id']}) ")
            # DownloadByGoogleDrive(filename=item['name'], file_id=item['id'])
    except HttpError as error:
        # TODO(developer) - Handle errors from drive API.
        raise ConnectionError("구글 드라이브 API 문제입니다.")
    return items


googleDrive()
# upload_basic("woman_39331_165_47_겨울_걸리시.jpg",os.path.join("../images/woman/걸리시", "woman_39331_165_47_겨울_걸리시.jpg"),"woman","39331","165","47","겨울","걸리시")