package com.clothes.perst.persistance;

import com.clothes.perst.domain.CoordinateVO;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

/**
 * 스타일 분석 후 코디법 이미지 관련 DB 저장
 */
@Repository
public interface CoordinateRepository extends CrudRepository<CoordinateVO, Integer> {

    CoordinateVO save(CoordinateVO codi);

    List<CoordinateVO> findAllByCoordinateGenderAndCoordinateStyle(String coordinateGender, String coordinateStyle);
    
    // File ID를 검색하는 메소드
    default List<String> searchFileID(String gender, String style){
        List<String> fileIDS = new ArrayList<>();

        List<CoordinateVO> codis = new ArrayList<>();
        codis = findAllByCoordinateGenderAndCoordinateStyle(gender, style);
        for (CoordinateVO codi: codis){
            fileIDS.add(codi.getCoordinateFileId());
        }
        return fileIDS;
    }
}
