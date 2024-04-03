package com.clothes.perst.persistance;

import com.clothes.perst.domain.PersonalSelectVO;
import org.springframework.data.repository.CrudRepository;

public interface PersonalSelectRepository extends CrudRepository<PersonalSelectVO, PersonalSelectVO> {
    PersonalSelectVO save(PersonalSelectVO personalSelectVO);
}