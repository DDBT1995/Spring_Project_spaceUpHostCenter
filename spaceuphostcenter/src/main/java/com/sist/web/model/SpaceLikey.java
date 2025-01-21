package com.sist.web.model;

import java.io.Serializable;

public class SpaceLikey implements Serializable {
    private static final long serialVersionUID = 1L;

    private String guestEmail;  // 구매자 이메일, 아이디로 사용
    private Long spaceId;       // 공간 ID, SEQUENCE

    // 기본 생성자
    public SpaceLikey() {
        this.guestEmail = "";
        this.spaceId = 0L;
    }

    // Getter와 Setter
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

    @Override
    public String toString() {
        return "SpaceLikey{" +
                "guestEmail='" + guestEmail + '\'' +
                ", spaceId=" + spaceId +
                '}';
    }
}
