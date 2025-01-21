<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" href="/resources/css/home.css">
    <title>장소 등록 플랫폼</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // number count for stats, using jQuery animate
    $('.counting').each(function() {
        var $this = $(this),
            countTo = $this.attr('data-count');
        
        $({ countNum: $this.text() }).animate({
            countNum: countTo
        },
        {
            duration: 1500,
            easing: 'linear',
            step: function() {
                $this.text(Math.floor(this.countNum));
            },
            complete: function() {
                $this.text(this.countNum);
            }
        });  
    });
    

	$("#register-button").on("click", function() {    	    	    
    	location.href = "/host/hostLoginForm";
    });
    
});

 
</script>
</head>
<body>
    <div class="main-container">
        <div class="header-background">
            <section class="content-section">
                <div class="intro-container">
                    <span class="subtext">나만의 장소를 모두의 장소로.</span>
                    <h1 class="main-title">우리 집에서 만들어지는 <strong>100만뷰 영상</strong></h1>
                    <button class="register-button" id="register-button">내 장소 등록하기</button>
                </div>
                <div class="stats-container">
                    <div class="stat-box">
                        <img src="https://s3.hourplace.co.kr/web/images/money.svg" alt="수익 이미지">
                        <h3>상위 호스트는 월 평균</h3>
                        <p class="stat-value"><span class="counting" data-count="734">0</span><span class="unit"> 만원</span></p>
                        <span class="stat-subtext">정도 벌고 있어요.</span>
                    </div>
                    <div class="stat-box">
                        <h3>예약 1건당</h3>
                        <p class="stat-value"><span class="counting" data-count="17">0</span><span class="unit"> 만원</span></p>
                        <span class="stat-subtext">정도가 평균 수익이에요.</span>
                    </div>
                </div>
            </section>
        </div>

        <section class="guide-section">
            <div class="guide-title">
                <h1>호스팅, 시작해볼까요?</h1>
                <span>모든 장소, 그 자체로 멋진 촬영 장소.</span>
            </div>
            <div class="guide-steps">
                <div class="step-box">
                    <img src="https://s3.hourplace.co.kr/web/images/party-popper.svg" alt="가입하기">
                    <span>회원가입하기</span>
                    <h3>누구나 무료로<br>장소를 등록할 수 있어요</h3>
                </div>
                <hr>
                <div class="step-box">
                    <img src="https://s3.hourplace.co.kr/web/images/house.svg" alt="등록하기">
                    <span>장소 등록하기</span>
                    <h3>PC, 모바일 앱 어디서든<br>사진과 상세 정보를 등록할 수 있어요</h3>
                </div>
                <hr>
                <div class="step-box">
                    <img src="https://s3.hourplace.co.kr/web/images/feed.svg" alt="예약 진행">
                    <span>예약 진행하기</span>
                    <h3>게스트 예약 정보를 확인 후<br>진행 의사가 있다면 예약을 수락해주세요</h3>
                </div>
            </div>
        </section>


    </div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
