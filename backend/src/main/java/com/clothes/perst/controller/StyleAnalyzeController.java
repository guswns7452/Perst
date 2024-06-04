package com.clothes.perst.controller;

import com.clothes.perst.DTO.RestResponse;
import com.clothes.perst.DTO.TransferStyleAnalyzeDTO;
import com.clothes.perst.config.JwtTokenService;
import com.clothes.perst.domain.StyleAnalyzeVO;
import com.clothes.perst.domain.StyleColorVO;
import com.clothes.perst.service.MemberService;
import com.clothes.perst.service.StyleAnalyzeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.security.auth.message.AuthException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.net.ConnectException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

@RestController
@RequestMapping("/clothes/analyze") // API의 기본 경로 설정
@Tag(name="스타일 분석하기", description = "스타일 분석하기와 관련된 API입니다.")
public class StyleAnalyzeController {
    private final StyleAnalyzeService styleAnalyzeService;
    private final MemberService memberService;
    RestResponse<Object> restResponse = new RestResponse<>();
    private static final Logger logger = LoggerFactory.getLogger(StyleAnalyzeController.class);
    private final JwtTokenService jwtTokenService;

    @Autowired
    public StyleAnalyzeController(StyleAnalyzeService styleAnalyzeService, MemberService memberService, JwtTokenService jwtTokenService) {
        this.styleAnalyzeService = styleAnalyzeService;
        this.memberService = memberService;
        this.jwtTokenService = jwtTokenService;
    }

    /**
     * 스타일 분석하는 API 필요
     */
    @ResponseBody
    @Operation(summary = "스타일 분석하기", description = "스타일 분석하기. 헤더에 토큰을 넣어주시고, image 파라미터에 파일을 담아 보내주세요")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "분석 성공",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "스타일 분석 성공"))}),
            @ApiResponse(responseCode = "500", description = "스타일 분석 시 오류 발생")
    })
    @PostMapping("")
    public ResponseEntity Analyze(@RequestHeader("Authorization") String token, @RequestParam("image") MultipartFile file) throws Exception {
        logger.info("[스타일 분석하기]");
        try {
            /* API 시간 측정 */
            long beforeTime = System.currentTimeMillis(); //코드 실행 전에 시간 받아오기

            /* 성별 알아내기 */
            int memberNumber = Integer.parseInt(jwtTokenService.getUsernameFromToken(token));
            String gender = memberService.findMemberGenderByMemberNumber(memberNumber);

            // 스타일 분석 메소드 호출
            StyleAnalyzeVO styleAnalyzeVO;
            styleAnalyzeVO = styleAnalyzeService.Analyze(file, memberNumber, gender);

            /* API 시간 측정 */
            long afterTime = System.currentTimeMillis(); // 코드 실행 후에 시간 받아오기
            long secDiffTime = (afterTime - beforeTime); //두 시간에 차 계산
            logger.info("실행 시간 : "+secDiffTime+"ms");

            
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("분석이 정상적으로 완료되었습니다!")
                    .data(styleAnalyzeVO)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }

        // 일치 하는 의류가 없을 때, IllegalArgumentException 발생
        catch (IllegalArgumentException e) {
            logger.info(e.getMessage());
            restResponse = RestResponse.builder()
                    .code(HttpStatus.FORBIDDEN.value())
                    .httpStatus(HttpStatus.FORBIDDEN)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        } catch (ConnectException e) {
            logger.info(e.getMessage());
            restResponse = RestResponse.builder()
                    .code(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                    .message("Flask Server 오류입니다. Flask 서버 상태를 확인해주세요.")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /**
     * 상세 분석 이력 호출하기
     * @param token
     * @param styleNumber
     * @return
     * @throws Exception
     */
    @GetMapping("")
    public ResponseEntity findMyStyle(@RequestHeader("Authorization") String token, @RequestParam("number") int styleNumber) throws Exception {

        /* 성별 알아내기 */
        int memberNumber = Integer.parseInt(jwtTokenService.getUsernameFromToken(token));
        String gender = memberService.findMemberGenderByMemberNumber(memberNumber);

        StyleAnalyzeVO newstyleAnalyzeVO = styleAnalyzeService.findMyStyle(gender, styleNumber);

        logger.info("[내 상세 분석 이력 불러오기]");
        try{
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("내 스타일을 분석 이력을 보여드립니다.")
                    .data(newstyleAnalyzeVO)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        catch(Exception e){
            logger.info("내 분석 이력 불러오기 중 오류");
            restResponse = RestResponse.builder()
                    .code(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                    .message(e.toString())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }


    /**
     * 상세 분석 이력 삭제하기
     * @param token
     * @param styleNumber
     * @return
     * @throws Exception
     */
    @DeleteMapping("")
    public ResponseEntity deleteMyStyle(@RequestHeader("Authorization") String token, @RequestParam("number") int styleNumber) throws Exception {
        try{
            int memberNumber = Integer.parseInt(jwtTokenService.getUsernameFromToken(token));

            // 삭제하는 메소드
            logger.info("[내 스타일 분석 이력 삭제하기]");
            styleAnalyzeService.deleteMyStyle(memberNumber, styleNumber);

            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("정상적으로 삭제되었습니다.")
                    .data(null)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        catch (AuthException e){
            logger.info("[내 스타일 이력 삭제] 다른 계정으로 삭제할 수 없습니다.");
            restResponse = RestResponse.builder()
                    .code(HttpStatus.UNAUTHORIZED.value())
                    .httpStatus(HttpStatus.UNAUTHORIZED)
                    .message(e.toString())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        catch(Exception e) {
            logger.info("내 스타일 분석 삭제 중 오류");
            restResponse = RestResponse.builder()
                    .code(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                    .message(e.toString())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /**
     * 나의 분석 이력들 호출하기
     * @param token
     * @return
     * @throws Exception
     */
    @GetMapping("/my")
    public ResponseEntity findMyStyleList(@RequestHeader("Authorization") String token) throws Exception {
        int memberNumber = Integer.parseInt(jwtTokenService.getUsernameFromToken(token));

        TransferStyleAnalyzeDTO newstyleAnalyzeVO = styleAnalyzeService.findMyStyleList(memberNumber);

        logger.info("[내 분석 이력 리스튼 불러오기]");
        try{
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("내 스타일을 분석 이력들을 보여드립니다.")
                    .data(newstyleAnalyzeVO)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        catch(Exception e){
            logger.info("내 분석 이력 불러오기 중 오류");
            restResponse = RestResponse.builder()
                    .code(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                    .message(e.toString())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

}