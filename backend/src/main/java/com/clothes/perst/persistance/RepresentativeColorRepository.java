package com.clothes.perst.persistance;

import com.clothes.perst.DTO.RepresentativeColorDTO;
import com.clothes.perst.domain.RepresentativeColorVO;
import org.springframework.data.repository.CrudRepository;

import java.util.ArrayList;
import java.util.List;

public interface RepresentativeColorRepository extends CrudRepository<RepresentativeColorVO, Integer> {

    List<RepresentativeColorVO> findAllByRepresentativeColorPersonalColor(String personalColor);

    default List<RepresentativeColorDTO> representativeColor(String personalColor){
        // DB에서 데이터를 불러와 할당하는 부분
        List<RepresentativeColorVO> representativeColorVOList;
        representativeColorVOList = findAllByRepresentativeColorPersonalColor(personalColor);

        // 전송을 위한 객체 리스트 선언
        List<RepresentativeColorDTO> representativeColorDTOList = new ArrayList<>();

        for(RepresentativeColorVO i : representativeColorVOList){
            RepresentativeColorDTO representativeColorDTO = new RepresentativeColorDTO(i);

            representativeColorDTOList.add(representativeColorDTO);
        }

        return representativeColorDTOList;
    }

}
