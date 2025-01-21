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
                    <input type="text" placeholder="예약번호 또는 예약자명을 입력하세요." value="">
                  </div>
                </div>
                <div class="flex">
                  <a class="btn btn_default">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <i class="sp_icon ico_btn_search"></i>검색
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="review_sorting_box">
        <!--셀렉박스-->
        <select class="review_sorting1" id="review_sorting1">
          <option value="0">정렬</option>
          <option value="1">예약 날짜 최신순 </option>
          <option value="2">예약 날짜 오랜된 순</option>          
          <option value="3">이용 날짜 최신순</option>
          <option value="2">이용 날짜 오랜된 순</option>
        </select>

        <select class="review_sorting2" id="review_sorting2">
          <option value="0">예약 상태</option>
          <option value="1">진행중</option>
          <option value="2">이용완료</option>
          <option value="3">예약취소</option>
        </select>
      </div>

      <div class="box_review">
        <div class="box_inner_se">
          <div id="commentList" class="comment-list">

            <div class="review_start">
              <div class="review_space_number"></div>
              <div class="manegementComment">                
                <div class="manegementComment-details">                  
                  <div class="manegementComment-header">
                    <img src="" alt="User Image" class="manegementComment-image" onerror="" />
                    <span class="manegementNickname">호스트 닉네임</span>
                    <div class="manegementCommnet-header-sorting1">                      
                      <div class="dropdown">
                        <button class="dropbtn"><img src="/resources/images/host/more_gray.svg"
                            style="width: 16px; height: 16px; object-fit: contain;"></button>
                        <div class="dropdown-content">
                          <a href="#">신고</a>
                          <a href="#">삭제</a>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="manegementComment-content">
                    <table border="1">
                      <thead>
                        <tr>
                          <th>예약번호</th>
                          <th>공간번호</th>
                          <th>이용날짜</th>
                          <th>이용 시작 시간</th>
                          <th>이용 종료 시간</th>
                          <th>인원수</th>
                          <th>사용용도</th>
                          <th>예약날짜</th>
                          <th>취소날짜</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>001</td>
                          <td>207</td>
                          <td>2024-12-03</td>
                          <td>11:10</td>
                          <td>13:10</td>
                          <td>3</td>
                          <td>촬영</td>
                          <td>2024-12-01</td>
                          <td>2024-12-03</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>            
          </div><!--commentList 끝-->

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