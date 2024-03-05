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

# ✅ 남성 / 여성
# ✅ 키, 몸무게 (이게 있으면 모델에 맞게 구매 가능하지)
# ✅ 계절감, 스타일

SCOPES = ["https://www.googleapis.com/auth/drive"]

def download_images(url,index):
    gender = "etc"
    season = "null"
    style = "null"

    # 페이지 요청 (크롤링이 아닌것 처럼 헤더 설정)
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"
    }
    response = requests.get(url, headers=headers)
    soup = BeautifulSoup(response.text, "html.parser")

    # 이미지 태그 찾기
    img_tags = soup.select(".detail_slider .detail_img")

    # icon_woman 클래스를 가진 요소 찾기
    icon_woman_elements = soup.find_all(class_="icon_woman")
    icon_man_elements = soup.find_all(class_="icon_man")

    if len(icon_woman_elements) > len(icon_man_elements):
        gender = "woman"
    elif len(icon_woman_elements) < len(icon_man_elements):
        gender = "man"
    
    # 모델의 키, 몸무게 추출하기
    try:
        model_info = soup.find(class_="model_info").get_text()
        height = model_info[0:3]
        weight = model_info[-4:-2]
        print("키 : " + height + " / 몸무게 : " + weight)

    except AttributeError:
        return 
    
    # 계절감, 스타일
    # 계절 : (#봄, #여름, #가을, #겨울)
    # 스타일 : (#아메카지, #캐주얼, #시크, #댄디, #비즈니스캐주얼, #걸리시, #골프, #레트로, #로맨틱, #스포티, #스트릿, #고프코어, #하이틴, #미니멀)
    
    define_season = ["#봄", "#여름", "#가을", "#겨울"]
    define_style = ["#아메카지", "#캐주얼", "#시크", "#댄디", "#비즈니스캐주얼", "#걸리시", "#골프", "#레트로", "#로맨틱", "#스포티", "#스트릿", "#고프코어", "#하이틴", "#미니멀"]
    
    tags = soup.find_all(class_="ui-tag-list__item")
    temp_tag0 = tags[0].get_text() 
    temp_tag1 = tags[1].get_text()
    
    # 계절과 스타일 적용함
    if(temp_tag0 in define_season):
        season = temp_tag0.replace('#','') 
        if(temp_tag1 in define_style):
            style = temp_tag1.replace('#','') 
            
    elif(temp_tag1 in define_season):
        season = temp_tag1.replace('#','')
        if(temp_tag0 in define_style):
            style = temp_tag0.replace('#','')

    # 계절과 스타일이 불분명한 경우
    if(season == "null"):
        for tag in reversed(tags):
            if(tag.get_text() in define_season):
                season = tag.get_text().replace('#','')
                break
            
        if(season == "null"): # 그래도 찾지 못하면 etc 폴더에 저장함
            gender = "etc"
            
    if(style == "null"):
        for tag in reversed(tags):
            if(tag.get_text() in define_style):
                style = tag.get_text().replace('#','')
                break
        
        if(style == "null"): # 그래도 찾지 못하면 etc 폴더에 저장함
            gender = "etc"
    
    
    print("계절 : " + season + " / 스타일 : " +  style)

    # 폴더가 없으면 생성 (image/성별/스타일)
    if not os.path.exists("newimages/" + gender + "/" + style):
        os.makedirs("newimages/" + gender + "/" + style)
    
    # 이미지 다운로드
    for idx, img_tag in enumerate(img_tags):
        img_url = img_tag["src"]
        img_data = requests.get(img_url).content
        
        filename = gender+"_"+index+"_"+height+"_"+weight+"_"+season+"_"+style+".jpg"
        print(filename)
        img_path = os.path.join("newimages/" + gender + "/" + style, f"{filename}")
        
        with open(img_path, "wb") as f:
            f.write(img_data)
            # upload_basic(filename, img_path, gender, index, height, weight, season, style)
            break

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

# 크롤링할 페이지 URL
# 2024/02/26 20:36 기준 40031 최신
# 2024/02/26 23:45 기준 34000 ~ 40031 완료
for i in range(34000, 30000, -1):

    index = "{:d}".format(i)
    url = "https://www.musinsa.com/app/styles/views/"+index

    # 크롤링 및 이미지 다운로드 실행
    download_images(url,index)

## 수정사항
## [아래를 정의함으로 처리됨] TODO 파일명에 "/" 있는 경우 FileNotFoundError 오류 -> line. 77
## [처리 완료] TODO 계절이 애매한 경우
## [처리 완료] TODO 스타일이 정확하지 않은 경우

## [처리 완료] TODO 중간중간 삭제된 경우 -> AttributeError로 
