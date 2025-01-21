package com.sist.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.QuestionReport;
import com.sist.web.model.Response;
import com.sist.web.service.QuestionReportService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("questionReportController")
public class QuestionReportController
{
	private static Logger logger = LoggerFactory.getLogger(QuestionReportController.class);
	
    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;
    
	@Autowired
	private QuestionReportService questionReportService;
	
	@RequestMapping(value="/host/insertQuestionReport", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> insertQuestionReport(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> resAjax = new Response<Object>();
	
		String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long spaceQuestionId = HttpUtil.get(request, "spaceQuestionId", (long)0);
		String reportReason = HttpUtil.get(request, "reportReason", "");
		
		if(!StringUtil.isEmpty(cookieUserEmail))
		{	// 로그인
			if(spaceQuestionId > 0)
			{	// 문의 있음
				QuestionReport questionReport  = new QuestionReport();
				
				questionReport.setHostEmail(cookieUserEmail);
				questionReport.setSpaceQuestionId(spaceQuestionId);
				questionReport.setReportReason(reportReason);
				
				logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
				logger.debug("spaceQuestionId: " + spaceQuestionId);
				logger.debug("reportReason: " + reportReason);
				logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
				
				if(questionReportService.insertQuestionReport(questionReport) > 0)
				{
					resAjax.setResponse(0, "Q Report insert success");
				}
				else
				{
					resAjax.setResponse(500, "Internal server error");
				}
			}
			else
			{	// 문의 없음
				resAjax.setResponse(404, "QuestionId not found");
			}
		}
		else
		{	// 미로그인
			resAjax.setResponse(410, "Not logged in");
		}
		
		return resAjax;
	}
	
    // 이메일을 16진수로 변환하는 메서드
    public static String emailToHex(String email) {
	if (email == null || email.isEmpty()) {
	    throw new IllegalArgumentException("Email cannot be null or empty");
	}
	StringBuilder hexBuilder = new StringBuilder();
	for (char c : email.toCharArray()) {
	    hexBuilder.append(String.format("%02x", (int) c)); // 각 문자에 대해 16진수 변환
	}
	return hexBuilder.toString();
    }   
}
