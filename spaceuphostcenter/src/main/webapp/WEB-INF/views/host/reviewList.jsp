<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/resources/css/host/reviewList.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<div class="profile-page">
		<!-- Info Section -->
		<div class="info-section">
			<div class="tabs">
				<div class="tab active">
					<h2 class="space_management_title">리뷰 관리</h2>
				</div>
			</div>

			<div class="review-search">
				<!-- 공간리뷰 검색-->
				<div class="search-bar">
					<input type="text" name="_searchValue" id="_searchValue" placeholder="공간번호를 입력해 주세요">
					<button type="button" id="btnSearch">
						<img src="https://img.shareit.kr/front-assets/icons/magnifier_lineBold_gray024.svg?version=1.0" alt="검색" class="Standardstyle__Image-sc-e72szk-0">
					</button>
				</div>
				
				<script>
				$(document).ready(function(){
					// 검색 버튼 눌렀을 경우
					$("#btnSearch").on("click", function(){
						document.reviewForm.reviewId = "";
						document.reviewForm.searchValue.value = $("#_searchValue").val();
						document.reviewForm.curPage.value = "1";
						document.reviewForm.action = "/host/reviewList";
						document.reviewForm.submit();
					});
					
					$("#reviewSorting").on("change", function(){
						document.reviewForm.reviewId = "";
						document.reviewForm.reviewSorting.value = $("#reviewSorting").val();
						document.reviewForm.curPage.value = "1";
						document.reviewForm.action = "/host/reviewList";
						document.reviewForm.submit();						
					});
				});
				</script>

				<!-- 정렬 -->
				<div class="review-sort">
				    <select class="review_sorting" id="reviewSorting" name="reviewSorting">
				        <option value="0" ${reviewSorting == "0" ? 'selected' : ''}>전체</option>
				        <option value="1" ${reviewSorting == "1" ? 'selected' : ''}>답글 미작성</option>
				        <option value="2" ${reviewSorting == "2" ? 'selected' : ''}>답글 작성완료</option>
				    </select>
				</div>
			</div>

			<div class="box_review">
				<div class="box_inner_se">
				
				<c:if test="${empty myReviewList}">
					<div id="NoReview">
						<span>리뷰가 없습니다.</span>
					</div>
				</c:if>
								
				<c:forEach var="list" items="${myReviewList}" varStatus="status">
					<div id="commentList" class="comment-list">
						<div class="review_start">
							<div class="review_space_number" id="spaceId">공간번호 ${list.spaceId}</div>
							
							<div class="view" onclick="location.href='http://spaceup.sist.co.kr:8088/space/spaceView?spaceId=${list.spaceId}'">
								<img src="/resources/images/space/upload/${list.spaceType}/${list.spaceId}/${list.spaceId}_1.jpg" onerror="this.onerror=null; this.src='/resources/images/host/noImage.jpg'" alt="공간 이미지" />
								<p>${list.spaceName}</p>
							</div>
							
							<div class="comment">
								<img src="http://spaceup.sist.co.kr:8088/resources/images/guest/upload/${list.guestEmail}.png" onerror="this.onerror=null; this.src='/resources/images/host/upload/profileNull.svg'" alt="User Image" class="comment-image" onerror="this.src='https://via.placeholder.com/120';" />
								<div class="comment-details">
									<div class="comment-header">

										<div class="commnet-header-sorting1">
											<div class="commnet-header-sorting2">
												<span class="nickname">${list.guestNickname}</span>
												&nbsp;
											</div>
											<div class="commnet-header-sorting2">
												<span class="comment-date">${list.regDate}</span>
												<div class="dropdown">
													<button class="dropbtn">
														<img src="/resources/images/host/more_gray.svg" style="width: 16px; height: 16px; object-fit: contain;">
													</button>
													<div class="dropdown-content">
													
													<!-- 답글 버튼. 답변이 이미 달려있으면 안보이게 하기 -->
													<c:if test="${empty list.reviewReply}">
														<button class="comment-section__add-comment-btn" id="add-comment-btn" data-reviewId="${list.reviewId}" onclick="toggleReply(this)">답글</button>
													</c:if>
														<button class="btnReport" data-reservationId="${list.reviewId}" onclick="fn_submitReport(${list.reviewId})">신고</button>
													</div>
												</div>
											</div>
										</div>		
									</div>
									<div class="comment-content">
										<c:if test="${list.status eq 'N'}">
											<div>삭제된 리뷰입니다.</div>
										</c:if>
										<c:if test="${list.status eq 'Y'}">
											<div>${list.reviewContent}</div>
										</c:if>
									</div>
								</div>
							</div>
							
							<script>
							document.addEventListener('DOMContentLoaded', function(){
								// 리뷰 별점
							    const reviews = document.querySelectorAll('.rating');

							    reviews.forEach(review => {
							        const score = review.getAttribute('data-score');
							        const stars = review.querySelectorAll('.star');

							        stars.forEach((star, index) => {
							            if (index < score) {
							                star.src = '/resources/images/host/starYellow.svg'; // 노란 별
							            } else {
							                star.src = '/resources/images/host/starGray.svg'; // 회색 별
							            }
							        });
							    });
							});
							</script>

							<hr>

							<div class="manegementComment">												
								<c:if test="${empty list.reviewReply}">
								    <div style="margin-left: 50px;">리뷰 답글이 없습니다.</div>
								</c:if>
								
								<c:if test="${list.reviewReply.status eq 'N'}">
									<div style="margin-left: 50px;">삭제된 답글입니다.</div>
								</c:if>
	                    		
	                    		<c:if test="${!empty list.reviewReply and list.reviewReply.status ne 'N'}">                 		                   									
									<img src="/resources/images/host/reply_arrow.png" style="width: 15px; filter: invert(26%) sepia(61%) saturate(2100%) hue-rotate(187deg) brightness(102%) contrast(104%);" />&emsp;
			
									<div class="manegementComment-wrapper">
									  
									  <img src="/resources/images/host/upload/${list.reviewReply.hostEmail}.png" alt="User Image" class="manegementComment-image" onerror="this.src='https://via.placeholder.com/120';" />
									</div>
									
									<div class="manegementComment-details">
										<div class="manegementComment-header">
											<div class="manegementCommnet-header-sorting1">
												<span class="manegementNickname">${list.reviewReply.hostNickname}</span>
												<div class="commnet-header-sorting2">
													<span class="manegementComment-date">${list.reviewReply.regDate}</span>
													<div class="dropdown">
														<button class="dropbtn">
															<img src="/resources/images/host/more_gray.svg" style="width: 16px; height: 16px; object-fit: contain;">
														</button>
														<div class="dropdown-content">
															<button id="viewCommentBtn_${list.reviewReply.replyId}" 
															        class="viewCommentBtn" 
															        data-replyId="${list.reviewReply.replyId}" 
															        data-replyContent="${list.reviewReply.replyContent}" 
															        onclick="toggleEditForm(this)">수정
															</button>
	
															<button class="deleteReply" id="deleteReply" onclick="deleteReply(${list.reviewReply.replyId})">삭제</button>														
														</div>
													</div>
												</div>
											</div>
		
											<div></div>
										</div>
										<div class="manegementComment-content">${list.reviewReply.replyContent}</div>
									</div>								
								</c:if>								
							</div>

							<!-- 답글 작성 -->							
							<div class="review_manegement">
								<div class="comment-action">
									<div class="comment-section">
										<!-- 답글 작성 폼 -->
										<div id="comment-form_${list.reviewId}" class="comment-section__comment-form" style="display: none;">
											<div class="hostComment">답글</div>
											<textarea id="replyContent_${list.reviewId}" name="replyContent" class="replyContent" placeholder="답글을 입력하세요." spellcheck="false"></textarea>
											<button id="btnTwoComm" class="comment-section__submit-comment-btn" data-reviewId="${list.reviewId}" onclick="submitReply(this, '${list.reviewId}')">답글 등록</button>
										</div>

										<!-- 답글 수정 폼 -->									
										<div id="viewCommentForm_${list.reviewReply.replyId}" class="viewCommentForm" style="display: none;">
										    <div class="hostComment">답글 수정</div>
										    <textarea id="viewTwoCommContent_${list.reviewReply.replyId}" 
										              name="viewTwoCommContent" 
										              class="viewTwoCommContent" 
										              placeholder="수정 답글을 입력하세요."></textarea>
										    <button id="btnViewTwoCommUp_${list.reviewReply.replyId}" 
										            class="btnViewTwoCommUp" 
										            data-replyId="${list.reviewReply.replyId}" 
										            onclick="updateReply(this, '${list.reviewReply.replyId}')">수정 등록
										    </button>
										</div>																			
									</div>
								</div>
							</div>
						</div>
						
						<!-- 신고 작성 -->
					    <div id="QnAOverlay_${list.reviewId}" class="QnAOverlay" style="display: none;">
						    <!-- 흰색 슬라이드 div -->
						    <div id="QnASlideUpDiv_${list.reviewId}" class="QnASlideUpDiv" style="display: none;">
						        <div id="QnAHeaderDiv" class="QnAHeaderDiv">
						       		<span style="font-size: 16px; font-weight: bold; color: rgb(27, 29, 31); width: 100%; text-align: center;">신고 내용을 적어주세요</span>
						        	<button id="btnQnAClose" class="btnQnAClose" data-reservationId="${list.reviewId}" onclick="fn_closeReview(${list.reviewId})" style="width: fit-content; position: absolute; top: 23px; right: 26px; background: transparent; border: none; outline:none; cursor: pointer;">
						        		<img src="/resources/images/host/close.svg" style="display: block; width: 18px;">
						        	</button>
						        </div>								
						        
						        <div id="QnAContentHeaderDiv" class="QnAContentHeaderDiv">
						        	<div>
						        		<span>내용</span>
						        	</div>
						        	<div>
						        		<span class="inputQuestionCount" id="inputQuestionCount">0</span><span>/200자</span>
						        	</div>
						        </div>
						        
						        <div id="QnAContentDiv_${list.reviewId}" class="QnAContentDiv">
						        	<textarea id="reviewContent_${list.reviewId}" name="reviewContent" class="reviewContent" maxlength="200" placeholder="신고를 작성하기 전에 확인해주세요!&#10;&#10;・ 개인정보를 공유 또는 요구하거나 아워플레이스를 통하지 않은 직거래 유도, 비방/욕설/명예훼손성 글을 등록하면 사전에 고지 없이 삭제 조치 될 수 있으며 서비스 이용에 제약이 있을 수 있습니다." style=" font-size: 14px; border: none; outline: none; width: 100%; resize: none; line-height: 1.5;" spellcheck="false"></textarea>
						        </div>
						        
						        <div id="QnaFooterDiv" class="QnaFooterDiv">
						        	<button class="submitWrite" id="submitWrite" style="color: white; font-weight: bold;" onclick="fn_submitWrite(${list.reviewId})">작성하기</button>
						        </div>
						    </div>
						</div>	
						
						<script>
				        $(document).ready(function () {
				        	// 글자 수
				            const maxLength = 200; // 최대 글자 수
			
				            $(".QnAContentDiv textarea").on("input", function () {
				                const textLength = $(this).val().length; // 입력된 글자 수
				                const $counter = $("#inputQuestionCount");
			
				                $counter.text(textLength); // 글자 수 업데이트
			
				                // 글자 수 제한 초과 여부 확인
				                if (textLength >= maxLength) {
				                    $counter.addClass("over-limit"); // 빨간색 클래스 추가
				                } else {
				                    $counter.removeClass("over-limit"); // 클래스 제거
				                }
				            });
				        });
						</script>
						
						<script>
						// 리뷰창 열기 함수
						function fn_submitReport(reviewId) {
							console.log("Opening report for reservationId:", reviewId);
						    
						    // Overlay와 해당 리뷰 창 선택
						    const overlay = document.getElementById("QnAOverlay_" + reviewId);
						    const slideUpDiv = document.getElementById("QnASlideUpDiv_" + reviewId);
						
						    // 리뷰 창 열기
						    if (overlay && slideUpDiv) {
						        overlay.style.display = "block"; // 배경 표시
						        slideUpDiv.style.display = "block"; // 리뷰창 표시
						        slideUpDiv.style.bottom = "200px"; // 슬라이드 업
						    } else {
						        console.error(`Elements for reservationId ${reviewId} not found.`);
						    }
						}
						
						function fn_closeReview(reviewId) {
						    console.log("Closing report for reservationId:", reviewId);
						
						    // Overlay와 해당 리뷰 창 선택
						    const overlay = document.getElementById("QnAOverlay_" + reviewId);
						    const slideUpDiv = document.getElementById("QnASlideUpDiv_" + reviewId);
						
						    // 내용 초기화
						    const reviewContent = document.getElementById("reviewContent_" + reviewId);
						    
						    // 리뷰 창 닫기
						    if (overlay && slideUpDiv) {
						        slideUpDiv.style.bottom = "-100%"; // 슬라이드 다운 효과
						        setTimeout(() => {
						            slideUpDiv.style.display = "none";
						            overlay.style.display = "none"; // 배경 숨기기

						            // 내용 초기화
						            if (reviewContent) {
						                reviewContent.value = ""; // 리뷰 내용 비우기
						            }
						        }, 300); // 애니메이션을 위한 딜레이
						    } else {
						        console.error(`Elements for reservationId ${reviewId} not found.`);
						    }
						}
						
						function fn_submitWrite(reviewId)
						{							
							var reviewContent = document.querySelector("#reviewContent_" + reviewId + ".reviewContent").value;    
 				            
				            if ($.trim(reviewContent).length <= 0) {
				                alert("신고 내용을 입력하세요.");
				                $(".reviewContent").focus();
				                return;
				            }

				            console.log("리뷰 내용: ", reviewContent);		
				            
				            if(confirm("정말 신고하시겠습니까?") == true)
			            	{
				            	// 신고 작성 aJax
					        	$.ajax({
					    			type:"POST",
					    			url:"/host/insertReport",
					    			data:{
					    				reviewId: reviewId,				// 리뷰SEQ
					    				reportReason: reviewContent	// 신고내용	
					    			},
					    			datatype:"JSON",
					    			beforeSend:function(xhr){
					    	            xhr.setRequestHeader("AJAX", "true");
					    			},
					    			success:function(response){
					    				if(response.code == 0)
					    				{
					    					alert("신고 작성 완료");
					    					location.reload();
					    				}
					    				else if(response.code == 410)
					    				{
					    					alert("로그인 되지 않았습니다.");
					    				}
					    				else if(response.code == 404)
					    				{
					    					alert("리뷰 내역이 존재하지 않습니다.");
					    				}
					    				else if(response.code == 500)
					    				{
					    					alert("내부 오류");
					    				}
					    				else
					    				{
					    					alert("리뷰 등록 중 오류가 발생하였습니다(1)");
					    				}
					    			},
					    			error:function(xhr){
					    	            icia.common.error(error);
					    	            alert("리뷰 등록 중 오류가 발생하였습니다.(2)");
					    			}
					    		});
			            	}			        	
						}
						</script>				
					</div>
				</c:forEach>	
			
				</div>
			</div>
			
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
		</div>
	</div>

