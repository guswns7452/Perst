package com.clothes.perst.controller;

import com.clothes.perst.DTO.MusinsaSearchRequest;
import com.clothes.perst.DTO.RestResponse;
import com.clothes.perst.config.JwtTokenService;
import com.clothes.perst.domain.MusinsaVO;
import com.clothes.perst.persistance.PersonalColorRepository;
import com.clothes.perst.service.MusinsaService;
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
@RequestMapping("/clothes/search") // API의 기본 경로 설정
@Tag(name="스타일 둘러보기", description = "스타일 둘러보기와 관련된 API입니다.")
public class ClothesSearchController {
    final MusinsaService musinsaService;
    final PersonalColorRepository personalColorJPA;

    RestResponse<Object> restResponse = new RestResponse<>();

    private static final Logger logger = LoggerFactory.getLogger(ClothesSearchController.class);

    private final JwtTokenService jwtTokenService;


    @Autowired
    public ClothesSearchController(MusinsaService musinsaService, JwtTokenService jwtTokenService, PersonalColorRepository personalColorJPA){
        this.musinsaService = musinsaService;
        this.jwtTokenService = jwtTokenService;
        this.personalColorJPA = personalColorJPA;
    }

    // TODO 토큰 활용하여 정상적인 사용자를 식별하는 코드 추가
    
    @ResponseBody
    @Operation(summary = "남성 스타일 둘러보기", description = "스타일을 입력하여 의류를 둘러볼 수 있음.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "조회 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "스타일 조회 성공")) }),
            @ApiResponse(responseCode = "404", description = "일치하는 스타일이 없음")
    })
    @PostMapping("/man")
    public ResponseEntity findMaleSearch(@RequestHeader("Authorization") String token, @RequestParam String style, @RequestBody MusinsaSearchRequest musinsaSearchVO) throws Exception {
        logger.info("[남성 스타일 둘러보기] Style : " + style + " / Color : " + musinsaSearchVO.getColor());
        try{
            int memberNumber = Integer.parseInt(jwtTokenService.getUsernameFromToken(token));
            musinsaSearchVO.setMemberNumber(memberNumber);
            MusinsaVO manInfo = new MusinsaVO(); manInfo.setMusinsaGender("man"); manInfo.setMusinsaStyle(style);

            List<MusinsaVO> maleClothes = musinsaService.findByMusinsaGenderAndMusinsaStyle(manInfo, musinsaSearchVO); // 맨날 불러오는 것이 성능적으로 괜찮은가?
            String myPersonal = personalColorJPA.findByMemberNumber(memberNumber).getPersonalColorType();

            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(myPersonal)
                    .data(maleClothes)
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
        // 퍼스널 컬러 진단을 하지 않고, 퍼스널 컬러 반영한 검색 요청 할 때
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    @ResponseBody
    @Operation(summary = "여성 스타일 둘러보기", description = "스타일을 입력하여 의류를 둘러볼 수 있음.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "조회 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "스타일 조회 성공")) }),
            @ApiResponse(responseCode = "404", description = "일치하는 스타일이 없음")
    })
    @PostMapping("/woman")
    public ResponseEntity findFemaleSearch(@RequestHeader("Authorization") String token, @RequestParam String style, @RequestBody MusinsaSearchRequest searchVO) throws Exception {
        logger.info("[여성 스타일 둘러보기] Style : " + style + " / Color : " + searchVO.getColor());
        try{
            int memberNumber = Integer.parseInt(jwtTokenService.getUsernameFromToken(token));
            searchVO.setMemberNumber(memberNumber);
            MusinsaVO womanInfo = new MusinsaVO(); womanInfo.setMusinsaGender("woman"); womanInfo.setMusinsaStyle(style);

            List<MusinsaVO> femaleClothes = musinsaService.findByMusinsaGenderAndMusinsaStyle(womanInfo, searchVO); // 맨날 불러오는 것이 성능적으로 괜찮은가?
            String myPersonal = personalColorJPA.findByMemberNumber(memberNumber).getPersonalColorType();

            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(myPersonal)
                    .data(femaleClothes)
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
        // 퍼스널 컬러 진단을 하지 않고, 퍼스널 컬러 반영한 검색 요청 할 때
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /* ================================================================= */
    /**
     * 남성의 스타일을 둘러보는 API
     */ /*
    @ResponseBody
    @Operation(summary = "남성 스타일 둘러보기", description = "스타일을 입력하여 의류를 둘러볼 수 있음. 한 페이지에 12장이 출력되고, 페이지마다 호출하세요.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "조회 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "스타일 조회 성공")) }),
            @ApiResponse(responseCode = "404", description = "일치하는 스타일이 없음")
    })
    @GetMapping("/male/{page}")
    public ResponseEntity findMaleSearch(@PathVariable int page, @RequestParam String maleStyle) throws Exception {
        logger.info("[남성 스타일 둘러보기] Style : " + maleStyle);
        try{
            List<ClothesMaleVO> maleClothes = clothesSearchService.findByMaleStyle(maleStyle); // 맨날 불러오는 것이 성능적으로 괜찮은가?

            int subListDataCount = 12; // 한 페이지에 넣을 데이터 개수
            List<ClothesMaleVO> subMaleClothes = maleClothes.subList(subListDataCount * (page-1),subListDataCount * page + 1);

            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(maleStyle + " 스타일 조회 성공했습니다. " + subMaleClothes.size() + "장")
                    .data(subMaleClothes)
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
    */

    /**
     * 여성의 스타일을 둘러보는 API
     *//*
    @ResponseBody
    @Operation(summary = "여성 스타일 둘러보기", description = "스타일을 입력하여 의류를 둘러볼 수 있음. 한 페이지에 12장이 출력되고, 페이지마다 호출하세요.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "조회 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "스타일 조회 성공")) }),
            @ApiResponse(responseCode = "404", description = "일치하는 스타일이 없음")
    })
    @GetMapping("/female/{page}")
    public ResponseEntity findFemaleSearch(@PathVariable int page, @RequestParam String femaleStyle) throws Exception {
        logger.info("[여성 스타일 둘러보기] Style : " + femaleStyle);
        try{
            List<ClothesFemaleVO> femaleClothes = clothesSearchService.findByFemaleStyle(femaleStyle);

            int subListDataCount = 12; // 한 페이지에 넣을 데이터 개수
            List<ClothesFemaleVO> subMaleClothes = femaleClothes.subList(subListDataCount * (page-1),subListDataCount * page + 1);

            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(femaleStyle + " 스타일 조회 성공했습니다. " + femaleClothes.size() + "장")
                    .data(subMaleClothes)
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
    */
}
