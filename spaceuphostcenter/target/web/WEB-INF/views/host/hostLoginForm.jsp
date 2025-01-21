<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/css/host/hostLoginForm.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>
<body>
    <div class="login-container">
        <h5><span class="highlight">호스트</span> 로그인</h5>
        <a href="/index">
    		<img src="/resources/images/host/host_logo_trans_crop.png" alt="spaceUp 로고">
		</a>
        <form>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="text" id="hostEmail" name="hostEmail" value="" placeholder="이메일" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="hostPassword" name="hostPassword" value="" placeholder="비밀번호" required>
            </div>

            <button type="button" id="btnLogin" class="btnLogin">로그인</button>
        </form>
        <div class="links">
            <a href="/host/hostFindEmailForm">아이디 찾기</a> |
            <a href="/host/hostFindPwdForm">비밀번호 찾기</a> |
            <a href="/host/hostRegForm"><b>회원가입</b></a>
        </div>
        <div class="footer2">host HERE</div>
    </div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
