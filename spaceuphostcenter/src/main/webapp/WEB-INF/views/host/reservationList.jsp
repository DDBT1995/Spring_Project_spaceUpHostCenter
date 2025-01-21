<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css"
    integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="/resources/css/host/reservationList.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <script>
    // ajax 미구현
    // 답글 추가 버튼 클릭 시 답글 작성 폼 토글
    $(document).on('click', '#add-comment-btn', function () {
      var commentForm = $(this).closest('.review_start').find('.comment-section__comment-form');
      commentForm.toggle(); // 해당 답글의 폼만 보이거나 숨겨짐
    });

    // 답글 작성 버튼 클릭 시 답글을 추가
    $(document).on('click', '#btnTwoComm', function () {
      var commentText = $(this).siblings('#twoCommContent').val().trim(); // 답글 텍스트
      // var commentText = $(this).closest('.review_start').find('#twoCommContent').val().trim(); // 위에꺼 안되면 사용해보기
      if (commentText !== '') {
        alert('답글이 작성되었습니다: ' + commentText);

        // 답글 입력 폼 초기화
        $(this).siblings('#twoCommContent').val('');  // 텍스트박스 비우기
        $(this).closest('.comment-section__comment-form').hide();  // 폼 숨기기
      } else {
        alert('답글을 입력해주세요.');
      }
    });

    // 수정 버튼 클릭 시 수정 폼 토글
    $(document).on('click', '#viewCommentBtn', function () {
      var commentForm = $(this).closest('.review_start').find('.viewCommentForm');
      commentForm.toggle(); // 해당 답글의 폼만 보이거나 숨겨짐
    });

    // 수정 버튼 클릭 시 수정
    $(document).on('click', '#btnViewTwoCommEmpty', function () {
      var commentText = $(this).siblings('#viewTwoCommContent').val().trim(); // 답글 텍스트
      // var commentText = $(this).closest('.review_start').find('#viewTwoCommContent').val().trim(); // 위에꺼 안되면 사용해보기
      if (commentText !== '') {
        // 수정 입력 폼 초기화
        $(this).siblings('#viewTwoCommContent').val('');  // 텍스트박스 비우기
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
          <h2 class="space_management_title" onclick="manegement_To">예약 관리</h2>
        </div>
      </div>

      <!-- 정산번호 검색-->
      <div class="box_search">
        <div class="box_inner">
          <div class="one_search">
            <div class="flex_wrap">
              <div class="flex_box">
                <div>
                  <h3>예약 정보 검색</h3>
                </div>
                <div class="flex">
                  <div class="input">
                    <input id="searchKeyword" type="text" placeholder="예약번호 또는 예약자 이메일을 입력하세요." value="${searchKeyword}" onkeydown="searchFn(event)">
                  </div>
                </div>
                <div class="flex">
                  <a class="btn btn_default" onclick="fn_list_search(1)">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <i class="sp_icon ico_btn_search"></i>검색
                  </a>
                  <a class="btn btn_reset" onclick="fn_list_reset(1)">
                    <i class="sp_icon ico_btn_search"></i>초기화
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="review_sorting_box">
	  	  <!--셀렉박스-->
	      <select class="review_sorting1" id="sortReservation" name="sortReservation">
	        <option value="">정렬</option>
	        <c:choose>
	        	<c:when test="${sortReservation eq 1}">
	        		<option value="1" selected>이용 날짜 최신순 </option>
	        	</c:when>
	        	<c:otherwise>
	        		<option value="1">이용 날짜 최신순 </option>
	        	</c:otherwise>
	        </c:choose>
	        <c:choose>
	        	<c:when test="${sortReservation eq 2}">
	        		<option value="2" selected>이용 날짜 오랜된 순</option>
	        	</c:when>
	        	<c:otherwise>
	        		<option value="2">이용 날짜 오랜된 순</option>
	        	</c:otherwise>
	        </c:choose>
	        <c:choose>
	        	<c:when test="${sortReservation eq 3}">
	        		<option value="3" selected>예약 날짜 최신순</option>
	        	</c:when>
	        	<c:otherwise>
	        		<option value="3">예약 날짜 최신순</option>
	        	</c:otherwise>
	        </c:choose>
	        <c:choose>
	        	<c:when test="${sortReservation eq 4}">
	        		<option value="4" selected>예약 날짜 오랜된 순</option>
	        	</c:when>
	        	<c:otherwise>
	        		<option value="4">예약 날짜 오랜된 순</option>
	        	</c:otherwise>
	        </c:choose>
	      </select>
	
	      <select class="review_sorting2" id="reservationStatus" name="reservationStatus">
	        <option value="">예약 상태</option>
	        <c:choose>
	        	<c:when test="${statusSelect eq 'P'}">
	        		<option value="P" selected>진행중</option>
	        	</c:when>
	        	<c:otherwise>
	        		<option value="P">진행중</option>
	        	</c:otherwise>
	        </c:choose>
	        <c:choose>
	        	<c:when test="${statusSelect eq 'C'}">
	        		<option value="C" selected>이용완료</option>
	        	</c:when>
	        	<c:otherwise>
	        		<option value="C">이용완료</option>
	        	</c:otherwise>
	        </c:choose>
	        <c:choose>
	        	<c:when test="${statusSelect eq 'D'}">
	        		<option value="D" selected>예약취소</option>
	        	</c:when>
	        	<c:otherwise>
	        		<option value="D">예약취소</option>
	        	</c:otherwise>
	        </c:choose>
	      </select>
      </div>

      <div class="box_review">
        <div class="box_inner_se">
          <div id="commentList" class="comment-list">
          	<c:choose>
          		<c:when test="${not empty reservationList}">
          			<div class="review_start">
		              <div class="review_space_number"></div>
		              <div class="manegementComment">                
		                <div class="manegementComment-details">                  
		                  <div class="manegementComment-content">
		                    <table border="1">
		                      <thead>
		                        <tr>
		                          <th>예약번호</th>
		                          <th>공간번호</th>
		                          <th>예약자 이메일</th>
		                          <th>이용날짜</th>
		                          <th>이용 시간</th>
		                          <th>인원수</th>
		                          <th>예약날짜</th>
		                          <th>취소날짜</th>
		                          <th>이용상태</th>
		                        </tr>
		                      </thead>
		                      <tbody>
		                      	<c:forEach items="${reservationList}" var="rList">
		                      		<tr id="reservationItem" data-payment-id="${rList.paymentId}">
			                          <td>${rList.reservationId}</td>
			                          <td>${rList.spaceId}</td>
			                          <td>${rList.guestEmail}</td>
			                          <td>
				                          <fmt:parseDate value="${rList.useDate}" var="dateValue" pattern="yyyyMMdd"/>
										  <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/>
									  </td>
			                          <td>
			                          	  <c:set var="timeValue" value="${rList.useStartTime}" />
										  <c:set var="hour" value="${timeValue % 12}" />
										  <c:set var="period" value="${timeValue >= 12 ? '오후' : '오전'}" />
										  <c:set var="formattedTimeStart" value="${period} ${hour}시" />
										  
			                          	  <c:set var="timeValue" value="${rList.useEndTime + 1}" />
										  <c:set var="hour" value="${timeValue % 12}" />
										  <c:set var="period" value="${timeValue >= 12 ? '오후' : '오전'}" />
										  <c:set var="formattedTimeEnd" value="${period} ${hour}시" />
										  <p>${formattedTimeStart} ~ ${formattedTimeEnd}</p>
									  </td>
			                          <td>${rList.usePeople}</td>
			                          <td>${rList.regDate}</td>
			                          <td>${rList.delDate}</td>
			                          <c:choose>
			                          	<c:when test="${rList.status eq 'P'}">
			                          		<td><button class="cancelReservation" id="cancelReservation">취소</button></td>
			                          	</c:when>
			                          	<c:when test="${rList.status eq 'C'}">
			                          		<td>이용 완료</td>
			                          	</c:when>
			                          	<c:when test="${rList.status eq 'D'}">
			                          		<td>취소 된 예약</td>
			                          	</c:when>
			                          </c:choose>
			                        </tr>
		                      	</c:forEach>
		                      </tbody>
		                    </table>
		                  </div>
		                </div>
		              </div>
		            </div>
          		</c:when>
          		<c:otherwise>
          			<div class="noReservationBox">
          				<p>등록된 예약이 없습니다.</p>
          			</div>
          		</c:otherwise>
          	</c:choose>
            
          </div><!--commentList 끝-->

        </div>
      </div>
      
      <!-- 예약 취소 modal -->
				
	<div id="rvUpdateOverlay">
	    <!-- 흰색 슬라이드 div -->
	    <div id="rvUpdateSlideUpDiv">
	        <div id="rvUpdateHeaderDiv">
        		<span style="font-size: 16px; font-weight: bold; color: rgb(27, 29, 31); width: 100%; text-align: center;">예약 취소 사유를 입력하세요.</span>
	        	<button id="btnRvUpdateClose" style="width: fit-content; position: absolute; top: 23px; right: 26px; background: transparent; border: none; outline:none;">
	        		<img src="/resources/images/host/close.svg" style="display: block; width: 18px;">
	        	</button>
	        </div>
	        
	        <div id="rvUpdateHeaderDiv">
        		<span style="font-size: 12px; font-weight: bold; color: #828181b3; width: 100%; text-align: center;">200자 내로 입력바랍니다!</span>
	        </div>
	        
	        <div id="rvUpdateContentHeaderDiv">
	        	<div>
	        		<span>내용</span>
	        	</div>
	        	<div>
	        		<span id="inputRvUpdateCount">0</span><span>/200자</span>
	        	</div>
	        </div>
	        
	        <div id="rvUpdateContentDiv">
	        	<textarea id="rvUpdateContentTextarea" maxlength="200" style=" font-size: 14px; border: none; outline: none; width: 100%; resize: none; height: 100%" ></textarea>
	        </div>
	        
	        <div id="rvUpdateFooterDiv">
	        	<span style="color: white; font-weight: bold;">예약 취소</span>
	        </div>
	        
	        <script>
		        $(document).ready(function () {
		            const maxLength = 200; // 최대 글자 수

		            $("#rvUpdateContentDiv textarea").on("input", function () {
		                const textLength = $(this).val().length; // 입력된 글자 수
		                const $counter = $("#inputRvUpdateCount");
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
	    </div>
	</div>
      
	   <nav>
	      <ul class="paging justify-content-center">
	
			<c:if test="${!empty paging}">
				<c:if test="${paging.prevBlockPage gt 0}">
			         <li class="bestSlidePrevBtn" onclick="fn_list(${paging.prevBlockPage})"></li>
				</c:if>
				<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
					<c:choose >
						<c:when test="${i ne curPage}">
					        <li class="btnPage" onclick="fn_list(${i})">${i}</li>
					    </c:when>
					    <c:otherwise>
					        <li class="btnPage btnPageActive" style="cursor:default;">${i}</li>
					    </c:otherwise>
				    </c:choose>
			    </c:forEach>
				<c:if test="${paging.nextBlockPage gt 0}">
			         <li class="bestSlideNextBtn" onclick="fn_list(${paging.nextBlockPage})"></li>
				</c:if>
			</c:if>
	      </ul>
	   </nav>
      
    </div>
  </div>
  
  <form name="reForm" id="reForm" method="get">
   		<input type="hidden" name="statusSelect" value="">
   		<input type="hidden" name="searchKeyword" value="">
   		<input type="hidden" name="sortReservation" value="">
   		<input type="hidden" name="curPage" value="${curPage}">
   </form>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>



<script>
	function searchFn(event) {
		if (event.key === "Enter") {
			fn_list_search(1);			
		}
	}

	function fn_list_search(curPage) {
		document.reForm.curPage.value = curPage;
		document.reForm.statusSelect.value = "";
		document.reForm.searchKeyword.value = $("#searchKeyword").val();
		document.reForm.sortReservation.value = "";
		document.reForm.action = "/host/reservationList";
		document.reForm.submit();
	}
	
	function fn_list(curPage) {
		document.reForm.curPage.value = curPage;
		document.reForm.statusSelect.value = $("select[name=reservationStatus] option:selected").val();
		document.reForm.searchKeyword.value = $("#searchKeyword").val();
		document.reForm.sortReservation.value = $("select[name=sortReservation] option:selected").val();
		document.reForm.action = "/host/reservationList";
		document.reForm.submit();
	}
	
	function fn_list_reset(curPage) {
		document.reForm.curPage.value = curPage;
		document.reForm.statusSelect.value = "";
		document.reForm.searchKeyword.value = "";
		document.reForm.sortReservation.value = "";
		document.reForm.action = "/host/reservationList";
		document.reForm.submit();
	}
	
	$("#sortReservation").on("change", function() {
		fn_list(1);
	});
	
	$("#reservationStatus").on("change", function() {
		fn_list(1);
	});
	
	let paymentId = null;
	
	$(document).on("click", "#cancelReservation", function(e) {
		paymentId = $(this).closest('#reservationItem').data('payment-id');
        console.log('선택된 댓글 ID:', paymentId);
		
		$("#rvUpdateOverlay").fadeIn(300); // 검은 배경 표시
        $("#rvUpdateSlideUpDiv").css("bottom", "200px"); // 흰색 div 슬라이드업
	});
	
	// 검은 배경 클릭 시 닫기
    $("#rvUpdateOverlay").on("click", function (e) {
        if ($(e.target).is("#rvUpdateOverlay")) { // 흰색 div 외의 검은 배경을 클릭한 경우
            $("#rvUpdateOverlay").fadeOut(300); // 검은 배경 숨기기
            $("#rvUpdateSlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
        }
    });
    
    $('#btnRvUpdateClose').on('click', function () {
    	$("#rvUpdateOverlay").fadeOut(300); // 검은 배경 숨기기
        $("#rvUpdateSlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
    });
    
    $("#rvUpdateFooterDiv").on("click", function() {
    	const deleteReason = $('#rvUpdateContentTextarea').val().trim();
    	
		if(!deleteReason) {
			alert("취소 사유 입력바랍니다.");
			return;
		}
					
			$.ajax({
				type : "POST",
				url : "http://spaceup.sist.co.kr:8088/order/kakaoPay/refund",
				data : {
					paymentId : paymentId,
					deleteReason : deleteReason
				},
				dataType : "JSON",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success : function(response) {
					if (response.code === 0) {
						alert("결제가 취소되었습니다.");
						location.href = "/host/reservationList";
					} else if (response.code === -1) {
						alert("결제 취소 중 오류가 발생하였습니다.");
					} else if (response.code === -2) {
						alert("이미 결제취소 완료된 건입니다.");
					} else if (response.code === -3) {
						alert("결제 정보가 존재하지 않습니다.");
					} else {
						alert("예기치 못한 오류가 발생했습니다. 다시 시도해주세요.");
					}
				},
				error : function(xhr, status, error) {
					console.error("AJAX Error:", error); // 콘솔에 상세 에러 출력
					alert("결제 취소 요청 중 문제가 발생했습니다. 잠시 후 다시 시도해주세요.");
				}
			});
					

	});
    
  	//결제취소 (환불)
	function fn_kakaoPayCancel(paymentId) {
		if (confirm("결제를 취소하시겠습니까?")) {
			console.log("Payment ID for cancel:", paymentId); // 디버깅 로그

			
		} else {
			alert("결제 취소를 취소하였습니다."); // 취소 알림
		}
	}
</script>
</body>
</html>





































