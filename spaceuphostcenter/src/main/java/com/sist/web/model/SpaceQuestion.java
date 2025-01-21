package com.sist.web.model;

import java.io.Serializable;

public class SpaceQuestion implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long spaceQuestionId;  // 공간 문의사항 ID
    private String guestEmail;     // 구매자 이메일
    private Long spaceId;          // 공간 ID
    private String questionContent; // 공간 문의 사항 내용
    private int questionCategory;  // 문의 카테고리 (1: 공간 문의, 2: 가격 문의, 3: 기타)
    private String status;         // 문의 상태 (정상: Y, 삭제: N)
    private String regDate;        // 문의 등록 날짜
    private String modiDate;       // 문의 수정 날짜
    private String delDate;        // 문의 삭제 날짜
    
    // 추가    
    private String spaceName; 			// 공간이름
    private String spaceAddr; 			// 공간주소
    private String guestNickname;		// 게스트 닉네임
    private String hostEmail;			// 호스트 이메일 계정
    private SpaceAnswer spaceAnswer;	// 리뷰 답변
    
    private String searchValue;
    private String qnaSorting;
    
    // 페이징
    private long startRow;
    private long endRow;

    // 기본 생성자
    public SpaceQuestion() {
        this.spaceQuestionId = 0L;
        this.guestEmail = "";
        this.spaceId = 0L;
        this.questionContent = "";
        this.questionCategory = 0;
        this.status = "Y";  // 기본값: 정상
        this.regDate = "";
        this.modiDate = null;
        this.delDate = null;
        
        // 추가
        spaceName = ""; 		// 공간이름
        spaceAddr = ""; 		// 공간주소
        guestNickname = "";		// 게스트 닉네임
        hostEmail = "";			// 호스트 이메일 계정
        spaceAnswer = null;		// 문의 답변
        
        searchValue = "";
        qnaSorting = "0";
        
        // 페이징
        startRow = 0; 
        endRow = 0; 
    }

    // Getter와 Setter
    public Long getSpaceQuestionId() {
        return spaceQuestionId;
    }

    public void setSpaceQuestionId(Long spaceQuestionId) {
        this.spaceQuestionId = spaceQuestionId;
    }

    public String getGuestEmail() {
        return guestEmail;
    }

    public void setGuestEmail(String guestEmail) {
        this.guestEmail = guestEmail;
    }

    public Long getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(Long spaceId) {
        this.spaceId = spaceId;
    }

    public String getQuestionContent() {
        return questionContent;
    }

    public void setQuestionContent(String questionContent) {
        this.questionContent = questionContent;
    }

    public int getQuestionCategory() {
        return questionCategory;
    }

    public void setQuestionCategory(int questionCategory) {
        this.questionCategory = questionCategory;
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

	public String getGuestNickname() {
		return guestNickname;
	}

	public void setGuestNickname(String guestNickname) {
		this.guestNickname = guestNickname;
	}

	public String getHostEmail() {
		return hostEmail;
	}

	public void setHostEmail(String hostEmail) {
		this.hostEmail = hostEmail;
	}

	public SpaceAnswer getSpaceAnswer() {
		return spaceAnswer;
	}

	public void setSpaceAnswer(SpaceAnswer spaceAnswer) {
		this.spaceAnswer = spaceAnswer;
	}	

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public String getQnaSorting() {
		return qnaSorting;
	}

	public void setQnaSorting(String qnaSorting) {
		this.qnaSorting = qnaSorting;
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
        return "SpaceQuestion{" +
                "spaceQuestionId=" + spaceQuestionId +
                ", guestEmail='" + guestEmail + '\'' +
                ", spaceId=" + spaceId +
                ", questionContent='" + questionContent + '\'' +
                ", questionCategory=" + questionCategory +
                ", status='" + status + '\'' +
                ", regDate='" + regDate + '\'' +
                ", modiDate='" + modiDate + '\'' +
                ", delDate='" + delDate + '\'' +
                '}';
    }
}
