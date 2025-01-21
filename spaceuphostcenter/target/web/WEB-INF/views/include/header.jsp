<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/resources/css/header.css">
</head>
<body>
    <header class="header main" style="top: 0px;">
        <div class="host-headerBox">
            <div class="header-left">
              <div class="toggle-btn" id="toggleBtn">
                <img src="/resources/images/header/toggleBtn.svg" style="width:50px; height:50px; filter: invert(100%) sepia(0%) saturate(0%) hue-rotate(360deg) brightness(100%) contrast(100%);">
              </div>
                <h1><a class="logo" href="/"></a></h1>
                
                <div class="headerLeftLogoBox">
                    <i>
                        <a href="/index" class="headerLeftLogoLink">
                            <img src="/resources/images/header/logo_white.png" alt="로고 이미지">
                        </a>
                    </i>
                </div>
            </div>
            
            <nav id="navmenu" class="navmenu">
              <ul>
                <li><a href="/index" class="active">Home<br></a></li>
                <li><a href="/host/hostMyPage">공간관리</a></li>
                <li><a href="/host/reservationList">예약</a></li>
                <li><a href="/host/reviewList">리뷰</a></li>
                <li><a href="/host/QnAList">QnA</a></li>
                <li><a href="/host/settlementList">정산</a></li>
              </ul>
              <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>                  
            </nav>

            <script>
              // 모든 a 태그를 선택
              const navLinks = document.querySelectorAll('#navmenu a');
            
              // 각 a 태그에 클릭 이벤트 추가
              navLinks.forEach(link => {
                link.addEventListener('click', function (e) {
                  // 기존에 active 클래스가 있는 링크에서 제거
                  navLinks.forEach(nav => nav.classList.remove('active'));
            
                  // 클릭된 링크에 active 클래스 추가
                  this.classList.add('active');
                });
              });
            </script>

            <div class="header-center">              
            </div>
            
			<div class="header-right">
			    <img src="/resources/images/guest/upload/01.png" 
			         onerror="this.src='/resources/images/host/upload/profileNull.svg';" 
			         class="headerRightUserImg">
			    <div class="dropdown headerUserMenu">
			        <ul>
			            <li><a href="/host/hostLoginForm">로그인</a></li>
			            <li><a href="/host/host">회원정보수정</a></li>
			            <li><a href="#">로그아웃</a></li>
			        </ul>
			    </div>
			    &emsp;           
			    <a href="http://spaceup.sist.co.kr:8088"><i class="guestHomeBtn">Guest홈으로 ></i></a>
			</div>
      </header>
      
      <script type="text/javascript">
	      $(document).ready(function () {
	    	    // 이미지 클릭 시 드롭다운 토글
	    	    $(".headerRightUserImg").on("click", function (e) {
	    	        e.stopPropagation(); // 이벤트 버블링 방지
	    	        $(".headerUserMenu").toggle(); // 드롭다운 메뉴 토글
	    	    });
	
	    	    // 페이지 다른 곳 클릭 시 드롭다운 닫기
	    	    $(document).on("click", function () {
	    	        $(".headerUserMenu").hide(); // 드롭다운 메뉴 숨기기
	    	    });
	    	});

      </script>

    <div class="profile-card" id="profileCard">
        <img class="profile-img" src="" onerror="this.src='/resources/images/host/upload/profileNull.svg'" alt="프로필 이미지">
        <input type="file" id="profile-picture" accept="image/*" style="display: none;" />
        <h2 class="username">host1234</h2>
        <p class="greeting">안녕하세요. 피카츄 입니다.</p>
        <button class="edit-profile-btn" onclick="location.href='/host/pwdCheckForm'">프로필 편집</button> 
        <p class="notice">더 많은 게시글을 업로드하고 응원을 받아보세요!</p>
        <!-- Separator -->
        <div class="separator"></div>
        <!-- Categories Section -->
        <div class="categories">
          <ul>
            <li><a href="/host/hostMyPage">관리자 공간 관리</a><span class="management_link_icon">></span></li>
            <div class="separator"></div>
            <li><a href="/host/reservationList">관리자 예약</a><span class="management_link_icon">></span></li>
            <div class="separator"></div>
            <li><a href="/host/reviewList">관리자 리뷰</a><span class="management_link_icon">></span></li>
            <div class="separator"></div>
            <li><a href="/host/QnAList">관리자 QnA</a><span class="management_link_icon">></span></li>
            <div class="separator"></div>
            <li><a href="/host/settlementList">관리자 정산</a><span class="management_link_icon">></span></li>
          </ul>
        </div>
    </div>

    <script>
        const toggleBtn = document.getElementById('toggleBtn');
        const profileCard = document.getElementById('profileCard');

        toggleBtn.addEventListener('click', () => {
            // 프로필 카드에 'active' 클래스를 토글하여 보이거나 숨김
            profileCard.classList.toggle('active');
        });

      </script>
</body>