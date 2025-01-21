<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/host/hostMyPage.css">
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<div class="profile-page">
		<!-- Info Section -->
		<div class="info-section">
			<div class="tabs">
				<div class="tab active">
					<h2 class="space_management_title" onclick="manegement_To">공간 관리</h2>
				</div>
			</div>
			<!-- 공간등록 버튼-->
			<div class="btn_space_insert">
				<a class="btn btn_full btn_secondary" href="/host/hostSpaceRegForm">공간 등록 +</a>
			</div>
			<!-- 공간 이미지와 설명-->
			<div class="image-gallery">

				<c:choose>
					<c:when test="${empty spaceList}">
						<div class="gallery-item" style="display: grid; width: 200px; height: 300px; align-items: center;">
							<div style="display: grid; justify-items: center;">
								<img src="/resources/images/host/plus.svg" style="width: 150px; box-shadow: none; filter: invert(55%) sepia(53%) saturate(3250%) hue-rotate(183deg) brightness(95%) contrast(88%);"> <span style="width: 160px; margin-top: 15px; font-size: 14px; text-align: center;">등록된 공간이 없습니다. 공간을 등록해주세요.</span>
							</div>
						</div>
					</c:when>

					<c:otherwise>
						<c:forEach var="space" items="${spaceList}" varStatus="stautus">
							<div class="gallery-item-${space.spaceId}">
								<img style="width: 386.66px; height: 200px;" src="/resources/images/space/upload/${space.spaceType}/${space.spaceId}/${space.spaceId}_1.jpg" alt="공간 이미지 1">
								<p>${space.spaceName}</p>
								<div class="separator_medium"></div>
								<div style="display: flex; align-items: center; justify-content: space-between;">
									<p class="space_number">
										공간번호 ${space.spaceId} </br> ${space.regDate}
									</p>
									<div class="toggle-wrapper">
										<input type="checkbox" id="toggle_${space.spaceId}" class="toggle-input" data-space-id="${space.spaceId}" ${space.status == 'Y' ? 'checked' : ''} /> <label for="toggle_${space.spaceId}" class="toggle-label"></label>
									</div>
								</div>
								<div class="btn_space_edit">
									<a class="space_modify" href="http://spaceup.sist.co.kr:8088/space/spaceView?spaceId=${space.spaceId}" target="_blank">공간 상세 보기</a>
									<a class="product_modify" id="spaceUpdate" href="#" onclick="spaceUdpate(${space.spaceId})">공간 상세 수정</a>
									<a href="#" id="spaceDelete" class="space_delete" data-space-id="${space.spaceId}">공간 삭제</a>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>

			<script type="text/javascript">
				function spaceUdpate(spaceId){
					document.myForm.spaceId.value = spaceId;
					document.myForm.method = "POST"
				    document.myForm.action = "/host/hostSpaceUpdateForm"
				    document.myForm.submit();
				}
				$(document).ready(function(){
					$(".toggle-input").on("change",function(){
						var spaceId = $(this).data("space-id"); // data-space-id로 해당 공간의 ID를 가져옴
						var status = $(this).prop("checked") ? "Y" : "D"; // 토글 체크 여부에 따라 상태값 설정
						
						spaceStatusUpdate(spaceId, status);
					});
					$("#spaceDelete").on("click", function(){
						var spaceId = $(this).data("space-id"); // data-space-id로 해당 공간의 ID를 가져옴
						var status = "N";
						spaceStatusUpdate(spaceId, status);
					})
				});
				
				function spaceStatusUpdate(spaceId, status){
					$.ajax({
						url: "/space/statusUpdate",
						method: "GET",
						data:{
							spaceId: spaceId,
							status: status
						},
						datatype: "JSON",
						beforeSend:function(xhr){
		    				xhr.setRequestHeader("AJAX", "true");
		    			},
		    			success: function(res){
		    				if(res.code == 1){
		    					alert("공간 상태 변경 성공");
		    				}
		    				else{
		    					alert("공간 상태 변경 실패");
		    					window.location.reload();
		    				}
		    			},
		    			error: function(err){
		    	    		icia.common.error(error);
		    			}
					});
				}
			</script>

			<!-- 리뷰 페이징 -->
			<div class="paging">
				<c:if test="${!empty paging}">
					<!-- 이전 버튼 -->
					<c:if test="${paging.prevBlockPage gt 0}">
						<a class="bestSlidePrevBtn" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})"></a>
					</c:if>

					<!-- 숫자 버튼 -->
					<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
						<c:choose>
							<c:when test="${i ne curPage}">
								<a class="btnPage" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a>
							</c:when>
							<c:otherwise>
								<a class="btnPage active" href="javascript:void(0)" onclick="fn_list(${i})" style="cursor: default;">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음 버튼 -->
					<c:if test="${paging.nextBlockPage gt 0}">
						<a class="bestSlideNextBtn" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})"></a>
					</c:if>
				</c:if>
			</div>
			<script type="text/javascript">
				function fn_list(curPage){
			      document.myForm.curPage.value = curPage;
			      document.myForm.action = "/host/hostMyPage"
			      document.myForm.submit();
			   }
			</script>
		</div>
	</div>
	<form id="myForm" name="myForm" method="GET">
		<input id="curPage" name="curPage" type="hidden" value="${curPage}"> <input id="spaceId" name="spaceId" type="hidden" value="">
	</form>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>