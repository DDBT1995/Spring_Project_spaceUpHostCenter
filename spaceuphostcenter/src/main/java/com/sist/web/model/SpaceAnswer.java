package com.sist.web.model;

import java.io.Serializable;

public class SpaceAnswer implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long spaceAnswerId;    // 공간 답변 ID
    private Long spaceQuestionId;  // 공간 문의사항 ID
    private String hostEmail;      // 호스트 이메일
    private String answerContent;  // 답변 내용
    private String status;         // 답변 상태 (정상: Y, 삭제: N)
    private String regDate;        // 답변 등록 날짜
    private String modiDate;       // 답변 수정 날짜
    private String delDate;        // 답변 삭제 날짜
    
    // 추가
    private String hostNickname;	// 호스트 닉네임

    // 기본 생성자
    public SpaceAnswer() {
        this.spaceAnswerId = 0L;
        this.spaceQuestionId = 0L;
        this.hostEmail = "";
        this.answerContent = "";
        this.status = "Y";  // 기본값: 정상
        this.regDate = "";
        this.modiDate = null;
        this.delDate = null;
        
        hostNickname = "";
    }

    // Getter와 Setter
    public Long getSpaceAnswerId() {
        return spaceAnswerId;
    }

    public void setSpaceAnswerId(Long spaceAnswerId) {
        this.spaceAnswerId = spaceAnswerId;
    }

    public Long getSpaceQuestionId() {
        return spaceQuestionId;
    }

    public void setSpaceQuestionId(Long spaceQuestionId) {
        this.spaceQuestionId = spaceQuestionId;
    }

    public String getHostEmail() {
        return hostEmail;
    }

    public void setHostEmail(String hostEmail) {
        this.hostEmail = hostEmail;
    }

    public String getAnswerContent() {
        return answerContent;
    }

    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent;
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
        return "SpaceAnswer{" +
                "spaceAnswerId=" + spaceAnswerId +
                ", spaceQuestionId=" + spaceQuestionId +
                ", hostEmail='" + hostEmail + '\'' +
                ", answerContent='" + answerContent + '\'' +
                ", status='" + status + '\'' +
                ", regDate='" + regDate + '\'' +
                ", modiDate='" + modiDate + '\'' +
                ", delDate='" + delDate + '\'' +
                '}';
    }
}
