##
# 퍼스널 컬러 범위를 정의한 코드입니다.
#

import colorsys

def rgb_to_hsv(r, g, b):
    temp = colorsys.rgb_to_hsv(r, g, b)
    h = int(temp[0] * 360)
    s = int(temp[1] * 100)
    v = round(temp[2] * 100 / 255)
    return [h, s, v]


## input : list(r,g,b)
## call : rgv_to_hsv
## return : personal_type
def get_season_tone(args):
    r,g,b = map(float, args)
    
    h,s,v = map(float, rgb_to_hsv(r,g,b))
    
    conditions = {
        "봄 라이트": [
            (330 <= h <= 360 or 0 <= h < 150, 0 <= s < 50, 75 <= v <= 100)
        ],
        "봄 브라이트": [
            (330 <= h <= 360 or 0 <= h < 150, 50 <= s < 75, 66.6 <= v <= 100),
            (330 <= h <= 360 or 0 <= h < 150, 75 <= s < 100, 20 <= v <= 100)
        ],
        "여름 라이트": [
            (150 <= h < 330, 0 <= s < 50, 75 <= v <= 100)
        ],
        "여름 브라이트": [
            (150 <= h < 330, 50 <= s < 75, 66.6 <= v <= 100)
        ],
        "여름 뮤트": [
            (150 <= h < 330, 0 <= s < 50, 25 <= v < 75)
        ],
        "가을 뮤트": [
            (330 <= h <= 360 or 0 <= h < 150, 0 <= s < 50, 25 <= v < 75)
        ],
        "가을 스트롱": [
            (330 <= h <= 360 or 0 <= h < 150, 50 <= s < 75, 33.3 <= v < 66.6)
        ],
        "가을 딥": [
            (330 <= h <= 360 or 0 <= h < 150, 0 <= s < 50, 0 <= v < 25),
            (330 <= h <= 360 or 0 <= h < 150, 50 <= s < 75, 0 <= v < 33.3)
        ],
        "겨울 브라이트": [
            (150 <= h < 330, 50 <= s < 75, 33.3 <= v < 66.6),
            (150 <= h < 330, 75 <= s <= 100, 20 <= v <= 100)
        ],
        "겨울 딥 ": [
            (150 <= h < 330, 0 <= s <= 50, 0 <= v < 25),
            (150 <= h < 330, 50 <= s <= 75, 0 <= v < 33.3),
            (0 <= h <= 360, 75 <= s <= 100, 0 <= v < 20)
        ]
    }

    for tone, conds in conditions.items():
        if any(all(cond) for cond in conds):
            return tone
    return "해당되는 계절/톤이 없습니다."


