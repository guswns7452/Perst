package com.clothes.perst.domain;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "clothes") // 테이블 이름을 명시해줄 수 있습니다.
public class ClothesVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int clothesNumber;

    private String clothesSex;

    private String clothesStyle;

    private String clothesFile;

    private String clothesStore;
}
