package com.clothes.perst.DTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PersonalColorTipDTO {
    private String myPersonalColor;
    private String analyzedPersonalColor;
    private String fileID;

    public PersonalColorTipDTO(String myPersonalColor, String analyzedPersonalColor, String fileID){
        this.myPersonalColor = myPersonalColor;
        this.analyzedPersonalColor = analyzedPersonalColor;
        this.fileID = fileID;
    }
}
