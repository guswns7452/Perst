package com.clothes.perst.persistance;

import com.clothes.perst.domain.ClothesMaleVO;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MaleClothesSearchRepository extends CrudRepository<ClothesMaleVO, Integer> {
    // 스타일로 조회하기
    List<ClothesMaleVO> findByClothesStyle(String clothesStyle);
    ClothesMaleVO save(ClothesMaleVO clothes);
}
