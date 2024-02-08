package com.clothes.perst.persistance;

import com.clothes.perst.domain.ClothesFemaleVO;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FemaleClothesSearchRepository extends CrudRepository<ClothesFemaleVO, ClothesFemaleVO> {
    List<ClothesFemaleVO> findByClothesStyle(String clothesStyle);
    ClothesFemaleVO save(ClothesFemaleVO clothes);
}
