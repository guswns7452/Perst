package com.clothes.perst.service;

import com.clothes.perst.DTO.RestResponse;
import com.clothes.perst.config.GoogleDriveAPI;
import com.clothes.perst.domain.StyleAnalyzeVO;
import com.clothes.perst.domain.StyleColorVO;
import com.clothes.perst.persistance.StyleAnalyzeColorRepository;
import com.clothes.perst.persistance.StyleAnalyzeRepository;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Service
public class StyleAnalyzeService {
    private final StyleAnalyzeRepository styleAnalyzeJPA;
    private final StyleAnalyzeColorRepository styleAnalyzeColorRepository;
    private final GoogleDriveAPI googleDriveAPI;

    @Value("${folderId.ClothesAnalyze}")
    String folderID;

    private static String uploadDir = "./src/main/resources/image/";

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

    @Autowired
    public StyleAnalyzeService(StyleAnalyzeRepository styleAnalyzeJPA, StyleAnalyzeColorRepository styleAnalyzeColorRepository, GoogleDriveAPI googleDriveAPI) {
        this.styleAnalyzeJPA = styleAnalyzeJPA;
        this.styleAnalyzeColorRepository = styleAnalyzeColorRepository;
        this.googleDriveAPI = googleDriveAPI;
    }

    /**
     * DB에 저장하는 코드
     */
    public StyleAnalyzeVO saveStyleAnalyze(StyleAnalyzeVO styleAnalyze) {
        return styleAnalyzeJPA.save(styleAnalyze);
    }

    public void saveStyleColor(List<StyleColorVO> colors) {
        for (StyleColorVO color : colors) {
            styleAnalyzeColorRepository.save(color);
        }
    }

    /**
     * 스타일 분석 시, 구글 드라이브에 이미지 업로드 하는 코드
     *
     * @param uploadFile
     * @param memberNumber
     * @return fileID
     */
    public String uploadImage(MultipartFile uploadFile, int memberNumber) throws IOException, GeneralSecurityException {
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        Drive service = new Drive.Builder(HTTP_TRANSPORT, GoogleDriveAPI.JSON_FACTORY, GoogleDriveAPI.getCredentials(HTTP_TRANSPORT))
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

        String apiUrl = "http://127.0.0.1:5000/style/analyze";
        ResponseEntity<RestResponse> response = restTemplate.postForEntity(apiUrl, entity, RestResponse.class);

        RestResponse responseBody = response.getBody();

        return responseBody;
    }
}
