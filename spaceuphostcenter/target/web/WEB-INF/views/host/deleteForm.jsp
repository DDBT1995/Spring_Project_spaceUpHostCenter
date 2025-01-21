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
		$("#guestPassword").focus();

		$("#btnDelete").on("click", function() {
			//비밀번호 입력체크
			if ($.trim($("#guestPassword").val()).length <= 0) {
				alert("비밀번호를 입력하세요.");
				$("#guestPassword").val("");
				$("#guestPassword").focus();
				return;
			}

			if (confirm("회원 탈퇴 시 같은 이메일로는 재가입 할 수 없습니다.") == true) {
				fn_guestDelete();
			}
		});

		function fn_guestDelete() {
			// 회원탈퇴 aJax
			$.ajax({
				type : "POST",
				url : "/guest/deleteProc",
				data : {
					guestPassword : $("#guestPassword").val()
				},
				datatype : "JSON",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success : function(response) {
					if (response.code == 0) {
						alert("회원탈퇴가 완료되었습니다.");
						location.href = "/guest/logout";
					} else if (response.code == -1) {
						alert("비밀번호가 일치하지 않습니다.");
						$("#guestPassword").focus();
					} else if (response.code == -99) {
						alert("이미 정지된 회원입니다.");
						location.href = "/guest/logout";
					} else if (response.code == 400) {
						alert("파라미터 값이 올바르지 않습니다.");
						$("#guestPassword").focus();
					} else if (response.code == 404) {
						alert("회원정보가 존재하지 않습니다.");
						location.href = "/guest/logout";
					} else if (response.code == 410) {
						alert("로그인이 되어있지 않습니다.");
						location.href = "/guest/logout";
					} else if (response.code == 500) {
						alert("회원탈퇴 중 오류가 발생하였습니다.(1)");
						location.href = "/guest/updateForm";
					} else {
						alert("회원탈퇴 중 오류가 발생하였습니다.(2)");
						location.href = "/guest/updateForm";
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
		<div class="profile-card">
			<div class="avatar">
				<img src="/resources/images/guest/upload/${hexGuestEmail}.png" onerror="this.src='https://via.placeholder.com/120';" alt="User Avatar">
			</div>
			<h2>${guest.guestNickname}</h2>
			<div class="email">
				<p>${guest.guestEmail}</p>
			</div>
			<button class="edit-profile" onclick="location.href='/guest/pwdCheckForm'">회원정보 관리</button>
			<div class="points-coupons"></div>

			<div class="menu">
				<div class="sideMenu">
					<h3>예약정보</h3>
					<ul>
						<li><a href="/guest/myPage" class="active">공간예약 내역</a></li>
					</ul>
				</div>

				<hr>

				<div class="sideMenu">
					<h3>활동정보</h3>
					<ul>
						<li><a href="/guest/reviewList">리뷰 관리</a></li>
						<li><a href="/guest/QnAList">공간Q&A</a></li>
						<li><a href="/guest/likeyList">좋아요</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="reserv-container">
			<div class="pwdConfirm-container">
				<h1>회원 탈퇴</h1>

				<div class="container">

					<div class="divider"></div>

					<div class="confirm-container2">
						<div class="form-group">
							<label for="current-password">현재 비밀번호</label>
							<div class="password-input">
								<input type="password" id="guestPassword" name="guestPassword" placeholder="비밀번호를 입력하세요">
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
