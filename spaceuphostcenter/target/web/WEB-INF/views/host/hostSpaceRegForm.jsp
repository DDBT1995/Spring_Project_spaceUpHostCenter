<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/resources/css/host/hostSpaceRegForm.css">
    
<script>
$(document).ready(function() {
	$("#success").on("click", function() {    	    	    
    	location.href = "/host/hostSpaceRegFormComplete";
    });
    
});

 
</script>    
</head>

<body>
<%@ include file="/WEB-INF/views/include/header.jsp"%>

    <div class="container">
        <h2>장소 등록</h2>
        <div class="line-group">        
            <h2 id="title">등록할 장소는 어디에 있나요?</h2>
            <div class="input-section">
                <label for="location-input">주소 입력</label>
                <input type="text" id="location-input" placeholder="지도api자리">
            </div>
        </div>

        <div class="line-group">
            <h2>등록할 장소</h2>
            <div class="map-placeholder">api에서 선택하면 바뀌는 창</div>
        </div>

        <div class="line-group">
            <h2>실제 분위기가 잘 나타난 사진을 올려주세요.</h2>
            <div class="upload-section">
                <input type="file" id="upload-photo" accept="image/png, image/jpeg, image/jpg" />
            </div>
            <div class="image-preview" id="image-preview">
                <p>이미지 파일을 선택해 주세요.</p>
            </div>
        </div>

        <div class="line-group">
            <h2>장소 카테고리를 하나만 선택해 주세요.</h2>
            <div class="category-section">            
                <label><input type="radio" name="category" value="자연광 스튜디오"> 자연광 스튜디오</label>
                <label><input type="radio" name="category" value="호텔 스튜디오"> 호텔 스튜디오</label>
                <label><input type="radio" name="category" value="호리존 스튜디오"> 호리존 스튜디오</label>
                <label><input type="radio" name="category" value="컨셉룸"> 컨셉룸</label>
                <label><input type="radio" name="category" value="카페"> 카페</label>
                <label><input type="radio" name="category" value="사무실"> 사무실</label>
                <label><input type="radio" name="category" value="연습실"> 연습실</label>
                <label><input type="radio" name="category" value="녹음실"> 녹음실</label>
                <label><input type="radio" name="category" value="무대"> 무대</label>
                <label><input type="radio" name="category" value="크로마키"> 크로마키</label>
                <label><input type="radio" name="category" value="한옥"> 한옥</label>
                <label><input type="radio" name="category" value="아파트"> 아파트</label>
            </div>
        </div>

        <div class="line-group">
            <h2>장소 제목을 지어볼까요?</h2>
            <input type="text" placeholder="장소의 이름을 지어보세요." />

            <h2>어떤 장소인지 알려주세요.</h2>
            <textarea placeholder="장소의 분위기가 느껴질 수 있도록 나의 장소를 소개해주세요."></textarea>

            <h2>장소 이용 팁💡</h2>
            <textarea placeholder="장소의 특징이나 위치가 드러나게 한 줄 소개를 지어보세요. 예) 강남구의, 빈티지, 원룸, 베이지톤의, 평범한"></textarea>
        
            <h2>장소 정보를 더 알려주세요.</h2>
            <div class="spotgroup">
                <label for="area">면적</label>
                <input type="text" id="area" placeholder=""> 평
            </div>

            <div class="spotgroup">
                <label for="floor">층 수</label>
                <div>
                    <button class="btn" id="aboveGroundBtn">지상</button>
                    <button class="btn" id="belowGroundBtn">지하</button>
                </div>
                <div>
                    <input type="text" id="floor" /> 층
                </div>
            </div>
        
            <div class="spotgroup">
                <label for="parking">주차</label>
                <div>
                    <button class="btn" id="parkingYesBtn">주차 가능</button>
                    <button class="btn" id="parkingNoBtn">주차 안됨</button>
                </div>
                <div id="carCountDiv" class="hidden">
                    <label for="carCount"></label>
                    <input type="text" id="carCount" placeholder="" /> 대
                </div>
            </div>

            <label for="rules">장소 위치 정보</label>
            <textarea placeholder="찾아오시는 길을 간략하게 적어주세요."></textarea>

            <label for="rules">장소 이용 규칙</label>
            <span id="spans">중요한 내용을 미리 적어놨어요. 자유롭게 수정하세요!</span>
            <textarea spellcheck="false">
[시간 엄수]

계약된 시간을 꼭 준수하여 주시기 바랍니다.
이용요금은 [시작 시간] 및 [종료 시간]으로 계약됩니다.
촬영 준비 및 세팅, 장비 철수 및 장소 원상복구 시간은 예약 시간에 포함됩니다.
계약된 촬영 시간을 초과할 경우 호스트가 추가결제를 요청할 수 있습니다.

