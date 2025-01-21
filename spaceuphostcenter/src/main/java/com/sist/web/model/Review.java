package com.sist.web.model;

import java.io.Serializable;

public class Review implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long reviewId;           // 리뷰 ID
    private Long reservationId;      // 예약 ID
    private int reviewScore;         // 리뷰 별점
    private String reviewContent;    // 리뷰 내용
    private String status;           // 리뷰 상태 (ex: Y: 정상, N: 삭제)
    private String regDate;          // 리뷰 등록 날짜
    private String modiDate;         // 리뷰 수정 날짜
    private String delDate;          // 리뷰 삭제 날짜
    
    // 작성한 리뷰 조회 추가
    private String guestEmail;			// 게스트 이메일 계정
    private String guestNickname;		// 게스트 닉네임
    private String spaceName; 			// 공간이름
    private String spaceAddr; 			// 공간주소
    private long spaceId;				// 공간 ID
    private int spaceType;				// 공간 TYPE
    private String hostEmail;			// 호스트 이메일 계정
    private ReviewReply reviewReply;	// 리뷰 답변
    
    // 공간번호 검색
    private String searchValue;
    
    // 정렬
    private String reviewSorting;
    
    // 페이징
    private long startRow; // 시작페이지(rownum)
    private long endRow; // 끝페이지(rownum)
    

    // 기본 생성자
    public Review() {
        this.reviewId = 0L;
        this.reservationId = 0L;
        this.reviewScore = 0;
        this.reviewContent = "";
        this.status = "Y";  // 기본값: 정상
        this.regDate = "";
        this.modiDate = null;
        this.delDate = null;
        
        // 작성한 리뷰 조회 추가
        guestEmail = "";		
        guestNickname = "";	
        spaceName = ""; 	
        spaceAddr = ""; 		
        spaceId = 0;
        spaceType = 0;
        hostEmail = "";
        reviewReply = null;
        
        // 공간번호 검색
        searchValue = "";
        
        // 정렬
        reviewSorting = "0";
        
        // 페이징
        startRow = 0; 
        endRow = 0; 
    }

    // Getter와 Setter
    public Long getReviewId() {
        return reviewId;
    }

    public void setReviewId(Long reviewId) {
        this.reviewId = reviewId;
    }

    public Long getReservationId() {
        return reservationId;
    }

    public void setReservationId(Long reservationId) {
        this.reservationId = reservationId;
    }

    public int getReviewScore() {
        return reviewScore;
    }

    public void setReviewScore(int reviewScore) {
        this.reviewScore = reviewScore;
    }

    public String getReviewContent() {
        return reviewContent;
    }

    public void setReviewContent(String reviewContent) {
        this.reviewContent = reviewContent;
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

    public String getModiDate() {
        return modiDate;
    }

    public void setModiDate(String modiDate) {
        this.modiDate = modiDate;
    }

    public String getDelDate() {
        return delDate;
    }

    public void setDelDate(String delDate) {
        this.delDate = delDate;
    }
    
    public String getGuestEmail() {
		return guestEmail;
	}

	public void setGuestEmail(String guestEmail) {
		this.guestEmail = guestEmail;
	}

	public String getGuestNickname() {
		return guestNickname;
	}

	public void setGuestNickname(String guestNickname) {
		this.guestNickname = guestNickname;
	}

	public String getSpaceName() {
		return spaceName;
	}

	public void setSpaceName(String spaceName) {
		this.spaceName = spaceName;
	}

	public String getSpaceAddr() {
		return spaceAddr;
	}

	public void setSpaceAddr(String spaceAddr) {
		this.spaceAddr = spaceAddr;
	}

	public long getSpaceId() {
		return spaceId;
	}

	public void setSpaceId(long spaceId) {
		this.spaceId = spaceId;
	}

	public int getSpaceType() {
		return spaceType;
	}

	public void setSpaceType(int spaceType) {
		this.spaceType = spaceType;
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

	public String getHostEmail() {
		return hostEmail;
	}

	public void setHostEmail(String hostEmail) {
		this.hostEmail = hostEmail;
	}	

	public ReviewReply getReviewReply() {
		return reviewReply;
	}

	public void setReviewReply(ReviewReply reviewReply) {
		this.reviewReply = reviewReply;
	}	

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public String getReviewSorting() {
		return reviewSorting;
	}

	public void setReviewSorting(String reviewSorting) {
		this.reviewSorting = reviewSorting;
	}

	@Override
    public String toString() {
        return "Review{" +
                "reviewId=" + reviewId +
                ", reservationId=" + reservationId +
                ", reviewScore=" + reviewScore +
                ", reviewContent='" + reviewContent + '\'' +
                ", status='" + status + '\'' +
                ", regDate='" + regDate + '\'' +
                ", modiDate='" + modiDate + '\'' +
                ", delDate='" + delDate + '\'' +
                '}';
    }
}
