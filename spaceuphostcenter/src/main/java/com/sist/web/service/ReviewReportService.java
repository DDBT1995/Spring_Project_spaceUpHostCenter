package com.sist.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.ReviewReportDao;
import com.sist.web.model.ReviewReport;

@Service("reviewReportService")
public class ReviewReportService
{
	private static Logger logger = LoggerFactory.getLogger(ReviewReportService.class);
	
	@Autowired
	private ReviewReportDao reviewReportDao;
	
	// 신고 등록
	public int insertReport(ReviewReport reviewReport)
	{
		int count = 0;
		
		try
		{
			count = reviewReportDao.insertReport(reviewReport);
		}
		catch(Exception e)
		{
		    logger.error("[ReviewReportService] insertReport Exception", e);
		}
		
		return count;		
	}
}
