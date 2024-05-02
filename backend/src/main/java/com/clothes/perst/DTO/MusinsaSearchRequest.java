package com.clothes.perst.DTO;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class MusinsaSearchRequest {
    private List<String> color;
    private int memberNumber; // 회원 번호
    private Boolean isPersonal; // 퍼스널 컬러를 반영한 검색을 하는가?
}
