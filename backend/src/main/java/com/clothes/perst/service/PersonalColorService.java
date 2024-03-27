package com.clothes.perst.service;

import com.clothes.perst.domain.PersonalColorVO;
import com.clothes.perst.domain.PersonalSelectVO;
import com.clothes.perst.persistance.PersonalColorRepository;
import com.clothes.perst.persistance.PersonalSelectRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PersonalColorService {

    private final PersonalColorRepository personalColorJPA;
    private final PersonalSelectRepository personalSelectJPA;

    public PersonalColorService(PersonalColorRepository personalColorJPA, PersonalSelectRepository personalSelectJPA){
        this.personalColorJPA = personalColorJPA;
        this.personalSelectJPA = personalSelectJPA;

    }
    public void registPersonalColor(PersonalColorVO personalColor){
        List<PersonalSelectVO> personalSelectVOList = personalColor.getPersonalSelects();

        // DB에 등록
        personalColorJPA.save(personalColor);
        personalSelectJPA.saveAll(personalSelectVOList);

        // TODO 응답 데이터 구성 (명도, 채도, 색상 / 어울리는 색상 정의 / 선택한 것중 순위)
    }
}
