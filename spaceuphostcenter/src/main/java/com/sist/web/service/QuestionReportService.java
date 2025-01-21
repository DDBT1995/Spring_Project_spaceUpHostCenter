package com.sist.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.QuestionReportDao;
import com.sist.web.model.QuestionReport;

@Service("questionReportService")
public class QuestionReportService
{
	private static Logger logger = LoggerFactory.getLogger(QuestionReportService.class);
	
	@Autowired
	private QuestionReportDao questionReportDao;
	
	public int insertQuestionReport(QuestionReport questionReport)
	{
		int count = 0;
		
		try
		{
			count = questionReportDao.insertQuestionReport(questionReport);
		}
		catch(Exception e)
		{
			logger.error("[QuestionReportService] insertQuestionReport Exception", e);
		}
		
		return count;
	}
}
