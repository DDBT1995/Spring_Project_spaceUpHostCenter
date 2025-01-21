package com.sist.web.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.sist.web.model.Host;
import com.sist.web.service.HeaderService;
import com.sist.web.util.CookieUtil;


@ControllerAdvice
public class HeaderController {
	
	private static Logger logger = LoggerFactory.getLogger(HeaderController.class);
	
	  @Value("#{env['auth.cookie.name']}")
	    private String AUTH_COOKIE_NAME;
	
	@Autowired
	private HeaderService headerService;
	
	// 모든 컨트롤러에서 유저 정보 모델에 추가
    @ModelAttribute
    public void addUserInfoToModel(ModelMap model, HttpServletRequest request) {
	    // 예시로, 쿠키에서 사용자 ID 가져오기
	    String cookieUserId = CookieUtil.getValue(request, AUTH_COOKIE_NAME);
	    
	    if (cookieUserId == null || cookieUserId.isEmpty()) {
	    	 return; // 특정 경로에서는 실행하지 않음	               
	    }
	    
	    Host headerHost = null;
	    
	    String decodedEmail = null;
	    

	    if (cookieUserId != null && !cookieUserId.isEmpty()) {
	        // 예시: 16진수로 인코딩된 이메일을 디코딩
	        decodedEmail = decodeHexToString(cookieUserId);	       
	    }
	        	    	    	    
	    headerHost = headerService.hostSelect(decodedEmail);
	   
	    Cookie[] cookies = request.getCookies();
	    for (Cookie cookie : cookies) {
	        System.out.println("Cookie Name: " + cookie.getName() + ", Value: " + cookie.getValue());
	    }
	    
	    model.addAttribute("cookieUserId", cookieUserId);
	    model.addAttribute("headerHost", headerHost);
	   
    }
    
    // 16진수로 인코딩된 값을 디코딩하는 유틸리티 메소드 예시
    private String decodeHexToString(String hex) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < hex.length(); i += 2) {
            sb.append((char) Integer.parseInt(hex.substring(i, i + 2), 16));
        }
        return sb.toString();
    }

 
}
