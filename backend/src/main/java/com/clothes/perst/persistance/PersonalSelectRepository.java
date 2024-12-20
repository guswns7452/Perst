package com.clothes.perst.persistance;

import com.clothes.perst.domain.PersonalSelectVO;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface PersonalSelectRepository extends CrudRepository<PersonalSelectVO, Integer> {
    PersonalSelectVO save(PersonalSelectVO personalSelectVO);

    List<PersonalSelectVO> findAllByPersonalColorNumber(int personalColorNumber);
}