package com.clothes.perst;

import com.clothes.perst.domain.ClothesVO;
import com.clothes.perst.persistance.ClothesInitRegister;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;

import java.io.File;
import java.io.FilenameFilter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@SpringBootTest
public class ClothesSubmitTests {

    @Autowired
    private ClothesInitRegister clothesInitRegister; // UserRepository는 JPA Repository 인터페이스

    @Test
    @DirtiesContext // 테스트가 컨텍스트에 영향을 주므로 사용
    public void testSaveUser() throws Exception {
        File dir = new File("G:\\내 드라이브\\[perst]데이터셋\\010.연도별 패션 선호도 파악 및 추천 데이터\\01-1.정식개방데이터\\Training\\01.원천데이터\\1960"); // URL
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
            ClothesVO clothes = new ClothesVO();
            System.out.println("filename : " + filename);
            clothes.setClothesFile(filename);
            clothes.setClothesSex("남자");

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

            ClothesVO clothes2 = clothesInitRegister.save(clothes); // DB에 저장하는 과정
            System.out.println(clothes2.getClothesFile());
        }
    }
}
