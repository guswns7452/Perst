package com.clothes.perst.controller;

import com.clothes.perst.DTO.RestResponse;
import com.clothes.perst.config.JwtTokenService;
import com.clothes.perst.domain.MemberVO;
import com.clothes.perst.service.MemberService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
public class HomeController {
    private final MemberService memberService;
    private final JwtTokenService jwtTokenService;

    @Autowired
    private ServletContext servletContext;

    RestResponse<Object> restResponse = new RestResponse<>();

    // 생성자 방식으로 의존성 주입
    @Autowired
    public HomeController(MemberService memberService, JwtTokenService jwtTokenService){
        this.memberService = memberService;
        this.jwtTokenService = jwtTokenService;
    }

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    /**
     * [ 로그인 하는 API ]
     * @apiNote  1. 성공적으로 로그인 했을 때
     *  / 2. 일치하는 전화번호가 없을 때, NullpointerException 발생
     *  / 3. 패스워드가 일치 하지 않을 때, IllegalArgumentException 발생
     * @throws NullPointerException 일치하는 전화번호가 없을 때
     * @throws IllegalArgumentException 패스워드가 일치 하지 않을 때
     */
    @ResponseBody
    @RequestMapping(value = { "/login" }, method = RequestMethod.POST)
    public ResponseEntity login(@RequestBody MemberVO member) throws Exception {
        logger.info("[로그인 요청] Phone : " + member.getMemberPhone());
        logger.info("[로그인 요청] Password : " + member.getMemberPassword());
        // 성공적으로 로그인 했을때.
        try{
            MemberVO full_member = memberService.loginMember(member);
            String token = jwtTokenService.generateToken(Integer.toString(full_member.getMemberNumber()));
            servletContext.setAttribute(token,full_member);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(token)
                    .data(full_member)
                    .build();
            System.out.println(restResponse.toString());
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 이메일 또는 비밀번호가 일치하지 않음, IllegalArgumentException 발생
        catch (IllegalArgumentException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.FORBIDDEN.value())
                    .httpStatus(HttpStatus.FORBIDDEN)
                    .message("이메일 또는 비밀번호가 틀렸습니다.")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /**
     * [ 회원가입 하는 API ]
     * @apiNote  1. 회원 가입을 완료했을 때 / 2. 중복되는 전화번호가 있을 때
     */
    @ResponseBody
    @RequestMapping(value = { "/signup" }, method = RequestMethod.POST)
    public ResponseEntity signup(@RequestBody MemberVO member, HttpServletRequest request) throws Exception {
        // 회원 가입 완료
        try{
            MemberVO signUpMember = memberService.signUpMember(member);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.CREATED.value())
                    .httpStatus(HttpStatus.CREATED)
                    .message("Success Signup")
                    .data(signUpMember)
                    .build();
        }
        // 회원가입 실패 시, (중복된 번호가 존재할 때)
        // 중복된 번호가 존재하면, 휴대폰 인증 시 걸러짐
        catch (IllegalStateException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.FORBIDDEN.value())
                    .httpStatus(HttpStatus.FORBIDDEN)
                    .message(e.getMessage())
                    .build();
        }
        return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
    }

}