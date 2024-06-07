# 24-04-20 코드 변경사항
# clothDetection() 함수에 배경과 의상파트를 모두 분류해낼 수 있도록 수정하였습니다.
# 퍼스널 컬러를 추출하는 personalColorExtract()함수를 추가하였습니다.
# 기존의 colorExtract()함수는 personalColorExtract()와 구분하기 위해, 이름을 totalColorExtract()로 변경하였습니다.
# 기존에는 마스크가 [0,1]로만 구분했지만, 이제는 [0~5]까지 구분해내므로 colorExtract()함수의 코드 일부를 수정하였습니다.
# 기존에는 색상의 대표값을 추출할 때, 평균(mean)값을 사용하였지만, 이상값의 영향을 줄이기 위해 중간값(median)을 사용하도록 변경하였습니다.
# 색상 출력형태를 RGB에서 HSV로 변경할까했지만, 통상적으로 사용하는 HSV 색공간과는 숫자범위가 달라서 그대로 RGB형식으로 출력하고있습니다.
# 경로에 한글이 포함된 이미지도 불러올 수 있도록 imgLoad() 함수를 개선하였습니다.

# 이미지 처리
import cv2
import numpy as np
import os

# 모델
from tensorflow import keras
from scipy.cluster import hierarchy  # hierarchical clustering

# 실제 모델파일이 저장된 경로에 맞춰서 수정해주세요
model_dir_path = os.getcwd()+"\\Models\\"

# 지금은 200x200 사이즈로 학습중이지만, 나중에 변경될 수도 있으므로 변수로 작성
img_width = 200
img_height = 200


# 원본 이미지 입력 함수
# 지금은 샘플 이미지를 불러오는 함수인데 나중에 api에서 이미지를 불러오는 방식에 따라 바뀔 수 있습니다.
def imgLoad(fileID, input_type):
    if input_type == "man":
        # 남성 샘플 이미지 불러오기
        img_path = model_dir_path + fileID + ".jpg"
        print(img_path)
    elif input_type == "woman":
        # 여성 샘플 이미지 불러오기
        img_path = model_dir_path + fileID + ".jpg"
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
# 출력: 마스크 이미지. [0~5]로 구분됨.
def clothDetection(input_img):
    # 배경제거 모델 불러오기
    bg_model_path = model_dir_path + "binary_poly_seg_model_0113_01.keras"
    bg_detection_model = keras.models.load_model(bg_model_path)

    # 의상 파츠분리 모델 불러오기
    part_model_path = model_dir_path + "poly_seg_model_0428_02.keras"
    part_detection_model = keras.models.load_model(part_model_path)

    # 배경제거 예측을 위해 list 형태로 만들기
    x_test = [input_img]
    x_test = np.array(x_test)

    # 모델 예측
    bg_preds = bg_detection_model.predict(x_test)
    bg_mask = np.ndarray.round(bg_preds[0])
    bg_mask = bg_mask.astype("uint8")

    # 생성된 마스크를 원본 이미지에 씌워서 배경 제거하기
    bg_masked_img = cv2.bitwise_and(input_img, input_img, mask=bg_mask)

    # 의상 파츠분리 예측을 위해 list 형태로 만들기
    x_test2 = [bg_masked_img]
    x_test2 = np.array(x_test2)

    # 모델 예측
    part_preds = part_detection_model.predict(x_test2)
    part_list = part_preds.argmax(axis=-1)
    part_pred_mask = part_list[0]

    return part_pred_mask


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

    model_path = model_dir_path + "fashion_classification_male_0127_04.keras"
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

    model_path = model_dir_path + "fashion_classification_female_0123_03.keras"
    female_fashion_model = keras.models.load_model(model_path)

    # 예측을 위해 list 형태로 만들기
    x_test = [input_img]
    x_test = np.array(x_test)

    # 모델 예측
    preds = female_fashion_model.predict(x_test)
    pred_label = female_label_name[np.argmax(preds)]
    return pred_label


# 의상 이미지 주요 색상 추출 함수
# 입력: 원본 이미지, 마스크 이미지
# 출력: [[[R값, G값, B값], 비율], [R값, G값, B값], 비율]
def totalColorExtract(ori_img, mask_img):
    # 마스크 영역의 픽셀값 추출
    pixel_list = []
    for he in range(0, 200):
        for wi in range(0, 200):
            if mask_img[he][wi] != 0:
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
        cluster_pixel[i] = np.median(cluster_pixel[i], axis=0)
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


