package com.clothes.perst.persistance;

import com.clothes.perst.domain.StyleColorVO;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StyleAnalyzeColorRepository extends JpaRepository<StyleColorVO, Integer> {
    StyleColorVO save(StyleColorVO styleAnalyzeColor);

    List<StyleColorVO> findAllByStyleNumber(int styleNumber);
    @Transactional
    void deleteByStyleNumber(int styleNumber);
}
