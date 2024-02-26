package com.clothes.perst.persistance;

import com.clothes.perst.domain.MusinsaVO;
import org.springframework.data.repository.CrudRepository;

public interface MusinsaRepository extends CrudRepository<MusinsaVO, MusinsaVO> {
    MusinsaVO save(MusinsaVO musinsaVO);
}
