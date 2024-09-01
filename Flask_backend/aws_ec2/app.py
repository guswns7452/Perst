# EC2 배포용 test 2
import os.path

from http import HTTPStatus
from flask import Flask, make_response, request
import json

from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.http import MediaIoBaseDownload
from module_import_example import machineLearning

PATH =  os.getcwd()

# If modifying these scopes, delete the file token.json.
SCOPES = ["https://www.googleapis.com/auth/drive"]

app = Flask(__name__)

# [1] 분석) 사진을 전송 받음.
## 프론트(요청) -> 스프링(요청) -> 머신러닝
### 요청 : 사진(구글 드라이브) / 키, 몸무게 
### 응답 : 스타일 / 추출 색상

##
# 구글 드라이브에서 이미지를 다운로드하는 코드
#
def DownloadByGoogleDrive(fileID):
    creds = service_account.Credentials.from_service_account_file(PATH+"/credentials_service.json")

    try:
        # Google 드라이브 API 빌드
        drive_service = build('drive', 'v3', credentials=creds)

        # 파일 다운로드
        request = drive_service.files().get_media(fileId=fileID)
        local_file_path = os.path.join(PATH+"/../Models/", f"{fileID}.jpg")
        with open(local_file_path, "wb") as fh:
            downloader = MediaIoBaseDownload(fh, request)
            done = False
            while not done:
                status, done = downloader.next_chunk()
                if status:
                    print("Download %d%%." % int(status.progress() * 100))
        print("이미지 다운로드가 완료되었습니다.")
        return local_file_path
    except Exception as e:
        print("이미지 다운로드 중 오류가 발생했습니다:", str(e))
        return None
## 
# 이미지 분석 후 jpg 파일을 삭제하는 코드
#
def delete_jpg_files(folder_path):
    files = os.listdir(folder_path)
    # .jpg 파일 삭제
    for file_name in files:
        if file_name.lower().endswith('.jpg'):
            file_path = os.path.join(folder_path, file_name)
            os.remove(file_path)
            print(f"{file_path} 삭제되었습니다.")

@app.route('/style/analyze', methods=['POST'])
def analyzeAPI():
    fileID = request.json['fileID'] # api 호출 시 반환 하는 값
    gender = request.json['gender']
    print(fileID)
    
    try:
        DownloadByGoogleDrive(fileID)
        output = machineLearning(fileID, gender)
        
        colors = []
        
        # 컬러 리스트 출력
        for color in output['total_color_list']:
            r = color[0][0]
            g = color[0][1]
            b = color[0][2]
            ratio = color[1]
            
            colors.append([r,g,b,ratio])
        
        # 현재 사진 데이터 하나라고 가정.
        message = "고객님의 사진을 분석하였습니다!"
        data = {"code": HTTPStatus.OK.value, "httpStatus": "OK", "message":message, "data":{"fashionType" : output['fashion_type'], "color1": str(colors[0]), "color2": str(colors[1]), "color3": str(colors[2]), "color4": str(colors[3]), "personalColorType": output['personal_color_label']}} # 이름의 필요성 없음. , "name": items[0]['name']
    
    #except FileNotFoundError:
    #    data = {"code": HTTPStatus.NOT_FOUND.value, "httpStatus": "Not Found", "message": "구글 드라이브에 일치하는 파일이 없습니다."}
    
    except ConnectionError:
        data = {"code": HTTPStatus.INTERNAL_SERVER_ERROR.value, "httpStatus": "Internal Server Error", "message":"[오류] 구글 드라이브 API 문제가 발생했습니다."}
    
    # 한글 인코딩 
    result = json.dumps(data, ensure_ascii=False) 
    res = make_response(result)
    res.headers['Content-Type'] = 'application/json'
    
    # 분석 한 후에 데이터 삭제함
    # delete_jpg_files(PATH+"/../Models")
    
    return res

if __name__ == '__main__':
    app.config['JSON_AS_ASCII'] = False
    # app.run()
    app.run(host='0.0.0.0') 
