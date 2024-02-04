from flask import Flask

app = Flask(__name__)

# [1] 분석) 사진을 전송 받음.
## 프론트(요청) -> 스프링(요청) -> 머신러닝
### 요청 : 사진(구글 드라이브) / 키, 몸무게 
### 응답 : 스타일 / 추출 색상

@app.route('/')
def hi():
    return 'Hello world!'

if __name__ == '__main__':
    app.run()