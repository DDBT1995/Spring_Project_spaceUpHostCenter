package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Settlement;

@Repository("settlementDao")
public interface SettlementDao {
	
	//정산 리스트
	public List<Settlement> settlementList(Settlement settlement);
	
	//정산 총게시물 수
	public long settlementCount(Settlement settlement);
	
//	//정산 인서트
//	public int insertSettlement(String hostEmail);
//	
//	//정산 가능한 호스트 조회
//	public List<String> getHostList();
}
