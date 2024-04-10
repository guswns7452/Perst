package com.clothes.perst.persistance;

import com.clothes.perst.domain.PersonalSelectVO;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PersonalSelectRepository extends CrudRepository<PersonalSelectVO, PersonalSelectVO> {
    PersonalSelectVO save(PersonalSelectVO personalSelectVO);

    List<PersonalSelectVO> findAllByPersonalColorNumber(int personalColorNumber);
}