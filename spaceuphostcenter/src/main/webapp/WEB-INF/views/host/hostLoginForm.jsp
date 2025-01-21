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
    
    <script>
		$(document).ready(function(){
			$("#hostEmail").focus();
			
			$("#hostEmail").on("keypress", function(e){
				if(e.which == 13){
					login();
				}
			});
			
			$("#hostPwd").on("keypress", function(e){
				if(e.which == 13){
					login();
				}
			});
		});
		
		function login(){
			if($.trim($("#hostEmail").val()).length <= 0){
				alert("아이디를 입력하세요.");
				$("#hostEmail").val("");
				$("#hostEmail").focus();
				return;
			}
			
			if($.trim($("#hostPwd").val()).length <= 0){
				alert("비밀번호를 입력하세요.");
				$("#hostPwd").val("");
				$("#hostPwd").focus();
				return;
			}
			
			$.ajax({
				type:"POST",
				url:"/host/loginProc",
				data:{
					hostEmail: $("#hostEmail").val(),
					hostPwd: $("#hostPwd").val()
				},
				datatype:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX","true");
				},
				success:function(response){
					icia.common.log(response);
					
					if(response.code == 1){
						location.href = "/host/hostMyPage";
					}
					else if(response.code == 0){
						alert("탈퇴한 회원입니다.")	
					}
					else if(response.code == -1){
						alert("정지된 회원입니다.")						
					}
					else if(response.code == -2){
						alert("승인되지 않은 회원입니다.")						
					}
					else{
						alert("아이디 또는 비밀번호를 확인하세요.")
					}
				},
				complete:function(data){
					icia.common.log(data);
				},
				error:function(xhr, status, error){
					icia.common.error(error);
				}
			});
		}
	</script>
    
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
                <input type="password" id="hostPwd" name="hostPwd" value="" placeholder="비밀번호" required>
            </div>

            <button type="button" id="btnLogin" class="btnLogin" onclick="login()">로그인</button>
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
