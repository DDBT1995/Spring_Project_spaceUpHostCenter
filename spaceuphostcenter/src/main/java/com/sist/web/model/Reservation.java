package com.sist.web.model;

import java.io.Serializable;

public class Reservation implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long reservationId;      // 예약 ID
    private Long spaceId;            // 공간 ID
    private String guestEmail;       // 구매자 이메일
    private String useDate;          // 이용 날짜 (ex: 20241225)
    private int useStartTime;        // 이용 시작 시간 (ex: 14)
    private int useEndTime;          // 이용 종료 시간 (ex: 24)
    private int usePeople;           // 사용 인원 수
    private String usePurpose;       // 사용 용도
    private String status;           // 예약 상태 (P: 진행 중, C: 완료, D: 취소)
    private String regDate;          // 예약을 한 날짜
    private String delDate;          // 예약을 취소한 날짜
    
    private String hostEmail;		// 판매자 이메일
    
    private long paymentId;			// 결제 ID
    
    private String searchKeyword;		// 검색 값
    private int sortReservation;		// 정렬타입 (1:이용날짜 최신순, 2:이용날짜 오래된순, 3:예약날짜 최신순, 4:예약날짜 오래된순)
	
	private long startRow;			// 시작페이지 rownum
	private long endRow;			// 끝페이지 rownum

    // 기본 생성자
    public Reservation() {
        this.reservationId = 0L;
        this.spaceId = 0L;
        this.guestEmail = "";
        this.useDate = "";
        this.useStartTime = 0;
        this.useEndTime = 0;
        this.usePeople = 0;
        this.usePurpose = "";
        this.status = "";  // 기본값: 진행 중
        this.regDate = "";
        this.delDate = null;
        
        hostEmail = "";
        
        paymentId = 0;
        
        searchKeyword = "";
        sortReservation = 0;
		
		startRow = 0;
		endRow = 0;
    }

    // Getter와 Setter
    public Long getReservationId() {
        return reservationId;
    }

    public void setReservationId(Long reservationId) {
        this.reservationId = reservationId;
    }

    public Long getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(Long spaceId) {
        this.spaceId = spaceId;
    }

    public String getGuestEmail() {
        return guestEmail;
    }

    public void setGuestEmail(String guestEmail) {
        this.guestEmail = guestEmail;
    }

    public String getUseDate() {
        return useDate;
    }

    public void setUseDate(String useDate) {
        this.useDate = useDate;
    }

    public int getUseStartTime() {
        return useStartTime;
    }

    public void setUseStartTime(int useStartTime) {
        this.useStartTime = useStartTime;
    }

    public int getUseEndTime() {
        return useEndTime;
    }

    public void setUseEndTime(int useEndTime) {
        this.useEndTime = useEndTime;
    }

    public int getUsePeople() {
        return usePeople;
    }

    public void setUsePeople(int usePeople) {
        this.usePeople = usePeople;
    }

    public String getUsePurpose() {
        return usePurpose;
    }

    public void setUsePurpose(String usePurpose) {
        this.usePurpose = usePurpose;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    public String getDelDate() {
        return delDate;
    }

    public void setDelDate(String delDate) {
        this.delDate = delDate;
    }

    public String getHostEmail() {
		return hostEmail;
	}

	public void setHostEmail(String hostEmail) {
		this.hostEmail = hostEmail;
	}

	public long getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(long paymentId) {
		this.paymentId = paymentId;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public int getSortReservation() {
		return sortReservation;
	}

	public void setSortReservation(int sortReservation) {
		this.sortReservation = sortReservation;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}

	@Override
    public String toString() {
        return "Reservation{" +
                "reservationId=" + reservationId +
                ", spaceId=" + spaceId +
                ", guestEmail='" + guestEmail + '\'' +
                ", useDate='" + useDate + '\'' +
                ", useStartTime=" + useStartTime +
                ", useEndTime=" + useEndTime +
                ", usePeople=" + usePeople +
                ", usePurpose='" + usePurpose + '\'' +
                ", status='" + status + '\'' +
                ", regDate='" + regDate + '\'' +
                ", delDate='" + delDate + '\'' +
                ", hostEmail='" + hostEmail + '\'' +
                '}';
    }
}
