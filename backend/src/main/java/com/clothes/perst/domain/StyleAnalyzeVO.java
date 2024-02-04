package com.clothes.perst.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "style_analyze") // 테이블 이름을 명시해줄 수 있습니다.
public class StyleAnalyzeVO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int styleNumber;

    private int memberNumber;

    private String styleFileID;

    private String styleName;

    private String styleFeedback;

    private String styleColor;

    @Temporal(TemporalType.TIMESTAMP)
    private Date styleDate;
}
