package com.clothes.perst.persistance;

import com.clothes.perst.domain.MusinsaVO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MusinsaRepository extends JpaRepository<MusinsaVO, Long> {

    List<MusinsaVO> findAllByMusinsaGenderAndMusinsaStyle(String musinsaGender, String musinsaStyle);
}
