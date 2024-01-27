package com.clothes.perst.controller;

import com.clothes.perst.DTO.RestResponse;
import com.clothes.perst.DTO.loginRequest;
import com.clothes.perst.domain.ClothesFemaleVO;
import com.clothes.perst.domain.ClothesMaleVO;
import com.clothes.perst.domain.MemberVO;
import com.clothes.perst.service.ClothesSearchService;
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
    //TODO [velog] 생성자 선언시 왜 final을 사용함?
    final ClothesSearchService clothesSearchService;

    RestResponse<Object> restResponse = new RestResponse<>();

    private static final Logger logger = LoggerFactory.getLogger(ClothesSearchController.class);

    @Autowired
    public ClothesSearchController(ClothesSearchService clothesSearchService){
        this.clothesSearchService = clothesSearchService;
    }

    /**
     * 남성의 스타일을 둘러보는 API
     */
    @ResponseBody
    @Operation(summary = "남성 스타일 둘러보기", description = "스타일을 입력하여 의류를 둘러볼 수 있음")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "조회 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "로그인 성공")) }),
            @ApiResponse(responseCode = "404", description = "일치하는 스타일이 없음")
    })
    @GetMapping("/male")
    public ResponseEntity findMaleSearch(@RequestParam String maleStyle) throws Exception {
        logger.info("[남성 스타일 둘러보기] Style : " + maleStyle);
        // 성공적으로 로그인 했을때.
        try{
            List<ClothesMaleVO> maleClothes = clothesSearchService.findByMaleStyle(maleStyle);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(maleStyle + " 스타일 조회 성공했습니다. " + maleClothes.size() + "장")
                    .data(maleClothes)
                    .build();
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
     * 남성의 스타일을 둘러보는 API
     */
    @ResponseBody
    @Operation(summary = "여성 스타일 둘러보기", description = "스타일을 입력하여 의류를 둘러볼 수 있음")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "조회 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "로그인 성공")) }),
            @ApiResponse(responseCode = "404", description = "일치하는 스타일이 없음")
    })
    @GetMapping("/female")
    public ResponseEntity findFemaleSearch(@RequestParam String femaleStyle) throws Exception {
        logger.info("[여성 스타일 둘러보기] Style : " + femaleStyle);
        // 성공적으로 로그인 했을때.
        try{
            List<ClothesFemaleVO> femaleClothes = clothesSearchService.findByFemaleStyle(femaleStyle);
            // 페미닌 8만장 DB 호출은 2초 이내, 데이터 파싱은 오래걸림
            // @TODO List를 랜덤하게 주어, 페이지 별로 API를 분리해야할듯
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(femaleStyle + " 스타일 조회 성공했습니다. " + femaleClothes.size() + "장")
                    .data(femaleStyle)
                    .build();
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
}
