package com.clothes.perst.persistance;

import com.clothes.perst.domain.PersonalColorVO;
import jakarta.transaction.Transactional;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PersonalColorRepository extends CrudRepository<PersonalColorVO, PersonalColorVO> {
    PersonalColorVO save(PersonalColorVO personalColorVO);

    PersonalColorVO findByMemberNumber(int memberNumber);

    @Transactional
    List<PersonalColorVO> deleteByMemberNumber(int memberNumber);
}