package com.sist.web.dao;

import org.springframework.stereotype.Repository;

import com.sist.web.model.ReviewReply;

@Repository("reviewReplyDao")
public interface ReviewReplyDao
{
	// 호스트 공간에 대한 호스트 답변 모두 조회
	public ReviewReply hostReviewList(long reviewId);
	
	// 호스트 답글
	public int insertReply(ReviewReply reviewReply);
	
	// 답글 조회
	public ReviewReply replySelect(long replyId);
	
	// 답글 수정
	public int updateReply(ReviewReply reviewReply);
	
	// 답글 삭제
	public int deleteReply(ReviewReply reviewReply);
}
