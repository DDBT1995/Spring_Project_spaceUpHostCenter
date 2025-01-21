package com.sist.web.controller;

import java.io.File;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.common.model.FileData;
import com.sist.common.util.StringUtil;
import com.sist.web.model.Host;
import com.sist.web.model.Response;
import com.sist.web.service.HostService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;
import com.sist.web.util.JsonUtil;

@Controller("hostController")
public class HostController {
    private static Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;
    
    @Value("#{env['upload.save.host.dir']}")
    private String UPLOAD_HOST_SAVE_DIR;

    @Autowired
    private HostService hostService;

    // 호스트 로그인
    @RequestMapping(value = "/host/loginProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> loginProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String hostEmail = HttpUtil.get(request, "hostEmail");
	String hostPwd = HttpUtil.get(request, "hostPwd");

	// 전달 받은 값 체크
	if (!StringUtil.isEmpty(hostEmail) && !StringUtil.isEmpty(hostPwd)) {
	    Host host = hostService.hostSelect(hostEmail);

	    // 해당 회원 가입 여부 체크
	    if (host != null) {

		// 아이디와 비밀번호 일치 여부 체크
		if (StringUtil.equals(host.getHostPwd(), hostPwd)) {
		    // 회원 상태 체크
		    if (StringUtil.equals(host.getStatus(), "Y")) {
			CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(hostEmail));
			ajaxResponse.setResponse(1, "로그인 성공");
		    } else if (StringUtil.equals(host.getStatus(), "N")) {
			ajaxResponse.setResponse(0, "탈퇴한 회원");
		    } else if (StringUtil.equals(host.getStatus(), "S")) {
			ajaxResponse.setResponse(-1, "정지된 회원");
		    } else if (StringUtil.equals(host.getStatus(), "W")) {
			ajaxResponse.setResponse(-2, "승인되지 않은 회원");
		    }
		} else {
		    ajaxResponse.setResponse(-3, "일치하지 않는 비밀번호");
		}
	    } else {
		ajaxResponse.setResponse(-4, "존재하지 않는 계정");
	    }
	} else {
	    ajaxResponse.setResponse(400, "전달받은 값이 비어있음");
	}
	return ajaxResponse;
    }
    
    // 로그아웃
    @RequestMapping(value = "/host/logout", method = RequestMethod.GET)
    public String logOut(HttpServletRequest request, HttpServletResponse response) {

	if (CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null) {
	    CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
	}
	return "redirect:/host/hostLoginForm";
    }

    @RequestMapping(value = "/host/hostLoginForm", method = RequestMethod.GET)
    public String hostLoginForm(HttpServletRequest request, HttpServletResponse response) {
	return "/host/hostLoginForm";
    }
    
    // 아이디 찾기 화면
    @RequestMapping(value = "/host/hostFindEmailForm", method = RequestMethod.GET)
    public String hostFindEmailForm(HttpServletRequest request, HttpServletResponse response) {
	return "/host/hostFindEmailForm";
    }
    
    // 아이디 찾기
    @RequestMapping(value = "/host/findEmailProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> findEmailProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String hostTel = HttpUtil.get(request, "hostTel");

	List<Host> list = null;

	request.getSession().setAttribute("emailFound", false);

	// guestTel 값 체크
	if (!StringUtil.isEmpty(hostTel)) {
	    // 전화번호로 이메일 찾기
	    list = hostService.findEmailList(hostTel);

	    // list가 null 또는 비어 있을 경우 아이디가 없다고 응답
	    if (list == null || list.isEmpty()) {
		ajaxResponse.setResponse(0, "일치하는 이메일이 없습니다.");
	    } else {
		// 이메일을 찾았으면 세션에 저장하고, 이메일이 있다고 표시
		request.getSession().setAttribute("list", list);
		request.getSession().setAttribute("listCount", list.size());
		request.getSession().setAttribute("emailFound", true);
		ajaxResponse.setResponse(1, "아이디 찾기 성공");
	    }
	} else {
	    ajaxResponse.setResponse(400, "hostTel 값이 비어있음");
	}

	return ajaxResponse;
    }

    // 찾은 아이디 보여주는 페이지
    @RequestMapping(value = "/host/hostShowEmailForm", method = RequestMethod.GET)
    public String showEmailForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	Boolean emailFound = (Boolean) request.getSession().getAttribute("emailFound");

	// 만약 emailFound가 true일 때만 진행
	if (emailFound != null && emailFound) {
	    // list와 listCount를 세션에서 가져오기
	    List<Host> list = (List<Host>) request.getSession().getAttribute("list");
	    int listCount = (int) request.getSession().getAttribute("listCount");

	    if (list != null) {
		model.addAttribute("list", list);
		model.addAttribute("listCount", listCount);
	    }

	    request.getSession().setAttribute("emailFound", false);

	    return "/host/hostShowEmailForm"; // 정상적으로 이메일을 찾은 경우 페이지 이동
	} else {
	    // 이메일이 없거나 이메일 찾기 과정을 밟지 않은 경우 리다이렉트
	    return "redirect:/host/hostShowEmailForm"; // 예: 다시 아이디 찾기 페이지로 이동
	}
    }

    @RequestMapping(value = "/host/hostFindPwdForm", method = RequestMethod.GET)
    public String hostFindPwdForm(HttpServletRequest request, HttpServletResponse response) {
	return "/host/hostFindPwdForm";
    }
    
    
    // 회원가입 화면
    @RequestMapping(value = "/host/hostRegForm", method = RequestMethod.GET)
    public String hostRegForm(HttpServletRequest request, HttpServletResponse response) {
    	
	return "/host/hostRegForm";
    }
    
    // 회원가입
    @RequestMapping(value = "/host/regProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> regProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String hostEmail = HttpUtil.get(request, "hostEmail");
	String hostPwd = HttpUtil.get(request, "hostPwd");
	String hostNickname = HttpUtil.get(request, "hostNickname");
	String hostTel = HttpUtil.get(request, "hostTel");
	String hostBirth = HttpUtil.get(request, "hostBirth");

	// 전달 받은 값 체크
	if (!StringUtil.isEmpty(hostEmail) && !StringUtil.isEmpty(hostPwd) && !StringUtil.isEmpty(hostNickname)
		&& !StringUtil.isEmpty(hostTel) && !StringUtil.isEmpty(hostBirth)) {

	    Host host = new Host();
	    host.setHostEmail(hostEmail);
	    host.setHostPwd(hostPwd);
	    host.setHostNickname(hostNickname);
	    host.setHostTel(hostTel);
	    host.setHostBirth(hostBirth);

	    // DB 인서트 결과
	    if (hostService.hostReg(host) > 0) {
		ajaxResponse.setResponse(1, "회원 가입 성공");
	    } else {
		ajaxResponse.setResponse(0, "회원가입 실패");
	    }
	} else {
	    ajaxResponse.setResponse(400, "전달받은 값이 비어있음");
	}

	return ajaxResponse;
    }
    
    // 인증 메일 전송
    @RequestMapping(value = "/host/emailAuth", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> sendAuthEmail(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String hostEmail = HttpUtil.get(request, "hostEmail");
	String authCode = hostService.createAuthCode();
	logger.debug(authCode);

	try {
	    // 서비스에서 메일 전송
		hostService.sendAuthCodeMail(hostEmail, authCode, request.getSession());

	    // 메일 전송 성공 응답
	    ajaxResponse.setResponse(1, "인증 코드가 이메일로 전송되었습니다.");
	} catch (MessagingException e) {
	    // 메일 전송 실패 예외 처리
	    ajaxResponse.setResponse(500, "메일 전송에 실패하였습니다.");
	    logger.error("메일 전송 실패: ", e);
	} catch (Exception e) {
	    // 기타 예외 처리
	    ajaxResponse.setResponse(500, "서버에서 알 수 없는 오류가 발생했습니다.");
	    logger.error("서버 오류: ", e);
	}
	return ajaxResponse;
    }
    
    // 이메일 중복 체크
    @RequestMapping(value = "/host/emailDupChk", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> emailDupChk(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String hostEmail = HttpUtil.get(request, "hostEmail");

	Host host = null;
	// guestEmail 값 체크
	if (!StringUtil.isEmpty(hostEmail)) {
	    // 해당 이메일과 일치하는 host 객체 선택
		host = hostService.hostSelect(hostEmail);

	    if (host == null) {
		ajaxResponse.setResponse(1, "일치하는 이메일 없음");
	    } else {
		if (StringUtil.equals(host.getStatus(), "Y")) {
		    ajaxResponse.setResponse(0, "이미 사용중인 이메일");
		} else if (StringUtil.equals(host.getStatus(), "W")) {
		    ajaxResponse.setResponse(0, "사용대기 회원");
		} else if (StringUtil.equals(host.getStatus(), "N")) {
		    ajaxResponse.setResponse(0, "탈퇴한 회원");
		} else if (StringUtil.equals(host.getStatus(), "S")) {
		    ajaxResponse.setResponse(0, "정지된 회원");
		}
	    }
	} else {
	    ajaxResponse.setResponse(400, "hostEmail 값이 비어있음");
	}
	return ajaxResponse;
    }

    // 인증코드 일치 여부 확인
    @RequestMapping(value = "/host/verifyAuthCode", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> verifyAuthCode(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String hostAuthCode = HttpUtil.get(request, "hostAuthCode");

	HttpSession session = request.getSession();
	boolean isVerified = hostService.checkAuthCode(hostAuthCode, session); // 입력된 코드와 세션 코드 비교
	request.getSession().setAttribute("pwdFound", false);

	if (isVerified) {
	    request.getSession().setAttribute("pwdFound", true);
	    ajaxResponse.setResponse(1, "일치");
	} else {
	    ajaxResponse.setResponse(0, "불일치");
	}
	return ajaxResponse;
    }

    // 닉네임 중복 체크
    @RequestMapping(value = "/host/nicknameDupChk", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> nicknameDupChk(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String hostNickname = HttpUtil.get(request, "hostNickname");

	// hostNickname 값 체크
	if (!StringUtil.isEmpty(hostNickname)) {
	    // 해당 닉네임 일치하는 host 객체 선택
	    if (hostService.hostNicknameDupChk(hostNickname) == 0) {
		ajaxResponse.setResponse(1, "사용 가능한 닉네임");
	    } else {
		ajaxResponse.setResponse(0, "이미 사용중인 닉네임");
	    }
	} else {
	    ajaxResponse.setResponse(400, "hostNickname 값이 비어있음");
	}
	return ajaxResponse;
    }
    
    // 연락처 중복 체크
    @RequestMapping(value = "/host/telDupChk", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> telDupChk(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String hostTel = HttpUtil.get(request, "hostTel");

	// hostTel 값 체크
	if (!StringUtil.isEmpty(hostTel)) {
	    // 해당 연락처와 일치하는 host 객체 선택
	    if (hostService.hostTelDupChk(hostTel) == 0) {
		ajaxResponse.setResponse(1, "사용 가능한 연락처");
	    } else {
		ajaxResponse.setResponse(0, "이미 사용중인 연락처");
	    }
	} else {
	    ajaxResponse.setResponse(400, "hostTel 값이 비어있음");
	}
	return ajaxResponse;
    }
    
    // 호스트 비밀번호 변경
    @RequestMapping(value = "/host/updatePwdProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> hostPwdUpdate(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String hostEmail = HttpUtil.get(request, "hostEmail");
	String hostPwd = HttpUtil.get(request, "hostPwd");

	// 전달 받은 값 체크
	if (!StringUtil.isEmpty(hostEmail) && !StringUtil.isEmpty(hostPwd)) {
	    Host host = new Host();
	    host.setHostEmail(hostEmail);
	    host.setHostPwd(hostPwd);

	    if (hostService.hostPwdUpdate(host) > 0) {
		ajaxResponse.setResponse(1, "비밀번호 업데이트 성공");
	    } else {
		ajaxResponse.setResponse(0, "비밀번호 업데이트 실패");
	    }
	} else {
	    ajaxResponse.setResponse(400, "전달받은 값이 비어있음");
	}

	return ajaxResponse;
    }
    
    // 회원 비밀번호 확인 화면
    @RequestMapping(value = "/host/pwdCheckForm", method = RequestMethod.GET)
    public String pwdCheckForm(HttpServletRequest request, HttpServletResponse response) {
	return "/host/pwdCheckForm";
    }
    
    // 회원정보 관리(비밀번호) aJax
    @RequestMapping(value = "/host/pwdCheckProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> pwdCheckProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	String hostPassword = HttpUtil.get(request, "hostPassword");

	request.getSession().setAttribute("checkedPwd", false);

	if (StringUtil.isEmpty(cookieUserId)) // 나중에 cookieUserId
	{ // 로그인 되어있지 않음
	    res.setResponse(410, "Not logged in");
	    return res;
	}

	if (StringUtil.isEmpty(hostPassword)) { // 비밀번호 값 없음
	    res.setResponse(400, "Bad request");
	    return res;
	}

	Host host = hostService.hostSelect(cookieUserId);

	if (host == null) // 나중에 guest
	{ // 게스트 정보가 DB에 없을 경우
	    res.setResponse(404, "Not found");
	    return res;
	}

	// 게스트 정보가 DB에 있을 경우
	if (!StringUtil.equals(host.getStatus(), "Y")) // 나중에 guest
	{ // 게스트 상태 Y 가 아닐 경우
	    res.setResponse(-99, "Status error");
	    return res;
	}

	// 비밀번호 조회
	String chkPassword = hostService.hostChkPwd(host.getHostEmail()); // 나중에 guest

	if (chkPassword == null || !StringUtil.equals(hostPassword, chkPassword)) { // 비밀번호 값이 없거나 일치하지 않을 경우
	    res.setResponse(-1, "Password mismatch");
	} else {
	    res.setResponse(0, "Host check password success");
	    request.getSession().setAttribute("checkedPwd", true);
	}

	if (logger.isDebugEnabled()) {
	    logger.debug("[HostController] /host/pwdCheckProc response \n" + JsonUtil.toJsonPretty(res));
	}

	return res;
    }
    
   
    // 회원정보수정 화면
    @RequestMapping(value = "/host/updateForm", method = RequestMethod.GET)
    public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
    
	Boolean checkedPwd = (Boolean) request.getSession().getAttribute("checkedPwd");

	// 만약 emailFound가 true일 때만 진행
	if (checkedPwd != null && checkedPwd) {
	    String cookieuserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	    String hexHostEmail = emailToHex(cookieuserEmail);

	    Host host = hostService.hostSelect(cookieuserEmail);

	    model.addAttribute("host", host);
	    model.addAttribute("hexHostEmail", hexHostEmail);

	    request.getSession().setAttribute("checkedPwd", false);

	    return "/host/updateForm";
	} else {
	    // 이메일이 없거나 이메일 찾기 과정을 밟지 않은 경우 리다이렉트
	    return "redirect:/host/pwdCheckForm"; // 예: 다시 아이디 찾기 페이지로 이동
	}
    	
    }
    
    // 회원정보수정 aJax
    @RequestMapping(value = "/host/updateProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	String cookieValue = CookieUtil.getValue(request, AUTH_COOKIE_NAME);

	String hostEmail = HttpUtil.get(request, "hostEmail");
	String hostPassword = HttpUtil.get(request, "hostPassword");
	String hostNickname = HttpUtil.get(request, "hostNickname");
	String hostTel = HttpUtil.get(request, "hostTel");

	// 프로필 사진 변경 저장
	FileData fileData = HttpUtil.getFile(request, "fileInput", UPLOAD_HOST_SAVE_DIR);

	if (!StringUtil.isEmpty(cookieUserId)) // 나중에 cookieUserId
	{ // 로그인 시

	    if (StringUtil.equals(hostEmail, cookieUserId)) // 나중에 cookieUserId
	    { // 쿠키 정보와 넘어온 hostEmail이 같을 경우

		Host host = hostService.hostSelect(cookieUserId); // 나중에 cookieUserId

		if (host != null) { // 사용자 정보가 DB에 있을 경우

		    if (!StringUtil.isEmpty(hostPassword) && !StringUtil.isEmpty(hostNickname)
			    && !StringUtil.isEmpty(hostTel)) { // 파라미터 값이 비어있지 않을 경우

		    	host.setHostEmail(hostEmail);
		    	host.setHostPwd(hostPassword);
		    	host.setHostNickname(hostNickname);
		    	host.setHostTel(hostTel);

			if (fileData != null && fileData.getFileSize() > 0) { // 프로필 첨부파일이 있고, 사이즈가 0 이상일 경우

			    String originalName = fileData.getFileName();
			    String newName = cookieValue + ".png";

			    logger.debug(originalName);
			    logger.debug(newName);
			    logger.debug(originalName);
			    logger.debug(newName);

			    // 파일 경로 설정
			    File originalFile = new File(UPLOAD_HOST_SAVE_DIR, originalName);
			    File renameFile = new File(UPLOAD_HOST_SAVE_DIR, newName);

			    // 이미 같은 이름의 파일이 존재하면 덮어쓰도록 삭제
			    if (renameFile.exists()) {
				renameFile.delete(); // 기존 파일 삭제
			    }

			    originalFile.renameTo(renameFile);
			}

			if (hostService.hostUpdate(host) > 0) { // 업데이트 건수 있을 경우
			    res.setResponse(0, "Host profile update success");
			} else { // 업데이트 건수 없을 경우
			    res.setResponse(500, "Internal server error");
			}
		    } else { // 파라미터 값이 올바르지 않을 경우
			res.setResponse(400, "Bad request");
		    }
		} else { // 사용자 정보가 DB에 없을 경우
		    CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		    res.setResponse(404, "Not found");
		}
	    } else { // 쿠키 정보와 넘어온 guestEmail이 다른 경우
		CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		res.setResponse(430, "Email information is different");
	    }
	} else { // 로그인 아닐 시
	    res.setResponse(410, "Not logged in");
	}

	if (logger.isDebugEnabled()) {
	    logger.debug("[GuestController] /host/updateProc response \n" + JsonUtil.toJsonPretty(res));
	}

	return res;
    }
    
    // 닉네임 중복체크 aJax
    @RequestMapping(value = "/host/nickCheck", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> nickCheck(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String hostNickname = HttpUtil.get(request, "hostNickname");

	if (!StringUtil.isEmpty(hostNickname)) { // 닉네임 값이 있을 경우
	    if (hostService.hostSelectNick(hostNickname) == null) { // 닉네임 없으면 정상
		res.setResponse(0, "Nickname check success");
	    } else { // 닉네임 있으면 중복
		res.setResponse(100, "Duplicate nickname");
	    }
	} else { // 닉네임 값이 없을 경우
	    res.setResponse(400, "Bad request");
	}

	if (logger.isDebugEnabled()) {
	    logger.debug("[HostController] /host/nickCheck response \n" + JsonUtil.toJsonPretty(res));
	}

	return res;
    }

    @RequestMapping(value = "/host/deleteForm", method = RequestMethod.GET)
    public String deleteForm(HttpServletRequest request, HttpServletResponse response) {
	return "/host/deleteForm";
    }
    
    // 회원 탈퇴 aJax
    @RequestMapping(value = "/host/deleteProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> deleteProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();
	
	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	Host host = null;

	// if(!StringUtil.isEmpty(guest2.getGuestEmail())) //나중에 cookieUserId
	// { //로그인 되어있음

	host = hostService.hostSelect(cookieUserId); // 나중에 cookieUserId

    if (host != null) { // 게스트 정보가 DB에 있을 경우
		if (StringUtil.equals(host.getStatus(), "Y")) { // 게스트 상태 Y 일 경우
			if (hostService.hostDelete(host) > 0) {
			    // if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
			    // {
			    res.setResponse(0, "Host delete success");
			    
			    if (CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null) {
				    CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
				}
			    // CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			    // }
			} else {
			    res.setResponse(500, "Internal server error");
			}
		} else { // 게스트 상태 Y 가 아닐 경우
		    res.setResponse(-99, "Status error");
		}
    } else { // 게스트 정보가 DB에 없을 경우
	res.setResponse(404, "Not found");
    }

//    	}
//    	else
//    	{	//로그인 되어있지 않음
//    		res.setResponse(410, "Not logged in");
//    	}

	if (logger.isDebugEnabled()) {
	    logger.debug("[HostController] /host/deleteProc response \n" + JsonUtil.toJsonPretty(res));
	}

	return res;
    }

    @RequestMapping(value = "/host/hostChangePwdForm", method = RequestMethod.GET)
    public String hostChangePwdForm(HttpServletRequest request, HttpServletResponse response) {
	return "/host/hostChangePwdForm";
    }
    
    
    


    // 이메일을 16진수로 변환하는 메서드
    public static String emailToHex(String email) {
	if (email == null || email.isEmpty()) {
	    throw new IllegalArgumentException("Email cannot be null or empty");
	}
	StringBuilder hexBuilder = new StringBuilder();
	for (char c : email.toCharArray()) {
	    hexBuilder.append(String.format("%02x", (int) c)); // 각 문자에 대해 16진수 변환
	}
	return hexBuilder.toString();
    }

   
}
