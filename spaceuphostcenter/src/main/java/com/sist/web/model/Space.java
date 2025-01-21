package com.sist.web.model;

import java.io.Serializable;

public class Space implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long spaceId; // 공간 ID
    private String hostEmail; // 호스트 이메일
    private int spaceType; // 공간 유형 (1: 파티룸, 2: 스튜디오, 3: 팝업스토어 등)
    private String spaceName; // 공간 명
    private String spaceDesc; // 공간에 대한 설명 (CLOB)
    private String spaceTip; // 공간 한줄 소개
    private String spaceParking; // 공간 이용 시 주차 가능한 차량 수
    private int spaceMaxCapacity; // 공간 최대 인원 수
    private String spaceAddr; // 공간 주소
    private String spaceAddrDesc; // 공간 주소에 대한 정보
    private int spaceCloseDay; // 공간 휴무일 (1: 없음, 2: 주말, 3: 평일, 4: 호스트 설정)
    private String spaceNotice; // 공간 사용 시 유의 사항 (CLOB)
    private String spaceCloseDayHost; // 호스트 설정 휴무일
    private int spaceStartTime; // 공간 사용 가능 시작 시간
    private int spaceEndTime; // 공간 사용 가능 종료 시간
    private int minReservationTime; // 최소 공간 이용 시간
    private int spaceHourlyRate; // 시간 당 공간 대여비
    private String status; // 공간 상태 (Y: 정상, N: 삭제, D: 비활성화)
    private String regDate; // 공간 등록 날짜
    private String modiDate; // 공간 수정 날짜
    private String delDate; // 공간 삭제 날짜
    private int spaceReadCnt; // 공간 조회수

    private long startRow; // 시작페이지(rownum)
    private long endRow; // 끝페이지(rownum)

    // 기본 생성자
    public Space() {
	this.spaceId = 0L;
	this.hostEmail = "";
	this.spaceType = 0;
	this.spaceName = "";
	this.spaceDesc = "";
	this.spaceTip = "";
	this.spaceParking = "";
	this.spaceMaxCapacity = 0;
	this.spaceAddr = "";
	this.spaceAddrDesc = "";
	this.spaceCloseDay = 0;
	this.spaceNotice = "";
	this.spaceCloseDayHost = "";
	this.spaceStartTime = 0;
	this.spaceEndTime = 0;
	this.minReservationTime = 0;
	this.spaceHourlyRate = 0;
	this.status = "Y"; // 기본값: 비활성화
	this.regDate = "";
	this.modiDate = "";
	this.delDate = "";
	this.spaceReadCnt = 0;
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

    // Getter와 Setter
    public Long getSpaceId() {
	return spaceId;
    }

    public void setSpaceId(Long spaceId) {
	this.spaceId = spaceId;
    }

    public String getHostEmail() {
	return hostEmail;
    }

    public void setHostEmail(String hostEmail) {
	this.hostEmail = hostEmail;
    }

    public int getSpaceType() {
	return spaceType;
    }

    public void setSpaceType(int spaceType) {
	this.spaceType = spaceType;
    }

    public String getSpaceName() {
	return spaceName;
    }

    public void setSpaceName(String spaceName) {
	this.spaceName = spaceName;
    }

    public String getSpaceDesc() {
	return spaceDesc;
    }

    public void setSpaceDesc(String spaceDesc) {
	this.spaceDesc = spaceDesc;
    }

    public String getSpaceTip() {
	return spaceTip;
    }

    public void setSpaceTip(String spaceTip) {
	this.spaceTip = spaceTip;
    }

    public String getSpaceParking() {
	return spaceParking;
    }

    public void setSpaceParking(String spaceParking) {
	this.spaceParking = spaceParking;
    }

    public int getSpaceMaxCapacity() {
	return spaceMaxCapacity;
    }

    public void setSpaceMaxCapacity(int spaceMaxCapacity) {
	this.spaceMaxCapacity = spaceMaxCapacity;
    }

    public String getSpaceAddr() {
	return spaceAddr;
    }

    public void setSpaceAddr(String spaceAddr) {
	this.spaceAddr = spaceAddr;
    }

    public String getSpaceAddrDesc() {
	return spaceAddrDesc;
    }

    public void setSpaceAddrDesc(String spaceAddrDesc) {
	this.spaceAddrDesc = spaceAddrDesc;
    }

    public int getSpaceCloseDay() {
	return spaceCloseDay;
    }

    public void setSpaceCloseDay(int spaceCloseDay) {
	this.spaceCloseDay = spaceCloseDay;
    }

    public String getSpaceNotice() {
	return spaceNotice;
    }

    public void setSpaceNotice(String spaceNotice) {
	this.spaceNotice = spaceNotice;
    }

    public String getSpaceCloseDayHost() {
	return spaceCloseDayHost;
    }

    public void setSpaceCloseDayHost(String spaceCloseDayHost) {
	this.spaceCloseDayHost = spaceCloseDayHost;
    }

    public int getSpaceStartTime() {
	return spaceStartTime;
    }

    public void setSpaceStartTime(int spaceStartTime) {
	this.spaceStartTime = spaceStartTime;
    }

    public int getSpaceEndTime() {
	return spaceEndTime;
    }

    public void setSpaceEndTime(int spaceEndTime) {
	this.spaceEndTime = spaceEndTime;
    }

    public int getMinReservationTime() {
	return minReservationTime;
    }

    public void setMinReservationTime(int minReservationTime) {
	this.minReservationTime = minReservationTime;
    }

    public int getSpaceHourlyRate() {
	return spaceHourlyRate;
    }

    public void setSpaceHourlyRate(int spaceHourlyRate) {
	this.spaceHourlyRate = spaceHourlyRate;
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

    public int getSpaceReadCnt() {
	return spaceReadCnt;
    }

    public void setSpaceReadCnt(int spaceReadCnt) {
	this.spaceReadCnt = spaceReadCnt;
    }

    @Override
    public String toString() {
	return "Space{" + "spaceId=" + spaceId + ", hostEmail='" + hostEmail + '\'' + ", spaceType=" + spaceType
		+ ", spaceName='" + spaceName + '\'' + ", spaceDesc='" + spaceDesc + '\'' + ", spaceTip='" + spaceTip
		+ '\'' + ", spaceParking='" + spaceParking + '\'' + ", spaceMaxCapacity=" + spaceMaxCapacity
		+ ", spaceAddr='" + spaceAddr + '\'' + ", spaceAddrDesc='" + spaceAddrDesc + '\'' + ", spaceCloseDay="
		+ spaceCloseDay + ", spaceNotice='" + spaceNotice + '\'' + ", spaceCloseDayHost='" + spaceCloseDayHost
		+ '\'' + ", spaceStartTime=" + spaceStartTime + ", spaceEndTime=" + spaceEndTime
		+ ", minReservationTime=" + minReservationTime + ", spaceHourlyRate=" + spaceHourlyRate + ", status='"
		+ status + '\'' + ", regDate='" + regDate + '\'' + ", modiDate='" + modiDate + '\'' + ", delDate='"
		+ delDate + '\'' + ", spaceReadCnt=" + spaceReadCnt + '}';
    }
}
