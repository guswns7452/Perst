import requests
import re
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
import os, sys
from multiprocessing import Process, freeze_support
from change_to_english import change_season_eng, change_style_eng

sys.path.append(os.getcwd())
from DB.DB_setting import connect_to_database

# ✅ 남성 / 여성  ->  남성 여성 구분이 모호하여 이렇게 작성했다
#   - selenium으로 개발해서 직접 버튼 클릭하기
#   - sleep (10)

# ✅ 키, 몸무게 (이게 있으면 모델에 맞게 구매 가능하지)
#   - 없는 경우도 따지기 -> 0으로 설정

# ✅ 계절감, ✅ 스타일

SCOPES = ["https://www.googleapis.com/auth/drive"]

def man_download_images(now_done_num, save_folderPath, url = "https://www.musinsa.com/mz/brandsnap"):
    # styles = ['dandy', 'street', 'americancasual', 'gorpcore', 'chic', 'formal', 'sports', 'golf', 'minimal']
    styles = ['americancasual', 'gorpcore', 'chic', 'formal', 'sports', 'golf', 'minimal']

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
        for i in range(1, 50):
            # 웹 페이지 열기
            driver.get(url+"?style_type="+urlStyle+"&p="+str(i))
            print(f"[man] style : {style} / {i}")
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
            
            ## 현재 다운 완료된 번호까지 탐색 하면 멈춤
            if int(innerURL[-1].split("/")[-1][:6]) <= now_done_num:
                break
            
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
            
            # 영어로 전환
            season = change_season_eng(season)
            
            # 폴더가 없으면 생성 (image/성별/스타일)
            if not os.path.exists(save_folderPath + gender + "/" + style):
                os.makedirs(save_folderPath + gender + "/" + style)
            
            # 이미지 다운로드
            img_url = img_tag.get_attribute('src')
            img_data = requests.get(img_url).content
                
            filename = gender+"_"+index+"_"+str(height)+"_"+str(weight)+"_"+season+"_"+style+".jpg"
            print(filename)
            img_path = os.path.join(save_folderPath + gender + "/" + style, f"{filename}")
                
            with open(img_path, "wb") as f:
                f.write(img_data)
                
## TODO 여성용도 만들기
def woman_download_images(now_done_num, save_folderPath, url = "https://www.musinsa.com/mz/brandsnap"):
    # styles = ['casual', 'girlish', 'chic', 'romantic', 'street', 'formal', 'sports', 'golf', 'gorpcore', 'americancasual',  'retro']
    styles = ['girlish', 'chic', 'romantic', 'street', 'formal', 'sports', 'golf', 'gorpcore', 'americancasual',  'retro']

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
        time.sleep(10)
        
        # for문 중단을 위한 변수
        vary = True
        
        # url
        for i in range(1, 50):
            # 웹 페이지 열기
            driver.get(url+"?style_type="+urlStyle+"&p="+str(i))
            print(f"[woman] style : {style} / {i}")
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
            
            ## 현재 다운 완료된 번호까지 탐색 하면 멈춤
            if int(innerURL[-1].split("/")[-1][:6]) <= now_done_num:
                break
            
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
            
            # 영어로 전환
            season = change_season_eng(season)
            
            # 폴더가 없으면 생성 (image/성별/스타일)
            if not os.path.exists(save_folderPath + gender + "/" + style):
                os.makedirs(save_folderPath + gender + "/" + style)
            
            # 이미지 다운로드
            img_url = img_tag.get_attribute('src')
            img_data = requests.get(img_url).content
            
            filename = gender+"_"+index+"_"+str(height)+"_"+str(weight)+"_"+season+"_"+style+".jpg"
            print(filename)
            img_path = os.path.join(save_folderPath + gender + "/" + style, f"{filename}")
            
            with open(img_path, "wb") as f:
                f.write(img_data)
                
def brand_main(save_folder):
    
    # DB에서 현재 완료되어 있는 이력 조회
    conn, cur = connect_to_database()
    sql = "select max(musinsa_number) from musinsa where musinsa_type = 'brandsnap'"
    cur.execute(sql)
    result = cur.fetchall()
    
    # 크롤링할 페이지 URL
    url = "https://www.musinsa.com/mz/brandsnap"

    # brandsnap Data
    # 두개의 멀티스레드로 구성
    processes = []
        
    freeze_support()  # Windows에서 multiprocessing 사용 시 필요
    
    t1 = Process(target=man_download_images, args=(int(result[0][0]),save_folder), name="1"); t1.start(); processes.append(t1);
    t2 = Process(target=woman_download_images, args=(int(result[0][0]),save_folder), name="2"); t2.start(); processes.append(t2);

    for precess in processes:
        precess.join()

    conn.close()
    
