<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>QnA 페이지</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css"
    integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="/resources/css/host/QnAList.css">
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
          <h2 class="space_management_title" onclick="manegement_To">QnA 관리</h2>
        </div>
      </div>

      <div class="review-search">
        <!-- 공간리뷰 검색-->
        <div class="search-bar">
          <input type="text" placeholder="공간번호를 입력해 주세요">
          <button><img loading="lazy" src="https://img.shareit.kr/front-assets/icons/magnifier_lineBold_gray024.svg?version=1.0" alt="검색" class="Standardstyle__Image-sc-e72szk-0"></button>
        </div>
  
        <!--셀렉박스-->
        <div class="review-sort">
        <select class="review_sorting" id="review_sorting">
          <option value="0">전체</option>
          <option value="1">답변 작성완료</option>
          <option value="2">답변 미작성</option>
        </select>
        </div>
      </div>

      <div class="box_review">
        <div class="box_inner_se">
          <div id="commentList" class="comment-list">

            <div class="review_start">
              <div class="review_space_number">공간번호 207</div>
              <div class="comment">
                <img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="comment-image" />
                <div class="comment-details">
                  <div class="comment-header">

                    <div class="commnet-header-sorting1">
                      <div class="commnet-header-sorting2">
                      <span class="nickname">이용자 김기현</span>
                      </div>
                      <div class="commnet-header-sorting2">
                      <span class="comment-date">2024.12.12</span>
                      <div class="dropdown">
                        <button class="dropbtn"><img src="/resources/images/host/more_gray.svg"
                            style="width: 16px; height: 16px; object-fit: contain;"></button>
                        <div class="dropdown-content">
                          <!-- 답글 버튼 ....답변이 이미 달려있으면 안보이게 하기-->
                          <button class="comment-section__add-comment-btn" id="add-comment-btn">답글</button>
                          <a href="#">메뉴 2</a>
                          <a href="#">신고</a>
                        </div>
                      </div>
                      </div>
                    </div>

                    
                  </div>
                  <div class="comment-content">너무 별로야 너무 별로야 너무 별로야 너무 별로야 너무 별로야</div>
                </div>
              </div>

              <hr>

              <div class="manegementComment">
                <img src="/resources/images/host/reply_arrow.png" style="width:15px; filter: invert(26%) sepia(61%) saturate(2100%) hue-rotate(187deg) brightness(102%) contrast(104%);" />&emsp;
                <img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="manegementComment-image" />
                <div class="manegementComment-details">
                  <div class="manegementComment-header">
                    <div class="manegementCommnet-header-sorting1">
                      <span class="manegementNickname">관리자 김기현</span>
                      <div class="commnet-header-sorting2">
                        <span class="manegementComment-date">2024.12.12</span>
                      <div class="dropdown">
                        <button class="dropbtn"><img src="/resources/images/host/more_gray.svg"
                            style="width: 16px; height: 16px; object-fit: contain;"></button>
                        <div class="dropdown-content">
                          <button id="viewCommentBtn" class="viewCommentBtn">수정</button>
                          <a href="#">삭제</a>
                          <a href="#">메뉴3</a>
                        </div>
                      </div>
                      </div>
                    </div>
                    
                    <div>
                    </div>
                  </div>
                  <div class="manegementComment-content">안녕하세요 관리자 입니다.</div>
                </div>
              </div>

              <!--   <div class="review_space_number">답변 완료</div>   -->
              <div class="review_manegement">
                <div class="comment-action">
                  <div class="comment-section">
                    <!-- 답글 작성 폼 -->
                    <div id="comment-form" class="comment-section__comment-form" style="display: none;">
                      <div class="hostComment">답변 달기</div>
                      <textarea id="twoCommContent" name="twoCommContent" class="twoCommContent"
                        placeholder="답글을 입력하세요..."></textarea>
                      <button id="btnTwoComm" class="comment-section__submit-comment-btn">답변 등록</button>
                    </div>

                    <div id="viewCommentForm" class="viewCommentForm" style="display: none;">
                      <div class="hostComment">답변 수정</div>
                      <textarea id="viewTwoCommContent" name="viewTwoCommContent" class="viewTwoCommContent"
                        placeholder="답글을 입력하세요..."></textarea>
                      <button id="btnViewTwoCommUp" class="btnViewTwoCommUp">수정 등록</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="review_start">
              <div class="review_space_number">공간번호 207</div>
              <div class="comment">
                <img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="comment-image" />
                <div class="comment-details">
                  <div class="comment-header">
                    <span class="nickname">김기현</span>
                    <span class="comment-date">2024.12.12</span>
                  </div>
                  <div class="comment-content">강아지 데리고 갈게요..?</div>
                </div>
              </div>
            </div>

            <div class="review_start">
              <div class="review_space_number">공간번호 207</div>
              <div class="comment">
                <img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="comment-image" />
                <div class="comment-details">
                  <div class="comment-header">
                    <span class="nickname">김기현</span>
                    <span class="comment-date">2024.12.12</span>
                  </div>
                  <div class="comment-content">깔끔해요?</div>
                </div>
              </div>
            </div>

            <div class="review_start">
              <div class="review_space_number">공간번호 207</div>
              <div class="comment">
                <img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="comment-image" />
                <div class="comment-details">
                  <div class="comment-header">
                    <span class="nickname">김기현</span>
                    <span class="comment-date">2024.12.12</span>
                  </div>
                  <div class="comment-content">엘베 있나요?</div>
                </div>
              </div>
            </div>

            <div class="review_start">
              <div class="review_space_number">공간번호 207</div>
              <div class="comment">
                <img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="comment-image" />
                <div class="comment-details">
                  <div class="comment-header">
                    <span class="nickname">김기현</span>
                    <span class="comment-date">2024.12.12</span>
                  </div>
                  <div class="comment-content">신발 벗어요??</div>
                </div>
              </div>
            </div>

            <div class="review_start">
              <div class="review_space_number">공간번호 207</div>
              <div class="comment">
                <img src="file:///C:/project/HTML/pika.gif" alt="User Image" class="comment-image" />
                <div class="comment-details">
                  <div class="comment-header">
                    <span class="nickname">김기현</span>
                    <span class="comment-date">2024.12.12</span>
                  </div>
                  <div class="comment-content">따뜻한가요?</div>
                </div>
              </div>
            </div>
          </div>
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