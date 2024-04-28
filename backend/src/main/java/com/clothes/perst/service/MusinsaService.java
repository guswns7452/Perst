package com.clothes.perst.service;

import com.clothes.perst.DTO.ColorToRGB;
import com.clothes.perst.domain.MusinsaVO;
import com.clothes.perst.persistance.MusinsaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class MusinsaService {
    private final MusinsaRepository musinsaJPA;

    @Autowired
    public MusinsaService(MusinsaRepository musinsaJPA) {
        this.musinsaJPA = musinsaJPA;
    }

    public List<MusinsaVO> findByMusinsaGenderAndMusinsaStyle(MusinsaVO musinsaVO, List<String> colors){
        List<MusinsaVO> musinsaVOList = new ArrayList<>();
        try{
            if (!colors.isEmpty()){
                for(String color: colors){
                    for(Map<String, int[]> map: ColorToRGB.getHSV(color)){
                        int[] Hue = map.get("H"); // [0, 360]의 범위
                        int[] Saturation = map.get("S");
                        int[] Value = map.get("V");
                        musinsaVOList.addAll(musinsaJPA.findByMusinsaGenderAndMusinsaStyleAndMusinsaHueBetweenAndMusinsaSaturationBetweenAndMusinsaValueBetween(musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle(),Hue[0],Hue[1], Saturation[0], Saturation[1], Value[0], Value[1]));
                    }
                }

                return musinsaVOList;
            }
        }catch (NullPointerException e){
            throw new IllegalArgumentException("정의되지 않은 색상입니다.");
        }


        // Color가 없으면, 모두 리턴함
        return musinsaJPA.findAllByMusinsaGenderAndMusinsaStyle(musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle());
    }
}
