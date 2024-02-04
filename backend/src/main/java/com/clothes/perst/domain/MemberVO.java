package com.clothes.perst.domain;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "member") // 테이블 이름을 명시해줄 수 있습니다.
@Schema(name = "member", description = "회원")
public class MemberVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int memberNumber;
    
    @Schema(name = "memberName", description = "회원 이름", example = "회원 이름")
    private String memberName;

    @Schema(name = "memberPhone", description = "회원 전화번호", example = "01012345678")
    private String memberPhone;

    @Schema(name = "memberPassword", description = "회원 비밀번호", example = "password")
    private String memberPassword;

    @Schema(name = "memberBirth", description = "회원 생년월일", example = "2024-01-27")
    private Date memberBirth;

    @Schema(name = "memberGender", description = "회원 성별", example = "남자/여자")
    private String memberGender;

    @Schema(name = "memberHeight", description = "회원 키", example = "180.4")
    private float memberHeight;

    @Schema(name = "memberWeight", description = "회원 몸무게", example = "62.8")
    private float memberWeight;

}

