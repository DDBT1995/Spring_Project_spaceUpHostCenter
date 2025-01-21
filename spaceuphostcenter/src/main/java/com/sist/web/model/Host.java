package com.sist.web.model;

import java.io.Serializable;

public class Host implements Serializable {
    private static final long serialVersionUID = 1L;

    private String hostEmail;        // 호스트 이메일, 아이디로 사용
    private String hostPwd;     // 호스트 비밀번호
    private String hostNickname;     // 호스트 닉네임
    private String hostBirth;        // 호스트 생년월일 (ex. 19961118)
    private String hostTel;          // 호스트 전화번호 (ex. 01063058027)
    private String status;           // 호스트 상태 (W: 승인 대기, Y: 정상, N: 탈퇴, S: 정지)
    private String regDate;          // 회원 가입 날짜
    private String modiDate;         // 회원 정보 수정 날짜
    private String delDate;          // 회원 탈퇴 날짜

    // 기본 생성자
    public Host() {
        this.hostEmail = "";
        this.hostPwd = "";
        this.hostNickname = "";
        this.hostBirth = "";
        this.hostTel = "";
        this.status = "W";  // 기본값: 승인 대기
        this.regDate = "";
        this.modiDate = null;
        this.delDate = null;
    }

    // Getter와 Setter

    public String getHostEmail() {
        return hostEmail;
    }

    public void setHostEmail(String hostEmail) {
        this.hostEmail = hostEmail;
    }

    public String getHostPwd() {
        return hostPwd;
    }

    public void setHostPwd(String hostPwd) {
        this.hostPwd = hostPwd;
    }

    public String getHostNickname() {
        return hostNickname;
    }

    public void setHostNickname(String hostNickname) {
        this.hostNickname = hostNickname;
    }

    public String getHostBirth() {
        return hostBirth;
    }

    public void setHostBirth(String hostBirth) {
        this.hostBirth = hostBirth;
    }

    public String getHostTel() {
        return hostTel;
    }

    public void setHostTel(String hostTel) {
        this.hostTel = hostTel;
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

    @Override
    public String toString() {
        return "Host{" +
                "hostEmail='" + hostEmail + '\'' +
                ", hostPwd='" + hostPwd + '\'' +
                ", hostNickname='" + hostNickname + '\'' +
                ", hostBirth='" + hostBirth + '\'' +
                ", hostTel='" + hostTel + '\'' +
                ", status='" + status + '\'' +
                ", regDate='" + regDate + '\'' +
                ", modiDate='" + modiDate + '\'' +
                ", delDate='" + delDate + '\'' +
                '}';
    }
}
