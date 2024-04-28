## ✅ 로컬 이미지 파일에서, 이미지들을 가져옴
## ✅ 이미지를 기반으로 분석하는 코드로 넘김
## ✅ 분석한 내용을 기반으로 DB에 저장

## ✅ 분석 내용 1 : 컬러 추출 (상의 색) -> DB에 저장
## ✅ 분석 내용 2 : 상의 컬러 추출 -> 퍼스널 컬러 진단
## ✅   -> HSV로 저장하기

import cv2
import pymysql
import json, numpy as np
import os, sys
import personal_color
from multiprocessing import Process, freeze_support
from test_data.call_data import call_data  

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
    

# 데이터베이스에 연결하는 코드
def connect_to_database():
    # 메인 코드
    data = read_database_info()
    conn = pymysql.connect(host = data['host'] ,port = data['port'], user = data['user'], password = data['password'], db = data['db'], charset='utf8')	# 접속정보
    cur = conn.cursor()	# 커서생성
    
    return conn, cur

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
        
def update_personalColor_to_DB(genders, styles, Data_status):
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
                folderPath = PATH + "/newimages/Musinsa Data/" + gender + "/" + bottomFolder
                files = os.listdir(folderPath)
                print(gender, " / " ,bottomFolder, " / " , folderPath, " / 현재 완료 갯수 : ", count)
                
                # 파일명 출력
                for file_name in files:
                    count += 1
                    
                    print(f"[Thread-{os.getpid()}] Processing {file_name} ({count}/{len(files)})")
                    
                    musinsa_number = file_name.split("_")[1]
                    m = int(musinsa_number[0:5])
                            
                    if m < analyze_completed_number-1:
                        continue
                    
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
            
            # 커넥션이 끊기면 다시 DB에 연동함
            except ConnectionResetError:
                conn, cur = connect_to_database()

    conn.close()	# 종료

##
# DB에 색상 업로드와 퍼스널 컬러 추가
# TODO : (0421) 4개의 스레드로 분리 후 코드 실행
# ConnectionResetError 예외처리 -> DB에 재 접속하기
#
def dataChange():
    # Style 정의
    style_args1 = ['amekaji', 'businessCasual', 'casual', 'chic', ]
    style_args2 = ['golf', 'minimal', 'sporty', 'street', 'dandy']
    style_args3 = ['girlish', 'gofcore', 'retro', 'romantic']
    
    style_args4 = ['dandy'];
    style_args5 = ['businessCasual'];
    
    Data_status = call_data()
    
    # brandsnap Data
    # 여섯개의 멀티스레드로 구성
    processes = []
    
    freeze_support()  # Windows에서 multiprocessing 사용 시 필요
    
    #[완료] t1 = Process(target=update_personalColor_to_DB, args=(['woman'], style_args1, Data_status), name="1"); t1.start(); processes.append(t1);
    #[완료] t2 = Process(target=update_personalColor_to_DB, args=(['woman'], style_args2, Data_status), name="2"); t2.start(); processes.append(t2);
    #[완료] t3 = Process(target=update_personalColor_to_DB, args=(['woman'], style_args3, Data_status), name="3"); t3.start(); processes.append(t3);
    #[완료] t4 = Process(target=update_personalColor_to_DB, args=(['man'], style_args1, Data_status), name="4"); t4.start(); processes.append(t4);
    #[완료] t5 = Process(target=update_personalColor_to_DB, args=(['man'], style_args2, Data_status), name="5"); t5.start(); processes.append(t5);
    #[완료] t6 = Process(target=update_personalColor_to_DB, args=(['man'], style_args3, Data_status), name="6"); t6.start(); processes.append(t6);
    t7 = Process(target=update_personalColor_to_DB, args=(['man'], style_args4, Data_status), name="6"); t7.start(); processes.append(t7);
    t8 = Process(target=update_personalColor_to_DB, args=(['woman'], style_args5, Data_status), name="6"); t8.start(); processes.append(t8);
    
    for precess in processes:
        precess.join()
    
if __name__ == '__main__':
    dataChange()

