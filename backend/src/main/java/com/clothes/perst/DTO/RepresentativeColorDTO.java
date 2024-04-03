package com.clothes.perst.DTO;

import com.clothes.perst.domain.RepresentativeColorVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RepresentativeColorDTO {
    public RepresentativeColorDTO(RepresentativeColorVO color){
        this.red = color.getRepresentativeColorRed();
        this.blue = color.getRepresentativeColorBlue();
        this.green = color.getRepresentativeColorGreen();
    }

    private int red;

    private int green;

    private int blue;
}
