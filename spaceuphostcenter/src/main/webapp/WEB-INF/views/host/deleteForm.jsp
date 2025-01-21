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
		$("#hostPassword").focus();

		$("#btnDelete").on("click", function() {
			//비밀번호 입력체크
			if ($.trim($("#hostPassword").val()).length <= 0) {
				alert("비밀번호를 입력하세요.");
				$("#hostPassword").val("");
				$("#hostPassword").focus();
				return;
			}

			if (confirm("회원 탈퇴 시 같은 이메일로는 재가입 할 수 없습니다.") == true) {
				fn_hostDelete();
			}
		});

		function fn_hostDelete() {
			// 회원탈퇴 aJax
			$.ajax({
				type : "POST",
				url : "/host/deleteProc",
				data : {
					hostPassword : $("#hostPassword").val()
				},
				datatype : "JSON",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success : function(response) {
					if (response.code == 0) {
						alert("회원탈퇴가 완료되었습니다.");
						location.href = "/host/logout";
					} else if (response.code == -1) {
						alert("비밀번호가 일치하지 않습니다.");
						$("#hostPassword").focus();
					} else if (response.code == -99) {
						alert("이미 정지된 회원입니다.");
						location.href = "/host/logout";
					} else if (response.code == 400) {
						alert("파라미터 값이 올바르지 않습니다.");
						$("#hostPassword").focus();
					} else if (response.code == 404) {
						alert("회원정보가 존재하지 않습니다.");
						location.href = "/host/logout";
					} else if (response.code == 410) {
						alert("로그인이 되어있지 않습니다.");
						location.href = "/host/logout";
					} else if (response.code == 500) {
						alert("회원탈퇴 중 오류가 발생하였습니다.(1)");
						location.href = "/host/updateForm";
					} else {
						alert("회원탈퇴 중 오류가 발생하였습니다.(2)");
						location.href = "/host/updateForm";
					}
				},
				error : function(error) {
					icia.common.error(error);
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
				<h1>회원 탈퇴</h1>

				<div class="container">

					<div class="divider"></div>

					<div class="confirm-container2">
						<div class="form-group">
							<label for="current-password">현재 비밀번호</label>
							<div class="password-input">
								<input type="password" id="hostPassword" name="hostPassword" placeholder="비밀번호를 입력하세요">
								<button class="confirm-button" id="btnDelete">탈퇴</button>
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