<form id="reviewForm" name="reviewForm">	
	<input type="hidden" id="reviewId" name="reviewId" value="" />
	<input type="hidden" id="searchValue" name="searchValue" value="${searchValue}" />
	<input type="hidden" id="curPage" name="curPage" value="${curPage}" />
	<input type="hidden" id="reviewSorting" name="reviewSorting" value="${reviewSorting}" />
</form>

<script>
function fn_list(curPage)
{
	document.reviewForm.curPage.value = curPage;
	document.reviewForm.reviewSorting.value = ${reviewSorting};
	document.reviewForm.action = "/host/reviewList"
	document.reviewForm.submit();
}
</script>
	
<script>
// 답글 추가 버튼 클릭 시 답글 작성 폼 토글
function toggleReply(button) {
    // data-reviewId 속성에서 reviewId 값을 가져오기
    var reviewId = button.getAttribute("data-reviewId");
    console.log("reviewId:", reviewId);

    // 버튼을 기준으로 적절한 답글 작성 폼 찾기
    var commentForm = $(button).closest('.review_start').find('.comment-section__comment-form');

    // 해당 답글 작성 폼 보이기/숨기기 토글
    if (commentForm.length) {
        commentForm.toggle();
    } else {
        console.error("답글 작성 폼을 찾을 수 없습니다.");
    }
}

