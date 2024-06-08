package com.clothes.perst.DTO;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PersonalColorDTO {

    public static PersonalColorInfo getSeasonTone(String personalColorType) {

        // 퍼스널 컬러 타입 : ['색상(h)','채도(S)','명도(v)']
        // 상 중 하로 저장함.
        Map<String, List<String>> conditions = new HashMap<>();

        conditions.put("봄 라이트", Arrays.asList("warm", "middle", "top"));
        conditions.put("봄 브라이트", Arrays.asList("warm", "top", "top"));
        conditions.put("여름 라이트", Arrays.asList("cool", "middle", "top"));
        conditions.put("여름 브라이트", Arrays.asList("cool", "middle", "top"));
        conditions.put("여름 뮤트", Arrays.asList("cool", "middle", "middle"));
        conditions.put("가을 뮤트", Arrays.asList("warm", "middle", "middle"));
        conditions.put("가을 스트롱", Arrays.asList("warm", "middle", "middle"));
        conditions.put("가을 딥", Arrays.asList("warm", "middle", "low"));
        conditions.put("겨울 브라이트", Arrays.asList("cool", "top", "middle"));
        conditions.put("겨울 딥", Arrays.asList("cool", "low", "low"));

        // 리스트에 저장
        List<String> list = conditions.get(personalColorType);

        PersonalColorInfo personalColorInfo = new PersonalColorInfo();
        personalColorInfo.setHue(list.get(0));
        personalColorInfo.setSaturation(list.get(1));
        personalColorInfo.setValue(list.get(2));

        return personalColorInfo;
    }

    /**
     * 퍼스널 컬러 타입 : 영어 -> 한글
     * @param Eng_personal_color
     * @return
     */
    public static String changeEngToKor(String Eng_personal_color){
        Map<String, String> lists = new HashMap<>();

        // Spelling 틀릴 수도 있어요..
        lists.put("Spring Light", "봄 라이트");
        lists.put("Spring Bright", "봄 브라이트");
        lists.put("Summer Light", "여름 라이트");
        lists.put("Summer Bright", "여름 브라이트");
        lists.put("Summer Mute", "여름 뮤트");
        lists.put("Autumn Mute", "가을 뮤트");
        lists.put("Autumn Strong", "가을 스트롱");
        lists.put("Autumn Deep", "가을 딥");
        lists.put("Winter Bright", "겨울 브라이트");
        lists.put("Winter Deep", "겨울 딥");

        return lists.get(Eng_personal_color);

    }
}
