import requests
import re
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
import os

import google.auth
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from googleapiclient.http import MediaFileUpload

# ✅ 남성 / 여성
#   - selenium으로 개발해서 직접 버튼 클릭하기
#   - sleep (10)

# ✅ 키, 몸무게 (이게 있으면 모델에 맞게 구매 가능하지)
#   - 없는 경우도 따지기 -> 0으로 설정

# ✅ 계절감, ✅ 스타일

SCOPES = ["https://www.googleapis.com/auth/drive"]

def man_download_images(url):
    styles = ['dandy', 'street', 'americancasual', 'gorpcore', 'chic', 'formal', 'sports', 'golf', 'minimal']

    # 크롬 브라우저 열기 (버전 업그레이드 후 인자가 필요없음)
    driver = webdriver.Chrome()

    # 웹페이지 열기 (여기서 성별 변경하기)
    driver.get(url)
    
    for style in styles:
        gender = "man"
        season = "null"
        urlStyle = style
        
        # 기존에 저장된 style
        if urlStyle == "gorpcore":
            style = "gofcore"
            
        elif urlStyle == "formal":
            style = "businessCasual"
            
        elif urlStyle == "sports":
            style = "sporty"
            
        # 내부 링크들
        innerURL = []
        
        # 웹페이지 열기 (여기서 성별 변경하기)
        driver.get(url+"?style_type="+urlStyle+"&p=1")
        time.sleep(3)
        
        # for문 중단을 위한 변수
        vary = True
        
        # url
        for i in range(1, 30):
            # 웹 페이지 열기
            driver.get(url+"?style_type="+urlStyle+"&p="+str(i))
            print(i)
            if not vary: break;
            
            # 리스트들 찾기
            element = driver.find_element(by=By.CLASS_NAME, value='snap-article-list')
            
            # 부모 요소의 자식 요소 찾기
            child_elements = element.find_elements(By.XPATH,'./*')
            
            # 자식 요소들 
            for child_element in child_elements:
                # 더 이상 존재하지 않으면 탐색 멈춤
                if child_element.get_attribute('class') == "nolist":
                    vary = False; break;
                
                # 링크 추가해두기
                else:
                    innerURL.append(child_element.find_element(By.TAG_NAME, 'a').get_attribute('href'))
                
        for innerurl in innerURL:
            print(innerurl)
            driver.get(innerurl)
            
            # 키 몸무게 추출하기
            heightTag = driver.find_element(By.XPATH, '//tr[.//span[contains(text(), "키/몸무게")]]')
            body = heightTag.find_element(By.TAG_NAME, 'td').find_element(By.TAG_NAME, 'span').text
            body = body.replace(' ','').split('/') # 공백 제거 후, 배열로 바꾸기
            
            # 키 추가하기
            if len(body[0]) == 1:
                height = 0
            else:
                height = int(body[0].replace('cm',''))
            
            # 몸무게 추가하기
            if len(body[1]) == 1:
                weight = 0
            else:
                weight = int(body[1].replace('kg',''))
            
            # 계절감 태그 가져오기
            tags = driver.find_elements(By.CLASS_NAME, 'article-tag-list')
            for tag in tags:
                if "봄" in tag.text:
                    season = "봄"
                    
                elif "여름" in tag.text:
                    season = "여름"
                
                elif "가을" in tag.text:
                    season = "가을"
                    
                elif "겨울" in tag.text:
                    season = "겨울"
                    
                else:
                    season = "null"
        
            # index 번호 찾기
            match = re.search(r'/(\d+)\?', innerurl)

            if match:
                index = match.group(1)
                print(index)
            else:
                print("숫자를 찾을 수 없습니다.")
            
            # 이미지 태그 찾기
            img_tag = driver.find_element(By.CLASS_NAME, 'view-photo')
            
            # 폴더가 없으면 생성 (image/성별/스타일)
            if not os.path.exists("newimages/" + gender + "/" + style):
                os.makedirs("newimages/" + gender + "/" + style)
            
            # 이미지 다운로드
            img_url = img_tag.get_attribute('src')
            img_data = requests.get(img_url).content
                
            filename = gender+"_"+str(index)+"_"+str(height)+"_"+str(weight)+"_"+season+"_"+style+".jpg"
            print(filename)
            img_path = os.path.join("newimages/" + gender + "/" + style, f"{filename}")
                
            with open(img_path, "wb") as f:
                f.write(img_data)
                # upload_basic(filename, img_path, gender, index, height, weight, season, style)

