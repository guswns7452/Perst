package com.clothes.perst.persistance;

import com.clothes.perst.domain.PersonalTipVO;
import org.springframework.data.repository.CrudRepository;

public interface PersonalTipRepository extends CrudRepository<PersonalTipVO, Integer> {

    PersonalTipVO save(PersonalTipVO personalTipVO);

    PersonalTipVO findByPersonalTipType(String personalTipType);

}
