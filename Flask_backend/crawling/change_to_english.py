#        계절감과 스타일을 영어로 변환         #

def change_style_eng(style):
    style_map = {
        "캐주얼": "casual", 
        "아메카지": "amekaji", 
        "시크": "chic", 
        "스포티": "sporty", 
        "스트릿": "street", 
        "비즈니스캐주얼": "businessCasual", 
        "로맨틱": "romantic", 
        "레트로": "retro", 
        "골프": "golf", 
        "고프코어": "gofcore", 
        "걸리시": "girlish", 
        "미니멀": "minimal", 
        "댄디": "dandy"
    }

    return style_map.get(style)
    
def change_season_eng(season):
    season_map = {
        "봄": "spring", 
        "여름": "summer", 
        "가을": "autumn", 
        "겨울": "winter"
    }
    
    return season_map.get(season)