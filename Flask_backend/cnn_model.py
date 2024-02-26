# 이미지 처리
import cv2
import numpy as np

# 모델
from tensorflow import keras
from scipy.cluster import hierarchy  # hierarchical clustering

# 실제 모델파일이 저장된 경로에 맞춰서 수정해주세요
model_dir_path = "D:\\perstDir\\Flask_backend\\Models\\"

# 원본 이미지 입력 함수
# 지금은 샘플 이미지를 불러오는 함수인데 나중에 api에서 이미지를 불러오는 방식에 따라 바뀔 수 있습니다.
def imgLoad(fileID, input_type):
    if input_type == "man":
        # 남성 샘플 이미지 불러오기
        img_path = model_dir_path + fileID + ".jpg";
        print(img_path)
    elif input_type == "woman":
        # 여성 샘플 이미지 불러오기
        img_path = model_dir_path + "img_sample_female.jpg"
    else:
        print(
            "img_type 변수의 입력 형태가 올바르지 않습니다. male과 female중 하나를 입력해주세요"
        )
        return

    img_file = cv2.imread(img_path)
    if img_file is None:
        print(
            "이미지 파일을 불러오는데 실패했습니다. 해당 파일이 존재하는지 확인해주세요"
        )
        return
    else:
        # 색상 공간을 RGB 형태로 변경
        img_file = cv2.cvtColor(img_file, cv2.COLOR_BGR2RGB)
        return img_file


# 의상 영역 마스킹 함수
# 입력: 원본 이미지 (200x200 사이즈)
# 출력: 마스크 이미지
def clothDetection(input_img):
    # 모델 불러오기
    model_path = model_dir_path + "binary_poly_seg_model_0113_01"
    cloth_detection_model = keras.models.load_model(model_path)

    # 예측을 위해 list 형태로 만들기
    x_test = [input_img]
    x_test = np.array(x_test)

    # 모델 예측
    preds = cloth_detection_model.predict(x_test)
    pred_mask = np.ndarray.round(preds[0])
    pred_mask = pred_mask.astype("uint8")
    return pred_mask


# 패션 분류 모델 (남성)
# 입력: 배경이 제거된 이미지 (200x200 사이즈)
# 출력: 패션 분류명 string
def maleFashionClassification(input_img):
    male_label_name = [
        "Ivy",
        "Mods",
        "Hippie",
        "Bold",
        "Hip-hop",
        "Metrosexual",
        "Sportive-Casual",
        "Normcore",
    ]

    model_path = model_dir_path + "fashion_classification_male_0127_04"
    male_fashion_model = keras.models.load_model(model_path)

    # 예측을 위해 list 형태로 만들기
    x_test = [input_img]
    x_test = np.array(x_test)

    # 모델 예측
    preds = male_fashion_model.predict(x_test)
    pred_label = male_label_name[np.argmax(preds)]
    return pred_label


# 패션 분류 모델 (여성)
# 입력: 배경이 제거된 이미지 (200x200 사이즈)
# 출력: 패션 분류명 string
def femaleFashionClassification(input_img):
    female_label_name = [
        "Traditional",
        "Manish",
        "Feminine",
        "Ethnic",
        "Contemporary",
        "Natural",
        "Gender-Fluid",
        "Sporty",
        "Subculture",
        "Casual",
    ]

    model_path = model_dir_path + "fashion_classification_female_0123_03"
    female_fashion_model = keras.models.load_model(model_path)

    # 예측을 위해 list 형태로 만들기
    x_test = [input_img]
    x_test = np.array(x_test)

    # 모델 예측
    preds = female_fashion_model.predict(x_test)
    pred_label = female_label_name[np.argmax(preds)]
    return pred_label


# 의상 이미지 주요 색상 추출 함수
# 입력: 원본 이미지, 마스크 이미지, 결과를 저장할 리스트
# 출력: [[[R값, G값, B값], 비율], [R값, G값, B값], 비율]
def colorExtract(ori_img, mask_img):
    # 마스크 영역의 픽셀값 추출
    pixel_list = []
    for he in range(0, 200):
        for wi in range(0, 200):
            if mask_img[he][wi] == 1:
                r = ori_img[he][wi][0]
                g = ori_img[he][wi][1]
                b = ori_img[he][wi][2]
                pixel_list.append([r, g, b])
    pixel_list = np.array(pixel_list)

    # 픽셀값 클러스터링
    cluster = hierarchy.linkage(pixel_list, method="centroid", metric="euclidean")
    predict = hierarchy.fcluster(
        cluster, 70, criterion="distance"
    )  # 거리 70까지 cluster 개수 정하기

    # 각 군집별 평균색상 계산
    cluster_pixel = []
    for i in range(0, len(np.unique(predict))):
        cluster_pixel.append([])

    for i in range(0, len(predict)):
        cluster_pixel[predict[i] - 1].append(pixel_list[i])

    for i in range(0, len(cluster_pixel)):
        cluster_pixel[i] = np.array(cluster_pixel[i])

    for i in range(0, len(cluster_pixel)):
        cluster_pixel[i] = np.mean(cluster_pixel[i], axis=0)
        cluster_pixel[i] = cluster_pixel[i].astype(int)

    # 각 군집을 빈도순으로 내림차순 정렬하고 비율 계산
    cluster_label, cluster_count = np.unique(predict, return_counts=True)

    cluster_count_dict = {}
    for i in range(0, len(cluster_label)):
        cluster_count_dict[cluster_label[i]] = cluster_count[i]

    cluster_count_dict = sorted(
        cluster_count_dict.items(), key=lambda item: item[1], reverse=True
    )

    cluster_label = []
    cluster_count = []

    for item in cluster_count_dict:
        cluster_label.append(item[0])
        cluster_count.append(item[1])

    cluster_total = np.sum(cluster_count)
    cluster_ratio = []

    for i in range(0, len(cluster_count)):
        ratio = (cluster_count[i] / cluster_total) * 100
        cluster_ratio.append(ratio)

    # 새롭게 리스트 형태로 만들기
    output_list = []
    for i in range(0, len(cluster_label)):
        rgb = cluster_pixel[cluster_label[i] - 1]
        ratio = cluster_ratio[i]
        tmp_list = [rgb, ratio]
        output_list.append(tmp_list)

    return output_list


# 종합 메인 코드
# 입력: 원본 이미지, 성별 타입
# 출력: 리스트 [배경 제거된 이미지 파일, '패션 분류명', [주요색상 RGB값 리스트]]
def cnn_model_main(ori_img, type):
    # 입력 이미지의 크기를 200x200 크기로 조정
    res_img = cv2.resize(ori_img, dsize=(200, 200), interpolation=cv2.INTER_AREA)
    res_img = np.array(res_img)

    # 입력 이미지의 의상 영역 마스크 생성
    mask = clothDetection(res_img)

    # 마스크를 사용해 배경을 제거
    masked_img = cv2.bitwise_and(res_img, res_img, mask=mask)
    masked_img = np.array(masked_img)

    # 패션 스타일 분류
    if type == "man":
        fashion_label = maleFashionClassification(masked_img)
    elif type == "woman":
        fashion_label = femaleFashionClassification(masked_img)
    else:
        print(
            "type 변수의 입력 형태가 올바르지 않습니다. male과 female중 하나를 입력해주세요"
        )
        return

    # 의상 주요 색상 추출
    color_list = colorExtract(ori_img=res_img, mask_img=mask)

    # 결과 출력
    output_list = [masked_img, fashion_label, color_list]
    return output_list
