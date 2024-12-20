package com.clothes.perst.config;

import com.clothes.perst.DTO.ClothesFolder;
import com.clothes.perst.service.StyleAnalyzeService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.FileList;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.auth.oauth2.ServiceAccountCredentials;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @TODO GoogleDriveAPI 할일 들
 * 1. 폴더 경로를 지정 해서 fileID 알아내기. -> 폴더도 미리 fileID를 기록해두어야 할듯 함.
 * 2. fileID를 RestAPI로 전송하기. -> 완료.
 * 3. 구글 드라이브 폴더 경로를 지정해서 파일 업로드 하기. -> 프론트에서 바로 업로드를 하고, 백에서는 DB에 저장하는 방식으로만
 * +) 프론트엔드에서는 구글 드라이브 링크로 출력하는 연습
 * +) DB image도 realID를 넣어야함. 경로도 (아직 생성되지는 않음.)
 * @see <a href="https://developers.google.com/drive/api/guides/about-sdk?hl=ko">Google Drive API</a>
 * */
@Service
public class GoogleDriveAPI {
    public static final String APPLICATION_NAME = "Google Drive API Java Quickstart";

    public static GoogleCredentials getCredentials() throws IOException {
        InputStream in = StyleAnalyzeService.class.getResourceAsStream("/credentials_service.json");

        GoogleCredentials credential = ServiceAccountCredentials.fromStream(in).createScoped("https://www.googleapis.com/auth/drive");

        return credential;
    }
    
    /**
     * 특정 FolderID를 반환 하는 코드
     * @param gender
     * @param folderName (남성일 때는 연도별, 여성일 때는 스타일)
     * @return
     */
    public static String searchFolderID(String filePath, String gender, String folderName) {
        ObjectMapper objectMapper = new ObjectMapper();
        List<ClothesFolder> ClothesFolderList = new ArrayList<>();

        try {
            // Try to read existing data from the file
            Path path = Paths.get(filePath);
            if (Files.exists(path)) {
                ClothesFolderList = objectMapper.readValue(path.toFile(), objectMapper.getTypeFactory().constructCollectionType(List.class, ClothesFolder.class));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 반복문을 사용하는 방법, JavaStream을 사용하는 방법도 있던데, 성능차이가 얼마나?
        for (ClothesFolder folder : ClothesFolderList) {
            if (folder.getGender().equals(gender) && folder.getFolderName().equals(folderName)) {
                String folderID = folder.getFolderID();
                return folderID;
            }
        }

        new NullPointerException("일치하는 폴더가 없습니다");
        return null;
    }

    /**
     * 정규식을 이용하여 이미지 파일만 검출
     * @param file
     * @param gender
     */
    private static void isJPG(File file, String gender){
        String fileName = file.getName();
        if(gender.equals("M") && fileName.contains(".jpg")){
            System.out.printf("%s (%s)\n", fileName, file.getId());
        } else if (gender.equals("F") && fileName.contains(".jpg")) {
            // 복사본을 출력하지 않기 위한 코드
            String pattern = "^[0-9]*(\\.jpg)";
            Pattern regex = Pattern.compile(pattern);
            Matcher matcher = regex.matcher(fileName);
            if (matcher.find()) {
                System.out.printf("%s (%s)\n", fileName, file.getId());
            }
        }
    }

    /**
     * 특정 Folder 안에 파일들 출력 하기.
     * @param filePath
     * @param folderId
     * @throws GeneralSecurityException
     * @throws IOException
     */
    private static void printFliesInFolder(String filePath, String gender, String folderId) throws GeneralSecurityException, IOException {
        System.out.println(filePath);

        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
        HttpRequestInitializer requestInitializer = new HttpCredentialsAdapter(getCredentials());

        Drive service = new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, requestInitializer)
                .setApplicationName(GoogleDriveAPI.APPLICATION_NAME)
                .build();

        List<com.google.api.services.drive.model.File> files = new ArrayList<>();

        String pageToken = null;
        int count = 1;
        do {
            FileList result = service.files().list()
                    .setQ("'" + folderId + "' in parents and trashed=false") // 특정 폴더만 검색하기
                    .setPageSize(1000) // 최대 1000개씩 가능함.
                    .setFields("nextPageToken, files(id, name)")
                    .setPageToken(pageToken)
                    .execute();

            files.addAll(result.getFiles());

            pageToken = result.getNextPageToken();
            System.out.println("[Google Drive] "+count++ + " Page Loading End!");
        } while (pageToken != null);

        if (files == null || files.isEmpty()) {
            System.out.println("No files found.");
        } else {
            System.out.println("Files:");
            for (File file : files) {
                isJPG(file, gender);
            }
        }
    }

    public static void main(String... args) throws GeneralSecurityException, IOException {
        String gender = "M";
        String filePath = "src/main/resources/GoogleDriveFileID.json";

        printFliesInFolder(filePath, gender, searchFolderID(filePath,gender,"1950"));
    }
}