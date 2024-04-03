package com.clothes.perst.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * 퍼스널 컬러의 대표색상을 저장하는 클래스
 */
@Getter
@Setter
@Entity
@Table(name = "representative_color") // 테이블 이름을 명시해줄 수 있습니다.
public class representativeColorVO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int representativeColorNumber;

    private int representativeColorRed;

    private int representativeColorGreen;

    private int representativeColorBlue;

    private String representativeColorPersonalColor;
}
