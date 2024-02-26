package com.clothes.perst.controller;

import com.clothes.perst.DTO.RestResponse;
import com.clothes.perst.domain.ClothesMaleVO;
import com.clothes.perst.domain.MusinsaVO;
import com.clothes.perst.service.ClothesSearchService;
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

    RestResponse<Object> restResponse = new RestResponse<>();

    private static final Logger logger = LoggerFactory.getLogger(ClothesSearchController.class);

    @Autowired
    public ClothesSearchController(MusinsaService musinsaService){
        this.musinsaService = musinsaService;
    }

    @ResponseBody
    @Operation(summary = "남성 스타일 둘러보기", description = "스타일을 입력하여 의류를 둘러볼 수 있음.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "조회 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "스타일 조회 성공")) }),
            @ApiResponse(responseCode = "404", description = "일치하는 스타일이 없음")
    })
    @GetMapping("/man")
    public ResponseEntity findMaleSearch(@RequestParam String style) throws Exception {
        logger.info("[남성 스타일 둘러보기] Style : " + style);
        try{
            MusinsaVO manInfo = new MusinsaVO(); manInfo.setMusinsaGender("man"); manInfo.setMusinsaStyle(style);
            List<MusinsaVO> maleClothes = musinsaService.findByMusinsaGenderAndMusinsaStyle(manInfo); // 맨날 불러오는 것이 성능적으로 괜찮은가?

            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(style + " 스타일 조회 성공했습니다. " + maleClothes.size() + "장")
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
    @GetMapping("/woman")
    public ResponseEntity findFemaleSearch(@RequestParam String style) throws Exception {
        logger.info("[여성 스타일 둘러보기] Style : " + style);
        try{
            MusinsaVO womanInfo = new MusinsaVO(); womanInfo.setMusinsaGender("woman"); womanInfo.setMusinsaStyle(style);
            List<MusinsaVO> maleClothes = musinsaService.findByMusinsaGenderAndMusinsaStyle(womanInfo); // 맨날 불러오는 것이 성능적으로 괜찮은가?

            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(style + " 스타일 조회 성공했습니다. " + maleClothes.size() + "장")
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
