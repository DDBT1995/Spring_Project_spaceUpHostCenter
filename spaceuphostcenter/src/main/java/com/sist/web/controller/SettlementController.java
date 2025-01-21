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
import com.sist.web.model.Settlement;
import com.sist.web.service.SettlementService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("settlementController")
public class SettlementController {
	
	private static Logger logger = LoggerFactory.getLogger(SettlementController.class);

	@Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;
	
	@Autowired
	private SettlementService settlementService;
	
	private static final int LIST_COUNT = 10;
    private static final int PAGE_COUNT = 3;
	
	@RequestMapping(value = "/host/settlementList", method = RequestMethod.GET)
    public String settlementList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		//검색
		String searchValue = HttpUtil.get(request, "searchValue", "");
		
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		//총게시물 수
		long totalCount = 0;
		
		//정산 리스트
		List<Settlement> list = null;
		
		//페이징 객체
		Paging paging = null;
		
		//정산 조회객체
		Settlement search = new Settlement();
		
		if(!StringUtil.isEmpty(cookieUserEmail))
		{
			search.setHostEmail(cookieUserEmail);
		}
		
		if(!StringUtil.isEmpty(searchValue))
		{
			search.setSearchValue(searchValue);
		}
		
		totalCount = settlementService.settlementCount(search);
		
		logger.debug("=============================");
		logger.debug("totalCount : " + totalCount);
		logger.debug("searchValue : " + searchValue);
		logger.debug("=============================");
		
		if(totalCount > 0)
		{
			paging = new Paging("/host/settlementList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = settlementService.settlementList(search);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("curPage", curPage);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("paging", paging);
		
		return "/host/settlementList";
    }
	
	
	
	
	
	
	
	
	
	
	
}
