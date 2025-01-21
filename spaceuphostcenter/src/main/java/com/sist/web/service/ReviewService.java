package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.ReviewDao;
import com.sist.web.model.Review;

@Service("reviewService")
public class ReviewService
{
	private static Logger logger = LoggerFactory.getLogger(ReviewService.class);

	@Autowired
	private ReviewDao reviewDao;
	
	// 게스트 작성한 리뷰 조회
	public List<Review> myReviewList(Review review)
	{
		List<Review> list = null;
		
		try
		{
			list = reviewDao.myReviewList(review);
		}
		catch(Exception e)
		{
		    logger.error("[ReviewService] myReviewList Exception", e);
		}
		
		return list;
	}
	
	// 작성한 리뷰 총게시물 수
	public long myReviewCount(Review review)
	{
		long count = 0;
		
		try
		{
			count = reviewDao.myReviewCount(review);
		}
		catch(Exception e)
		{
		    logger.error("[ReviewService] myReviewCount Exception", e);
		}
		
		return count;
		
	}
}
