import os, sys

sys.path.append(os.getcwd())

from DB.DB_setting import connect_to_database

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
    conn, cur = connect_to_database()
    
    sql="select max(musinsa_number), musinsa_style, musinsa_gender from musinsa where musinsa_personal != 'null' group by musinsa_style, musinsa_gender;"
    
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