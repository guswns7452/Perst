package com.clothes.perst.controller;

import com.clothes.perst.DTO.RestResponse;
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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
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

    @Autowired
    public StyleAnalyzeController(StyleAnalyzeService styleAnalyzeService, MemberService memberService){
        this.styleAnalyzeService = styleAnalyzeService;
        this.memberService = memberService;
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
    public ResponseEntity Analyze(@RequestBody StyleAnalyzeVO styleAnalyzeVO) throws Exception {
        logger.info("[스타일 분석하기]");
        try{ 
            // TODO 파일 업로드 요청 -> 파일 업로드 (file만) / meta데이터들 API 분리하기
            // Flask로 요청 보내기

            String gender = memberService.findMemberGenderByMemberNumber(styleAnalyzeVO.getMemberNumber());

            String requestBody = "{\"fileID\": \""+styleAnalyzeVO.getStyleFileID() + "\", \"gender\": \""+gender+"\"}";
            RestResponse responseBody = styleAnalyzeService.ConnectFlaskServer(requestBody);

            LinkedHashMap data = (LinkedHashMap) responseBody.getData();

            StyleAnalyzeVO styleAnalyzed = new StyleAnalyzeVO(); // TODO 추후 생성자 형태로 변경하기
            styleAnalyzed.setStyleName((String) data.get("fashionType"));
            styleAnalyzed.setStyleFileID(styleAnalyzeVO.getStyleFileID());
            styleAnalyzed.setMemberNumber(styleAnalyzeVO.getMemberNumber());

            logger.info(String.valueOf(data));

            /* 결과값 받아 DB에 저장하기 */
            StyleAnalyzeVO newstyleAnalyzeVO =  styleAnalyzeService.saveStyleAnalyze(styleAnalyzed);
            int styleNumber = newstyleAnalyzeVO.getStyleNumber();

            /* DB에 색상 저장하기 */
            List<StyleColorVO> colors = new ArrayList();
            colors.add(new StyleColorVO((String) data.get("color1"), styleNumber));
            colors.add(new StyleColorVO((String) data.get("color2"), styleNumber));
            colors.add(new StyleColorVO((String) data.get("color3"), styleNumber));
            colors.add(new StyleColorVO((String) data.get("color4"), styleNumber));
            styleAnalyzeService.saveStyleColor(colors);

            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("분석이 정상적으로 완료되었습니다!")
                    .data(newstyleAnalyzeVO)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 일치 하는 의류가 없을 때, IllegalArgumentException 발생
        catch (NullPointerException e){
            logger.info(e.getMessage());
            restResponse = RestResponse.builder()
                    .code(HttpStatus.FORBIDDEN.value())
                    .httpStatus(HttpStatus.FORBIDDEN)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }
}
