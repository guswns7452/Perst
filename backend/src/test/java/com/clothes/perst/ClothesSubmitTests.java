package com.clothes.perst;

import com.clothes.perst.domain.ClothesFemaleVO;
import com.clothes.perst.domain.ClothesMaleVO;
import com.clothes.perst.persistance.ClothesFemaleInitRegister;
import com.clothes.perst.persistance.ClothesMaleInitRegister;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;

import java.io.File;
import java.io.FilenameFilter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @implNote 남성, 여성 테이블을 나눠서 남성은 연도별 구분완료함
 */
@SpringBootTest
public class ClothesSubmitTests {

    @Autowired
    private ClothesMaleInitRegister clothesMaleInitRegister; // UserRepository는 JPA Repository 인터페이스

    @Autowired
    private ClothesFemaleInitRegister clothesFemaleInitRegister; // UserRepository는 JPA Repository 인터페이스

    /**
     * 남성용 데이터를 불러오기 위한 코드
     * 남성 데이터 Training : 1950 - 2019 완료 -> 31,049장 / Validation : 반영 X
     */
    @Test
    @DirtiesContext // 테스트가 컨텍스트에 영향을 주므로 사용
    public void testSaveMale() throws Exception {
        int times = 2019; // 시대를 저장함
        
        // 구글 드라이브에서 파일명을 불러옴
        File dir = new File("G:\\내 드라이브\\[perst]데이터셋\\010.연도별 패션 선호도 파악 및 추천 데이터\\01-1.정식개방데이터\\Training\\01.원천데이터\\"+Integer.toString(times)); // URL
        String pattern = "^[a-zA-Z]_[0-9]*_[0-9]*_(\\w+)(_M\\.jpg)";

        FilenameFilter filter = new FilenameFilter() {
            public boolean accept(File f, String name) {
                //파일 이름에 ".jpg"가 붙은것들만 필터링
                return name.contains(".jpg");
            }
        };

        // 파일들 불러옴
        String[] filenames = dir.list(filter);
        
        // 반복문을 통해 하나하나 DB에 등록할 예정
        for (String filename : filenames) {
            ClothesMaleVO clothes = new ClothesMaleVO(); //객체를 새로 선언해야 DB에 새로 업데이트 됨

            System.out.println("filename : " + filename);
            clothes.setClothesFile(filename);
            clothes.setClothesTimes(times);

            // 정규식을 통해서 스타일 추출
            Pattern regex = Pattern.compile(pattern);
            Matcher matcher = regex.matcher(filename);

            if (matcher.find()) {
                String extractedString = matcher.group(1); // word 부분만 추출하여 스타일 등록
                clothes.setClothesStyle(extractedString);
            }else{
                throw new IllegalArgumentException("스타일이 좀 이상한데요?"); // 정규식 추출 실패시 에러 발생
            }
            clothes.setClothesStore("");

            ClothesMaleVO clothes2 = clothesMaleInitRegister.save(clothes); // DB에 저장하는 과정
            System.out.println(clothes2.getClothesFile());
        }
    }

    /**
     * 여성용 데이터를 반영하기 위한 테스트 코드
     * [여성 데이터 완료 ] 기타 / 레트로 / 로맨틱 (진행중) / 리조트
     * [여성 데이터 대기 ] 스트리트 : 클라우드에 모두 업로드 되지 않음
     */
    @Test
    @DirtiesContext // 테스트가 컨텍스트에 영향을 주므로 사용
    public void testSaveFemale() throws Exception {
        String style = "리조트"; // 스타일을 저장함

        // 구글 드라이브에서 파일명을 불러옴
        File dir = new File("D:\\perst dataset\\k-fashion\\K-Fashion 이미지\\Training\\원천데이터_1\\"+style); // URL
        String pattern = "^[0-9]*(\\.jpg)";

        FilenameFilter filter = new FilenameFilter() {
            public boolean accept(File f, String name) {
                //파일 이름에 ".jpg"가 붙은것들만 필터링
                return name.contains(".jpg");
            }
        };

        // 파일들 불러옴
        String[] filenames = dir.list(filter);

        // 반복문을 통해 하나하나 DB에 등록할 예정
        for (String filename : filenames) {
            ClothesFemaleVO clothes = new ClothesFemaleVO(); //객체를 새로 선언해야 DB에 새로 업데이트 됨

            System.out.println("filename : " + filename);
            clothes.setClothesFile(filename);
            clothes.setClothesStyle(style);
            
            // 정규식을 통해서 스타일 추출
            Pattern regex = Pattern.compile(pattern);
            Matcher matcher = regex.matcher(filename);

            if (matcher.find()) {
                clothes.setClothesStore("");

                ClothesFemaleVO clothes2 = clothesFemaleInitRegister.save(clothes); // DB에 저장하는 과정
                System.out.println(clothes2.getClothesFile());
            }else{
                System.out.println("제외됨 : " + filename);
            }
        }
    }
}
