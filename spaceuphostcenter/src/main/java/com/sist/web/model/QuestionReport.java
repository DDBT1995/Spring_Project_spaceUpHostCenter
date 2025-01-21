package com.sist.web.model;

import java.io.Serializable;

public class QuestionReport implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long questionReportId;    // 문의신고 ID
    private Long spaceQuestionId;     // 공간 문의사항 ID
    private String hostEmail;         // 호스트 이메일
    private String reportReason;      // 신고 내용
    private String reportDate;        // 신고 날짜
    private String status;            // 처리 여부 (ex: Y: 처리됨, N: 처리되지 않음)

    // 기본 생성자
    public QuestionReport() {
        this.questionReportId = 0L;
        this.spaceQuestionId = 0L;
        this.hostEmail = "";
        this.reportReason = "";
        this.reportDate = "";
        this.status = "N";  // 기본값: 처리되지 않음
    }

    // Getter와 Setter
    public Long getQuestionReportId() {
        return questionReportId;
    }

    public void setQuestionReportId(Long questionReportId) {
        this.questionReportId = questionReportId;
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

    public String getReportReason() {
        return reportReason;
    }

    public void setReportReason(String reportReason) {
        this.reportReason = reportReason;
    }

    public String getReportDate() {
        return reportDate;
    }

    public void setReportDate(String reportDate) {
        this.reportDate = reportDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "QuestionReport{" +
                "questionReportId=" + questionReportId +
                ", spaceQuestionId=" + spaceQuestionId +
                ", hostEmail='" + hostEmail + '\'' +
                ", reportReason='" + reportReason + '\'' +
                ", reportDate='" + reportDate + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
