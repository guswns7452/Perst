## [크롤링] 프로세스 소개
## 1. musinsa_brandsnap_crawling 파일 저장
## 2. musinsa_codishop_crawling 파일 저장
## 3. 

from musinsa_brandsnap_crawling import brand_main
from musinsa_codishop_crawling import codi_main

import sys, os

sys.path.append(os.getcwd())
from personal_color.musinsa_data_analyze import dataChange

PATH = os.getcwd()
# ------------------------------------------ #
# 저장할 폴더 위치를 지정해주세요! #

brand_save_folderPath = PATH + "\\Image\\newimages\\0502_brand\\"
codi_save_folderPath = PATH + "\\Image\\newimages\\20240502\\"

# ------------------------------------------ #

if __name__ == '__main__':
    brand_main(brand_save_folderPath)
    # codi_main(codi_save_folderPath)


    ## 퍼스널 컬러 분석
    ## 구글 드라이브 업로드
    ## DB 업로드 
    # dataChange(brand_save_folderPath, "brandsnap")
    # dataChange(codi_save_folderPath, "codishop")