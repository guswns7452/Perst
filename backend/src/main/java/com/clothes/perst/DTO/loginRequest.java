package com.clothes.perst.DTO;

import com.clothes.perst.domain.MemberVO;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

/**
 * [Swagger Request]
 * 로그인을 위한 객체 - 전화번호와 비밀번호
 */
@Getter
@Setter
public class loginRequest {

    @Schema(name = "memberPhone", description = "회원 전화번호", example = "01012345678")
    private String memberPhone;

    @Schema(name = "memberPassword", description = "회원 비밀번호", example = "password")
    private String memberPassword;

    /**
     * login 요청 객체를 memberVO로 변환
     * @return MemberVO
     */
    public MemberVO changeToMember(){
        MemberVO member = new MemberVO();
        member.setMemberPhone(memberPhone);
        member.setMemberPassword(memberPassword);

        return member;
    }
}
