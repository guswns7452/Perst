## ✅ 로컬 이미지 파일에서, 이미지들을 가져옴
## ✅ 이미지를 기반으로 분석하는 코드로 넘김
## ✅ 분석한 내용을 기반으로 DB에 저장

## ✅ 분석 내용 1 : 컬러 추출 (상의 색) -> DB에 저장
## ✅ 분석 내용 2 : 상의 컬러 추출 -> 퍼스널 컬러 진단
## ✅   -> HSV로 저장하기

import cv2
import numpy as np
import os, sys
from personal_color.personal_color import rgb_to_hsv, get_season_tone
from multiprocessing import Process, freeze_support
from test_data.call_data import call_data  

sys.path.append(os.getcwd())

import cnn_model
from DB.DB_setting import connect_to_database
from crawling.google_upload_image import upload_basic

PATH =  os.getcwd()

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
    

# 현재 지금 스타일이 분석 완료 되었는지 판단
def is_completed(Data_status, nowStyle, gender):
    man_complete_list = Data_status["man"]
    woman_complete_list = Data_status["woman"]
    
    if gender == "man":
        for i in man_complete_list:
            try:
                if i[nowStyle] > 0:
                    return i[nowStyle]//10 # 완료된 번호
            except KeyError:
                pass
        
        return False
    
    else:
        for i in woman_complete_list:
            try:
                if i[nowStyle] > 0:
                    return i[nowStyle]//10 # 완료된 번호
            except KeyError:
                pass
        
        return False
        
def update_personalColor_to_DB(genders, styles, Data_status, save_folderPath, musinsa_type):
    # 전역변수 선언부
    conn = None
    cur = None
    
    # 데이터베이스에 연결
    conn, cur = connect_to_database()
    sql=""
    
    for gender in genders:  
        for bottomFolder in styles:
            try:
                count = 0
                
                # 이미 이미지가 분석되었는지 판단하는 코드
                # 이미지가 분석이 완료된 번호가 analyze_completed_number에 담긴다
                data = is_completed(Data_status, bottomFolder, gender)
                if data == False:
                    analyze_completed_number = 0
                else:
                    analyze_completed_number = data
                
                # 폴더 내의 파일명 가져오기
                folderPath = PATH + "/" + save_folderPath + gender + "/" + bottomFolder
                files = os.listdir(folderPath)
                print(gender, " / " ,bottomFolder, " / " , folderPath, " / 현재 완료 갯수 : ", count)
                
                # 파일명 출력
                for file_name in files:
                    count += 1
                    
                    print(f"[Thread-{os.getpid()}] Processing {file_name} ({count}/{len(files)})")
                    
                    file_metaData = file_name.split("_")
                    musinsa_number = int(file_metaData[1])
                    musinsa_height = int(file_metaData[2])
                    musinsa_weight = int(file_metaData[3])
                    musinsa_season = file_metaData[4]
                            
                    ori_img = imgLoad(folderPath, file_name)
                    if ori_img is None:
                        print("이미지 파일을 불러오는데 실패하였습니다.")

                    # CNN 으로 정보 추출
                    output_dict = cnn_model.cnn_model_main(ori_img, gender)
                    
                    personal_rgb = output_dict['personal_color_rgb']    # 퍼스널 컬러가 담길 변수
                    r,g,b = map(float, personal_rgb)
                    h,s,v = rgb_to_hsv(r,g,b)
                    musinsa_personal = get_season_tone(personal_rgb) # 의류에 어울리는 퍼스널 컬러
                    
                    ## 데이터 업데이트 코드
                    file_id = upload_basic(file_name, folderPath+"/"+file_name, gender, bottomFolder)
                    
                    # 퍼스널 컬러, RGB 값 DB에 업데이트
                    sql = f"INSERT INTO musinsa(musinsa_number, musinsa_gender, musinsa_height, musinsa_weight, musinsa_season, musinsa_style, musinsa_fileid, musinsa_type, musinsa_personal, musinsa_red, musinsa_green, musinsa_blue, musinsa_hue, musinsa_saturation, musinsa_value) VALUES ({musinsa_number}, '{gender}', {musinsa_height}, {musinsa_weight}, '{musinsa_season}', '{bottomFolder}', '{file_id}', '{musinsa_type}', '{musinsa_personal}' '{r}', '{g}', '{b}', '{h}','{s}','{v}')"	# DB 반영
                    cur.execute(sql)	# 커서로 sql문 실행
                    conn.commit()
            
            except FileNotFoundError:
                continue
            
            # 커넥션이 끊기면 다시 DB에 연동함
            except ConnectionResetError:
                conn, cur = connect_to_database()

    conn.close()	# 종료

##
# DB에 색상 업로드와 퍼스널 컬러 추가
# ConnectionResetError 예외처리 -> DB에 재 접속하기
#
def dataChange(save_folderPath, musinsa_type):
    # Style 정의
    style_args = ['amekaji', 'businessCasual', 'casual', 'chic', 'golf', 'minimal', 'sporty', 'street', 'dandy', 'girlish', 'gofcore', 'retro', 'romantic']
    
    Data_status = call_data()
    
    # brandsnap Data
    # 여섯개의 멀티스레드로 구성
    processes = []
    
    freeze_support()  # Windows에서 multiprocessing 사용 시 필요
    
    t1 = Process(target=update_personalColor_to_DB, args=(['man'], style_args, Data_status, save_folderPath, musinsa_type), name="1"); t1.start(); processes.append(t1);
    t2 = Process(target=update_personalColor_to_DB, args=(['woman'], style_args, Data_status, save_folderPath, musinsa_type), name="2"); t2.start(); processes.append(t2);
    
    for precess in processes:
        precess.join()
    


