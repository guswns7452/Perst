package com.clothes.perst.persistance;

import com.clothes.perst.domain.PersonalColorVO;
import org.springframework.data.repository.CrudRepository;

public interface PersonalColorRepository extends CrudRepository<PersonalColorVO, PersonalColorVO> {
    PersonalColorVO save(PersonalColorVO personalColorVO);

    PersonalColorVO findByMemberNumber(int memberNumber);

    void deleteByMemberNumber(int memberNumber);
}
