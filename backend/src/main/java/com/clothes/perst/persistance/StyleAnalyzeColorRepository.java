package com.clothes.perst.persistance;

import com.clothes.perst.domain.StyleColorVO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StyleAnalyzeColorRepository extends JpaRepository<StyleColorVO, Integer> {
    StyleColorVO save(StyleColorVO styleAnalyzeColor);
}
