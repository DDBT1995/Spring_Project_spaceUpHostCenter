package com.sist.web.model;

import java.io.Serializable;

public class ReviewReply implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long replyId;          // 리뷰 답변 ID, SEQUENCE
    private Long reviewId;         // 리뷰 ID, SEQUENCE
    private String hostEmail;      // 호스트 이메일, 아이디로 사용
    private String replyContent;   // 답변 내용
    private String status;         // 답변 상태, ex) 정상: "Y", 삭제: "N"
    private String regDate;        // 답변 등록 날짜
    private String modiDate;       // 답변 수정 날짜
    private String delDate;        // 답변 삭제 날짜
    
    // 호스트 답변 추가
    private String hostNickname;	// 호스트 닉네임

    // 기본 생성자
    public ReviewReply() {
        this.replyId = 0L;
        this.reviewId = 0L;
        this.hostEmail = "";
        this.replyContent = "";
        this.status = "Y";  // 기본값은 정상
        this.regDate = "";
        this.modiDate = null;
        this.delDate = null;
        
        // 호스트 답변 추가
        hostNickname = "";
    }

    // Getter와 Setter
    public Long getReplyId() {
        return replyId;
    }

    public void setReplyId(Long replyId) {
        this.replyId = replyId;
    }

    public Long getReviewId() {
        return reviewId;
    }

    public void setReviewId(Long reviewId) {
        this.reviewId = reviewId;
    }

    public String getHostEmail() {
        return hostEmail;
    }

    public void setHostEmail(String hostEmail) {
        this.hostEmail = hostEmail;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
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
    
    public String getHostNickname() {
		return hostNickname;
	}

	public void setHostNickname(String hostNickname) {
		this.hostNickname = hostNickname;
	}

	@Override
    public String toString() {
        return "ReviewReply{" +
                "replyId=" + replyId +
                ", reviewId=" + reviewId +
                ", hostEmail='" + hostEmail + '\'' +
                ", replyContent='" + replyContent + '\'' +
                ", status='" + status + '\'' +
                ", regDate='" + regDate + '\'' +
                ", modiDate='" + modiDate + '\'' +
                ", delDate='" + delDate + '\'' +
                '}';
    }
}
