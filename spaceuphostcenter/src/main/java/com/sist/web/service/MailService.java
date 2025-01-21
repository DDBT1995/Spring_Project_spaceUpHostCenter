package com.sist.web.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service("mailService")
public class MailService {
    private static Logger logger = LoggerFactory.getLogger(MailService.class);

    @Autowired
    JavaMailSenderImpl mailSender;

    public void sendMail(String guestEmail, String title, String content) throws MessagingException {

	MimeMessage message = mailSender.createMimeMessage();
	MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

	// From, To, Subject, Text 설정
	helper.setFrom("rlatjddn8027@naver.com");
	helper.setTo(guestEmail);
	helper.setSubject(title);
	helper.setText(content, true); // HTML 형식으로 메일 내용 설정

	try {
	    // 메일 전송
	    mailSender.send(message);
	    logger.debug("메일 전송 성공, 수신자: " + guestEmail);
	}
	catch (Exception e) {
	    // 예외 처리: 메일 전송 실패 시 로그를 기록하거나 알림을 보내는 로직
	    logger.error("Error sending mail: " + e);
	    throw new MessagingException("메일 전송 실패, 수신자: " + guestEmail, e);
	}
    }
}
