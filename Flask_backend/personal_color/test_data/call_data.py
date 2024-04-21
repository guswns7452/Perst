import pymysql, os, json

##
# DB 세팅 값 불러오기
#
def read_database_info():
    # JSON 파일 경로
    jsonFilePath = os.getcwd() + '/database.json'
    
    # JSON 파일 읽기
    with open(jsonFilePath, 'r') as f:
        # JSON 데이터 파싱
        data = json.load(f)
        
    return data


##
# 현재 DB에 반영된 퍼스널 컬러 반영된 마지막 번호 출력하기
# [return 값]
# """
# {
#     "man" : ['Amekaji': 393507}, {'businessCasual': 263072}]],
#     "woman" : ['Amekaji': 393507}, {'businessCasual': 263072}]]
# }
# """
#
def call_data():
    data = read_database_info()
    conn = pymysql.connect(host = data['host'] ,port = data['port'], user = data['user'], password = data['password'], db = data['db'], charset='utf8')	# 접속정보
    cur = conn.cursor()	# 커서생성
    
    sql="select max(musinsa_number), musinsa_style, musinsa_gender from musinsa where musinsa_personal != 'null' group by musinsa_style;"
    
    cur.execute(sql)	# 커서로 sql문 실행
    
    dict_data = dict()
    man_list = []
    woman_list = []
    
    for i in cur:
        d = dict()
        d[i[1]] = int(i[0])
        
        if i[2] == "man":
            man_list.append(d)
        else:
            woman_list.append(d)
        
        # (393507, 'Amekaji', 'man')
        # (263072, 'businessCasual', 'man')
        # (312128, 'girlish', 'woman')
        # (393901, 'gofcore', 'woman')
        # (346936, 'golf', 'woman')
    
    dict_data['man'] = man_list
    dict_data['woman'] = woman_list    
    conn.close()
    
    return dict_data # dictionary 형태로 반환