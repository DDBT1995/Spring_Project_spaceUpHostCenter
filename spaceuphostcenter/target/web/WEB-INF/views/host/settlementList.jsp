<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/resources/css/host/settlementList.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	// ajax 미구현
	// 답글 추가 버튼 클릭 시 답글 작성 폼 토글
	$(document).on(
			'click',
			'#add-comment-btn',
			function() {
				var commentForm = $(this).closest('.review_start').find(
						'.comment-section__comment-form');
				commentForm.toggle(); // 해당 답글의 폼만 보이거나 숨겨짐
			});

	// 답글 작성 버튼 클릭 시 답글을 추가
	$(document).on('click', '#btnTwoComm', function() {
		var commentText = $(this).siblings('#twoCommContent').val().trim(); // 답글 텍스트
		// var commentText = $(this).closest('.review_start').find('#twoCommContent').val().trim(); // 위에꺼 안되면 사용해보기
		if (commentText !== '') {
			alert('답글이 작성되었습니다: ' + commentText);

			// 답글 입력 폼 초기화
			$(this).siblings('#twoCommContent').val(''); // 텍스트박스 비우기
			$(this).closest('.comment-section__comment-form').hide(); // 폼 숨기기
		} else {
			alert('답글을 입력해주세요.');
		}
	});

	// 수정 버튼 클릭 시 수정 폼 토글
	$(document).on(
			'click',
			'#viewCommentBtn',
			function() {
				var commentForm = $(this).closest('.review_start').find(
						'.viewCommentForm');
				commentForm.toggle(); // 해당 답글의 폼만 보이거나 숨겨짐
			});

	// 수정 버튼 클릭 시 수정
	$(document).on('click', '#btnViewTwoCommEmpty', function() {
		var commentText = $(this).siblings('#viewTwoCommContent').val().trim(); // 답글 텍스트
		// var commentText = $(this).closest('.review_start').find('#viewTwoCommContent').val().trim(); // 위에꺼 안되면 사용해보기
		if (commentText !== '') {
			// 수정 입력 폼 초기화
			$(this).siblings('#viewTwoCommContent').val(''); // 텍스트박스 비우기
			$(this).closest('.view-comment-section__comment-form').hide(); // 폼 숨기기
		} else {
			alert('답글을 입력해주세요.');
		}
	});
