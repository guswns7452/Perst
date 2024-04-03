package com.clothes.perst.persistance;

import com.clothes.perst.DTO.RepresentativeColorDTO;
import com.clothes.perst.domain.RepresentativeColorVO;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface RepresentativeColorRepository extends CrudRepository<RepresentativeColorVO, RepresentativeColorVO> {

    List<RepresentativeColorDTO> findAllByRepresentativeColorPersonalColor(String personalColor);

}
