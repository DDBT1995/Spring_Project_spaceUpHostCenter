package com.sist.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.SpaceAnswerDao;
import com.sist.web.model.SpaceAnswer;

@Service("spaceAnswerService")
public class SpaceAnswerService
{
	private static Logger logger = LoggerFactory.getLogger(SpaceAnswerService.class);
	
	@Autowired
	private SpaceAnswerDao spaceAnswerDao;
	
	// 문의 답변 모두 조회
	public SpaceAnswer hostAnswerList(long spaceQuestionId)
	{		
		SpaceAnswer spaceAnswer = null;
		
		try
		{
			spaceAnswer = spaceAnswerDao.hostAnswerList(spaceQuestionId);
		}
		catch(Exception e)
		{
			logger.error("[SpaceAnswerService] hostAnswerList Exception", e);
		}
		
		return spaceAnswer;
	}

	// 문의 답변 등록
	public int insertAnswer(SpaceAnswer spaceAnswer)
	{
		int count = 0;
		
		try
		{
			count = spaceAnswerDao.insertAnswer(spaceAnswer);
		}
		catch(Exception e)
		{
			logger.error("[SpaceAnswerService] insertAnswer Exception", e);
		}
		
		return count;
	}

	// 문의 답변 1개 조회
	public SpaceAnswer AnswerSelect(long spaceAnswerId)
	{
		SpaceAnswer spaceAnswer = null;
		
		try
		{
			spaceAnswer = spaceAnswerDao.AnswerSelect(spaceAnswerId);
		}
		catch(Exception e)
		{
			logger.error("[SpaceAnswerService] AnswerSelect Exception", e);
		}
		
		return spaceAnswer;
	}

	// 문의 답변 수정
	public int updateAnswer(SpaceAnswer spaceAnswer) 
	{
		int count = 0;
		
		try
		{
			count = spaceAnswerDao.updateAnswer(spaceAnswer);
		}
		catch(Exception e)
		{
			logger.error("[SpaceAnswerService] updateAnswer Exception", e);
		}
		
		return count;
	}

	// 문의 답변 삭제
	public int deleteAnswer(SpaceAnswer spaceAnswer)
	{
		int count = 0;
		
		try
		{
			count = spaceAnswerDao.deleteAnswer(spaceAnswer);
		}
		catch(Exception e)
		{
			logger.error("[SpaceAnswerService] deleteAnswer Exception", e);
		}
		
		return count;
	}
}
