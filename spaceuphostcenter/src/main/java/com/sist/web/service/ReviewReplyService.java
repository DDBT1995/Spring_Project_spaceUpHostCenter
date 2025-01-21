package com.sist.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.ReviewReplyDao;
import com.sist.web.model.ReviewReply;

@Service("reviewReplyService")
public class ReviewReplyService
{
	private static Logger logger = LoggerFactory.getLogger(ReviewReplyService.class);
	
	@Autowired
	private ReviewReplyDao reviewReplyDao;
	
	// 호스트 공간에 대한 호스트 답변 모두 조회
	public ReviewReply hostReviewList(long reviewId)
	{
		ReviewReply reviewReply = null;
		
		try
		{
			reviewReply = reviewReplyDao.hostReviewList(reviewId);
		}
		catch(Exception e)
		{
		    logger.error("[ReviewReplyService] hostReviewList Exception", e);
		}
		
		return reviewReply;
	}
	
	// 호스트 답글 인서트
	public int insertReply(ReviewReply reviewReply)
	{
		int count = 0;
				
		try
		{
			count = reviewReplyDao.insertReply(reviewReply);
		}
		catch(Exception e)
		{
		    logger.error("[ReviewReplyService] hostReviewList Exception", e);
		}
		
		return count;
	}
	
	// 답글 조회
	public ReviewReply replySelect(long replyId)
	{
		ReviewReply reviewReply = null;
		
		try
		{
			reviewReply = reviewReplyDao.replySelect(replyId);
		}
		catch(Exception e)
		{
		    logger.error("[ReviewReplyService] replySelect Exception", e);
		}
		
		return reviewReply;
	}
	
	// 답글 수정
	public int updateReply(ReviewReply reviewReply)
	{
		int count = 0;
		
		try
		{
			count = reviewReplyDao.updateReply(reviewReply);
		}
		catch(Exception e)
		{
		    logger.error("[ReviewReplyService] updateReply Exception", e);
		}
		
		return count;
	}
	
	// 답글 삭제
	public int deleteReply(ReviewReply reviewReply)
	{
		int count = 0;
		
		try
		{
			count = reviewReplyDao.deleteReply(reviewReply);
		}
		catch(Exception e)
		{
		    logger.error("[ReviewReplyService] deleteReply Exception", e);
		}
		
		return count;
	}
	
	
	
	
	
	
}
