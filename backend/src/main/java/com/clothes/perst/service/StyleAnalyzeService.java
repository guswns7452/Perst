package com.clothes.perst.service;

import com.clothes.perst.DTO.*;
import com.clothes.perst.config.GoogleDriveAPI;
import com.clothes.perst.domain.PersonalColorVO;
import com.clothes.perst.domain.PersonalTipVO;
import com.clothes.perst.domain.StyleAnalyzeVO;
import com.clothes.perst.domain.StyleColorVO;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.auth.oauth2.ServiceAccountCredentials;
import com.clothes.perst.persistance.*;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import jakarta.security.auth.message.AuthException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class StyleAnalyzeService {
    private final StyleAnalyzeRepository styleAnalyzeJPA;
    private final CoordinateRepository coordinateJPA;
    private final StyleAnalyzeColorRepository styleAnalyzeColorJPA;
    private final PersonalColorRepository personalColorJPA;
    private final PersonalTipRepository personalTipJPA;
    private final GoogleDriveAPI googleDriveAPI;
    private static final Logger logger = LoggerFactory.getLogger(StyleAnalyzeService.class);


    @Value("${folderId.ClothesAnalyze}")
    String folderID;


    @Value("${apiURL}")
    String apiUrl;

    @Autowired
    public StyleAnalyzeService(StyleAnalyzeRepository styleAnalyzeJPA, PersonalTipRepository personalTipJPA, PersonalColorRepository personalColorJPA, CoordinateRepository coordinateJPA, StyleAnalyzeColorRepository styleAnalyzeColorRepository, GoogleDriveAPI googleDriveAPI) {
        this.styleAnalyzeJPA = styleAnalyzeJPA;
        this.styleAnalyzeColorJPA = styleAnalyzeColorRepository;
        this.googleDriveAPI = googleDriveAPI;
        this.coordinateJPA = coordinateJPA;
        this.personalColorJPA = personalColorJPA;
        this.personalTipJPA = personalTipJPA;
    }

    private static String uploadDir = "./src/main/resources/image/";

    /**
     * 스타일 분석하는 코드
     * @param file (MultipartFile)
     * @param memberNumber
     * @param gender
     * @return styleAnalyzeVO
     * @throws Exception
     */
    public StyleAnalyzeVO Analyze(MultipartFile file, int memberNumber, String gender) throws Exception {

        /* 구글 드라이브로 업로드 하기 */
        String fileID = uploadImage(file, memberNumber);

        /* Flask로 요청 보내기 */
        String requestBody = "{\"fileID\": \"" + fileID + "\", \"gender\": \"" + gender + "\"}";
        RestResponse responseBody = ConnectFlaskServer(requestBody);

        LinkedHashMap data = (LinkedHashMap) responseBody.getData();

        /* 퍼스널 컬러 타입 영어 TO 한글*/
        String AnalyzedPersonalColor = PersonalColorDTO.changeEngToKor((String) data.get("personalColorType"));

        /* 스타일 분석 내용 저장 : styleName, FileID, memberNumber, personalColorType */
        StyleAnalyzeVO styleAnalyzed = new StyleAnalyzeVO((String) data.get("fashionType"), fileID, memberNumber, AnalyzedPersonalColor);

        /* 결과값 받아 DB에 저장하기 */
        StyleAnalyzeVO newstyleAnalyzeVO = saveStyleAnalyze(styleAnalyzed);
        int styleNumber = newstyleAnalyzeVO.getStyleNumber();

        /* DB에 색상 저장하기 */
        List<StyleColorVO> colors = new ArrayList();
        List getColors = splitArr((String) data.get("colors"));
        int i = 0;
        for (Object k : getColors){
            colors.add(new StyleColorVO(getColors.get(i).toString(), styleNumber));
            i += 1;
        }
        saveStyleColor(colors);
        newstyleAnalyzeVO.setStyleColor(colors);

        /* 이미지 삭제하기 */
        deleteFile();

        /* 스타일 피드백 FileID 리스트 출력 */
        String changeStyle = CoordinateTipDTO.changeCodiTip(newstyleAnalyzeVO.getStyleName(), gender);
        newstyleAnalyzeVO.setStyleCommentFileID(searchStyleCommentFileIDs(gender, changeStyle));
        newstyleAnalyzeVO.setStyleName(changeStyle);

        /* 퍼스널 컬러 피드백 */
        newstyleAnalyzeVO.setPersonalColorTip(setPersonalColorTip(memberNumber, AnalyzedPersonalColor));
        return newstyleAnalyzeVO;
    }

    private List splitArr(String s) {
        // 중괄호와 대괄호 제거
        s = s.substring(2, s.length() - 2);

        // 각 요소를 쉼표를 기준으로 분리
        String[] parts = s.split("\\], \\[");

        // 결과를 저장할 리스트
        List<List<String>> result = new ArrayList<>();

        for (String part : parts) {
            String[] values = part.split(", ");
            List<String> innerList = new ArrayList<>();
            for (String value : values) {
                innerList.add(value);
            }
            result.add(innerList);
        }
        return result;
    }

    /**
     * 스타일 이력 상세 조회
     * @param gender
     * @param styleNumber
     * @return
     */
    public StyleAnalyzeVO findMyStyle(String gender, int styleNumber){
        StyleAnalyzeVO vo = styleAnalyzeJPA.findByStyleNumber(styleNumber);
        vo.setStyleColor(styleAnalyzeColorJPA.findAllByStyleNumber(styleNumber));

        /* 스타일 피드백 FileID 리스트 출력 */
        String changeStyle = CoordinateTipDTO.changeCodiTip(vo.getStyleName(), gender);
        vo.setStyleCommentFileID(searchStyleCommentFileIDs(gender, changeStyle));
        vo.setStyleName(changeStyle);

        /* 퍼스널 컬러 피드백 */
        vo.setPersonalColorTip(setPersonalColorTip(vo.getMemberNumber(), vo.getStylePersonalColor()));

        return vo;
    }

    /**
     * 내 스타일 이력들 조회
     * @param memberNumber
     * @return
     */
    public TransferStyleAnalyzeDTO findMyStyleList(int memberNumber){
        List<StyleAnalyzeVO> vo = styleAnalyzeJPA.findAllByMemberNumber(memberNumber);

        // 전송용 DTO로 변경하기
        TransferStyleAnalyzeDTO transfer = new TransferStyleAnalyzeDTO(vo);
        return transfer;
    }

    /**
     * 내 스타일 이력 삭제
     * @param memberNumber
     * @param styleNumber
     * @throws Exception
     */
    public void deleteMyStyle(int memberNumber, int styleNumber) throws Exception{
        isYoursByStyleNumber(memberNumber, styleNumber);
        styleAnalyzeColorJPA.deleteByStyleNumber(styleNumber);
        styleAnalyzeJPA.deleteByStyleNumber(styleNumber);
    }

    /** ================== [하위 모듈] ================== */

    /* 파일 저장 코드 */
    public String multipartFileToFile(MultipartFile multipartFile, String fileName) throws IOException {
        try {
            // 파일 경로 설정 (디렉토리 생성)
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // 파일 경로와 파일 이름 결합
            Path filePath = uploadPath.resolve(fileName);

            // 파일 저장
            Files.copy(multipartFile.getInputStream(), filePath);

            return fileName;
        } catch (IOException e) {
            throw new IOException("Could not save file " + fileName, e);
        }
    }

    /* 사용된 이미지들은 삭제 해버림 */
    public void deleteFile() throws IOException {
        Files.walk(Path.of(uploadDir))
                .sorted(java.util.Comparator.reverseOrder())
                .map(Path::toFile)
                .forEach(file -> {
                    try {
                        Files.delete(file.toPath());
                    } catch (IOException e) {
                        // 예외 처리
                        e.printStackTrace();
                    }
                });

        // 디렉토리 삭제
        Files.deleteIfExists(Path.of(uploadDir));
    }

    /**
     * DB에 저장하는 코드
     */
    public StyleAnalyzeVO saveStyleAnalyze(StyleAnalyzeVO styleAnalyze) {
        return styleAnalyzeJPA.save(styleAnalyze);
    }

    public void saveStyleColor(List<StyleColorVO> colors) {
        for (StyleColorVO color : colors) {
            styleAnalyzeColorJPA.save(color);
        }
    }

    public List<String> searchStyleCommentFileIDs(String gender, String style) {
        return coordinateJPA.searchFileID(gender, style);
    }

    /**
     * 스타일 분석 시, 구글 드라이브에 이미지 업로드 하는 코드
     *
     * @param uploadFile
     * @param memberNumber
     * @return fileID
     */
    public String uploadImage(MultipartFile uploadFile, int memberNumber) throws IOException, GeneralSecurityException {
        HttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
        InputStream in = StyleAnalyzeService.class.getResourceAsStream("/credentials_service.json");

        GoogleCredentials credential = ServiceAccountCredentials.fromStream(in).createScoped("https://www.googleapis.com/auth/drive");
        HttpRequestInitializer requestInitializer = new HttpCredentialsAdapter(credential);

        Drive service = new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, requestInitializer)
                .setApplicationName(GoogleDriveAPI.APPLICATION_NAME)
                .build();

        /* 구글 드라이브에 저장될 파일 이름 지정 : 회원번호. 현재시간 */
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd_HHmmss");
        String fileName = memberNumber + "_" + sdf1.format(new Date()) + ".jpg";

        File fileMetadata = new File();
        fileMetadata.setName(fileName);
        fileMetadata.setParents(Collections.singletonList(folderID));

        java.io.File files = new java.io.File(uploadDir+multipartFileToFile(uploadFile,fileName));

        // 구글 드라이브에 파일 저장
        FileContent mediaContent = new FileContent("image/jpeg",files);
        try {
            File file = service.files().create(fileMetadata, mediaContent)
                    .setFields("id")
                    .execute();
            System.out.println("File ID: " + file.getId());
            return file.getId();
        } catch (GoogleJsonResponseException e) {
            System.err.println("Unable to upload file: " + e.getDetails());
            throw e;
        }
    }

    public RestResponse ConnectFlaskServer(String requestBody) throws Exception {
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        // AWS Lambda 함수로 요청, apiUrl은 상단에 명시되어있음.

        ResponseEntity<RestResponse> response = restTemplate.postForEntity(apiUrl, entity, RestResponse.class);

        logger.info(response.toString());
        RestResponse responseBody = response.getBody();

        return responseBody;
    }

    /**
     * 다른 사람이 이력을 삭제 할 때 오류 발생시킴
     * @param memberNumber
     * @param styleNumber
     * @return
     * @throws Exception
     */
    public void isYoursByStyleNumber(int memberNumber, int styleNumber) throws Exception{
        StyleAnalyzeVO vo = styleAnalyzeJPA.findByStyleNumber(styleNumber);
        if (memberNumber != vo.getMemberNumber()){
            throw new AuthException("다른 사람의 이력은 삭제할 수 없습니다.");
        }
    }

    /**
     * 퍼스널 컬러 피드백 구성하는 메소드
     * @param memberNumber
     * @param analyzedPersonalColor
     * @return PersonalColorTipDTO
     */
    public PersonalColorTipDTO setPersonalColorTip(int memberNumber, String analyzedPersonalColor) {
        String myPersonalColor = personalColorJPA.findByMemberNumber(memberNumber).getPersonalColorType();
        String fileID;


        if (myPersonalColor != null) {
            fileID = personalTipJPA.findByPersonalTipType(myPersonalColor).getPersonalTipFileId();
        } else {
            fileID = personalTipJPA.findByPersonalTipType(analyzedPersonalColor).getPersonalTipFileId();
        }

        PersonalColorTipDTO personalColorTip = new PersonalColorTipDTO(myPersonalColor, analyzedPersonalColor, fileID);

        return personalColorTip;
    }
}
