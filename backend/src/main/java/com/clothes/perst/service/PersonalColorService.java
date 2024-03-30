package com.clothes.perst.service;

import com.clothes.perst.DTO.PersonalColorDTO;
import com.clothes.perst.domain.PersonalColorVO;
import com.clothes.perst.domain.PersonalSelectVO;
import com.clothes.perst.persistance.PersonalColorRepository;
import com.clothes.perst.persistance.PersonalSelectRepository;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Service
public class PersonalColorService {

    private final PersonalColorRepository personalColorJPA;
    private final PersonalSelectRepository personalSelectJPA;

    public PersonalColorService(PersonalColorRepository personalColorJPA, PersonalSelectRepository personalSelectJPA){
        this.personalColorJPA = personalColorJPA;
        this.personalSelectJPA = personalSelectJPA;

    }

    /**
     * 퍼스널 컬러 진단 후 등록하는 코드ㄱㄷ
     * @param personalColor
     * @return
     */
    public PersonalColorVO registPersonalColor(PersonalColorVO personalColor){
        List<PersonalSelectVO> personalSelectVOList = personalColor.getPersonalSelects();

        // DB에 등록
        personalColorJPA.save(personalColor);

        for(PersonalSelectVO personalSelectVO : personalSelectVOList){
            personalSelectVO.setPersonalColorNumber(personalColor.getPersonalColorNumber());
        }
        personalSelectVOList = (List<PersonalSelectVO>) personalSelectJPA.saveAll(personalSelectVOList);
        personalColor.setPersonalSelects(personalSelectVOList);

        // 선택 순위 정렬하기
        Collections.sort(personalSelectVOList, Comparator.comparingInt(PersonalSelectVO::getPersonalSelectTimes).reversed());
        
        // 명도, 채도, 색상, 상 중 하 정의
        personalColor.setPersonalColorInfo(PersonalColorDTO.getSeasonTone(personalColor.getPersonalColorType()));
        return personalColor;
        
        // TODO 응답 데이터 구성 (✅명도, 채도, 색상 / 어울리는 색상 정의 / ✅선택한 것중 순위)
    }
}
