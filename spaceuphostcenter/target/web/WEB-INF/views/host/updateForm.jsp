<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/host/host.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<%
// "isPasswordVerified" 속성을 null로 초기화
session.setAttribute("isPasswordVerified", null);
%>

<script>
// 프로필 사진과 파일 입력 요소 선택
document.addEventListener('DOMContentLoaded', () => {
    const profileImg = document.getElementById('profileImg');
    const svgImg = document.getElementById('svgImg');
    const fileInput = document.getElementById('fileInput');

    // 프로필 사진 클릭 시 파일 선택 창 열기
    profileImg.addEventListener('click', () => {
        fileInput.click();
    });
    
    // svg 이미지 클릭 시 파일 선택 창 열기
    svgImg.addEventListener('click', () => {
        fileInput.click();
    });

    // 파일 선택 후 이미지 미리보기
    fileInput.addEventListener('change', (event) => {
        const file = event.target.files[0]; // 선택한 파일
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                profileImg.src = e.target.result; // 프로필 이미지를 변경
            };
            reader.readAsDataURL(file);
        }
    });
});

$(document).ready(function(){
	
	$("#guestPassword1").focus();
	
	// 닉네임 중복 확인에 대한 상태
	let initialNickname = $("#guestNickname").val(); // 초기 닉네임 저장
	let isNickChecked = false; // 닉네임 중복 확인 여부
	
	// 회원 탈퇴 버튼 눌렀을 경우
	$("#btnDel").on("click", function(){		
		location.href = "/guest/deleteForm";
	});
	
	// 중복 확인 버튼 눌렀을 경우
	$("#nickCheck").on("click", function(){
		// 공백 체크 정규식
		var emptCheck = /\s/g;
		
		// 닉네임 정규식: 2~16자, 영어 또는 숫자 또는 한글(한글 초성과 모음은 불가능)
		var nickCheck = /^(?=.*[a-zA-Z0-9가-힣])[a-zA-Z0-9가-힣]{2,16}$/;
		
		// 닉네임 입력 체크
		if($.trim($("#guestNickname").val()).length <= 0)
		{
			alert("닉네임을 입력하세요.");
			$("#guestNickname").val("");
			$("#guestNickname").focus();
			return;
		}
		
		// 닉네임 공백 체크
		if(emptCheck.test($("#guestNickname").val()))
		{
			alert("닉네임은 공백이 포함될 수 없습니다.");
			$("#guestNickname").val("");
			$("#guestNickname").focus();
			return;
		}
		
		// 닉네임 정규식 체크
		if(!nickCheck.test($("#guestNickname").val()))
		{
			alert("닉네임은 영어, 숫자, 한글 2~16자로만 입력 가능합니다.");
			$("#guestNickname").val("");
			$("#guestNickname").focus();
			return;
		}		
		
		// 닉네임 중복체크 aJax		
		const currentNickname = $("#guestNickname").val();	// 변경할 닉네임
		
	    if (currentNickname == initialNickname)
	    {
	        isNickChecked = true;	// 닉네임 변경 없으면 중복 확인 완료 상태로 간주
	        alert("기존 닉네임 입니다.")
	        return;
	    }
    
		$.ajax({
			type: "POST",
			url: "/guest/nickCheck",
			data:{
				guestNickname: $("#guestNickname").val()
			},
			datatype: "JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{	// 닉네임 중복 없음
					alert("사용가능한 닉네임 입니다.");
					isNickChecked = true;
				}
				else if(response.code == 100)
				{	// 닉네임 중복
					alert("중복된 닉네임 입니다.");
					$("#guestNickname").focus();
					isNickChecked = false;
				}
				else if(response.code == 400)
				{	// 파라미터 값 없음
					alert("닉네임 값을 확인하세요.");
					$("#guestNickname").focus();
					isNickChecked = false;
				}
				else if(response.code == 500)
				{	// 업데이트 건수 없음
					alret("닉네임 중복 체크 중 오류가 발생하였습니다.(1)")
					$("#guestNickname").focus();
					isNickChecked = false;
				}
				else
				{	// 나머지 오류
					alret("닉네임 중복 체크 중 오류가 발생하였습니다.(2)")
					$("#guestNickname").focus();
					isNickChecked = false;
				}
			},
			error:function(error){
				icia.common.error(error);
				isNickChecked = false;
			}
		});
	});
	
	// 수정 완료 버튼 눌렀을 경우
	$("#btnModi").on("click", function(){
		// 공백 정규표현식
		var emptCheck = /\s/g;
		
		// 전화번호 정규표현식
		var telCheck = /^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/;
		
		// 비밀번호 정규식: 8~20자, 1개이상의 특수기호 포함
		var PwdCheck = /^(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,20}$/;
		
		// 닉네임 정규식: 2~16자, 영어 또는 숫자 또는 한글(한글 초성과 모음은 불가능)
		var nickCheck = /^(?=.*[a-zA-Z0-9가-힣])[a-zA-Z0-9가-힣]{2,16}$/;
		
		// 비밀번호 입력 체크
		if($.trim($("#guestPassword1").val()).length <= 0)
		{
			alert("비밀번호를 입력하세요.");
			$("#guestPassword1").val("");
			$("#guestPassword1").focus();
			return;
		}
		
		// 비밀번호 정규식표현 체크
		if(!PwdCheck.test($("#guestPassword1").val()))
		{
			alert("비밀번호는 1개 이상의 특수기호 포함한 8~20자로만 입력 가능합니다.");
			$("#guestPassword1").focus();
			return;
		}
		
		// 비밀번호 확인 입력 체크
		if($.trim($("#guestPassword2").val()).length <= 0)
		{
			alert("비밀번호 확인을 입력하세요.");
			$("#guestPassword2").val("");
			$("#guestPassword2").focus();
			return;
		}
		
		// 비밀번호 일치 체크
		if($("#guestPassword1").val() != $("#guestPassword2").val())
		{
			alert("비밀번호가 일치하지 않습니다.");
			$("#guestPassword2").focus();
			return;
		}
		
		// 비밀번호 hidden값에 넣기
		$("#guestPassword").val($("#guestPassword1").val());
		
		// 닉네임 입력 체크
		if($.trim($("#guestNickname").val()).length <= 0)
		{
			alert("닉네임을 입력하세요.");
			$("#guestNickname").val("");
			$("#guestNickname").focus();
			return;
		}
		
		// 전화번호 입력 체크
		if($.trim($("#guestTel").val()).length <= 0)
		{
			alert("전화번호를 입력하세요.");
			$("#guestTel").val("");
			$("#guestTel").focus();
			return;
		}
		
		// 전화번호 정규표현식 확인
		if(!telCheck.test($("#guestTel").val()))
		{
			alert("전화번호 형식이 올바르지 않습니다.");
			$("#guestTel").focus();
			return;
		}
		
		// 닉네임이 변경되었고, 중복확인을 하지 않았다면 요청 중단
	    const currentNickname = $("#guestNickname").val();	// 변경할 닉네임
		    
	    if (currentNickname != initialNickname && !isNickChecked)
	    {
	        alert("닉네임 중복확인을 해주세요.");
	        return false;
	    }	
	   
		
		// 회원 정보 수정 aJax multipart
		let form = $("#updateForm")[0];
		let formData = new FormData(form);
		
		$.ajax({
			type:"POST",
			enctype:"multipart/form-data",
			url:"/guest/updateProc",
			data: formData,
			processData:false,
			contentType:false,
			cache:false,
			timeout:600000,
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("회원 정보 수정 완료");
					location.href = "/guest/updateForm";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#guestPassword1").focus();
				}
				else if(response.code == 404)
				{
					alert("회원정보가 존재하지 않습니다.");
					location.href = "/guest/updateForm";
				}
				else if(response.code == 410)
				{
					alert("로그인이 되어있지 않습니다.");
					location.href = "/guest/updateForm";
				}
				else if(response.code == 430)
				{
					alert("이메일 정보가 다릅니다.");
					location.href = "/guest/updateForm";
				}
				else if(response.code == 500)
				{
					alert("회원정보수정 중 오류가 발생하였습니다.(1)");
					$("#guestPassword1").focus();
				}
				else
				{
					alert("회원정보수정 중 오류가 발생하였습니다.(2)");
					$("#guestPassword1").focus();
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
				alert("서버 통신 중 오류가 발생하였습니다.");
			}
		});		
	});
	
	$("#guestNickname").on("input", function() {
		const currentNickname = $("#guestNickname").val();	// 변경할 닉네임
		if (currentNickname != initialNickname)
		{
		    isNickChecked = false; // 닉네임 변경 시 중복 확인 상태 초기화
		}
	});
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
			<h1>회원정보수정</h1>
			<form method="post" name="updateForm" id="updateForm" enctype="multipart/form-data">

				<div class="container">
					<div class="profile-group">
						<div class="profile-picture">
							<!-- 기본 프로필 사진 -->
							<img id="profileImg" name="profileImg" src="/resources/images/guest/upload/${hexGuestEmail}.png" alt="Profile Picture" onerror="this.src='https://via.placeholder.com/120';" title="프로필 사진은 .png 파일만 가능합니다.">
							<!-- 아이콘 -->
							<div class="icon" id="icon-upload">
								<!-- 아이콘 SVG 삽입 -->
								<img id="svgImg" src="/resources/images/host/my_profile_edit.svg" alt="Upload Icon">
							</div>
							<!-- 파일 선택 입력 -->
							<input type="file" id="fileInput" name="fileInput" accept="image/png">

						</div>
					</div>

					<div class="update-container">
						<div class="updateForm-group">
							<label for="email">이메일</label> <input type="text" id="guestEmail" name="guestEmail" value="${guest.guestEmail}" readonly>
						</div>
						<div class="updateForm-group">
							<label for="password">새 비밀번호</label> <input type="password" id="guestPassword1" name="guestPassword1" value="${guest.guestPwd}" autoComplete="off">
						</div>
						<div class="updateForm-group">
							<label for="password">새 비밀번호 확인</label> <input type="password" id="guestPassword2" name="guestPassword2" value="${guest.guestPwd}" autoComplete="off">
						</div>
						<div class="updateForm-group2">
							<label for="nickname">닉네임</label><br /> <input type="text" id="guestNickname" name="guestNickname" value="${guest.guestNickname}">
							<button type="button" id="nickCheck">중복확인</button>
						</div>
						<div class="updateForm-group">
							<label for="tel">전화번호</label> <input type="text" id="guestTel" name="guestTel" value="${guest.guestTel}">
						</div>
						<div class="updateForm-group">
							<label for="birth">생년월일</label> <input type="text" id="guestBirth" name="guestBirth" value="${guest.guestBirth}" disabled>
						</div>
					</div>

					<!-- 원래 탈퇴, 수정 버튼 자리 -->
				</div>

				<div class="btndel">
					<button type="button" id="btnDel" class="btnDel">회원 탈퇴</button>
				</div>

				<div class="buttons">
					<button type="button" id="btnModi" class="btnModi">수정 완료</button>
				</div>

				<input type="hidden" id="guestPassword" name="guestPassword" value="${guest.guestPwd}" />
			</form>

		</div>
	</div>


	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
