package com.clothes.perst.persistance;

import com.clothes.perst.domain.MusinsaVO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MusinsaRepository extends JpaRepository<MusinsaVO, Long> {

    // 필수 : Gender, Style
    // 선택 : musinsa_personal, color
    
    // Gender, Style로 검색
    List<MusinsaVO> findAllByMusinsaGenderAndMusinsaStyle(String musinsaGender, String musinsaStyle);

    // Gender, Style, personal로 검색
    List<MusinsaVO> findAllByMusinsaGenderAndMusinsaStyleAndMusinsaPersonal(String musinsaGender, String musinsaStyle, String musinsaPersonal);

    // Gender, Style, Color로 검색
    List<MusinsaVO> findAllByMusinsaGenderAndMusinsaStyleAndMusinsaHueBetweenAndMusinsaSaturationBetweenAndMusinsaValueBetween(
            String musinsaGender, String musinsaStyle,
            int minHue, int maxHue,
            int minSaturation, int maxSaturation,
            int minValue, int maxValue
    );

    // Gender, Style, Personal, Color로 검색
    List<MusinsaVO> findAllByMusinsaGenderAndMusinsaStyleAndMusinsaPeronsalAndMusinsaHueBetweenAndMusinsaSaturationBetweenAndMusinsaValueBetween(
            String musinsaGender, String musinsaStyle, String musinsaPersonal,
            int minHue, int maxHue,
            int minSaturation, int maxSaturation,
            int minValue, int maxValue
    );
}

