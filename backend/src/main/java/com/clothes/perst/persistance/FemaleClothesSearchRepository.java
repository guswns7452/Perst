package com.clothes.perst.persistance;

import com.clothes.perst.domain.ClothesFemaleVO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FemaleClothesSearchRepository extends JpaRepository<ClothesFemaleVO, ClothesFemaleVO> {
    List<ClothesFemaleVO> findByClothesStyle(String clothesStyle);
}
