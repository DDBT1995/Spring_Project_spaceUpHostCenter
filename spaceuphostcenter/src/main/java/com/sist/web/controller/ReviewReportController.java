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
import com.sist.web.model.Response;
import com.sist.web.model.ReviewReport;
import com.sist.web.service.ReviewReportService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("reviewReportController")
public class ReviewReportController
{
   private static Logger logger = LoggerFactory.getLogger(ReviewController.class);

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;
    
    @Autowired
    private ReviewReportService reviewReportService;
    
    // 신고 등록 aJax
    @RequestMapping(value="/host/insertReport", method=RequestMethod.POST)
    @ResponseBody
    public Response<Object> insertReport(HttpServletRequest request, HttpServletResponse response)
    {
    	Response<Object> res = new Response<Object>();
    	
    	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
    	
    	long reviewId = HttpUtil.get(request, "reviewId", (long)0);
    	String reporterId = HttpUtil.get(request, "reporterId", "");
    	String reporterType = HttpUtil.get(request, "reporterType", "");
    	String reportReason = HttpUtil.get(request, "reportReason", "");    	
    			
    	if(!StringUtil.isEmpty(cookieUserEmail) && cookieUserEmail != null)
    	{	// 로그인
			if(reviewId > 0)
			{	// 리뷰 있음
				ReviewReport reviewReport = new ReviewReport();
				
				reviewReport.setReporterId(cookieUserEmail);	// 리뷰 신고자
				reviewReport.setReviewId(reviewId);				// 리뷰 ID
				reviewReport.setReporterType("H");				// 신고자 타입
				reviewReport.setReportReason(reportReason);		// 신고 내용
				
				logger.debug("=====*====*=======*====*=====*===");
				logger.debug("reporterId : " + reporterId);
				logger.debug("reporterType : " + reporterType);
				logger.debug("reportReason : " + reportReason);
				logger.debug("======*====*===*=====*====*======");
				
				if(reviewReportService.insertReport(reviewReport) > 0)
				{
					res.setResponse(0, "Report insert success");
				}
				else
				{
					res.setResponse(500, "Internal server error");
				}    				
			}
			else
			{	// 리뷰 없음
				res.setResponse(404, "Review not found");
			}
    	}
    	else
    	{	// 미로그인
    		res.setResponse(410, "Not logged in");
    	}
    	
    	return res;
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
