package com.clothes.perst.DTO;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CoordinateTipDTO {

    /**
     * 코디 팁 타입 매칭
     * @param prev_codi
     * @param gender
     * @return
     */
    public static String changeCodiTip(String prev_codi, String gender){
        if(gender.equals("man")){
            Map<String, String> lists = new HashMap<>();

            // TODO 추후 Mods 고려 해야함 -> 현재 casual 매치가 되어있지 않아, 캐주얼에 매칭
            lists.put("Ivy", "businessCasual");
            lists.put("Mods", "casual");
            lists.put("Hippie", "amkaji");
            lists.put("Bold", "dandy");
            lists.put("Hip-hop", "street");
            lists.put("Metrosexual", "chic");
            lists.put("Sportive-Casual", "gofcore");
            lists.put("Normcore", "minimal");

            return lists.get(prev_codi);
        }

        else {
            Map<String, String> lists = new HashMap<>();

            lists.put("Traditional", "casual");
            lists.put("Manish", "businessCasual");
            lists.put("Feminine", "romantic");
            lists.put("Ethnic", "retro");
            lists.put("Contemporary", "casual");
            lists.put("Natural", "girlish");
            lists.put("Gender-Fluid", "businessCasual");
            lists.put("Sporty", "sporty");
            lists.put("Subculture", "casual");
            lists.put("Casual", "casual");

            return lists.get(prev_codi);
        }
    }
}
