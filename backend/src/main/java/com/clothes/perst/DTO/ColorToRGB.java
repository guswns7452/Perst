package com.clothes.perst.DTO;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ColorToRGB {

    public List<Map<String, int[]>> getHSV(String color){
        String jsonFilePath = "src/main/resources/colorToHSV.json";

        // ObjectMapper 객체 생성
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // JSON 파일을 읽어서 HashMap에 데이터 로드
            File jsonFile = new File(jsonFilePath);
            TypeReference<HashMap<String, List<Map<String, int[]>>>> typeRef = new TypeReference<HashMap<String, List<Map<String, int[]>>>>() {};
            HashMap<String, List<Map<String, int[]>>> colorMap = objectMapper.readValue(jsonFile, typeRef);

            return colorMap.get(color);

        } catch (IOException e) {
            System.err.println("파일 읽기 오류: " + e.getMessage());
        }

        return null;
    }

}
