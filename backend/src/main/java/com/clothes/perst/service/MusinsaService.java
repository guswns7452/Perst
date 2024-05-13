package com.clothes.perst.service;

import com.clothes.perst.DTO.ColorToRGB;
import com.clothes.perst.DTO.MusinsaSearchRequest;
import com.clothes.perst.domain.MusinsaVO;
import com.clothes.perst.persistance.MusinsaRepository;
import com.clothes.perst.persistance.PersonalColorRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class MusinsaService {
    private final MusinsaRepository musinsaJPA;
    private final PersonalColorRepository personalColorJPA;
    private static final Logger logger = LoggerFactory.getLogger(MusinsaService.class);


    @Autowired
    public MusinsaService(MusinsaRepository musinsaJPA, PersonalColorRepository personalColorJPA) {
        this.musinsaJPA = musinsaJPA;
        this.personalColorJPA = personalColorJPA;
    }

    public List<MusinsaVO> findByMusinsaGenderAndMusinsaStyle(MusinsaVO musinsaVO, MusinsaSearchRequest musinsaSearchRequest) {
        List<MusinsaVO> musinsaVOList = new ArrayList<>();
        String memberPersonal = "none";

        try{
            // 회원의 퍼스널 컬러를 반영할 것인가?
            if(musinsaSearchRequest.getIsPersonal()){
                logger.info(Integer.toString(musinsaSearchRequest.getMemberNumber()));
                logger.info(personalColorJPA.findByMemberNumber(musinsaSearchRequest.getMemberNumber()).toString());
                memberPersonal = personalColorJPA.findByMemberNumber(musinsaSearchRequest.getMemberNumber()).getPersonalColorType();
            }
        } catch (NullPointerException e){
            throw new NullPointerException("회원님 아직 퍼스널 컬러 진단 이력이 없어요!");
        }

        // 계절감 상관 없이 검색
        if(musinsaSearchRequest.getSeason().equals("all")){
            logger.info(musinsaSearchRequest.getSeason());
            try {
                if (!musinsaSearchRequest.getColor().isEmpty()) {
                    for (String color : musinsaSearchRequest.getColor()) {
                        for (Map<String, int[]> map : ColorToRGB.getHSV(color)) {
                            int[] Hue = map.get("H"); // [0, 360]의 범위
                            int[] Saturation = map.get("S");
                            int[] Value = map.get("V");

                            // gender, style, personal, color 모두 반영하여 검색
                            if (!memberPersonal.equals("none")) {
                                musinsaVOList.addAll(musinsaJPA.findAllByMusinsaGenderAndMusinsaStyleAndMusinsaPersonalAndMusinsaHueBetweenAndMusinsaSaturationBetweenAndMusinsaValueBetween(musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle(), memberPersonal, Hue[0], Hue[1], Saturation[0], Saturation[1], Value[0], Value[1]));

                            }
                            // gender, style, color 만 반영함
                            else{
                                musinsaVOList.addAll(musinsaJPA.findAllByMusinsaGenderAndMusinsaStyleAndMusinsaHueBetweenAndMusinsaSaturationBetweenAndMusinsaValueBetween(musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle(), Hue[0], Hue[1], Saturation[0], Saturation[1], Value[0], Value[1]));

                            }
                        }
                    }

                    return musinsaVOList;
                }
            } catch (NullPointerException e) {
                throw new IllegalArgumentException("정의되지 않은 색상입니다.");
            }
            // Color가 없으면, 모두 리턴함
            if (!musinsaSearchRequest.getIsPersonal()) {
                return musinsaJPA.findAllByMusinsaGenderAndMusinsaStyle(musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle());
            } else {
                return musinsaJPA.findAllByMusinsaGenderAndMusinsaStyleAndMusinsaPersonal(musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle(), memberPersonal);
            }
        }

        // 계절 고려하여 검색
        else{
            try {
                if (!musinsaSearchRequest.getColor().isEmpty()) {
                    for (String color : musinsaSearchRequest.getColor()) {
                        for (Map<String, int[]> map : ColorToRGB.getHSV(color)) {
                            int[] Hue = map.get("H"); // [0, 360]의 범위
                            int[] Saturation = map.get("S");
                            int[] Value = map.get("V");

                            // gender, style, personal, color 모두 반영하여 검색
                            if (!memberPersonal.equals("none")) {
                                musinsaVOList.addAll(musinsaJPA.findAllByMusinsaSeasonAndMusinsaGenderAndMusinsaStyleAndMusinsaPersonalAndMusinsaHueBetweenAndMusinsaSaturationBetweenAndMusinsaValueBetween(musinsaSearchRequest.getSeason(), musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle(), memberPersonal, Hue[0], Hue[1], Saturation[0], Saturation[1], Value[0], Value[1]));

                            }
                            // gender, style, color 만 반영함
                            else{
                                musinsaVOList.addAll(musinsaJPA.findAllByMusinsaSeasonAndMusinsaGenderAndMusinsaStyleAndMusinsaHueBetweenAndMusinsaSaturationBetweenAndMusinsaValueBetween(musinsaSearchRequest.getSeason(), musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle(), Hue[0], Hue[1], Saturation[0], Saturation[1], Value[0], Value[1]));

                            }
                        }
                    }

                    return musinsaVOList;
                }
            } catch (NullPointerException e) {
                throw new IllegalArgumentException("정의되지 않은 색상입니다.");
            }
            // Color가 없으면, 모두 리턴함
            if (!musinsaSearchRequest.getIsPersonal()) {
                return musinsaJPA.findAllByMusinsaSeasonAndMusinsaGenderAndMusinsaStyle(musinsaSearchRequest.getSeason(),  musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle());
            } else {
                return musinsaJPA.findAllByMusinsaSeasonAndMusinsaGenderAndMusinsaStyleAndMusinsaPersonal(musinsaSearchRequest.getSeason(), musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle(), memberPersonal);
            }
        }

    }
}
