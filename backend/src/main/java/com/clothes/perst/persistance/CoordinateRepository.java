package com.clothes.perst.persistance;

import com.clothes.perst.domain.ClothesFemaleVO;
import com.clothes.perst.domain.CoordinateVO;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * 스타일 분석 후 코디법 이미지 관련 DB 저장
 */
@Repository
public interface CoordinateRepository extends CrudRepository<ClothesFemaleVO, ClothesFemaleVO> {

    void save(CoordinateVO codi);

}
