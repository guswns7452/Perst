package com.clothes.perst.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "member") // 테이블 이름을 명시해줄 수 있습니다.
public class MemberVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int memberNumber;

    private String memberName;
    private String memberPhone;
    private String memberPassword;
    private Date memberBirth;
    private String memberSex;
    private float memberHeight;
    private float memberWeight;

}

