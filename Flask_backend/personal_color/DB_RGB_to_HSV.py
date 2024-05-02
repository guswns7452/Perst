# RGB로 저장된 DB 값을
# HSV로 변환하는 코드

import colorsys, os, sys
from multiprocessing import Process, freeze_support

sys.path.append(os.getcwd())
from DB.DB_setting import connect_to_database

PATH = os.getcwd()

def change_RGB_to_HSV(gender, styles):
    # 전역변수 선언부
    conn = None
    cur = None
    
    # 데이터베이스에 연결
    conn, cur = connect_to_database()
    sql=""

    for style in styles:
        # 모든 데이터 가져오기
        sql = f"SELECT musinsa_number, musinsa_red, musinsa_green, musinsa_blue from musinsa where musinsa_gender = '{gender}' and musinsa_style = '{style}'"	# 퍼스널 컬러
        cur.execute(sql)	# 커서로 sql문 실행
        result = cur.fetchall()
        
        for i in result:
            number = int(i[0])
            hsv = rgb_to_hsv(i[1], i[2], i[3])
            print(hsv)
            sql = f"UPDATE musinsa SET musinsa_hue = {hsv[0]}, musinsa_saturation = {hsv[1]}, musinsa_value = {hsv[2]}  WHERE musinsa_number = {number}"	# 퍼스널 컬러
            cur.execute(sql)	# 커서로 sql문 실행
            conn.commit()
    
    conn.close

##
# RGB to HSV
#
def rgb_to_hsv(r, g, b):
    temp = colorsys.rgb_to_hsv(r, g, b)
    h = int(temp[0] * 360)
    s = int(temp[1] * 100)
    v = round(temp[2] * 100 / 255)
    return [h, s, v]


def dataChange():
    # Style 정의
    style_args1 = ['amekaji', 'businessCasual', 'casual', 'chic', 'golf', 'minimal']
    style_args2 = ['sporty', 'street', 'dandy', 'girlish', 'gofcore', 'retro', 'romantic']
    
    # brandsnap Data
    # 여섯개의 멀티스레드로 구성
    processes = []
    
    freeze_support()  # Windows에서 multiprocessing 사용 시 필요
    
    t1 = Process(target=change_RGB_to_HSV, args=('woman', style_args1), name="1"); t1.start(); processes.append(t1);
    t2 = Process(target=change_RGB_to_HSV, args=('woman', style_args2), name="2"); t2.start(); processes.append(t2);
    t3 = Process(target=change_RGB_to_HSV, args=('man', style_args1), name="3"); t3.start(); processes.append(t3);
    t4 = Process(target=change_RGB_to_HSV, args=('man', style_args2), name="4"); t4.start(); processes.append(t4);
    
    for precess in processes:
        precess.join()

if __name__ == '__main__':
    print(rgb_to_hsv(116,204,71))