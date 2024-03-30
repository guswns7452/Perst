package com.clothes.perst.domain;

import com.clothes.perst.DTO.PersonalColorInfo;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "personal_color") // 테이블 이름을 명시해줄 수 있습니다.
@Schema(name = "personal_color", description = "퍼스널 컬러 진단 객체")
public class PersonalColorVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int personalColorNumber;

    private String personalColorType; // 진단한 퍼스널 컬러 타입 / ex : "겨울 딥"

    private int personalColorAllTimes; // 전체 퍼스널 컬러 진단 횟수

    private Date personalColorDate; // 퍼스널 컬러 날짜

    @Transient // DB에 포함하지 않는 변수
    private List<PersonalSelectVO> personalSelects;

    @Transient // DB에 포함하지 않는 변수
    private PersonalColorInfo personalColorInfo;

    private int memberNumber; // 외래키
}
