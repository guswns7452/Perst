import os, json, pymysql

PATH = os.path.dirname(os.path.realpath(__file__)) # 현재 디렉터리 위치

# 데이터베이스에 연결하는 코드 
def connect_to_database():
    # 메인 코드
    data = read_database_info()
    conn = pymysql.connect(host = data['host'] ,port = data['port'], user = data['user'], password = data['password'], db = data['db'], charset='utf8')	# 접속정보
    cur = conn.cursor()	# 커서생성
    
    return conn, cur

##
# DB 세팅 값 불러오기
#
def read_database_info():
    # JSON 파일 경로
    jsonFilePath = PATH+'\\database.json'
    
    # JSON 파일 읽기
    with open(jsonFilePath, 'r') as f:
        # JSON 데이터 파싱
        data = json.load(f)
        
    return data
