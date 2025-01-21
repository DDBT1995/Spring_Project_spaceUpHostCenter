package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.SpaceQuestion;

@Repository("spaceQuestionDao")
public interface SpaceQuestionDao
{
	// 문의 조회
	public List<SpaceQuestion> questionSelect(SpaceQuestion spaceQuestion);
	
	// 문의 총 갯수
	public long questionCount(SpaceQuestion spaceQuestion);
}
