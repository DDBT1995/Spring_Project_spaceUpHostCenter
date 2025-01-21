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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Paging;
import com.sist.web.model.Response;
import com.sist.web.model.Review;
import com.sist.web.model.ReviewReport;
import com.sist.web.service.ReviewReplyService;
import com.sist.web.service.ReviewReportService;
import com.sist.web.service.ReviewService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("reviewController")
public class ReviewController {
    private static Logger logger = LoggerFactory.getLogger(ReviewController.class);

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private ReviewReplyService reviewReplyService;

    private static final int REVIEW_LIST_COUNT = 3; // 한 페이지의 게시물 수
    private static final int REVIEW_PAGE_COUNT = 3; // 페이징 수

    // 호스트 마이페이지 > 리뷰
    @RequestMapping(value = "/host/reviewList")
    public String reviewList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	// 쿠키
	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	// 검색용
	String searchValue = HttpUtil.get(request, "searchValue", "");

	// 상태에 따른 정렬
	String reviewSorting = HttpUtil.get(request, "reviewSorting", "0");

	// 현재 페이지
	long curPage = HttpUtil.get(request, "curPage", (long) 1);

	// 작성한 리뷰 리스트
	List<Review> myReviewList = null;

	// 조회용 객체
	Review search = new Review();

	// 페이징 객체
	Paging paging = null;

	// 리뷰 총 갯수
	long myReviewCount = 0;

//    	Host host = new Host();

	// 호스트 쿠키 세팅
	if (!StringUtil.isEmpty(cookieUserEmail)) {
//    		String hexHostEmail = emailToHex(cookieUserEmail);
//    		host = hostService.hostSelect(cookieUserEmail);

	    search.setHostEmail(cookieUserEmail);
	}

	// 검색 세팅
	if (!StringUtil.isEmpty(searchValue)) {
	    search.setSearchValue(searchValue);
	}

	// 정렬 세팅
	if (!StringUtil.isEmpty(reviewSorting)) {
	    search.setReviewSorting(reviewSorting);
	}

	myReviewCount = reviewService.myReviewCount(search);

	logger.debug("curPage=========" + curPage);
	logger.debug("myReviewCount=========" + myReviewCount);

	if (myReviewCount > 0) {
	    paging = new Paging("/host/reviewList", myReviewCount, REVIEW_LIST_COUNT, REVIEW_PAGE_COUNT, curPage,
		    "curPage");

	    search.setStartRow(paging.getStartRow());
	    search.setEndRow(paging.getEndRow());

	    myReviewList = reviewService.myReviewList(search);

	    for (int i = 0; i < myReviewList.size(); i++) {
		myReviewList.get(i)
			.setReviewReply(reviewReplyService.hostReviewList(myReviewList.get(i).getReviewId()));
	    }
	    
	    for (Review reviewData : myReviewList) {
	        String guestEmail = reviewData.getGuestEmail();
	        
	        if (guestEmail != null) {
	            String hexEmail = emailToHex(guestEmail);

	            reviewData.setGuestEmail(hexEmail);
	        }
	        
	        if(reviewData.getReviewReply() != null) {
	    		String hostEmail = emailToHex(reviewData.getReviewReply().getHostEmail());
	    		
	    		reviewData.getReviewReply().setHostEmail(hostEmail);
	    	}
	    }
	}

	model.addAttribute("myReviewList", myReviewList);
	model.addAttribute("curPage", curPage);
	model.addAttribute("paging", paging);
	model.addAttribute("searchValue", searchValue);
	model.addAttribute("reviewSorting", reviewSorting);

	return "/host/reviewList";
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
