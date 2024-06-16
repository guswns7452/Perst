print("한글경로 대응 테스트 프로그램 실행중. 기다려주세요.")

# 샘플 이미지를 불러오기위한 함수입니다.
from cnn_model import imgLoad

# 단위 테스트용 이미지창을 출력하기위한 패키지입니다.
# 다른 프로그램과 연동하여 거기서 이미지를 출력한다면 import하지 않아도 됩니다.
import matplotlib.pyplot as plt

# 실제 모델파일이 저장된 경로에 맞춰서 수정해주세요
model_dir_path = 'C:\\TUKorea\\Perst\\CNN_Models\\Models\\'

eng_file_path = model_dir_path + 'img_sample_female.jpg'
kor_file_path = model_dir_path + '한글이름테스트.jpg'

print("영어이름파일 불러오기")
eng_img = imgLoad(eng_file_path)
plt.imshow(eng_img)
plt.show()

print("한글이름파일 불러오기")
kor_img = imgLoad(kor_file_path)
plt.imshow(kor_img)
plt.show()
