package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.SettlementDao;
import com.sist.web.model.Settlement;

@Service("settlementService")
public class SettlementService {

    private static Logger logger = LoggerFactory.getLogger(SettlementService.class);

    @Autowired
    private SettlementDao settlementDao;

    // 정산 리스트
    public List<Settlement> settlementList(Settlement settlement) {
	List<Settlement> list = null;

	try {
	    list = settlementDao.settlementList(settlement);
	} catch (Exception e) {
	    logger.error("[settlementService] settlementList Exception e");
	}

	return list;
    }

    // 정산 총게시물 수
    public long settlementCount(Settlement settlement) {
	long count = 0;

	try {
	    count = settlementDao.settlementCount(settlement);
	} catch (Exception e) {
	    logger.error("[settlementService] settlementCount Exception e");
	}

	return count;
    }

//	//정산 인서트
//	public int insertSettlement(String hostEmail)
//	{
//		int count = 0;
//		
//		try
//		{
//			count = settlementDao.insertSettlement(hostEmail);
//		}
//		catch(Exception e)
//		{
//			logger.error("[settlementService] insertSettlement Exception e");
//		}
//		
//		return count;
//	}
//	
//	//정산 가능한 호스트 조회
//	public List<String> getHostList()
//	{
//		List<String> list = null;
//		
//		try
//		{
//			list = settlementDao.getHostList();
//		}
//		catch(Exception e)
//		{
//			logger.error("[settlementService] getHostList Exception e");
//		}
//		
//		return list;
//	}
}
