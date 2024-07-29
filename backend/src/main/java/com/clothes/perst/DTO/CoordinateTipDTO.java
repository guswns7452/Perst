package com.clothes.perst.DTO;

import java.util.HashMap;
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

            lists.put("Business-Casual", "businessCasual");
            lists.put("Casual", "casual");
            lists.put("Amekaji", "amkaji");
            lists.put("Dandy", "dandy");
            lists.put("Street", "street");
            lists.put("Chic", "chic");
            lists.put("Gofcore", "gofcore");
            lists.put("Minimal", "minimal");
            lists.put("Golf", "golf");
            lists.put("Sporty", "sporty");
            // lists.put("Romantic", "romantic");

            return lists.get(prev_codi);
        }

        else {
            Map<String, String> lists = new HashMap<>();

            lists.put("Girlish", "girlish");
            lists.put("Gofcore", "gofcore");
            lists.put("Golf", "golf");
            lists.put("Retro", "retro");
            lists.put("Romantic", "romantic");
            lists.put("Business-Casual", "businessCasual");
            lists.put("Street", "street");
            lists.put("Sporty", "sporty");
            lists.put("Chic", "chic");
            lists.put("Amekaji", "amekaji");
            lists.put("Casual", "casual");

            return lists.get(prev_codi);
        }
    }
}
