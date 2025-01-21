package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.SpaceQuestionDao;
import com.sist.web.model.SpaceQuestion;

@Service("spaceQuestionService")
public class SpaceQuestionService
{
	private static Logger logger = LoggerFactory.getLogger(SpaceQuestionService.class);
	
	@Autowired
	private SpaceQuestionDao spaceQuestionDao;
		
	// 문의 조회
	public List<SpaceQuestion> questionSelect(SpaceQuestion spaceQuestion)
	{
		List<SpaceQuestion> list = null;
		
		try
		{
			list = spaceQuestionDao.questionSelect(spaceQuestion);
		}
		catch(Exception e)
		{
		    logger.error("[SpaceQuestionService] myReviewList Exception", e);
		}
		
		return list;
	}
	
	// 문의 총 갯수
	public long questionCount(SpaceQuestion spaceQuestion)
	{
		long count = 0;
		
		try
		{
			count = spaceQuestionDao.questionCount(spaceQuestion);
		}
		catch(Exception e)
		{
		    logger.error("[SpaceQuestionService] questionCount Exception", e);
		}
		
		return count;
	}
}
