# 테스트하는데 처음 import문이 은근히 시간이 걸리길래 추가한 코드.
print("프로그램 실행중. 기다려주세요.")

# 머신러닝을 진행하려면 import해야하는 자체제작 모듈입니다.
from cnn_model import cnn_model_main

# 샘플 이미지를 불러오기위한 함수입니다.
from cnn_model import imgLoad

# 단위 테스트용 이미지창을 출력하기위한 패키지입니다.
# 다른 프로그램과 연동하여 거기서 이미지를 출력한다면 import하지 않아도 됩니다.
import matplotlib.pyplot as plt

# 단위 테스트용 input 코드입니다.
# @Return : 결과값 Dictionary (패션 타입, RGB, Personal Color)
def machineLearning(fileID, gender):
    ori_img = imgLoad(fileID, gender)
    if ori_img is None:
        print("이미지 파일을 불러오는데 실패하였습니다.")

    output = cnn_model_main(ori_img, gender)

    # 배경이 제거된 이미지 출력
    plt.imshow(output['no_background_img'])
    plt.show()

    # 패션 분류 타입 출력
    print("="*100)
    print("Fashion Type : " + output['fashion_type'])

    # 컬러 리스트 출력
    for color in output['total_color_list']:
        r = color[0][0]
        g = color[0][1]
        b = color[0][2]
        ratio = color[1]

        rgb_string = 'R' + str(r) + ' G' + str(g) + ' B' + str(b) + ' / '
        ratio_string = ('%.2f' % ratio) + '%'
        new_string = rgb_string + ratio_string

        print(new_string)

    # 퍼스널컬러 판별범위 표시용 이미지 출력
    # plt.imshow(output['personal_masked_img'])
    # plt.show()

    # 퍼스널컬러 라벨 출력
    print("Personal Color Type : " + output['personal_color_label'])

    # 퍼스널컬러 대표값 RGB 출력
    ps_r = output['personal_color_rgb'][0]
    ps_g = output['personal_color_rgb'][1]
    ps_b = output['personal_color_rgb'][2]
    print("Personal Color RGB : " + 'R' + str(ps_r) + ' G' + str(ps_g) + ' B' + str(ps_b))
    print("="*100)
    
    return output