package com.clothes.perst.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "style_analyze_color") // 테이블 이름을 명시해줄 수 있습니다.
public class StyleColorVO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int styleColorNumber;

    private int styleNumber;

    private int styleRed;

    private int styleGreen;

    private int styleBlue;

    private float styleRatio;

    public StyleColorVO(String color1, int styleNumber) {
        color1 = color1.replace("[","");
        color1 = color1.replace("]","");

        List colors = List.of(color1.split(", "));
        this.styleRed = Integer.parseInt((String) colors.get(0));
        this.styleGreen = Integer.parseInt((String) colors.get(1));
        this.styleBlue = Integer.parseInt((String) colors.get(2));
        this.styleRatio = Float.parseFloat((String) colors.get(3));
        this.styleNumber = styleNumber;
    }

    public StyleColorVO() {

    }
}
