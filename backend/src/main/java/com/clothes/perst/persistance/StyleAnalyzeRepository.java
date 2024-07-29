package com.clothes.perst.persistance;

import com.clothes.perst.domain.StyleAnalyzeVO;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StyleAnalyzeRepository extends JpaRepository<StyleAnalyzeVO, Integer> {
    StyleAnalyzeVO save(StyleAnalyzeVO styleAnalze);

    StyleAnalyzeVO findByStyleNumber(int StyleNumber);

    List<StyleAnalyzeVO> findAllByMemberNumber(int memberNumber);

    @Transactional
    void deleteByStyleNumber(int styleNumber);
}
