package com.clothes.perst;

import com.clothes.perst.DTO.ClothesFolder;
import com.clothes.perst.config.GoogleDriveAPI;
import com.clothes.perst.domain.MusinsaVO;
import com.clothes.perst.persistance.MusinsaRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.drive.model.File;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@SpringBootTest
public class ShoppingClothesUpload {
    //사용자의 토큰을 어디에 저장할지 경로를 지정
    public static final String TOKENS_DIRECTORY_PATH = "tokens";
    //어플리케이션이 요청하는 권한의 범위를 지정
    public static final List<String> SCOPES = Collections.singletonList(DriveScopes.DRIVE);
    //비밀키 경로
    public static final String CREDENTIALS_FILE_PATH = "/credentials.json";
    public static final String APPLICATION_NAME = "Google Drive API Java Quickstart";
    public static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

    @Autowired
    private MusinsaRepository musinsaRepository; // UserRepository는 JPA Repository 인터페이스

    // Json 파일을 불러오는 코드
    public static List<ClothesFolder> loadClothesList(String filePath) {
        ObjectMapper objectMapper = new ObjectMapper();
        List<ClothesFolder> clothesList = new ArrayList<>();

        try {
            // Try to read existing data from the file
            Path path = Paths.get(filePath);
            if (Files.exists(path)) {
                clothesList = objectMapper.readValue(path.toFile(), objectMapper.getTypeFactory().constructCollectionType(List.class, ClothesFolder.class));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return clothesList;
    }

    private static ClothesFolder findFolderID(String style, String gender) {
        String filePath = "src/main/resources/musinsaFolderID.json";
        List<ClothesFolder> clothesList = loadClothesList(filePath);

        for (ClothesFolder folder : clothesList) {
            if (folder.folderName.equals(style) && folder.gender.equals(gender)) {
                return folder;
            }
        }
        // 일치하는 폴더를 찾지 못한 경우 null을 반환합니다.
        return null;
    }

    public static Credential getCredentials(final NetHttpTransport HTTP_TRANSPORT) throws IOException {
        //credentials.json 파일을 in에 저장함
        InputStream in = GoogleDriveAPI.class.getResourceAsStream(CREDENTIALS_FILE_PATH);
        if (in == null) {   // credentials이 빈값이면
            throw new FileNotFoundException("Resource not found: " + CREDENTIALS_FILE_PATH);
        }
        GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));
        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                .setDataStoreFactory(new FileDataStoreFactory(new java.io.File(TOKENS_DIRECTORY_PATH)))
                .setAccessType("offline")
                .build();
        LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8081).build();
        Credential credential = new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");
        return credential;
    }

    @Test
    public void updateMusinsaDB() throws GeneralSecurityException, IOException {
        String folderPath = "D:\\perstDir\\Flask_backend\\images\\";

        ArrayList<String> genders = new ArrayList(); genders.add("man"); genders.add("woman");
        ArrayList<String> styles = new ArrayList(); styles.add("걸리시");  styles.add("고프코어"); styles.add("골프"); styles.add("댄디"); styles.add("로맨틱"); styles.add("미니멀"); styles.add("비즈니스캐주얼"); styles.add("스트릿"); styles.add("스포티"); styles.add("시크"); styles.add("아메카지"); styles.add("캐주얼");

        for (String gender : genders){
            for(String style : styles){
                // 폴더 객체 생성
                java.io.File folder = new java.io.File(folderPath+"\\"+gender+"\\"+style);

                // 해당 폴더에 있는 파일 목록 가져오기
                java.io.File[] files = folder.listFiles();

                // 파일 목록 출력
                if (files != null) {
                    for (java.io.File file : files) {
                        String fileName = file.getName();
                        List<String> fileMetaData = new ArrayList<>(List.of(file.getName().split("_")));
                        fileMetaData.set(5, fileMetaData.get(5).replace(".jpg",""));
                        fileMetaData.add(uploadBasic(gender, style, fileName));

                        System.out.println(fileName);
                        System.out.println(fileMetaData); // [man, 34376, 188, 70, 여름, 고프코어, 3jdhFJUr_dsjcb3j5bkksbakDJSFK]

                        MusinsaVO musinsaVO = new MusinsaVO(fileMetaData);
                        musinsaRepository.save(musinsaVO);
                    }
                } else {
                    System.out.println("해당 폴더에 파일이 존재하지 않습니다.");
                }
            }
        }
    }

    public String uploadBasic(String gender, String style, String fileName) throws IOException, GeneralSecurityException {
        // Load pre-authorized user credentials from the environment.
        // TODO(developer) - See https://developers.google.com/identity for
        // guides on implementing OAuth2 for your application.

        String folderPath = "D:\\perstDir\\Flask_backend\\images\\" + gender + "\\" + style + "\\" + fileName;
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        Drive service = new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
                .setApplicationName(APPLICATION_NAME)
                .build();

        // 저장할 폴더위치 파악함
        ClothesFolder folder = findFolderID(style, gender);
        List<String> folderID = new ArrayList();  folderID.add(folder.getFolderID());

        // Upload file photo.jpg on drive.
        File fileMetadata = new File();
        // File's content.
        java.io.File filepath = new java.io.File(folderPath);
        fileMetadata.setName(fileName);
        fileMetadata.setParents(folderID);

        // Specify media type and file-path for file.
        FileContent mediaContent = new FileContent("image/jpeg", filepath);
        try {
            File file = service.files().create(fileMetadata, mediaContent)
                    .setFields("id")
                    .execute();
            // System.out.println("File ID: " + file.getId());
            return file.getId();
        } catch (GoogleJsonResponseException e) {
            // TODO(developer) - handle error appropriately
            System.err.println("Unable to upload file: " + e.getDetails());
            throw e;
        }
    }

}
