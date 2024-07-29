package com.clothes.perst.domain;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "personal_select") // 테이블 이름을 명시해줄 수 있습니다.
@Schema(name = "personal_select", description = "퍼스널 컬러 선택 횟수")
public class PersonalSelectVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int personalSelectNumber;

    private String personalSelectType;

    private int personalSelectTimes;

    private int personalColorNumber;
}
