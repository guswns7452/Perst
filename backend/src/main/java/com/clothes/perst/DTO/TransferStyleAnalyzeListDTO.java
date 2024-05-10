package com.clothes.perst.DTO;

import com.clothes.perst.domain.StyleAnalyzeVO;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class TransferStyleAnalyzeListDTO {
    private int styleNumber;
    private String styleFileID;
    private String styleName;
    private Date styleDate;

    // StyleAnalyzeVO -> TransferStyleAnalyzeListDTO
    public TransferStyleAnalyzeListDTO(StyleAnalyzeVO style){
        this.styleName = style.getStyleName(); this.styleNumber = style.getStyleNumber();
        this.styleFileID = style.getStyleFileID(); this.styleDate = style.getStyleDate();
    }
}
