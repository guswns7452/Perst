package com.clothes.perst;

import com.clothes.perst.DTO.ClothesFolder;
import com.clothes.perst.config.GoogleDriveAPI;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.FileList;
import org.junit.jupiter.api.Test;
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
public class GoogleFileID {
    public static final String APPLICATION_NAME = "Google Drive API Java Quickstart";
    public static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
    //사용자의 토큰을 어디에 저장할지 경로를 지정
    public static final String TOKENS_DIRECTORY_PATH = "tokens";
    //어플리케이션이 요청하는 권한의 범위를 지정
    public static final List<String> SCOPES = Collections.singletonList(DriveScopes.DRIVE);
    //비밀키 경로
    public static final String CREDENTIALS_FILE_PATH = "/credentials.json";

    /**
     * 폴더 위한 클래스 -> DTO로 분리함
     */

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

    // Json 파일을 저장하는 코드
    public static void saveClothesList(String filePath, List<ClothesFolder> clothesList) {
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // Save the updated list back to the file
            Path path = Paths.get(filePath);
            System.out.println(path);
            objectMapper.writeValue(path.toFile(), clothesList);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Credentials 코드
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
        LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8080).build();
        Credential credential = new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");
        return credential;
    }
    
    @Test
    public void SaveGoogleFolderFileID() throws GeneralSecurityException, IOException {
        String filePath = "src/main/resources/musinsaFolderID.json";
        System.out.println(filePath);

        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        Drive service = new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
                .setApplicationName(APPLICATION_NAME)
                .build();
        FileList result = service.files().list()
                .setQ("'1q-P7if9MFNl2LV8nBvzN5tNeOXuiPQVM' in parents and trashed=false") //특정 폴더 만 검색하기
                .setPageSize(100)
                .setFields("nextPageToken, files(id, name)")
                .execute();

        List<File> files = result.getFiles();

        // List<ClothesFolder> clothesList = new ArrayList<>();
        List<ClothesFolder> clothesList = loadClothesList(filePath);

        if (files == null || files.isEmpty()) {
            System.out.println("No files found.");
        } else {
            System.out.println("Files:");
            for (File file : files) {
                ClothesFolder newClothes = new ClothesFolder("man", file.getName(), file.getId()); // 폴더를 저장하는 코드
                clothesList.add(newClothes);
                System.out.printf("%s (%s)\n", file.getName(), file.getId());
            }
        }
        saveClothesList(filePath, clothesList);
    }


}

