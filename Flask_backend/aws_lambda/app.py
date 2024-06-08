# CI/CD TEST4 : 환경 변수 오류 설정
import os.path

from http import HTTPStatus
import boto3,json

from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.http import MediaIoBaseDownload

from googleapiclient.http import MediaIoBaseDownload

from module_import_example import machineLearning

PATH = '/tmp/Models/'

# If modifying these scopes, delete the file token.json.
SCOPES = ["https://www.googleapis.com/auth/drive"]


# [1] 분석) 사진을 전송 받음.
## 프론트(요청) -> 스프링(요청) -> 머신러닝
### 요청 : 사진(구글 드라이브) / 키, 몸무게 
### 응답 : 스타일 / 추출 색상

##
# 구글 드라이브에서 이미지를 다운로드하는 코드
#
def DownloadByGoogleDrive(fileID):
    creds = service_account.Credentials.from_service_account_file("/tmp/credentials_service.json")

    try:
        # Google 드라이브 API 빌드
        drive_service = build('drive', 'v3', credentials=creds)

        # 파일 다운로드
        request = drive_service.files().get_media(fileId=fileID)
        local_file_path = os.path.join(PATH, f"{fileID}.jpg")
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

def analyzeAPI(id, gen):
    fileID = id # api 호출 시 반환 하는 값
    gender = gen
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
        
        print(output)
        
        # 현재 사진 데이터 하나라고 가정.
        message = "고객님의 사진을 분석하였습니다!"
        data = {"code": HTTPStatus.OK.value, "httpStatus": "OK", "message":message, "data":{"fashionType" : output['fashion_type'], "color1": str(colors[0]), "color2": str(colors[1]), "color3": str(colors[2]), "color4": str(colors[3]), "personalColorType": output['personal_color_label']}} # 이름의 필요성 없음. , "name": items[0]['name']
    
    # except FileNotFoundError:
    #    data = {"code": HTTPStatus.NOT_FOUND.value, "httpStatus": "Not Found", "message": "구글 드라이브에 일치하는 파일이 없습니다."}
    
    except ConnectionError:
        data = {"code": HTTPStatus.INTERNAL_SERVER_ERROR.value, "httpStatus": "Internal Server Error", "message":"[오류] 구글 드라이브 API 문제가 발생했습니다."}
    
    # 분석 한 후에 데이터 삭제함
    delete_jpg_files(PATH)
    
    return data

def downloadDefaultSetting(s3):
    bucket_name = os.getenv("bucket_name")
    
    # Model들 저장할 폴더 생성
    download_path = '/tmp/Models/'
    os.makedirs(download_path, exist_ok=True)
    
    # 4개의 모델 /tmp 폴더에 다운로드
    for i in range(4):
        folder_name = os.getenv("model_"+str(i))
        local_file_path = '/tmp/Models/' + folder_name + '/'
        os.makedirs(local_file_path, exist_ok=True)
        os.makedirs(local_file_path+"variables", exist_ok=True) # Variables 폴더 생성
        
        # S3 버킷에서 파일 목록 가져오기
        response = s3.list_objects_v2(Bucket=bucket_name, Prefix=folder_name)
        
        if 'Contents' in response:
            for item in response['Contents']:
                file_key = item['Key']
                file_name = file_key.split('/')[-1]
                
                if file_name:  # 폴더 자체가 아닌 경우
                    # 파일명에 variable이 포함되어있으면 Variables 디렉토리에 다운로드
                    if 'variables' in file_name:
                        file_path = os.path.join(local_file_path+'/variables/', file_name)
                    
                    else:
                        file_path = os.path.join(local_file_path, file_name)
                    
                    # 파일 다운로드
                    s3.download_file(bucket_name, file_key, file_path)
                    print(f'Downloaded {file_key} to {file_path}')
        else:
            print('No files found in the specified folder.')
            
    ## credentials 다운로드
    # 06/04 S3에 파일 재업
    s3.download_file(bucket_name, 'credentials_service.json', '/tmp/credentials_service.json')

    ## token 다운로드
    s3.download_file(bucket_name, 'token.json', '/tmp/token.json')
    
def lambda_handler(event, context):
    # S3 클라이언트 생성
    s3 = boto3.client('s3')
    
    # 모델 다운로드, Credentials, token 다운로드
    downloadDefaultSetting(s3)
    
    return analyzeAPI(event['fileID'], event['gender'])