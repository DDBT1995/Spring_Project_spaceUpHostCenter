<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/host/footer.css">
</head>
<body id="fbody">
    <div class="fcontainer">
        <div class="fmenu">
            <p onclick="openLink('https://munchfactory.freshdesk.com/support/home')">고객센터</p>
            <p onclick="openLink('https://munchfactory.freshdesk.com/support/tickets/new')">제휴문의</p>
            <p onclick="openLink('https://munchfactory.freshdesk.com/support/solutions/articles/151000158121')">장소문의</p>
            <p onclick="logAndOpen('/policy/service')">이용약관</p>
            <p onclick="logAndOpen('/policy/personal')">개인정보처리방침</p>
            <p onclick="logAndOpen('/policy/feed')">게시물 가이드라인</p>
            <p onclick="openBizInfo()">사업자정보확인</p>
            <p class="femail">team@spaceup.co.kr</p>
        </div>

        <div class="fbusiness-info">
            <p class="ftitle">(주)스페이스업 사업자 정보</p>
            <p class="fdetails">
                대표 김성우<br>
                주소 서울특별시 마포구 월드컵북로 21 풍성빌딩 쌍용강북교육센터<br>
                사업자 등록번호 214-85-29296<br>
                통신판매업신고번호 2018-서울강남-04057<br>
                전화번호 1533-7082<br>
                (주)스페이스업은 통신판매중개자로서, 통신판매의 당사자가 아니라는 사실을 고지하며 상품의 예약, 이용 및 환불 등과 관련한 의무와 책임은 각 판매자에게 있습니다.
            </p>
            <div class="footer">
                <p class="footer2">Copyright©2024 spaceUp All rights reserved</p>

                <div class="ficonBox_row">
                    <div class="ficonBox_column" onclick="openSns()">
                        <div class="ficonBox">
                            <img src="/resources/images/footer/sns_instagram_dark.svg">
                        </div>
                    </div>
                    <div class="ficonBox_column" onclick="openSns()">
                        <div class="ficonBox">
                            <img src="/resources/images/footer/sns_twitter_dark.svg">
                        </div>
                    </div>
                    <div class="ficonBox_column" onclick="openSns()">
                        <div class="ficonBox">
                            <img src="/resources/images/footer/sns_blog_dark.svg">
                        </div>
                    </div>
                    <div class="ficonBox_column" onclick="openSns()">
                        <div class="ficonBox">
                            <img src="/resources/images/footer/sns_apple_dark.svg">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openLink(url) {
            window.open(url, '_blank');
        }

        function logAndOpen(path) {
            // 로그를 기록하는 함수 (예: hourplace_v2.userLog 등을 호출)
            console.log('로그 기록:', path);
            window.open(`https://example.com${path}`, '_blank');
        }

        function openBizInfo() {
            window.open(
                'http://www.ftc.go.kr/bizCommPop.do?wrkr_no=4948100558',
                '주식회사 먼치팩토리',
                'width=750, height=700'
            );
        }

        function openSns() {
            hourplace_v2.userLog('W', '/?utm_source=google&amp;utm_medium=cpc&amp;utm_campaign=google_cpc_conv_kr_mf_search&amp;utm_content=purchase_brand_240830_keyword&amp;utm_term=%EC%95%84%EC%9B%8C%ED%94%8C%EB%A0%88%EC%9D%B4%EC%8A%A4&amp;gad_source=1&amp;gclid=EAIaIQobChMIi-GPz-iHigMVJG4PAh05tCL4EAAYASAAEgLb8_D_BwE', 'click', 'sns', 'instagram');window.open('http://instagram.com/hourplace/?hl=ko')
        }
    </script>
</body>
</html>