import os
import json
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.http import MediaIoBaseDownload

# 경로 설정
CREDENTIALS_FILE_PATH = 'credentials_service.json'  # 실제 서비스 계정 JSON 파일 경로
FILE_ID = ''
DOWNLOAD_PATH = 'file.jpg'  # 다운로드할 파일의 로컬 경로

def download_by_google_drive(file_id, creds_path, download_path):
    try:
        # 서비스 계정 자격 증명 로드
        creds = service_account.Credentials.from_service_account_file(creds_path)

        # Google Drive API 클라이언트 생성
        drive_service = build('drive', 'v3', credentials=creds)

        # 파일 다운로드 요청
        request = drive_service.files().get_media(fileId=file_id)
        with open(download_path, "wb") as fh:
            downloader = MediaIoBaseDownload(fh, request)
            done = False
            while not done:
                status, done = downloader.next_chunk()
                if status:
                    print("Download %d%%." % int(status.progress() * 100))
        print("이미지 다운로드가 완료되었습니다.")
        return download_path
    except Exception as e:
        print("이미지 다운로드 중 오류가 발생했습니다:", str(e))
        return None

if __name__ == '__main__':
    # 파일 다운로드 실행
    local_file_path = download_by_google_drive(FILE_ID, CREDENTIALS_FILE_PATH, DOWNLOAD_PATH)

    if local_file_path:
        print(f"파일이 성공적으로 다운로드되었습니다: {local_file_path}")
    else:
        print("파일 다운로드 실패")
