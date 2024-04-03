## ✅ 로컬 이미지 파일에서, 이미지들을 가져옴
## 이미지를 기반으로 분석하는 코드로 넘김
## ✅ 분석한 내용을 기반으로 DB에 저장

## 분석 내용 1 : 컬러 추출 (여러가지 색) -> DB에 저장
## 분석 내용 2 : 상의 컬러 추출 -> 퍼스널 컬러 진단
## ✅   -> HSV로 저장하기

import colorsys
import pymysql
import json
import os

PATH =  os.getcwd()

##
# DB 세팅 값 불러오기
#
def database_SetUp():
    # JSON 파일 경로
    jsonFilePath = PATH+'/database.json'
    
    # JSON 파일 읽기
    with open(jsonFilePath, 'r') as f:
        # JSON 데이터 파싱
        data = json.load(f)
        
    return data

##
# DB에 색상 업로드와 퍼스널 컬러 추가
#
def dataChange():
    # 전역변수 선언부
    conn = None
    cur = None

    sql=""

    # 메인 코드
    data = database_SetUp()
    conn = pymysql.connect(host = data['host'] ,port = data['port'], user = data['user'], password = data['password'], db = data['db'], charset='utf8')	# 접속정보
    cur = conn.cursor()	# 커서생성

    # codishop Data
    for gender in ['man','woman']:
        for bottomFolder in ['고프코어', '골프', '댄디', '로맨틱', '미니멀', '비즈니스캐주얼', '스트릿', '스포티', '시크', '아메카지', '캐주얼' , '걸리시', '레트로']:
            try:
                folderPath = PATH + "/images/" + gender + "/" + bottomFolder
                
                # 폴더 내의 파일명 가져오기
                files = os.listdir(folderPath)

                # 파일명 출력
                for file_name in files:
                    print(file_name)
                    
                    musinsa_number = file_name.split("_")[1]
                    
                    ##########################################
                    # 머신러닝을 통해 퍼스널 컬러를 진단하는 곳 #
                    ##########################################
                    
                    musinsa_personal = ""    # 퍼스널 컬러가 담길 변수
                    
                    sql = f"UPDATE musinsa SET musinsa_personal = '{musinsa_personal}' where musinsa_number = {musinsa_number}"	# 퍼스널 컬러
                    cur.execute(sql)	# 커서로 sql문 실행
                    conn.commit()
            
            except FileNotFoundError:
                continue
            
    # brandsnap Data
    for gender in ['man','woman']:
        for bottomFolder in ['Amekaji', 'businessCasual', 'casual',' chic', 'dandy', 'gofcore', 'golf', 'minimal', 'sporty', 'street', 'girlish', 'retro', 'romantic']:
            try:
                folderPath = PATH + "/images/" + gender + "/" + bottomFolder
                
                # 폴더 내의 파일명 가져오기
                files = os.listdir(folderPath)

                # 파일명 출력
                for file_name in files:
                    print(file_name)
                    
                    musinsa_number = file_name.split("_")[1]
                    
                    ##########################################
                    # 머신러닝을 통해 퍼스널 컬러를 진단하는 곳 #
                    ##########################################
                    
                    musinsa_personal = ""    # 퍼스널 컬러가 담길 변수
                    
                    sql = f"UPDATE musinsa SET musinsa_personal = '{musinsa_personal}' where musinsa_number = {musinsa_number}"	# 퍼스널 컬러
                    cur.execute(sql)	# 커서로 sql문 실행
                    conn.commit()
            
            except FileNotFoundError:
                continue

    conn.close()	# 종료

##
# RGB to HSV
#
def rgb_to_hsv(r, g, b):
    # RGB 값을 0~1 범위로 정규화
    r /= 255.0
    g /= 255.0
    b /= 255.0
    
    # RGB를 HSV로 변환
    hsv = colorsys.rgb_to_hsv(r, g, b)
    
    # HSV값을 반환
    return hsv

# 예시 RGB 값
r, g, b = 255, 0, 0

# RGB를 HSV로 변환
h, s, v = rgb_to_hsv(r, g, b)

# 변환된 HSV 값 출력
print("Hue:", h)
print("Saturation:", s)
print("Value:", v)

dataChange()