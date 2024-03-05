package com.clothes.perst.domain;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "musinsa") // 테이블 이름을 명시해줄 수 있습니다.
@Schema(name = "musinsa", description = "무신사 페이지")
public class MusinsaVO {

    public MusinsaVO(List<String> fileMetaData){
        this.musinsaGender = fileMetaData.get(0);
        this.musinsaNumber = Integer.parseInt(fileMetaData.get(1));
        this.musinsaHeight = Integer.parseInt(fileMetaData.get(2));
        this.musinsaWeight = Integer.parseInt(fileMetaData.get(3));
        this.musinsaSeason = fileMetaData.get(4);
        this.musinsaStyle = fileMetaData.get(5);
        this.musinsaFileid = fileMetaData.get(6);
    }

    @Id
    private int musinsaNumber;

    private String musinsaGender;

    private int musinsaHeight;

    private int musinsaWeight;

    private String musinsaSeason;

    private String musinsaStyle;

    private String musinsaFileid;

    private String musinsaType;

    public MusinsaVO() {

    }
}

