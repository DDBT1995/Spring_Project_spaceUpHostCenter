<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/css/host/hostFindPwdForm.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>

<body>
    <div class="titles">
        <h3><span class="highlight">호스트</span> 비밀번호 찾기</h3>
    </div>

    <div class="find-container">
        <form>            
            <div class="alret">가입하신 이메일 주소로 온 인증번호를 입력하시면,
                               비밀번호 재설정 화면으로 전환됩니다.
            </div>
                 
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="text" id="hostEmail" name="hostEmail" value="" placeholder="이메일을 입력해 주세요." />&nbsp;
                <button type="button" id="btnCertify" class="btnCertify">인증하기</button>
            </div>
            <div class="form-group">
                <input type="text" id="hostCertify" name="hostCertify" value="" placeholder="인증번호를 입력해 주세요." />&nbsp;
                <button type="button" id="btnOk" class="btnOk">확인</button>
            </div>
        </form>
    </div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>