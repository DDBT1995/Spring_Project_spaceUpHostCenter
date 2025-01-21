package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Review;

@Repository("reviewDao")
public interface ReviewDao
{
	// 게스트 작성한 리뷰 조회
	public List<Review> myReviewList(Review review);
	
	// 작성한 리뷰 총게시물 수
	public long myReviewCount(Review review);
}
