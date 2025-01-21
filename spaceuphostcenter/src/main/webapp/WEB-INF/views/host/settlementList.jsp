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
$(document).ready(function(){
	$("#btnSearch").on("click", function(){
		document.settlementForm.searchValue.value = $("#searchValue").val();
		document.settlementForm.curPage.value = "1";
		document.settlementForm.action = "/host/settlementList";
		document.settlementForm.submit();
	});
});


function fn_list(curPage)
{
   document.settlementForm.curPage.value = curPage;
   document.settlementForm.action = "/host/settlementList"
   document.settlementForm.submit();
}
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
										<input type="text" id="searchValue" placeholder="정산번호를 입력하세요." value="${searchValue}">
									</div>
								</div>
								<div class="flex">
									<a class="btn btn_default" id="btnSearch"> <i class="fa-solid fa-magnifying-glass"></i> <i class="sp_icon ico_btn_search"></i>검색
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			

			<div class="box_review">
				<div class="box_inner_se">
					<div id="commentList" class="comment-list">

						<div class="review_start">
							<div class="manegementComment">
								<div class="manegementComment-details">
									<div class="manegementComment-content">
										<c:if test='${empty list}'>
											정산 내역이 존재하지 않습니다.
										</c:if>
										<c:if test='${!empty list}'>
										<table class="settlementTable">
											<thead>
												<tr>
													<th>정산번호</th>
													<th>정산여부</th>
													<th>결제건수</th>
													<th>총 정산금액</th>
													<th>정산처리날짜</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="settlement" items="${list}" varStatus="status">
												<tr>
													<td>${settlement.settlementId}</td>
													<td>완료</td>
													<td>${settlement.payCount}</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" groupingUsed="true" value="${settlement.settlementAmount}" /></td>
													<td>${settlement.settlementDate}</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
										</c:if>
									</div>
								</div>
							</div>
						</div>

					</div>
					<!--commentList 끝-->

				</div>

			</div>
			
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
		</div>
		
		<form name="settlementForm" id="settlementForm">
			<input type="hidden" name="settlementId" value="" />
			<input type="hidden" name="curPage" value="${curPage}" />
			<input type="hidden" name="searchValue" value="${searchValue}" />
		</form>
		
	</div>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>