package com.sist.web.dao;

import org.springframework.stereotype.Repository;

import com.sist.web.model.SpaceAnswer;

@Repository("spaceAnswerDao")
public interface SpaceAnswerDao
{
	// 문의 답변 모두 조회
	public SpaceAnswer hostAnswerList(long spaceQuestionId);

	// 문의 답변 등록
	public int insertAnswer(SpaceAnswer spaceAnswer);

	// 문의 답변 1개 조회
	public SpaceAnswer AnswerSelect(long spaceAnswerId);

	// 문의 답변 수정
	public int updateAnswer(SpaceAnswer spaceAnswer);

	// 문의 답변 삭제
	public int deleteAnswer(SpaceAnswer spaceAnswer);
}
