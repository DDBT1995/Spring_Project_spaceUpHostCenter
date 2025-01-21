package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.ReservationDao;
import com.sist.web.model.Reservation;

@Service("reservationService")
public class ReservationService {
	private static Logger logger = LoggerFactory.getLogger(HostService.class);
	
	@Autowired
	private ReservationDao reservationDao;
	
	// 예약 리스트 조회
    public List<Reservation> reservationList(Reservation reservation) {
		List<Reservation> reservationList = null;
		
		try {
		    reservationList = reservationDao.reservationList(reservation);
		} catch (Exception e) {
		    logger.error("[reservationService] reservationList Exception", e);
		}
		
		return reservationList;
    }
    
    // 예약 리스트 count
    public long reservationTotalCount(Reservation reservation) {
		long count = 0;
		
		try {
		    count = reservationDao.reservationTotalCount(reservation);
		} catch (Exception e) {
		    logger.error("[reservationService] reservationTotalCount Exception", e);
		}
		
		return count;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
