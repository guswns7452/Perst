package com.clothes.perst.controller;

import com.clothes.perst.DTO.RestResponse;
import com.clothes.perst.domain.StyleAnalyzeVO;
import com.clothes.perst.service.StyleAnalyzeService;
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

import java.util.LinkedHashMap;

@RestController
@RequestMapping("/clothes/analyze") // API의 기본 경로 설정
@Tag(name="스타일 분석하기", description = "스타일 분석하기와 관련된 API입니다.")
public class StyleAnalyzeController {
    private final StyleAnalyzeService styleAnalyzeService;
    RestResponse<Object> restResponse = new RestResponse<>();
    private static final Logger logger = LoggerFactory.getLogger(StyleAnalyzeController.class);

    @Autowired
    public StyleAnalyzeController(StyleAnalyzeService styleAnalyzeService){
        this.styleAnalyzeService = styleAnalyzeService;
    }

    /**
     * 스타일 분석하는 API 필요
     */
    @ResponseBody
    @Operation(summary = "스타일 분석하기", description = "스타일 분석하기")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "분석 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = RestResponse.class),
                            examples = @ExampleObject(name = "스타일 분석 성공")) }),
            @ApiResponse(responseCode = "500", description = "스타일 분석 시 오류 발생")
    })
    @PostMapping("/")
    public ResponseEntity Analyze(@RequestBody String filename) throws Exception {
        logger.info("[스타일 분석하기]");
        try{
            String requestBody = "{\"filename\": \""+filename+"\"}";
            RestResponse responseBody = styleAnalyzeService.ConnectFlaskServer(requestBody);

            LinkedHashMap data = (LinkedHashMap) responseBody.getData();

            StyleAnalyzeVO styleAnalyzed = new StyleAnalyzeVO(); // TODO 추후 생성자 형태로 변경하기
            styleAnalyzed.setStyleFileID((String) data.get("styleFileId"));

            /* 결과값 받아 DB에 저장하기 */
            StyleAnalyzeVO newstyleAnalyzeVO =  styleAnalyzeService.saveStyleAnalyze(styleAnalyzed);

            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("분석이 정상적으로 완료되었습니다!")
                    .data(newstyleAnalyzeVO)
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
