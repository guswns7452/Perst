import requests
from bs4 import BeautifulSoup
import os

# ✅ 남성 / 여성
# ✅ 키, 몸무게 (이게 있으면 모델에 맞게 구매 가능하지)
# ✅ 계절감, 스타일

def download_images(url,index):
    gender = "etc"

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
    model_info = soup.find(class_="model_info").get_text()
    height = model_info[0:3]
    weight = model_info[-4:-2]
    print("키 : " + height + " / 몸무게 : " + weight)

    # 계절감, 스타일
    tags = soup.find_all(class_="ui-tag-list__item")
    temp_tag0 = tags[0].get_text().replace('#','') 
    temp_tag1 = tags[1].get_text().replace('#','') 
    if(temp_tag0 == "봄" or temp_tag0 == "여름" or temp_tag0 == "가을" or temp_tag0 == "겨울"):
        season = temp_tag0
        style = temp_tag1
    else:
        season = temp_tag1
        style = temp_tag0
        
    print("계절 : " + season + "/ 스타일 : " +  style)

    # 폴더가 없으면 생성
    if not os.path.exists("images/"+gender):
        os.makedirs("images/"+gender)
    
    print(gender+"_"+index+"_"+height+"_"+weight+"_"+season+"_"+style+".jpg")
    
    # # 이미지 다운로드
    # for idx, img_tag in enumerate(img_tags):
    #     img_url = img_tag["src"]
    #     img_data = requests.get(img_url).content
    #     with open(os.path.join("images/" + gender, f"image_{idx}.jpg"), "wb") as f:
    #         f.write(img_data)
    #         break

# 크롤링할 페이지 URL
# 2024/02/25 23:50 기준 40031 최신
for i in range(40031, 34000, -1):
    index = "{:d}".format(i)
    url = "https://www.musinsa.com/app/styles/views/"+index

    # 크롤링 및 이미지 다운로드 실행
    download_images(url,index)