// 답글 작성 버튼 클릭 시 답글을 추가
function submitReply(button, reviewId)
{
	var reviewId = button.getAttribute("data-reviewId");
    var replyContent = document.querySelector("#comment-form_" + reviewId + " .replyContent").value;

    if ($.trim(replyContent).length <= 0) {
        alert("답글 내용을 입력하세요.");
        button.disabled = false;
        return;
    }
    
    console.log("reviewIdAjax:", reviewId);
	
    //리뷰 답글 작성 aJax
	$.ajax({
		type:"POST",
		url:"/host/insertReply",
		data:{
			reviewId: reviewId,
			replyContent: replyContent
		},
		datatype:"JSON",
		beforeSend:function(xhr){
	        xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0)
			{
				alert("작성 완료.");
				location.reload();
			}
			else if(response.code == 404)
			{
				alert("리뷰가 존재하지 않습니다.");
			}
			else if(response.code == 410)
			{				
				alert("로그인 되지 않았습니다.");
			}
			else if(response.code == 500)
			{
				alert("내부 오류입니다.");
			}
			else
			{
				alert("답글 등록 중 오류가 발생하였습니다.(1)");
			}
		},
		error:function(xhr){
	        icia.common.error(error);
	        alert("답글 등록 중 오류가 발생하였습니다.(2)");
		}
	});    
}

