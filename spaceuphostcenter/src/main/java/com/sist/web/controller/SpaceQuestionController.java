package com.sist.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Paging;
import com.sist.web.model.Review;
import com.sist.web.model.SpaceQuestion;
import com.sist.web.service.SpaceAnswerService;
import com.sist.web.service.SpaceQuestionService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("SpaceQuestionController")
public class SpaceQuestionController {
    private static Logger logger = LoggerFactory.getLogger(SpaceQuestionController.class);

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;

    @Autowired
    private SpaceQuestionService spaceQuestionService;

    @Autowired
    private SpaceAnswerService spaceAnswerService;

    private static final int QNA_LIST_COUNT = 3; // 한 페이지의 게시물 수
    private static final int QNA_PAGE_COUNT = 3; // 페이징 수

    // QnA 페이지
    @RequestMapping(value = "/host/QnAList")
    public String QnAList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long curPage = HttpUtil.get(request, "curPage", (long) 1);

	String searchValue = HttpUtil.get(request, "searchValue", "");
	String qnaSorting = HttpUtil.get(request, "qnaSorting", "0");

	List<SpaceQuestion> list = null;

	SpaceQuestion search = new SpaceQuestion();

	// 페이징
	Paging paging = null;

	// 총 갯수
	long qnaCount = 0;

	// 쿠키 세팅
	if (!StringUtil.isEmpty(cookieUserEmail)) {
	    search.setHostEmail(cookieUserEmail);
	}

	// 검색 세팅
	if (!StringUtil.isEmpty(searchValue)) {
	    search.setSearchValue(searchValue);
	}

	// 정렬 세팅
	if (!StringUtil.isEmpty(qnaSorting)) {
	    search.setQnaSorting(qnaSorting);
	}

	qnaCount = spaceQuestionService.questionCount(search);

	logger.debug("curPage=========" + curPage);
	logger.debug("qnaCount=========" + qnaCount);

	if (qnaCount > 0) {
	    paging = new Paging("/host/QnAList", qnaCount, QNA_LIST_COUNT, QNA_PAGE_COUNT, curPage, "curPage");

	    search.setStartRow(paging.getStartRow());
	    search.setEndRow(paging.getEndRow());

	    list = spaceQuestionService.questionSelect(search);

	    for (int i = 0; i < list.size(); i++) {
		list.get(i).setSpaceAnswer(spaceAnswerService.hostAnswerList(list.get(i).getSpaceQuestionId()));
	    }
	    
	    for (SpaceQuestion QnAData : list) {
	        String guestEmail = QnAData.getGuestEmail();
	        
	        if (guestEmail != null) {
	            String hexEmail = emailToHex(guestEmail);

	            QnAData.setGuestEmail(hexEmail);
	        }
	        
	        if(QnAData.getSpaceAnswer() != null) {
	    		String hostEmail = emailToHex(QnAData.getSpaceAnswer().getHostEmail());
	    		
	    		QnAData.getSpaceAnswer().setHostEmail(hostEmail);
	    	}
	    }
	}

	model.addAttribute("listQnA", list);
	model.addAttribute("curPage", curPage);
	model.addAttribute("paging", paging);
	model.addAttribute("searchValue", searchValue);
	model.addAttribute("qnaSorting", qnaSorting);

	return "/host/QnAList";
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
