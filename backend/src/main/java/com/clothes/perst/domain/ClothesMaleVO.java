package com.clothes.perst.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Getter
@Setter
@Entity
@Table(name = "clothes_male") // 테이블 이름을 명시해줄 수 있습니다.
public class ClothesMaleVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int clothesNumber;

    private int clothesTimes;

    private String clothesStyle;

    private String clothesFile;

    private String clothesStore;

    private String clothesFileID;

    /**
     * 생성자로 객체 생성
     * @param clothesTimes
     * @param clothesFile
     * @param clothesFileID
     */
    public ClothesMaleVO(int clothesTimes, String clothesFile, String clothesFileID){
        this.clothesTimes = clothesTimes;
        this.clothesFile = clothesFile;
        this.clothesFileID = clothesFileID;

        String pattern = "^[a-zA-Z]_[0-9]*_[0-9]*_(\\w+)(_M\\.jpg)";

        Pattern regex = Pattern.compile(pattern);
        Matcher matcher = regex.matcher(clothesFile);
        
        if (matcher.find()) {
            String extractedString = matcher.group(1); // word 부분만 추출하여 스타일 등록
            this.clothesStyle = extractedString;
        }else{
            throw new IllegalArgumentException("스타일이 좀 이상한데요?"); // 정규식 추출 실패시 에러 발생
        }
    }

    public ClothesMaleVO() {

    }
}
