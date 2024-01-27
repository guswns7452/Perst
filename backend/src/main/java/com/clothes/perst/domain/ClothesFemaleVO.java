package com.clothes.perst.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "clothes_female") // 테이블 이름을 명시해줄 수 있습니다.
public class ClothesFemaleVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int clothesNumber;

    private String clothesStyle;

    private String clothesFile;

    private String clothesStore;
}
