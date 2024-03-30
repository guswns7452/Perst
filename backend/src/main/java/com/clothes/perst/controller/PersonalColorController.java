package com.clothes.perst.controller;

import com.clothes.perst.DTO.RestResponse;
import com.clothes.perst.config.JwtTokenService;
import com.clothes.perst.domain.MusinsaVO;
import com.clothes.perst.domain.PersonalColorVO;
import com.clothes.perst.service.PersonalColorService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/personal") // API의 기본 경로 설정
@Tag(name="퍼스널 컬러 진단하기", description = "퍼스널 컬러 분석하기와 관련된 API입니다.")
public class PersonalColorController {
    private final PersonalColorService personalColorService;
    RestResponse<Object> restResponse = new RestResponse<>();
    private static final Logger logger = LoggerFactory.getLogger(PersonalColorController.class);
    private final JwtTokenService jwtTokenService;

    @Autowired
    public PersonalColorController(JwtTokenService jwtTokenService, PersonalColorService personalColorService){
        this.jwtTokenService = jwtTokenService;
        this.personalColorService = personalColorService;
    }

    /**
     * Personal Color를 등록하는 API
     * @param token
     * @param personalColor
     * @return
     * @throws Exception
     */
    @ResponseBody
    @Operation(summary = "퍼스널 컬러 등록하기", description = "퍼스널 컬러를 등록하는 API")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "퍼스널 컬러 등록 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "퍼스널 컬러 등록 성공")) }),
            @ApiResponse(responseCode = "404", description = "오류 발생")
    })
    @PostMapping("/color")
    public ResponseEntity registPersonalColor(@RequestHeader("Authorization") String token, @RequestBody PersonalColorVO personalColor) throws Exception {
        int memberNumber = Integer.parseInt(jwtTokenService.getUsernameFromToken(token));

        logger.info(String.format("[퍼스널 컬러 등록하기] 회원 번호 : %d / 퍼스널 컬러 : %s", memberNumber, personalColor.getPersonalColorType()));
        personalColor.setMemberNumber(memberNumber); // 멤버 번호 할당하기
        
        // 퍼스널 컬러 코드 실행하기
        personalColorService.registPersonalColor(personalColor);

        try{
            restResponse = RestResponse.builder()
                    .code(HttpStatus.CREATED.value())
                    .httpStatus(HttpStatus.CREATED)
                    .message("퍼스널 컬러 등록에 성공했습니다.")
                    .data(personalColor)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }

        // 일치 하는 의류가 없을 때, IllegalArgumentException 발생
        catch (IllegalArgumentException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.FORBIDDEN.value())
                    .httpStatus(HttpStatus.FORBIDDEN)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }
}
