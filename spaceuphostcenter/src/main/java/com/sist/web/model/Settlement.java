package com.sist.web.model;

import java.io.Serializable;

public class Settlement implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long settlementId;       // 정산 ID, SEQUENCE
    private String hostEmail;        // 호스트 이메일, 아이디로 사용
    private Long settlementAmount;   // 정산 금액
    private String status;           // 정산 상태, ex) Y:정산 완료, N: 정산 대기
    private String settlementDate;   // 정산 처리 날짜
    private int payCount;			 // 월별 결제 건수
    
    private String searchValue;		 // 검색 값
    
    private long startRow; // 시작페이지(rownum)
    private long endRow; // 끝페이지(rownum)

    // 기본 생성자
    public Settlement() {
        this.settlementId = 0L;
        this.hostEmail = "";
        this.settlementAmount = 0L;
        this.status = "N";  // 기본값은 정산 대기(N)
        this.settlementDate = "";
        payCount = 0;
        
        searchValue = "";
        
        startRow = 0;
        endRow = 0;
    }

    // Getter와 Setter
    public Long getSettlementId() {
        return settlementId;
    }

    public void setSettlementId(Long settlementId) {
        this.settlementId = settlementId;
    }

    public String getHostEmail() {
        return hostEmail;
    }

    public void setHostEmail(String hostEmail) {
        this.hostEmail = hostEmail;
    }

    public Long getSettlementAmount() {
        return settlementAmount;
    }

    public void setSettlementAmount(Long settlementAmount) {
        this.settlementAmount = settlementAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSettlementDate() {
        return settlementDate;
    }

    public void setSettlementDate(String settlementDate) {
        this.settlementDate = settlementDate;
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

	public int getPayCount() {
		return payCount;
	}

	public void setPayCount(int payCount) {
		this.payCount = payCount;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	@Override
    public String toString() {
        return "Settlement{" +
                "settlementId=" + settlementId +
                ", hostEmail='" + hostEmail + '\'' +
                ", settlementAmount=" + settlementAmount +
                ", status='" + status + '\'' +
                ", settlementDate='" + settlementDate + '\'' +
                '}';
    }
}
