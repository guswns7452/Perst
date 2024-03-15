package com.clothes.perst.service;

import com.clothes.perst.domain.MusinsaVO;
import com.clothes.perst.persistance.MusinsaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MusinsaService {
    private final MusinsaRepository musinsaJPA;

    @Autowired
    public MusinsaService(MusinsaRepository musinsaJPA) {
        this.musinsaJPA = musinsaJPA;
    }

    public List<MusinsaVO> findByMusinsaGenderAndMusinsaStyle(MusinsaVO musinsaVO){
        return musinsaJPA.findAllByMusinsaGenderAndMusinsaStyle(musinsaVO.getMusinsaGender(), musinsaVO.getMusinsaStyle());
    }
}
