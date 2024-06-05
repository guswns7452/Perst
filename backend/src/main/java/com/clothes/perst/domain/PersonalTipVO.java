package com.clothes.perst.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "personal_tip") // 테이블 이름을 명시해줄 수 있습니다.
public class PersonalTipVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int personalTipNumber;

    private String personalTipType;

    private String personalTipFileId;

    /**
     * 객체 생성자
     * @param personalTipType
     * @param personalTipFileID
     */
    public PersonalTipVO(String personalTipType, String personalTipFileID){
        this.personalTipType = personalTipType;
        this.personalTipFileId = personalTipFileID;
    }

    public PersonalTipVO() {

    }
}
