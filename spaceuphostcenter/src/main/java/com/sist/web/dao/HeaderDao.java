package com.sist.web.dao;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Host;

@Repository("headerDao")
public interface HeaderDao {
	// 사용자 조회
    public Host hostSelect(String hostEmail);
}	
