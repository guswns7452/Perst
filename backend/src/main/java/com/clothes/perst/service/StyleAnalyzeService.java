package com.clothes.perst.service;

import com.clothes.perst.domain.StyleAnalyzeVO;
import com.clothes.perst.persistance.StyleAnalyzeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StyleAnalyzeService {
    private final StyleAnalyzeRepository styleAnalyzeJPA;

    @Autowired
    public StyleAnalyzeService(StyleAnalyzeRepository styleAnalyzeJPA) {
        this.styleAnalyzeJPA = styleAnalyzeJPA;
    }

    /**
     * DB에 저장하는 코드
     */
    public StyleAnalyzeVO saveStyleAnalyze(StyleAnalyzeVO styleAnalyze){
        return styleAnalyzeJPA.save(styleAnalyze);
    }
}
