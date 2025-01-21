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
        <div class="gallery-item">
          <img src="1.jpg" alt="공간 이미지 1">
          <p>아주 깔끔한 스튜디오 </p>
          <div class="separator_medium"></div>
          <p class="space_number">공간번호 123456 </br> 등록일 2024.11.22</p>
          <div class="btn_space_edit">
            <a class="space_modify" href="/space/modify?spaceId=67481">공간 상세 보기</a>
            <a class="product_modify" href="/host/hostSapceUpdateForm">공간 상세 수정</a>
            <a class="space_delete" href="/">공간 삭제</a>
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