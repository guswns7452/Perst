package com.clothes.perst.DTO;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ColorToRGB {

    public static List<Map<String, int[]>> getHSV(String color) {
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // ClassPathResource를 통해 InputStream으로 JSON 파일 읽기
            Resource resource = new ClassPathResource("colorToHSV.json");
            InputStream inputStream = resource.getInputStream();

            // InputStream을 통해 JSON 파일을 읽고 Map<String, List<Map<String, int[]>>>으로 변환
            TypeReference<HashMap<String, List<Map<String, int[]>>>> typeRef = new TypeReference<HashMap<String, List<Map<String, int[]>>>>() {};
            HashMap<String, List<Map<String, int[]>>> colorMap = objectMapper.readValue(inputStream, typeRef);

            // InputStream 사용 후 닫기
            inputStream.close();

            // 주어진 색상에 대한 HSV 값을 반환
            return colorMap.get(color);
        } catch (IOException e) {
            System.err.println("파일 읽기 오류: " + e.getMessage());
        }

        return null;
    }
}