# 퍼스널 컬러 추출 함수
# 입력: 원본 이미지, 마스크 이미지
# 출력: [퍼스널컬러 분류, [R값, G값, B값], 퍼스널컬러 마스크 적용된 이미지]
def personalColorExtract(ori_img, mask_img):
    # 어느 파츠의 색상을 추출할 것인지 결정
    if 2 in np.unique(mask_img):
        mask_part = 2
    elif 1 in np.unique(mask_img):
        mask_part = 1
    elif 4 in np.unique(mask_img):
        mask_part = 4
    elif 3 in np.unique(mask_img):
        mask_part = 3
    else:
        print("Image has no cloth part!!")
        return

    # 해당 파츠의 이진 마스크 생성
    part_mask = np.zeros(mask_img.shape, dtype=np.uint8)
    part_mask[mask_img == mask_part] = 1

    # 해당 파츠를 씌운 이미지 생성
    part_img = cv2.bitwise_and(ori_img, ori_img, mask=part_mask)

    # 해당 파츠의 모든 픽셀값 추출
    pixel_list = []

    for he in range(0, img_height):
        for wi in range(0, img_width):
            if mask_img[he][wi] == mask_part:
                r = ori_img[he][wi][0]
                g = ori_img[he][wi][1]
                b = ori_img[he][wi][2]
                pixel_list.append([r, g, b])

    pixel_list = np.array(pixel_list)

    # 중간값을 계산하여 대표값으로 사용
    median_color = np.median(pixel_list, axis=0)

    # 색공간을 RGB에서 HSV로 변경
    rgb_view = np.full((1, 1, 3), median_color, dtype=np.uint8)
    hsv_view = cv2.cvtColor(rgb_view, cv2.COLOR_RGB2HSV)
    hsv_color = hsv_view[0, 0]

    # 색상, 채도, 명도로 퍼스널컬러 공간 특정
    h = hsv_color[0]  # 색상
    s = hsv_color[1]  # 채도
    v = hsv_color[2]  # 명도

    # 퍼스널 컬러 영역 계산
    # 3분할 s/v  0 < 85 < 170 < 255
    if h >= 75 and h < 165:
        # 쿨톤
        if v > 170:
            personal_label = "Summer Light"
        else:
            if s > 170:
                personal_label = "Winter Bright"
            elif s > 85:
                personal_label = "Summer Bright"
            else:
                if v < 85:
                    personal_label = "Winter Deep"
                else:
                    personal_label = "Summer Mute"
    else:
        # 웜톤
        if v < 85:
            personal_label = "Autumn Deep"
        else:
            if v > 170:
                if s < 85:
                    personal_label = "Spring Light"
                else:
                    personal_label = "Spring Bright"
            else:
                if s > 170:
                    personal_label = "Autumn Strong"
                else:
                    personal_label = "Autumn Mute"

    # 출력: [퍼스널컬러 분류, [R값, G값, B값], 퍼스널컬러 마스크 적용된 이미지]
    output_list = [personal_label, median_color, part_img]
    return output_list


# 종합 메인 코드
# 입력: 원본 이미지, 성별 타입
# 출력: 딕셔너리 [no_background_img, fashion_type, total_color_list, personal_color_label, personal_color_rgb, personal_masked_img]
def cnn_model_main(ori_img, type):
    # 입력 이미지의 크기를 200x200 크기로 조정
    res_img = cv2.resize(
        ori_img, dsize=(img_height, img_width), interpolation=cv2.INTER_AREA
    )
    res_img = np.array(res_img)

    # 입력 이미지의 의상 영역 마스크 생성
    total_mask = clothDetection(res_img)

    # 마스크에서 배경 부분만 빼기
    bg_mask = np.ones(total_mask.shape, dtype=np.uint8)
    bg_mask[total_mask == 0] = 0

    # 마스크를 사용해 배경을 제거
    masked_img = cv2.bitwise_and(res_img, res_img, mask=bg_mask)
    masked_img = np.array(masked_img)

    # 패션 스타일 분류
    if type == "man":
        fashion_label = maleFashionClassification(masked_img)
    elif type == "woman":
        fashion_label = femaleFashionClassification(masked_img)
    else:
        print(
            "type 변수의 입력 형태가 올바르지 않습니다. man과 woman중 하나를 입력해주세요"
        )
        return

    # 의상 주요 색상 추출
    total_color_list = totalColorExtract(ori_img=res_img, mask_img=total_mask)

    # 퍼스널 컬러 추출
    personal_color_list = personalColorExtract(ori_img=res_img, mask_img=total_mask)

    # 결과 출력
    output_dict = {}
    output_dict["no_background_img"] = masked_img
    output_dict["fashion_type"] = fashion_label
    output_dict["total_color_list"] = total_color_list
    output_dict["personal_color_label"] = personal_color_list[0]
    output_dict["personal_color_rgb"] = personal_color_list[1]
    output_dict["personal_masked_img"] = personal_color_list[2]

    return output_dict
