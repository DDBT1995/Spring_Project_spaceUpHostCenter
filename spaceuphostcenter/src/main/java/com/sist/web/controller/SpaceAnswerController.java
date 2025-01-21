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
import com.sist.web.model.SpaceAnswer;
import com.sist.web.service.SpaceAnswerService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;
import com.sist.web.util.JsonUtil;

@Controller("spaceAnswerController")
public class SpaceAnswerController {
    private static Logger logger = LoggerFactory.getLogger(SpaceAnswerController.class);

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;

    @Autowired
    private SpaceAnswerService spaceAnswerService;

    // 문의 답변 등록 aJax
    @RequestMapping(value = "/host/insertAnswer", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> insertAnswer(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	long spaceQuestionId = HttpUtil.get(request, "spaceQuestionId", (long) 0);
	String answerContent = HttpUtil.get(request, "answerContent", "");

	if (!StringUtil.isEmpty(cookieUserEmail)) { // 로그인
	    if (spaceQuestionId > 0) { // 문의 있음
		if (!StringUtil.isEmpty(answerContent)) { // 문의 내용 있음
		    SpaceAnswer spaceAnswer = new SpaceAnswer();

		    spaceAnswer.setHostEmail(cookieUserEmail);
		    spaceAnswer.setSpaceQuestionId(spaceQuestionId);
		    spaceAnswer.setAnswerContent(answerContent);
		    spaceAnswer.setStatus("Y");

		    logger.debug("++++++++++++++++++++++++++++++++++++");
		    logger.debug("cookieUserEmail : " + cookieUserEmail);
		    logger.debug("spaceQuestionId : " + spaceQuestionId);
		    logger.debug("answerContent : " + answerContent);
		    logger.debug("++++++++++++++++++++++++++++++++++++");

		    if (spaceAnswerService.insertAnswer(spaceAnswer) > 0) {
			res.setResponse(0, "Answer insert success");
		    } else {
			res.setResponse(500, "Internal server error");
		    }
		} else { // 문의 내용 없음
		    res.setResponse(400, "Bad request");
		}
	    } else { // 문의 없음
		res.setResponse(404, "Space Question not found");
	    }
	} else { // 미고르인
	    res.setResponse(410, "Not logged in");
	}

	if (logger.isDebugEnabled()) {
	    logger.debug("[SpaceAnswerController] /host/insertAnswer response \n" + JsonUtil.toJsonPretty(res));
	}

	return res;
    }

    // 문의 답변 수정 aJax
    @RequestMapping(value = "/host/updateAnswer", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> updateAnswer(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	long spaceAnswerId = HttpUtil.get(request, "spaceAnswerId", (long) 0);
	String answerContent = HttpUtil.get(request, "answerContent", "");

	if (spaceAnswerId > 0 && !StringUtil.isEmpty(answerContent)) { // 문의 있음, 내용 있음

	    SpaceAnswer spaceAnswer = spaceAnswerService.AnswerSelect(spaceAnswerId);

	    if (spaceAnswer != null) { // 답변 있음
		if (StringUtil.equals(cookieUserEmail, spaceAnswer.getHostEmail())) { // 본인 글
		    spaceAnswer.setSpaceAnswerId(spaceAnswerId);
		    spaceAnswer.setAnswerContent(answerContent);
		    spaceAnswer.setStatus("Y");

		    if (spaceAnswerService.updateAnswer(spaceAnswer) > 0) {
			res.setResponse(0, "Answer update success");
		    } else {
			res.setResponse(500, "Internal server error");
		    }
		} else { // 본인 글 아님
		    res.setResponse(403, "Not own's post");
		}
	    } else { // 답변이 없음
		res.setResponse(404, "Not found");
	    }
	} else { // 문의 없고, 내용 없음
	    res.setResponse(400, "Bad request");
	}

	return res;
    }

    // 문의 답변 삭제 aJax
    @RequestMapping(value = "/host/deleteAnswer", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> deleteAnswer(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	long spaceAnswerId = HttpUtil.get(request, "spaceAnswerId", (long) 0);

	if (spaceAnswerId > 0) { // 답변 있음
	    SpaceAnswer spaceAnswer = spaceAnswerService.AnswerSelect(spaceAnswerId);

	    if (spaceAnswer != null) { // 답변 해당글 있음
		if (StringUtil.equals(spaceAnswer.getHostEmail(), cookieUserEmail)) { // 본인 글
		    if (spaceAnswerService.deleteAnswer(spaceAnswer) > 0) {
			res.setResponse(0, "Answer delete success");
		    } else {
			res.setResponse(500, "Internal server error");
		    }
		} else { // 본인 글이 아님
		    res.setResponse(403, "Not own's post");
		}
	    } else { // 답변 맞는 해당글이 없음
		res.setResponse(404, "Not found");
	    }
	} else { // 답변 없음
	    res.setResponse(404, "spaceAnswerId Not found");
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
