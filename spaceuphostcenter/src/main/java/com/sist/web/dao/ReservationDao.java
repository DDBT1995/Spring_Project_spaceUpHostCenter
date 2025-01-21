package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Reservation;

@Repository("reservationDoa")
public interface ReservationDao {
	// 예약 리스트 조회
	public List<Reservation> reservationList(Reservation reservation);
	
	// 예약 리스트 count
	public long reservationTotalCount(Reservation reservation);
	
}
