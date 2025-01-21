package com.sist.web.dao;

import org.springframework.stereotype.Repository;

import com.sist.web.model.ReviewReport;

@Repository("reviewReportDao")
public interface ReviewReportDao
{
	// 신고 등록
	public int insertReport(ReviewReport reviewReport);
}
