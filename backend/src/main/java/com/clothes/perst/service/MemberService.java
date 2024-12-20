package com.clothes.perst.service;

import com.clothes.perst.domain.MemberVO;
import com.clothes.perst.persistance.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class MemberService {
    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

    /***
     * 로그인 하는 메소드, 암호화 된 비밀번호로 로그인
     * @param member (Phone, PW)
     * @return 로그인 되었으면, 완성된 객체 전달함. 아니면 null
     */
    public MemberVO loginMember(MemberVO member) throws Exception {
        String memberPhone = member.getMemberPhone();
        MemberVO members = memberRepository.findByMemberPhone(memberPhone);

        if (passwordEncoder.matches(member.getMemberPassword(), members.getMemberPassword())) {
            return members;
        } else {
            throw new IllegalArgumentException("[로그인] 전화번호 또는 이메일이 일치하지 않습니다.");
        }
    }

    /***
     * 회원 가입하는 메소드 [비밀번호 인코딩]
     * @param member
     * @return member (회원가입한 친구들)
     */
    public MemberVO signUpMember(MemberVO member) throws Exception {
        String inputPW = member.getMemberPassword();
        member.setMemberPassword(passwordEncoder.encode(inputPW));

        // 전화번호 중복이면 오류 발생, 아니면 회원가입 진행
        if(memberRepository.findByMemberPhone(member.getMemberPhone()) != null){
            throw new IllegalStateException("이미 가입된 아이디가 있습니다.");
        }
        else{
            return memberRepository.save(member);
        }
    }

    /**
     * 스타일 분석에 필요한 성별 찾아내기
     * @param memberNumber
     * @return
     * @throws Exception
     */
    public String findMemberGenderByMemberNumber(int memberNumber) throws Exception{
        return memberRepository.findByMemberNumber(memberNumber).getMemberGender();
    }

    /**
     * 회원 번호로 객체 찾기
     * @param memberNumber
     * @return
     * @throws Exception
     */
    public MemberVO findByMemberNumber(int memberNumber) throws Exception{
        MemberVO member = memberRepository.findByMemberNumber(memberNumber);
        if (member == null) {
            throw new IllegalArgumentException("일치하는 회원이 없습니다.");
        }
        return member;
    }

    /**
     * 회원 정보를 수정하는 코드
     * @param member
     * @return
     * @throws Exception
     */
    public MemberVO editMyInfo(MemberVO member) throws Exception{
        String phone = member.getMemberPhone();
        if (memberRepository.findAllByMemberPhone(phone).size() > 1){
            throw new IllegalAccessException("이미 중복된 전화번호가 존재합니다.");
        } else{
            // save가 등록도 되지만, 수정도 됨 (하지만, 일부 값이 Null이라면 문제가 될 수 있음)
            member.setMemberPassword(passwordEncoder.encode(member.getMemberPassword()));
            return memberRepository.save(member);  
            
        }
    }
}
