package com.sist.web.service;

import java.security.SecureRandom;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.common.util.StringUtil;
import com.sist.web.dao.HostDao;
import com.sist.web.model.Host;

@Service("hostService")
public class HostService {
    
    private static Logger logger = LoggerFactory.getLogger(HostService.class);

    @Autowired
    private HostDao hostDao;
    
    @Autowired
    private MailService mailService;
    
    // host 객체 선책(hostEmail)
    public Host hostSelect(String hostEmail) {
	Host host = null;

	try {
	    host = hostDao.hostSelect(hostEmail);
	} catch (Exception e) {
	    logger.error("[hostService] hostSelect Exception", e);
	}
	return host;
    }
    
    // 닉네임 중복체크
    public int hostNicknameDupChk(String hostNickname) {
	int count = -1;

	try {
	    count = hostDao.hostNicknameDupChk(hostNickname);
	} catch (Exception e) {
	    logger.error("[hostService] hostNicknameDupChk Exception", e);
	}

	return count;
    }
    
    // 연락처 중복체크
    public int hostTelDupChk(String hostTelDupChk) {
	int count = -1;

	try {
	    count = hostDao.hostTelDupChk(hostTelDupChk);
	} catch (Exception e) {
	    logger.error("[hostService] hostTelDupChk Exception", e);
	}

	return count;
    }
    
    
    // 호스트 회원가입
    public int hostReg(Host host) {
	int result = 0;

	try {
	    result = hostDao.hostReg(host);
	} catch (Exception e) {
	    logger.error("[hostService] hostReg Exception", e);
	}
	return result;
    }
    
    // 인증 코드 체크
    public boolean checkAuthCode(String guestAuthCode, HttpSession session) {
	String sessionAuthCode = (String) session.getAttribute("authCode"); // 세션에서 인증 코드 가져오기

	return guestAuthCode != null && StringUtil.equals(guestAuthCode, sessionAuthCode); // 입력된 인증 코드와 세션 코드 비교
    }

    // 인증 메일 전송
    public void sendAuthCodeMail(String guestEmail, String authCode, HttpSession session) throws MessagingException {
	// 인증 메일의 제목과 내용을 작성
	String title = "SpaceUp 인증";
	String content =  "<div style='font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 30px;'>"
	        + "<table align='center' cellpadding='0' cellspacing='0' style='max-width: 600px; width: 100%; background-color: #ffffff; border: 1px solid #eaeaea;'>"
	        + "<tr>"
	        + "<td style='text-align: center; padding: 20px;'>"
	        + "<img src=\"https://i.imgur.com/u7GBJNK.png\" alt=\"SpaceUp\" style=\"width: 150px; margin-bottom: -30px;\">\n"	        	    
	        + "</td>"
	        + "</tr>"
	        + "<tr>"
	        + "<td style='padding: 20px; text-align: center; color: #333; font-size: 16px; line-height: 1.5;'>"
	        + "<h2 style='color: #333;'>이메일 인증 코드</h2>"
	        + "<p>안녕하세요! SpaceUp에 가입해 주셔서 감사합니다.\n"
	        + "<br>"
	        + "<p>아래의 인증 코드를 사용해 이메일 인증을 완료해 주세요.\n"
	        + "<br>"
	        + "<br>"
	        + "인증코드는 이메일 발송 시점부터 <strong style='color: #2575fc;'>5분</strong>간 유효합니다.</p>"
	        + "</td>"
	        + "</tr>"
	        + "<tr>"
	        + "<td style='text-align: center; padding: 20px;'>"
	        + "<span style='display: inline-block; background-color: #2575fc; padding: 10px 20px; font-size: 22px; font-weight: bold; color: #fff; border: 1px solid #2575fc;'>\n"
	        + " " + authCode + "\n"
	        + "</span>"	      
	        + "</td>"
	        + "</tr>"
	        + "<tr>"
	        + "<td style='padding: 20px; text-align: center; color: #888; font-size: 12px; line-height: 1.5;'>"
	        + "<p>본 메일은 정보통신망 이용촉진 및 정보보호 등에 관한 법률 시행규칙 제 11조 3항에 의거<br>"
	        + "귀하의 요청에 의해 발송된 메일입니다. 발신 전용 메일이므로 회신을 통한 문의는 처리되지 않습니다.</p>"
	        + "<p>문의사항은 <a href='mailto:team@spaceup.co.kr' style='color: #2575fc;'>team@spaceup.co.kr</a>로 문의해주세요.</p>"
	        + "</td>"
	        + "</tr>"
	        + "<tr>"
	        + "<td style='background-color: #f1f1f1; color: #888; font-size: 12px; text-align: center; padding: 10px;'>"
	        + "(주)spaceUp | 서울특별시 마포구 월드컵북로 21 풍성빌딩 쌍용강북교육센터<br>"
	        + "사업자 등록번호 214-85-29296 | 이메일 <a href='mailto:team@spaceup.co.kr' style='color: #2575fc;'>team@spaceup.co.kr</a><br>"
	        + "© spaceUp Inc. All Rights Reserved."
	        + "</td>"
	        + "</tr>"
	        + "</table>"
	        + "</div>";

	// 인증 메일 전송
	try {
	    // 세션에 인증 코드 저장
	    session.setAttribute("authCode", authCode);
	    mailService.sendMail(guestEmail, title, content);
	} catch (MessagingException e) {
	    // 예외 처리 (로그 기록, 예외 전파 등)
	    logger.error("메일 전송 실패, 수신자: " + guestEmail);
	    throw new MessagingException("메일 전송 실패, 수신자: " + guestEmail, e);
	}
    }

