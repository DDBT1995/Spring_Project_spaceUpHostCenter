<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/css/host/hostShowEmailForm.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    
<script>
	$(document).ready(function(){
		$("#btnFindPwd").on("click", function() {    	    	    
	    	location.href = "/host/hostFindPwdForm";
	    });
		
		$("#btnLogin").on("click", function() {    	    	    
	    	location.href = "/host/hostLoginForm";
	    });
	});

</script>
</head>

<body>
    <div class="titles">
        <h3><span class="highlight">호스트</span> 이메일 찾기</h3>
    </div>

    <div class="find-container">
        <h5>1개의 이메일을 찾았습니다.</h5>

        <form>
            <div class="form-group">
                <p class="emailFind" id="hostEmail" name="hostEmail">email@naver.com</p>
                <p class="regDateFind" id="regDate" name="regDate">가입일 : 2024.11.26</p>
            </div>
        </form>

        <button type="button" id="btnFindPwd" class="btnFindPwd">비밀번호 찾기</button>&ensp;
        <button type="button" id="btnLogin" class="btnLogin">로그인</button>
    </div>
    
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>