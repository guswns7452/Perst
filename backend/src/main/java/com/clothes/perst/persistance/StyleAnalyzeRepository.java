package com.clothes.perst.persistance;

import com.clothes.perst.domain.StyleAnalyzeVO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StyleAnalyzeRepository extends JpaRepository<StyleAnalyzeVO, StyleAnalyzeVO> {
    StyleAnalyzeVO save(StyleAnalyzeVO styleAnalze);
}
