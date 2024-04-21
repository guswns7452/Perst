## ✅ 로컬 이미지 파일에서, 이미지들을 가져옴
## 이미지를 기반으로 분석하는 코드로 넘김
## ✅ 분석한 내용을 기반으로 DB에 저장

## 분석 내용 1 : 컬러 추출 (여러가지 색) -> DB에 저장
## 분석 내용 2 : 상의 컬러 추출 -> 퍼스널 컬러 진단
## ✅   -> HSV로 저장하기

import colorsys, cv2
import pymysql
import json, numpy as np
import os, sys
import personal_color
import threading

sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))
import cnn_model

PATH =  os.getcwd()

##
# DB 세팅 값 불러오기
#
def read_database_info():
    # JSON 파일 경로
    jsonFilePath = PATH+'/database.json'
    
    # JSON 파일 읽기
    with open(jsonFilePath, 'r') as f:
        # JSON 데이터 파싱
        data = json.load(f)
        
    return data


def imgLoad(folder_path, file_name):
    # 한글 파일 경로도 읽을 수 있도록
    img_array = np.fromfile(folder_path+"/"+file_name, dtype=np.uint8)
    img_file = cv2.imdecode(img_array, cv2.IMREAD_COLOR)
    
    if img_file is None:
        print(
            "이미지 파일을 불러오는데 실패했습니다. 해당 파일이 존재하는지 확인해주세요"
        )
        return
    else:
        # 색상 공간을 RGB 형태로 변경
        img_file = cv2.cvtColor(img_file, cv2.COLOR_BGR2RGB)
        return img_file
    

def connect_to_database():
    # 메인 코드
    data = read_database_info()
    conn = pymysql.connect(host = data['host'] ,port = data['port'], user = data['user'], password = data['password'], db = data['db'], charset='utf8')	# 접속정보
    cur = conn.cursor()	# 커서생성
    
    return conn, cur
    

def update_personalColor_to_DB(genders, styles):
    for gender in genders:  
        for bottomFolder in styles:
            try:
                folderPath = PATH + "/newimages/Musinsa Data/" + gender + "/" + bottomFolder
                
                # 폴더 내의 파일명 가져오기
                files = os.listdir(folderPath)
                print(gender, " / " ,bottomFolder, " / " , folderPath, " / 현재 완료 갯수 : ", count)
                
                # 파일명 출력
                for file_name in files:
                    count += 1
                    print(file_name, " / 현재 완료 갯수 : ", count)
                    
                    musinsa_number = file_name.split("_")[1]
                    
                    ori_img = imgLoad(folderPath, file_name)
                    if ori_img is None:
                        print("이미지 파일을 불러오는데 실패하였습니다.")

                    # CNN 으로 정보 추출
                    output_dict = cnn_model.cnn_model_main(ori_img, gender)
                    
                    personal_rgb = output_dict['personal_color_rgb']    # 퍼스널 컬러가 담길 변수
                    musinsa_personal = personal_color.get_season_tone(personal_rgb) # 의류에 어울리는 퍼스널 컬러
                    
                    # 퍼스널 컬러, RGB 값 DB에 업데이트
                    sql = f"UPDATE musinsa SET musinsa_personal = '{musinsa_personal}', musinsa_red  = {personal_rgb[0]}, musinsa_green  = {personal_rgb[1]}, musinsa_blue  = {personal_rgb[2]} where musinsa_number = {musinsa_number}"	# 퍼스널 컬러
                    cur.execute(sql)	# 커서로 sql문 실행
                    conn.commit()
            
            except FileNotFoundError:
                continue

##
# DB에 색상 업로드와 퍼스널 컬러 추가
# TODO : (0421) 4개의 스레드로 분리 후 코드 실행
# ConnectionResetError 예외처리 -> DB에 재 접속하기
#
def dataChange():
    
    # 데이터베이스에 연결
    conn, cur = connect_to_database()
    sql=""
    
    # Style 정의
    style_args1 = ['amekaji', 'businessCasual', 'casual', 'chic', ]
    style_args2 = ['golf', 'minimal', 'sporty', 'street', 'dandy']
    style_args3 = ['girlish', 'gofcore', 'retro', 'romantic']
    
    # brandsnap Data
    # 여섯개의 멀티스레드로 구성
    threads = []
    
    t1 = threading.Thread(target=update_personalColor_to_DB, args=('woman', style_args1)); t1.start(); threads.append(t1);
    t2 = threading.Thread(target=update_personalColor_to_DB, args=('woman', style_args2)); t2.start(); threads.append(t2);
    t3 = threading.Thread(target=update_personalColor_to_DB, args=('woman', style_args3)); t3.start(); threads.append(t3);
    t4 = threading.Thread(target=update_personalColor_to_DB, args=('man', style_args1)); t4.start(); threads.append(t4);
    t5 = threading.Thread(target=update_personalColor_to_DB, args=('man', style_args2)); t5.start(); threads.append(t5);
    t6 = threading.Thread(target=update_personalColor_to_DB, args=('man', style_args3)); t6.start(); threads.append(t6);
    
    for thread in threads:
        thread.join()
    


# 전역변수 선언부
conn = None
cur = None
    
dataChange()

conn.close()	# 종료