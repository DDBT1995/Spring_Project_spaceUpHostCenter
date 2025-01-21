package com.sist.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sist.web.model.Paging;
import com.sist.web.model.Reservation;
import com.sist.web.service.ReservationService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("reservationController")
public class ReservationContoller {
	private static Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;
    
    @Autowired
    private ReservationService reservationService;
    
    private static final int LIST_COUNT = 5;	// 한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;	// 페이징 수
    
    @RequestMapping(value = "/host/reservationList", method = RequestMethod.GET)
    public String reservationList(HttpServletRequest request, HttpServletResponse response, Model model) {
    	String loginHostEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
    	String searchKeyword = HttpUtil.get(request, "searchKeyword");
    	int sortReservation = HttpUtil.get(request, "sortReservation", 0);
    	long curPage = HttpUtil.get(request, "curPage", (long)1);
    	String statusSelect = HttpUtil.get(request, "statusSelect");
    	
    	List<Reservation> reservationList = null;
    	
		// 페이징 객체
		Paging paging = null;
    	
    	if(loginHostEmail != null && loginHostEmail != "") {
    		Reservation reservation = new Reservation();
    		
    		reservation.setHostEmail(loginHostEmail);
    		reservation.setSearchKeyword(searchKeyword);
    		reservation.setSortReservation(sortReservation);
    		reservation.setStatus(statusSelect);
    		
    		long totalCount = reservationService.reservationTotalCount(reservation);
    		
    		if(totalCount > 0) {
    			paging = new Paging("/board/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
    			
    			reservation.setStartRow(paging.getStartRow());
    			reservation.setEndRow(paging.getEndRow());
    			
    			reservationList = reservationService.reservationList(reservation);
    		}
    		
    		System.out.println("total@@@@@ : " + totalCount);
    		System.out.println("total@@@@@ : " + sortReservation);
    	}
    	
    	model.addAttribute("reservationList", reservationList);
    	model.addAttribute("curPage", curPage);
    	model.addAttribute("searchKeyword", searchKeyword);
    	model.addAttribute("sortReservation", sortReservation);
    	model.addAttribute("statusSelect", statusSelect);
    	model.addAttribute("paging", paging);
    	
	return "/host/reservationList";
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
