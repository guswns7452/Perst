# 테스트하는데 처음 import문이 은근히 시간이 걸리길래 추가한 코드.
print("프로그램 실행중. 기다려주세요.")

# 머신러닝을 진행하려면 import해야하는 자체제작 모듈입니다.
from cnn_model import cnn_model_main

# 샘플 이미지를 불러오기위한 함수입니다.
from cnn_model import imgLoad

# 단위 테스트용 이미지창을 출력하기위한 패키지입니다.
# 다른 프로그램과 연동하여 거기서 이미지를 출력한다면 import하지 않아도 됩니다.
import matplotlib.pyplot as plt

def machineLearning(fileId, gender):
    # 단위 테스트용 input 코드입니다.
    user_input = gender
    ori_img = imgLoad(fileId, user_input)
    if ori_img is None:
        print("이미지 파일을 불러오는데 실패하였습니다.")

    output = cnn_model_main(ori_img, user_input)

    # 배경이 제거된 이미지 출력
    # plt.imshow(output[0])
    # plt.show()

    return output;