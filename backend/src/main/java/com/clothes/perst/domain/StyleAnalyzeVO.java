package com.clothes.perst.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name = "style_analyze") // 테이블 이름을 명시해줄 수 있습니다.
public class StyleAnalyzeVO {
    public StyleAnalyzeVO(String fashionType, String styleFileID, int memberNumber, String personalColorType){
        this.styleName = fashionType;
        this.styleFileID = styleFileID;
        this.memberNumber = memberNumber;
        this.stylePersonalColor = personalColorType;
    }
    public StyleAnalyzeVO(){

    }
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int styleNumber;

    private int memberNumber;

    private String styleFileID;

    private String styleName;

    private String styleFeedback;

    private String stylePersonalColor;

    @Transient // DB에 포함하지 않는 변수
    private List<StyleColorVO> styleColor;

    @Transient // DB에 포함하지 않는 변수
    private List<String> styleCommentFileID;

    @CreatedDate
    private Date styleDate;
}
