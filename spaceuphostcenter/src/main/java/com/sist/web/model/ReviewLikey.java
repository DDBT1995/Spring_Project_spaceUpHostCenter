package com.sist.web.model;

import java.io.Serializable;

public class ReviewLikey implements Serializable {
    private static final long serialVersionUID = 1L;

    private String guestEmail;    // 구매자 이메일, 아이디로 사용
    private Long reviewId;        // 리뷰 ID, SEQUENCE

    // 기본 생성자
    public ReviewLikey() {
        this.guestEmail = "";
        this.reviewId = 0L;
    }

    // Getter와 Setter
    public String getGuestEmail() {
        return guestEmail;
    }

    public void setGuestEmail(String guestEmail) {
        this.guestEmail = guestEmail;
    }

    public Long getReviewId() {
        return reviewId;
    }

    public void setReviewId(Long reviewId) {
        this.reviewId = reviewId;
    }

    @Override
    public String toString() {
        return "ReviewLikey{" +
                "guestEmail='" + guestEmail + '\'' +
                ", reviewId=" + reviewId +
                '}';
    }
}
