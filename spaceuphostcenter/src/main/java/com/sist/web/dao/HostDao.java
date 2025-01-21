package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Host;


@Repository("hostDao")
public interface HostDao {
	// 사용자 조회
    public Host hostSelect(String hostEmail);
    
    // 닉네임 중복 체크
    public int hostNicknameDupChk(String hostNickname);
    
    // 연락처 중북 체크
    public int hostTelDupChk(String hostTelDupChk);
    
    // 호스트 회원가입
    public int hostReg(Host host);
    
    // 호스트 아이디 찾기
    public List<Host> findEmailList(String hostTel);
    
    // 호스트 비밀번호 변경
    public int hostPwdUpdate(Host host);
    
    // 회원정보 관리 비밀번호 확인
    public String hostChkPwd(String hostEmail);
    
    // 호스트 닉네임 조회
    public Host hostSelectNick(String hostNickname);
    
  

    // 회원정보 수정
    public int hostUpdate(Host host);
    
    // 회원 탈퇴
    public int hostDelete(Host host);

}
