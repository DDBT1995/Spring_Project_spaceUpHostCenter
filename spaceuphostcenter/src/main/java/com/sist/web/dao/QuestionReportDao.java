package com.sist.web.dao;

import org.springframework.stereotype.Repository;

import com.sist.web.model.QuestionReport;

@Repository("questionReportDao")
public interface QuestionReportDao
{
	// 문의 신고 등록
	public int insertQuestionReport(QuestionReport questionReport);
}
