package com.sist.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

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
import com.sist.web.model.ReviewReply;
import com.sist.web.service.ReviewReplyService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("reviewReplyController")
public class ReviewReplyController {
    private static Logger logger = LoggerFactory.getLogger(ReviewReplyController.class);

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;

    @Autowired
    private ReviewReplyService reviewReplyService;

    // 답글 등록 aJax
    @RequestMapping(value = "/host/insertReply", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> insertReply(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	long reviewId = HttpUtil.get(request, "reviewId", (long) 0);
	String replyContent = HttpUtil.get(request, "replyContent", "");

	logger.debug("111============================");
	logger.debug("reviewId : " + reviewId);
	logger.debug("replyContent : " + replyContent);
	logger.debug("111============================");

	if (!StringUtil.isEmpty(cookieUserEmail)) { // 로그인
	    if (reviewId > 0 && !StringUtil.isEmpty(replyContent)) { // 리뷰가 있는 경우
		ReviewReply reviewReply = new ReviewReply();

		reviewReply.setHostEmail(cookieUserEmail);
		reviewReply.setReviewId(reviewId);
		reviewReply.setReplyContent(replyContent);
		reviewReply.setStatus("Y");

		logger.debug("222=====*====*=======*====*=====*===");
		logger.debug("cookieUserEmail : " + cookieUserEmail);
		logger.debug("reviewId : " + reviewId);
		logger.debug("replyContent : " + replyContent);
		logger.debug("222======*====*===*=====*====*======");

		if (reviewReplyService.insertReply(reviewReply) > 0) {
		    res.setResponse(0, "Reply insert success");
		} else {
		    res.setResponse(500, "Internal server error");
		}
	    } else { // 리뷰가 없는 경우
		res.setResponse(404, "Review not found");
	    }
	} else { // 미로그인
	    res.setResponse(410, "Not logged in");
	}

	return res;
    }

    // 답글 수정 aJax
    @RequestMapping(value = "/host/updateReply", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> updateReply(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	long replyId = HttpUtil.get(request, "replyId", (long) 0);
	String replyContent = HttpUtil.get(request, "replyContent", "");

	logger.debug("============================");
	logger.debug("replyId : " + replyId);
	logger.debug("replyContent : " + replyContent);
	logger.debug("============================");

	if (replyId > 0 && !StringUtil.isEmpty(replyContent)) { // 답글ID 있고, 답글내용 있음
	    ReviewReply reviewReply = reviewReplyService.replySelect(replyId);

	    if (reviewReply != null) { // 답글 ID에 맞는 답글이 있음
		if (StringUtil.equals(cookieUserEmail, reviewReply.getHostEmail())) { // 호스트 계정 본인글일 경우
		    reviewReply.setReplyId(replyId);
		    reviewReply.setReplyContent(replyContent);
		    reviewReply.setStatus("Y");

		    // 현재 날짜와 시간을 문자열로 변환
		    SimpleDateFormat sdf = new SimpleDateFormat("YYYY. MM. DD");
		    String currentDate = sdf.format(new Date());
		    reviewReply.setModiDate(currentDate);

		    if (reviewReplyService.updateReply(reviewReply) > 0) {
			res.setResponse(0, "Reply update success");
		    } else {
			res.setResponse(500, "Internal server error");
		    }
		} else { // 호스트 계정 본인글이 아닌 경우
		    res.setResponse(403, "Not own's post");
		}
	    } else { // 답글 ID에 맞는 답글이 없을 경우
		res.setResponse(404, "Not found");
	    }
	} else { // 답글ID 없거나 답글내용 없을 경우
	    res.setResponse(400, "Bad request");
	}

	return res;
    }

    // 답글 삭제 aJax
    @RequestMapping(value = "/host/deleteReply", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> deleteReply(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	long replyId = HttpUtil.get(request, "replyId", (long) 0);

	if (replyId > 0) { // 답글 ID가 있음
	    ReviewReply reviewReply = reviewReplyService.replySelect(replyId);

	    if (reviewReply != null) { // 답글 ID에 맞는 해당글이 있음
		if (StringUtil.equals(reviewReply.getHostEmail(), cookieUserEmail)) { // 본인 글
		    if (reviewReplyService.deleteReply(reviewReply) > 0) {
			res.setResponse(0, "Reply delete success");
		    } else {
			res.setResponse(500, "Internal server error");
		    }
		} else { // 본인 글이 아님
		    res.setResponse(403, "Not own's post");
		}
	    } else { // 답글 ID에 맞는 해당글이 없음
		res.setResponse(404, "Not found");
	    }
	} else { // 답글 ID가 없음
	    res.setResponse(404, "ReplyId Not found");
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
