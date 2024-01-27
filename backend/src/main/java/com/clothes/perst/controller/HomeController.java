package com.clothes.perst.controller;

import com.clothes.perst.DTO.RestResponse;
import com.clothes.perst.DTO.loginRequest;
import com.clothes.perst.config.JwtTokenService;
import com.clothes.perst.domain.MemberVO;
import com.clothes.perst.service.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.ServletContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springdoc.core.annotations.RouterOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/member") // API의 기본 경로 설정
@Tag(name="Member", description = "회원과 관련된 API입니다.")
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
     *  / 2. 전화번호 또는 패스워드가 일치하지 않을 때, IllegalArgumentException 발생
     * @throws IllegalArgumentException 전화번호 또는 패스워드가 일치 하지 않을 때
     */
    @ResponseBody
    @Operation(summary = "로그인", description = "전화번호와 비밀번호로 로그인 가능합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "로그인 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "로그인 성공")) }),
            @ApiResponse(responseCode = "404", description = "전화번호나 비밀번호 미일치")
    })
    @PostMapping("/login")
    public ResponseEntity login(@RequestBody loginRequest loginReq) throws Exception {
        MemberVO member = loginReq.changeToMember();
        logger.info("[로그인 요청] Phone : " + member.getMemberPhone());
        logger.info("[로그인 요청] Password : " + member.getMemberPassword());
        // 성공적으로 로그인 했을때.
        try{
            MemberVO full_member = memberService.loginMember(member);
            String token = jwtTokenService.generateToken(Integer.toString(full_member.getMemberNumber())); // 토큰 제작
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
    public ResponseEntity signup(@RequestBody MemberVO member) throws Exception {
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