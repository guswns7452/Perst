package com.clothes.perst.GoogleDrive.Clothes;

import com.clothes.perst.DTO.ClothesFolder;
import com.clothes.perst.config.GoogleDriveAPI;
import com.clothes.perst.domain.MusinsaVO;
import com.clothes.perst.persistance.MusinsaRepository;
import com.clothes.perst.service.StyleAnalyzeService;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.util.*;

/**
 * 쇼핑몰 이미지의 정보 > Google Drive 업로드
 * # 현재는 Python으로 이동함  #
 */
@Deprecated
@SpringBootTest
public class ShoppingCodiShopClothesUpload {
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

    public static GoogleCredentials getCredentials() throws IOException {
        InputStream in = StyleAnalyzeService.class.getResourceAsStream("/credentials_service.json");

        GoogleCredentials credential = ServiceAccountCredentials.fromStream(in).createScoped("https://www.googleapis.com/auth/drive");

        return credential;
    }

    @Test
    public void updateMusinsaDB() throws GeneralSecurityException, IOException {
        Map<String, String> seasonMap = new HashMap<String, String>();
        seasonMap.put("봄","spring"); seasonMap.put("여름","summer"); seasonMap.put("가을","autumn"); seasonMap.put("겨울","winter");

        Map<String, String> styleMap = new HashMap<String, String>();
        styleMap.put("캐주얼","casual"); styleMap.put("아메카지","Amekaji"); styleMap.put("시크","chic"); styleMap.put("스포티","sporty"); styleMap.put("스트릿","street"); styleMap.put("비즈니스캐주얼","businessCasual"); styleMap.put("로맨틱","romantic"); styleMap.put("레트로","retro"); styleMap.put("골프","golf"); styleMap.put("고프코어","gofcore"); styleMap.put("걸리시","girlish"); styleMap.put("미니멀","minimal"); styleMap.put("댄디","dandy");

        String folderPath = "D:\\coding\\perstDir\\Flask_backend\\newimages\\20240502";

        ArrayList<String> genders = new ArrayList(); genders.add("woman"); /*genders.add("man");*/
        ArrayList<String> styles = new ArrayList(); /*styles.add("걸리시"); styles.add("고프코어"); styles.add("골프"); styles.add("댄디"); styles.add("로맨틱"); styles.add("미니멀"); styles.add("비즈니스캐주얼"); styles.add("스트릿"); styles.add("스포티"); styles.add("시크"); styles.add("아메카지");*/ styles.add("캐주얼"); styles.add("레트로");

        for (String gender : genders){
            for(String style : styles){
                // 폴더 객체 생성
                java.io.File folder = new java.io.File(folderPath+"\\"+gender+"\\"+style);

                String englishStyle = styleMap.get(style);
                // 해당 폴더에 있는 파일 목록 가져오기
                java.io.File[] files = folder.listFiles();

                // 파일 목록 출력
                if (files != null) {
                    for (java.io.File file : files) {
                        String fileName = file.getName();
                        List<String> fileMetaData = new ArrayList<>(List.of(fileName.split("_")));

                        fileMetaData.set(4, seasonMap.get(fileMetaData.get(4)));
                        fileMetaData.set(5, styleMap.get(fileMetaData.get(5).replace(".jpg","")));

                        // File명을 모두 영어로 변경함
                        String newFileName = fileMetaData.toString().replace("[","").replace("]","").replace(", ","_")+".jpg";
                        
                        // 중간에 정지 하면 넘김 (숫자와 스타일)
                        if(Integer.parseInt(fileMetaData.get(1)) <= 41059 && style.equals("캐주얼")){
                            continue;
                        } 
                        
                        fileMetaData.add(uploadBasic(gender, englishStyle, folderPath+"\\"+gender+"\\"+style+"\\"+fileName, newFileName));

                        // System.out.println(fileName);
                        // System.out.println(fileMetaData); // [man, 34376, 188, 70, 여름, 고프코어, 3jdhFJUr_dsjcb3j5bkksbakDJSFK]

                        MusinsaVO musinsaVO = new MusinsaVO(fileMetaData);
                        musinsaVO.setMusinsaType("codishop");
                        musinsaRepository.save(musinsaVO);

                        System.out.println(newFileName);
                    }
                } else {
                    System.out.println("해당 폴더에 파일이 존재하지 않습니다.");
                }
            }
        }
    }

    public String uploadBasic(String gender, String style, String folderPath, String newFileName) throws IOException, GeneralSecurityException {
        // Load pre-authorized user credentials from the environment.
        // (developer) - See https://developers.google.com/identity for
        // guides on implementing OAuth2 for your application.

        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
        HttpRequestInitializer requestInitializer = new HttpCredentialsAdapter(getCredentials());

        Drive service = new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, requestInitializer)
                .setApplicationName(GoogleDriveAPI.APPLICATION_NAME)
                .build();

        // 저장할 폴더위치 파악함
        ClothesFolder folder = findFolderID(style, gender);
        List<String> folderID = new ArrayList();  folderID.add(folder.getFolderID());

        // Upload file photo.jpg on drive.
        File fileMetadata = new File();
        // File's content.
        java.io.File filepath = new java.io.File(folderPath);
        fileMetadata.setName(newFileName);
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
            // (developer) - handle error appropriately
            System.err.println("Unable to upload file: " + e.getDetails());
            throw e;
        }
    }

}