//수정 버튼 클릭 시 수정 폼 토글
function toggleEditForm(button) {
    // 버튼에서 replyId와 기존 답글 내용 가져오기
    var replyId = button.getAttribute("data-replyId");
    var replyContent = button.getAttribute("data-replyContent");
    
    console.log("replyId:", replyId, "replyContent:", replyContent);

    // 수정 폼 찾기
	var editForm = button.closest('.review_start').querySelector('.viewCommentForm');
	var textarea = editForm.querySelector('.viewTwoCommContent');

    // 수정 폼 토글
    if (editForm.style.display === "none") {
        editForm.style.display = "block"; // 수정 폼 열기
        textarea.value = replyContent;   // 기존 답글 내용 채우기
    } else {
        editForm.style.display = "none"; // 수정 폼 닫기
    }
}

// 수정 버튼 클릭 시 수정 등록
function updateReply(button, replyId)
{
    // textarea에서 수정된 내용 가져오기
    var textarea = button.closest('.viewCommentForm').querySelector('.viewTwoCommContent');
    var updatedContent = textarea.value;

    if ($.trim(updatedContent).length <= 0) {
        alert("수정 내용을 입력하세요.");
        return;
    }

    console.log("Updating reply for replyId:", replyId, "with content:", updatedContent);

    // 수정 요청 AJAX
    $.ajax({
        type: "POST",
        url: "/host/updateReply",
        data: {
            replyId: replyId,
            replyContent: updatedContent
        },
        datatype: "JSON",
        success: function(response)
        {
            if (response.code == 0)
            {
                alert("수정 완료.");
                location.reload();
            }
            else if (response.code == 404)
            {
                alert("답글이 존재하지 않습니다.");
            } 
            else if (response.code == 410)
            {
                alert("로그인 되지 않았습니다.");
            } 
            else if (response.code == 500)
            {
                alert("내부 오류입니다.");
            } 
            else {
                alert("답글 수정 중 오류가 발생하였습니다.(1)");
            }
        },
        error: function(xhr) {
            alert("답글 수정 중 오류가 발생하였습니다.(2)");
        }
    });
}

function deleteReply(replyId)
{
	if(confirm("댓글을 정말 삭제하시겠습니까?") == true){		
		// 댓글 삭제 aJax
		$.ajax({
			type:"POST",
			url:"/host/deleteReply",
			data:{
				replyId: replyId
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("답글 삭제 성공");
					location.reload();
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
				}
				else if(response.code == 403)
				{
					alert("본인이 작성한 답글이 아닙니다.");
				}
				else if(response.code == 404)
				{
					alert("답글을 찾을 수 없습니다.");
				}
				else
				{
					alert("답글 삭제 중 오류 발생(1)");
				}
			},
			error:function(error){
				icia.common.error(error);
				alert("답글 삭제 중 오류 발생(2)");
			}
		});
	}
}
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>