## TODO 여성용도 만들기
def woman_download_images(url):
    styles = ['casual', 'girlish', 'chic', 'romantic', 'street', 'formal', 'sports', 'golf', 'gorpcore', 'americancasual',  'retro']

    # 크롬 브라우저 열기 (버전 업그레이드 후 인자가 필요없음)
    driver = webdriver.Chrome()

    # 웹페이지 열기 (여기서 성별 변경하기)
    driver.get(url)
    
    for style in styles:
        gender = "woman"
        season = "null"
        urlStyle = style
        
        # 기존에 저장된 style
        if urlStyle == "gorpcore":
            style = "gofcore"
            
        elif urlStyle == "formal":
            style = "businessCasual"
            
        elif urlStyle == "sports":
            style = "sporty"
            
        # 내부 링크들
        innerURL = []
        
        # 웹페이지 열기 (여기서 성별 변경하기)
        driver.get(url+"?style_type="+urlStyle+"&p=1")
        time.sleep(3)
        
        # for문 중단을 위한 변수
        vary = True
        
        # url
        for i in range(1, 30):
            # 웹 페이지 열기
            driver.get(url+"?style_type="+urlStyle+"&p="+str(i))
            print(i)
            if not vary: break;
            
            # 리스트들 찾기
            element = driver.find_element(by=By.CLASS_NAME, value='snap-article-list')
            
            # 부모 요소의 자식 요소 찾기
            child_elements = element.find_elements(By.XPATH,'./*')
            
            # 자식 요소들 
            for child_element in child_elements:
                # 더 이상 존재하지 않으면 탐색 멈춤
                if child_element.get_attribute('class') == "nolist":
                    vary = False; break;
                
                # 링크 추가해두기
                else:
                    innerURL.append(child_element.find_element(By.TAG_NAME, 'a').get_attribute('href'))
                
        for innerurl in innerURL:
            print(innerurl)
            driver.get(innerurl)
            
            # 키 몸무게 추출하기
            heightTag = driver.find_element(By.XPATH, '//tr[.//span[contains(text(), "키/몸무게")]]')
            body = heightTag.find_element(By.TAG_NAME, 'td').find_element(By.TAG_NAME, 'span').text
            body = body.replace(' ','').split('/') # 공백 제거 후, 배열로 바꾸기
            
            # 키 추가하기
            if len(body[0]) == 1:
                height = 0
            else:
                height = int(body[0].replace('cm',''))
            
            # 몸무게 추가하기
            if len(body[1]) == 1:
                weight = 0
            else:
                weight = int(body[1].replace('kg',''))
            
            # 계절감 태그 가져오기
            tags = driver.find_elements(By.CLASS_NAME, 'article-tag-list')
            for tag in tags:
                if "봄" in tag.text:
                    season = "봄"
                    
                elif "여름" in tag.text:
                    season = "여름"
                
                elif "가을" in tag.text:
                    season = "가을"
                    
                elif "겨울" in tag.text:
                    season = "겨울"
                    
                else:
                    season = "null"
        
            # index 번호 찾기
            match = re.search(r'/(\d+)\?', innerurl)

            if match:
                index = match.group(1)
                print(index)
            else:
                print("숫자를 찾을 수 없습니다.")
            
            # 이미지 태그 찾기
            img_tag = driver.find_element(By.CLASS_NAME, 'view-photo')
            
            # 폴더가 없으면 생성 (image/성별/스타일)
            if not os.path.exists("newimages/" + gender + "/" + style):
                os.makedirs("newimages/" + gender + "/" + style)
            
            # 이미지 다운로드
            img_url = img_tag.get_attribute('src')
            img_data = requests.get(img_url).content
                
            filename = gender+"_"+str(index)+"_"+height+"_"+weight+"_"+season+"_"+style+".jpg"
            print(filename)
            img_path = os.path.join("newimages/" + gender + "/" + style, f"{filename}")
                
            with open(img_path, "wb") as f:
                f.write(img_data)
                # upload_basic(filename, img_path, gender, index, height, weight, season, style)

# 크롤링할 페이지 URL
# 2024/03/06 01:37 393585 
url = "https://www.musinsa.com/mz/brandsnap"

# 크롤링 및 이미지 다운로드 실행
man_download_images(url)    
    

## 고려해야 할 수 있는 요소
## TODO 파일명에 "/" 있는 경우 FileNotFoundError 오류 -> line. 77
## TODO 중간중간 삭제된 경우 -> AttributeError로 

# -------------------------------------- #
# Deprecated
def upload_basic(file_name, img_path, gender, index, height, weight, season, style):
    """Insert new file.
    Returns : Id's of the file uploaded

    Load pre-authorized user credentials from the environment.
    TODO(developer) - See https://developers.google.com/identity
    for guides on implementing OAuth2 for the application.
    """
    
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
        
        folder_id = "1MkfNx1KUIrffO5iJIopznx68QU1iIkqw"

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