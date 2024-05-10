package com.clothes.perst.DTO;

import com.clothes.perst.domain.StyleAnalyzeVO;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@Setter
public class TransferStyleAnalyzeDTO {
    private List<TransferStyleAnalyzeListDTO> myAnalyzeList = new ArrayList<>();
    private Map<String, Integer> myStyle = new HashMap<>();  // 내 스타일 이력도 보여줌
    private int myStyleLength;


    // 기존의 스타일 분석 리스트를 통해서, 전송용 객체로 변경
    public TransferStyleAnalyzeDTO(List<StyleAnalyzeVO> styles){
        // 내 스타일 분석 횟수를 세기 위한 변수
        int count = 0;

        for(StyleAnalyzeVO style: styles){
            TransferStyleAnalyzeListDTO transfer = new TransferStyleAnalyzeListDTO(style);
            this.myAnalyzeList.add(transfer);
            
            String styleName = style.getStyleName();
            if (this.myStyle.get(styleName) == null){
                this.myStyle.put(styleName, 1);
            }else{
                int num = this.myStyle.get(styleName) + 1;
                this.myStyle.put(styleName, num);
            }
            count ++;
        }
        this.myStyleLength = count;
    }
}
