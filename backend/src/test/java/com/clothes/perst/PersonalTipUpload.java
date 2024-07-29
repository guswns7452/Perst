package com.clothes.perst;

import com.clothes.perst.config.GoogleDriveAPI;
import com.clothes.perst.domain.PersonalTipVO;
import com.clothes.perst.persistance.PersonalTipRepository;
import com.clothes.perst.service.StyleAnalyzeService;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.drive.model.File;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.auth.oauth2.ServiceAccountCredentials;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;
import java.io.InputStream;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.List;

/**
 * Google Drive에 코디법 업로드 하는 코드
 */
@SpringBootTest
public class PersonalTipUpload {
    //사용자의 토큰을 어디에 저장할지 경로를 지정
    public static final String TOKENS_DIRECTORY_PATH = "tokens";
    //어플리케이션이 요청하는 권한의 범위를 지정
    public static final List<String> SCOPES = Collections.singletonList(DriveScopes.DRIVE);
    //비밀키 경로
    public static final String CREDENTIALS_FILE_PATH = "/credentials.json";
    public static final String APPLICATION_NAME = "Google Drive API Java Quickstart";
    public static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

    @Autowired
    private PersonalTipRepository personalTipJPA; // UserRepository는 JPA Repository 인터페이스

    @Value("${folderId.PersonalTip}")
    String folderID;

    public static GoogleCredentials getCredentials() throws IOException {
        InputStream in = StyleAnalyzeService.class.getResourceAsStream("/credentials_service.json");

        GoogleCredentials credential = ServiceAccountCredentials.fromStream(in).createScoped("https://www.googleapis.com/auth/drive");

        return credential;
    }

    @Test
    public void updatePersonalTipDB() throws GeneralSecurityException, IOException {
        String folderPath = "D:\\coding\\perst_dataset\\personal_tip";

        // 폴더 객체 생성
        java.io.File folder = new java.io.File(folderPath);

        // 해당 폴더에 있는 파일 목록 가져오기
        java.io.File[] files = folder.listFiles();

        // 파일 목록 출력
        if (files != null) {
            for (java.io.File file : files) {
                String fileName = file.getName();

                String fileId = uploadBasic(fileName);
                fileName.replace(".png", "");

                PersonalTipVO personalTip = new PersonalTipVO(fileName, fileId);
                personalTipJPA.save(personalTip);

                System.out.println("업로드 완료 : "+fileName);
            }
        } else {
            System.out.println("해당 폴더에 파일이 존재하지 않습니다.");
        }
    }


    public String uploadBasic(String fileName) throws IOException, GeneralSecurityException {
    // Load pre-authorized user credentials from the environment.
    // (developer) - See https://developers.google.com/identity for
    // guides on implementing OAuth2 for your application.

        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
        HttpRequestInitializer requestInitializer = new HttpCredentialsAdapter(getCredentials());

        Drive service = new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, requestInitializer)
                .setApplicationName(GoogleDriveAPI.APPLICATION_NAME)
                .build();

        String folderPath = "D:\\coding\\perst_dataset\\personal_tip\\";

        // Upload file photo.jpg on drive.
        File fileMetadata = new File();
        // File's content.
        java.io.File filepath = new java.io.File(folderPath+fileName);
        fileMetadata.setName(fileName);
        fileMetadata.setParents(Collections.singletonList(folderID));

        // Specify media type and file-path for file.
        FileContent mediaContent = new FileContent("image/png", filepath);
        try {
            File file = service.files().create(fileMetadata, mediaContent)
                    .setFields("id")
                    .execute();
            // System.out.println("File ID: " + file.getId());
            return file.getId();
        } catch (GoogleJsonResponseException e) {
            // (developer) - handle error appropriately
            System.err.println("Unable to upload file: " + e.getDetails());
            throw e;
        }
    }

}
