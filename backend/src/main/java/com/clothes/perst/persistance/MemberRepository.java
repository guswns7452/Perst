package com.clothes.perst.persistance;

import com.clothes.perst.domain.MemberVO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemberRepository extends JpaRepository<MemberVO, Integer> {
    // 특별한 쿼리 메서드가 필요 없는 경우, JpaRepository에서 제공하는 메서드들로 데이터를 조회할 수 있습니다.
    MemberVO findByMemberPhone(String memberPhone);
    List<MemberVO> findAllByMemberPhone(String memberPhone);
    MemberVO findByMemberNumber(int memberNumber);
    MemberVO save(MemberVO member);


}