[파손 주의]
삼각대, 조명, 철제박스, 각종 의자, 기타 장비로 인한 나무 바닥과 벽지 파손에 꼭 주의하세요.
준비물 : 간단한 돗자리나 모포, 테니스공을 준비해 장비 밑에 깔아 주세요.
파손 시 : 현장에서 함께 확인 > 사진 촬영 > 견적 확인 후, 배상 요청을 진행하게 됩니다.

[스탭 인원]
설정한 최대 스탭 인원이 지켜지지 않을 경우, 호스트가 촬영을 취소하거나 추가결제를 요청할 수 있습니다.

[취식 금지]
공간에서 취식은 항상 금지되어있습니다. 부득이한 경우 호스트에게 먼저 양해를 꼭 구해주세요.

[에티켓]
주변 주민들을 위해 기본 에티켓을 지켜주세요.
주변 야외 촬영은 불가능합니다.
촬영 도중 발생한 쓰레기는 모두 정리해주셔야 합니다.
주차는 안내된 주차대수만 제공됩니다.
기존의 가구 세팅 및 구조를 필요에 의해 변경하신 경우 마감 시간 전에 원상복구 해주셔야 합니다.
            </textarea>
        </div>

        <div class="line-group">
            <h2>금액을 정해볼까요?</h2>
            <div class="input-group">
                <label for="min-time">최소 예약 시간</label>
                <div class="counter">
                    <button type="button" onclick="decrement('min-time')">–</button>
                    <input type="text" id="min-time" value="1" readonly>
                    <button type="button" onclick="increment('min-time')">+</button>
                </div>
            </div>
            <div class="input-group">
                <label for="base-people">기본 인원</label>
                <div class="counter">
                    <button type="button" onclick="decrement('base-people')">–</button>
                    <input type="text" id="base-people" value="1" readonly>
                    <button type="button" onclick="increment('base-people')">+</button>
                </div>
            </div>

            <h2>시간당 얼마를 받을까요?</h2>
            <label for="hourly-rate">시간당 요금</label>
            <input type="text" id="hourly-rate" min="0" placeholder="예: 50,000"> 원
        </div>

        <div class="line-group">
            <h2>이제 마지막 단계예요! 결제 방식을 선택해 주세요.</h2>
            <label><input type="radio" name="payment" value="카드 결제"> 카드 결제</label>

            <div class="returnInfo">
                <p id="return"><b style="font-size: 18px;">spaceUp 환불 규정</b>
        
                    호스트 승인 전
                    • 호스트 승인 전에 예약 취소 시 100% 환불돼요.
                    
                    호스트 승인 후
                    • 게스트 취소 시 - 결제 후 2시간 이내 또는 사용일 4일 전까지 취소하면 100% 환불돼요.(사용일 3일 전 환불 불가)
                    • 호스트 귀책 사유 취소 시 - 100% 환불돼요.
                </p>
            </div>
        </div>

        <button type="button" class="success" id="success">등록 완료</button>
    </div>

    <!--Jquery-->
    <script>
        document.getElementById('upload-photo').addEventListener('change', function(event) {
            const file = event.target.files[0];
            const preview = document.getElementById('image-preview');
            preview.innerHTML = ''; // 기존 내용을 지우기

            if (file && file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    preview.appendChild(img);
                };
                reader.readAsDataURL(file);
            } else {
                preview.innerHTML = '<p>유효한 이미지 파일을 선택해 주세요.</p>';
            }
        });

        function increment(id) {
            const input = document.getElementById(id);
            input.value = parseInt(input.value) + 1;
        }

        function decrement(id) {
            const input = document.getElementById(id);
            if (parseInt(input.value) > 1) {
                input.value = parseInt(input.value) - 1;
            }
        }

        const aboveGroundBtn = document.getElementById('aboveGroundBtn');
        const belowGroundBtn = document.getElementById('belowGroundBtn');
        const parkingYesBtn = document.getElementById('parkingYesBtn');
        const parkingNoBtn = document.getElementById('parkingNoBtn');
        const carCountDiv = document.getElementById('carCountDiv');

        aboveGroundBtn.addEventListener('click', () => {
            aboveGroundBtn.classList.add('active');
            belowGroundBtn.classList.remove('active');
        });

        belowGroundBtn.addEventListener('click', () => {
            belowGroundBtn.classList.add('active');
            aboveGroundBtn.classList.remove('active');
        });

        parkingYesBtn.addEventListener('click', () => {
            parkingYesBtn.classList.add('active');
            parkingNoBtn.classList.remove('active');
            carCountDiv.classList.remove('hidden');
        });

        parkingNoBtn.addEventListener('click', () => {
            parkingNoBtn.classList.add('active');
            parkingYesBtn.classList.remove('active');
            carCountDiv.classList.add('hidden');
        });
    </script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>