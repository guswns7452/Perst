package com.clothes.perst.service;

import com.clothes.perst.DTO.RestResponse;
import com.clothes.perst.domain.StyleAnalyzeVO;
import com.clothes.perst.domain.StyleColorVO;
import com.clothes.perst.persistance.StyleAnalyzeColorRepository;
import com.clothes.perst.persistance.StyleAnalyzeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Service
public class StyleAnalyzeService {
    private final StyleAnalyzeRepository styleAnalyzeJPA;
    private final StyleAnalyzeColorRepository styleAnalyzeColorRepository;

    @Autowired
    public StyleAnalyzeService(StyleAnalyzeRepository styleAnalyzeJPA, StyleAnalyzeColorRepository styleAnalyzeColorRepository) {
        this.styleAnalyzeJPA = styleAnalyzeJPA;
        this.styleAnalyzeColorRepository = styleAnalyzeColorRepository;
    }

    /**
     * DB에 저장하는 코드
     */
    public StyleAnalyzeVO saveStyleAnalyze(StyleAnalyzeVO styleAnalyze){
        return styleAnalyzeJPA.save(styleAnalyze);
    }

    public void saveStyleColor(List<StyleColorVO> colors) {
        for(StyleColorVO color : colors){
            styleAnalyzeColorRepository.save(color);
        }
    }

    public RestResponse ConnectFlaskServer(String requestBody){
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        String apiUrl = "http://127.0.0.1:5000/style/analyze";
        ResponseEntity<RestResponse> response = restTemplate.postForEntity(apiUrl, entity, RestResponse.class);

        RestResponse responseBody = response.getBody();

        return responseBody;
    }
}
