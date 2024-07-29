package com.clothes.perst.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "coordinate") // 테이블 이름을 명시해줄 수 있습니다.
public class CoordinateVO {

    public CoordinateVO(List<String> fileMetaData){
        this.coordinateGender = fileMetaData.get(0);
        this.coordinateStyle = fileMetaData.get(1);
        this.coordinatePictureNumber = Integer.parseInt(fileMetaData.get(2));
        this.coordinateFileId = fileMetaData.get(3);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int coordinateNumber;

    private String coordinateGender;

    private String coordinateStyle;

    private int coordinatePictureNumber;

    private String coordinateFileId;

    public CoordinateVO() {

    }
}
