<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/resources/css/host/hostSpaceRegFormComplete.css">

<script>
	$(document).ready(function() {
		$("#btnHostList").on("click", function() {
			location.href = "/host/hostMyPage";
		});

	});
</script>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<div class="container">
		<div class="titles">
			<h3>등록 완료</h3>
		</div>

		<form>
			<div class="form-group">
				<img src="/resources/images/host/check_hostReg.png" />
				<p id="rev">이제부터 예약을 받을 수 있어요</p>
				<p id="rev2">호스트님, 만나서 반가워요!</p>
			</div>
		</form>

		<!-- 버튼 누르면 호스트 마이페이지로 이동-->
		<button type="button" id="btnHostList" class="btnHostList">장소 목록 보기</button>
	</div>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>