    // 인증 코드 생성, 영어 대소문자, 숫자로 이루어진 8자리
    public String createAuthCode() {
	String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	SecureRandom random = new SecureRandom();
	StringBuilder authCode = new StringBuilder();

	for (int i = 0; i < 8; i++) {
	    int index = random.nextInt(characters.length());
	    authCode.append(characters.charAt(index));
	}
	return authCode.toString();
    }
    
    // 호스트 아이디 찾기
    public List<Host> findEmailList(String hostTel) {
	List<Host> list = null;

	try {
	    list = hostDao.findEmailList(hostTel);
	} catch (Exception e) {
	    logger.error("[hostService] findHostEmail Exception", e);
	}
	return list;
    }
    
    // 호스트 비밀번호 변경
    public int hostPwdUpdate(Host host) {
	int result = 0;

	try {
	    result = hostDao.hostPwdUpdate(host);
	} catch (Exception e) {
	    logger.error("[hostService] hostPwdUpdate Exception", e);
	}

	return result;
    }
    
    // 회원정보 관리 비밀번호 확인
    public String hostChkPwd(String hostEmail) {
	String host = null;

	try {
		host = hostDao.hostChkPwd(hostEmail);
	} catch (Exception e) {
	    logger.error("[HostService] hostChkPwd Exception", e);
	}

	return host;
    }
    
    // 호스트 닉네임 조회
    public Host hostSelectNick(String hostNickname) {
	Host host = null;

	try {
		host = hostDao.hostSelectNick(hostNickname);
	} catch (Exception e) {
	    logger.error("[HostService] hostSelectNick Exception", e);
	}

	return host;
    }
    
    // 회원정보 수정
    public int hostUpdate(Host host) {
	int count = 0;

	try {
	    count = hostDao.hostUpdate(host);
	} catch (Exception e) {
	    logger.error("[HostService] hostUpdate Exception", e);
	}

	return count;
    }
    
    // 회원 탈퇴
    public int hostDelete(Host host) {
	int count = 0;

	try {
	    count = hostDao.hostDelete(host);
	} catch (Exception e) {
	    logger.error("[HostService] hostDelete Exception", e);
	}

	return count;
    }
}
