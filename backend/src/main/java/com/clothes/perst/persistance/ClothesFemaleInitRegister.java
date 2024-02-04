package com.clothes.perst.persistance;

import com.clothes.perst.domain.ClothesFemaleVO;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

// JPA Test를 위해서는 CRUD가 모두 구현되어 있어야만, 테스트 가능함
// CRUD를 지원하는 CrudRepository 상속 받음
@Repository
@Deprecated
public interface ClothesFemaleInitRegister extends CrudRepository<ClothesFemaleVO, ClothesFemaleVO> {

}
