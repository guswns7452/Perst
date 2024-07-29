package com.clothes.perst.service;

import com.clothes.perst.domain.ClothesFemaleVO;
import com.clothes.perst.domain.ClothesMaleVO;
import com.clothes.perst.persistance.FemaleClothesSearchRepository;
import com.clothes.perst.persistance.MaleClothesSearchRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Deprecated
@Slf4j
@RequiredArgsConstructor
@Service
public class ClothesSearchService {
    private final MaleClothesSearchRepository maleJPA;
    private final FemaleClothesSearchRepository femaleJPA;

    /**
     * 남성의 의류를 조회하는 메소드
     * @param maleStyle
     * @return List<ClothesMaleVO>
     */
    public List<ClothesMaleVO> findByMaleStyle(String maleStyle){
        List<ClothesMaleVO> maleClothesList = new ArrayList<>();
        maleClothesList = maleJPA.findByClothesStyle(maleStyle);

        if(maleClothesList.isEmpty()){
             throw new IllegalArgumentException("일치하는 스타일이 없습니다.");
        }
        return maleClothesList;
    }

    /**
     * 여성의 의류를 조회하는 메소드
     * @param femaleStyle
     * @return
     */
    public List<ClothesFemaleVO> findByFemaleStyle(String femaleStyle){
        List<ClothesFemaleVO> femaleClothesList = new ArrayList<>();
        femaleClothesList = femaleJPA.findByClothesStyle(femaleStyle);

        if(femaleClothesList.isEmpty()){
            throw new IllegalArgumentException("일치하는 스타일이 없습니다.");
        }
        return femaleClothesList;
    }
}
