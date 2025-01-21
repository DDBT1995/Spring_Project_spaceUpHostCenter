<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/host/host.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script>
	$(document).ready(function() {

		$("#btnChkPwd").on("click", function() {

			// 비밀번호 입력 체크
			if ($.trim($("#hostPassword").val()).length <= 0) {
				alert("비밀번호를 입력하세요.");
				$("#hostPassword").val("");
				$("#hostPassword").focus();
				return;
			}

			fn_pwdCheck();
		});

		function fn_pwdCheck() {
			// 비밀번호 일치 확인 aJax
			$.ajax({
				type : "POST",
				url : "/host/pwdCheckProc",
				data : {
					hostPassword : $("#hostPassword").val()
				},
				datatype : "JSON",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success : function(response) {
					if (response.code == 0) { // 비밀번호 일치
						alert("비밀번호 일치");
						location.href = "/host/updateForm";
					} else if (response.code == -1) { // 비밀번호 불일치
						alert("비밀번호가 일치하지 않습니다.");
						location.href = "/host/pwdCheckForm";
					} else if (response.code == -99) { // 정지된 회원
						alert("정지된 회원입니다.");
						location.href = "/host/pwdCheckForm";
					} else if (response.code == 400) { // 잘못된 요청
						alert("파라미터 값이 올바르지 않습니다.");
						location.href = "/host/pwdCheckForm";
					} else if (response.code == 404) { // 게스트 정보 DB에 없음
						alert("게스트 정보가 올바르지 않습니다.");
						location.href = "/host/pwdCheckForm";
					} else if (response.code == 410) { // 로그인되지 않음
						alert("로그인 되어있지 않습니다.");
						location.href = "/host/pwdCheckForm";
					} else { // 기타 오류
						alert("비밀번호가 확인 중 오류가 발생하였습니다.");
						location.href = "/";
					}
				},
				error : function(error) {
					icia.common.error(error);
					alert("서버 통신 중 오류가 발생하였습니다.");
				}
			});
		}
	});
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<div class="profile-container">
		
		<div class="reserv-container">
			<div class="pwdConfirm-container">
				<h1>회원정보 변경</h1>

				<div class="container">
					<div class="info-section">
						회원님의 개인 정보를 소중하게 보호하고 있습니다.<br> 회원님의 동의 없이 회원정보를 제3자에게 제공하지 않습니다.
					</div>
					<div class="divider"></div>
					<div class="notice2">고객님의 개인 정보 보호를 위해 비밀번호를 입력 후, 이용이 가능합니다.</div>

					<div class="confirm-container">
						<div class="form-group">
							<label for="current-password">현재 비밀번호</label>
							<div class="password-input">
								<input type="password" id="hostPassword" name="hostPassword" placeholder="비밀번호를 입력하세요">
								<button class="confirm-button" id="btnChkPwd">회원 확인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
