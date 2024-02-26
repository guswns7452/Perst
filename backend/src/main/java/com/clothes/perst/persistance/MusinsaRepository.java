package com.clothes.perst.persistance;

import com.clothes.perst.domain.MusinsaVO;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MusinsaRepository extends CrudRepository<MusinsaVO, MusinsaVO> {
    MusinsaVO save(MusinsaVO musinsaVO);
    List<MusinsaVO> findAllByMusinsaGenderAndMusinsaStyle(String musinsaGender, String musinsaStyle);
}