</script>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<div class="profile-page">
		<!-- Info Section -->
		<div class="info-section">
			<div class="tabs">
				<div class="tab active">
					<h2 class="space_management_title" onclick="manegement_To">정산 관리</h2>
				</div>
			</div>

			<!-- 정산번호 검색-->
			<div class="box_search">
				<div class="box_inner">
					<div class="one_search">
						<div class="flex_wrap">
							<div class="flex_box">
								<div>
									<h3>정산 번호 검색</h3>
								</div>
								<div class="flex">
									<div class="input">
										<input type="text" placeholder="정산번호를 입력하세요." value="">
									</div>
								</div>
								<div class="flex">
									<a class="btn btn_default"> <i class="fa-solid fa-magnifying-glass"></i> <i class="sp_icon ico_btn_search"></i>검색
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!--셀렉박스-->
			<select class="review_sorting" id="review_sorting">
				<option value="0">전체</option>
				<option value="1">답글 작성완료</option>
				<option value="2">답글 미작성</option>
			</select>

			<div class="box_review">
				<div class="box_inner_se">
					<div id="commentList" class="comment-list">

						<div class="review_start">
							<div class="review_space_number">정산번호 207</div>
							<div class="manegementComment">
								<img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="manegementComment-image" />
								<div class="manegementComment-details">
									<div class="manegementComment-header">
										<div class="manegementCommnet-header-sorting1">
											<span class="manegementNickname">관리자 김기현</span>
											<div class="dropdown">
												<button class="dropbtn">
													<img src="/resources/images/host/more_gray.svg" style="width: 16px; height: 16px; object-fit: contain;">
												</button>
												<div class="dropdown-content">
													<button id="viewCommentBtn" class="viewCommentBtn">수정</button>
													<a href="#">삭제</a> <a href="#">메뉴3</a>
												</div>
											</div>
										</div>
										<span class="manegementComment-date">2024.12.12</span>
										<div></div>
									</div>
									<div class="manegementComment-content">
										<table border="1">
											<thead>
												<tr>
													<th>정산번호</th>
													<th>정산여부</th>
													<th>정산공간수량</th>
													<th>정산비용</th>
													<th>정산처리날짜</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>001</td>
													<td>완료</td>
													<td>10</td>
													<td>500,000</td>
													<td>2024-12-03</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<div class="review_start">
							<div class="review_space_number">정산번호 207</div>
							<div class="manegementComment">
								<img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="manegementComment-image" />
								<div class="manegementComment-details">
									<div class="manegementComment-header">
										<div class="manegementCommnet-header-sorting1">
											<span class="manegementNickname">관리자 김기현</span>
											<div class="dropdown">
												<button class="dropbtn">
													<img src="file:///C:/project/HTML/.vscode/more_grey.svg" style="width: 16px; height: 16px; object-fit: contain;">
												</button>
												<div class="dropdown-content">
													<button id="viewCommentBtn" class="viewCommentBtn">수정</button>
													<a href="#">삭제</a> <a href="#">메뉴3</a>
												</div>
											</div>
										</div>
										<span class="manegementComment-date">2024.12.12</span>
										<div></div>
									</div>
									<div class="manegementComment-content">
										<table border="1">
											<thead>
												<tr>
													<th>정산번호</th>
													<th>정산여부</th>
													<th>정산공간수량</th>
													<th>정산비용</th>
													<th>정산처리날짜</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>001</td>
													<td>완료</td>
													<td>10</td>
													<td>500,000</td>
													<td>2024-12-03</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<div class="review_start">
							<div class="review_space_number">정산번호 207</div>
							<div class="manegementComment">
								<img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="manegementComment-image" />
								<div class="manegementComment-details">
									<div class="manegementComment-header">
										<div class="manegementCommnet-header-sorting1">
											<span class="manegementNickname">관리자 김기현</span>
											<div class="dropdown">
												<button class="dropbtn">
													<img src="file:///C:/project/HTML/.vscode/more_grey.svg" style="width: 16px; height: 16px; object-fit: contain;">
												</button>
												<div class="dropdown-content">
													<button id="viewCommentBtn" class="viewCommentBtn">수정</button>
													<a href="#">삭제</a> <a href="#">메뉴3</a>
												</div>
											</div>
										</div>
										<span class="manegementComment-date">2024.12.12</span>
										<div></div>
									</div>
									<div class="manegementComment-content">
										<table border="1">
											<thead>
												<tr>
													<th>정산번호</th>
													<th>정산여부</th>
													<th>정산공간수량</th>
													<th>정산비용</th>
													<th>정산처리날짜</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>001</td>
													<td>완료</td>
													<td>10</td>
													<td>500,000</td>
													<td>2024-12-03</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<div class="review_start">
							<div class="review_space_number">정산번호 207</div>
							<div class="manegementComment">
								<img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="manegementComment-image" />
								<div class="manegementComment-details">
									<div class="manegementComment-header">
										<div class="manegementCommnet-header-sorting1">
											<span class="manegementNickname">관리자 김기현</span>
											<div class="dropdown">
												<button class="dropbtn">
													<img src="file:///C:/project/HTML/.vscode/more_grey.svg" style="width: 16px; height: 16px; object-fit: contain;">
												</button>
												<div class="dropdown-content">
													<button id="viewCommentBtn" class="viewCommentBtn">수정</button>
													<a href="#">삭제</a> <a href="#">메뉴3</a>
												</div>
											</div>
										</div>
										<span class="manegementComment-date">2024.12.12</span>
										<div></div>
									</div>
									<div class="manegementComment-content">
										<table border="1">
											<thead>
												<tr>
													<th>정산번호</th>
													<th>정산여부</th>
													<th>정산공간수량</th>
													<th>정산비용</th>
													<th>정산처리날짜</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>001</td>
													<td>완료</td>
													<td>10</td>
													<td>500,000</td>
													<td>2024-12-03</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

					</div>
					<!--commentList 끝-->

				</div>

			</div>
			<div class="paging">
				<div class="bestSlidePrevBtn"></div>
				<a class="btnPage" href="javascript:void(0)" onclick="fn_list()">1</a>
				<div class="bestSlideNextBtn"></div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>