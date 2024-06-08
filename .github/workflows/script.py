import boto3
import mysql.connector
import os

# GitHub Secrets로부터 정보 가져오기
ssm_parameter_name = "/lambda/url"
db_host = os.getenv("MYSQL_HOST")
db_user = os.getenv("MYSQL_USER")
db_port = os.getenv("MYSQL_PORT")
db_password = os.getenv("MYSQL_PASSWORD")
db_name = os.getenv("DATABASE_NAME")
table_name = "lambda_url"

# AWS Systems Manager에서 Lambda URL 가져오기
ssm = boto3.client("ssm")
response = ssm.get_parameter(Name=ssm_parameter_name)
lambda_url = response["Parameter"]["Value"]

# MySQL 데이터베이스에 Lambda 함수 URL 삽입
try:
    connection = mysql.connector.connect(
        host=db_host, port=db_port, database=db_name, user=db_user, password=db_password
    )

    cursor = connection.cursor()

    # Lambda 함수 URL 삭제 SQL 쿼리
    delete_query = f"DELETE FROM {table_name} WHERE 1"
    cursor.execute(delete_query)
    
    connection.commit()
    
    # Lambda 함수 URL 삽입 SQL 쿼리
    insert_query = f"INSERT INTO {table_name} (function_url) VALUES (%s)"
    record_to_insert = (lambda_url,)
    cursor.execute(insert_query, record_to_insert)

    connection.commit()
    print("Lambda 함수 URL이 MySQL 데이터베이스에 성공적으로 삽입되었습니다.")

except mysql.connector.Error as error:
    print("MySQL 데이터베이스 오류:", error)

finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL 연결이 닫혔습니다.")
