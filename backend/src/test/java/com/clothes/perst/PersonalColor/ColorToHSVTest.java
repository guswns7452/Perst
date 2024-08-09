package com.clothes.perst.PersonalColor;

import com.clothes.perst.domain.MusinsaVO;
import com.clothes.perst.service.MusinsaService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
public class ColorToHSVTest {
    private final MusinsaService musinsaService;

    public ColorToHSVTest(MusinsaService musinsaService) {
        this.musinsaService = musinsaService;
    }

    @Test
    public static void main(String[] args) {
        // JSON 파일 경로
        String jsonFilePath = "src/main/resources/colorToHSV.json";

        // ObjectMapper 객체 생성
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // JSON 파일을 읽어서 HashMap에 데이터 로드
            File jsonFile = new File(jsonFilePath);
            TypeReference<HashMap<String, List<Map<String, int[]>>>> typeRef = new TypeReference<HashMap<String, List<Map<String, int[]>>>>() {};
            HashMap<String, List<Map<String, int[]>>> colorMap = objectMapper.readValue(jsonFile, typeRef);

            // HashMap 출력 (테스트)
            System.out.println("HashMap 출력:");

            MusinsaVO musinsaVO = new MusinsaVO();
            musinsaVO.setMusinsaStyle("dandy");
            musinsaVO.setMusinsaGender("man");

            List<String> color = new ArrayList<>();
            color.add("sky");


            /*
            for (Map.Entry<String, List<Map<String, int[]>>> entry : colorMap.entrySet()) {
                String colorName = entry.getKey();
                List<Map<String, int[]>> ranges = entry.getValue();
                System.out.println("색상: " + colorName);
                for (Map<String, int[]> range : ranges) {
                    System.out.println(" - 범위:");
                    for (Map.Entry<String, int[]> rangeEntry : range.entrySet()) {
                        String attribute = rangeEntry.getKey();
                        int[] values = rangeEntry.getValue();
                        System.out.println("   " + attribute + ": " + Arrays.toString(values));
                    }
                }
            }*/
        } catch (IOException e) {
            System.err.println("파일 읽기 오류: " + e.getMessage());
        }
    }
}

