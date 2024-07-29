package com.clothes.perst;

import com.clothes.perst.config.GoogleDriveAPI;
import com.clothes.perst.domain.CoordinateVO;
import com.clothes.perst.persistance.CoordinateRepository;
import com.clothes.perst.service.StyleAnalyzeService;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.drive.Drive;
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
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Google Drive에 코디법 업로드 하는 코드
 */
@SpringBootTest
public class CoordinateUpload {
    @Autowired
    private CoordinateRepository codiJPA; // UserRepository는 JPA Repository 인터페이스

    @Value("${folderId.Coordinate}")
    String folderID;

    public static GoogleCredentials getCredentials() throws IOException {
        InputStream in = StyleAnalyzeService.class.getResourceAsStream("/credentials_service.json");

        GoogleCredentials credential = ServiceAccountCredentials.fromStream(in).createScoped("https://www.googleapis.com/auth/drive");

        return credential;
    }

    @Test
    public void updateCodiDB() throws GeneralSecurityException, IOException {
        String folderPath = "D:\\coding\\perst_dataset\\coordinate_golf";
//        String folderPath = "D:\\coding\\perst_dataset\\coordinate";

        // 폴더 객체 생성
        java.io.File folder = new java.io.File(folderPath);

        // 해당 폴더에 있는 파일 목록 가져오기
        java.io.File[] files = folder.listFiles();

        // 파일 목록 출력
        if (files != null) {
            for (java.io.File file : files) {
                String fileName = file.getName();
                List<String> fileMetaData = new ArrayList<>(List.of(fileName.split("_")));

                // 구글 업로드 후 FileId 필요함
                String fileId = uploadBasic(fileName);
                fileMetaData.set(2,fileMetaData.get(2).replace(".png",""));
                fileMetaData.add(fileId);

                CoordinateVO codi = new CoordinateVO(fileMetaData);
                codiJPA.save(codi);

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

        String folderPath = "D:\\coding\\perst_dataset\\coordinate_golf\\";
//        String folderPath = "D:\\coding\\perst_dataset\\coordinate\\";

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
