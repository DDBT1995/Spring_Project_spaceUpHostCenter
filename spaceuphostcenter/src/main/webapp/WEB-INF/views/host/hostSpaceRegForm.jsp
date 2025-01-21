<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/resources/css/host/hostSpaceRegForm.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0f979efa24339b22af634ee6af0fd743&libraries=services"></script>
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
</head>
<body>
	<form id="spaceRegForm" name="spaceRegForm" method="get" enctype="multipart/form-data">

		<%@ include file="/WEB-INF/views/include/header.jsp"%>

		<div class="container">
			<div class="tabs">
				<div class="tab active">
					<h2 class="space_management_title" onclick="manegement_To">공간 등록</h2>
				</div>
			</div>

			<div class="line-group">
				<h3 id="title" style="margin-top: 0px; margin-bottom: 10px;">등록할 장소는 어디에 있나요?</h3>
				<div style="display: flex; align-items: flex-end; margin-bottom: 30px;">
					<input id="spaceAddr" type="text" placeholder="주소를 입력해주세요. 현재 표시된 주소는 쌍용강북아카데미 입니다." style="margin-top: 0px; width: 70%; margin-right: 10px; outline: none;" readonly>
					<button type="button" id="btnAddrSearch" onclick="daumPost()">
						<i class="fa-solid fa-magnifying-glass"></i>주소 검색
					</button>
				</div>

				<div class="input-section" style="margin: 0px;">
					<h3 id="title" style="margin-top: 0px; margin-bottom: 10px;">장소 위치</h3>
					<div id="map" style="width: 100%; height: 400px; margin-bottom: 30px;"></div>
				</div>

				<h3 id="title" style="margin-top: 0px; margin-bottom: 10px;">장소 위치 정보</h3>
				<div id="spaceAddrDesc" style="margin: 0px; height: 100px;"></div>
				<script type="text/javascript">
					var spaceAddrDescQuill = new Quill('#spaceAddrDesc', {
					    theme: 'snow',
					    placeholder: "찾아오시는 길을 간략하게 적어주세요.",
					    modules: {
					        toolbar: [
					            ['bold', 'italic', 'underline', 'strike'],        // 서식 옵션
					            [{ 'header': 1 }, { 'header': 2 }],              // 헤더 레벨
					            [{ 'list': 'ordered'}, { 'list': 'bullet' }],    // 리스트 옵션
					            [{ 'indent': '-1'}, { 'indent': '+1' }],         // 들여쓰기
					            [{ 'size': ['small', false, 'large', 'huge'] }], // 글자 크기
					            [{ 'align': [] }]                                // 정렬
					        ]
					    }
					});
				</script>
			</div>


			<script type="text/javascript">
		    let map, marker, geocoder;
		
		    // 지도 및 마커 초기화
		    function initializeMap() {
		        var mapContainer = document.getElementById('map');
		        var mapOptions = {
		            center: new kakao.maps.LatLng(37.556571, 126.919550), // 초기 지도 중심 좌표
		            level: 3 // 확대 레벨
		        };
		
		        map = new kakao.maps.Map(mapContainer, mapOptions);
		        geocoder = new kakao.maps.services.Geocoder();
		
		        // 초기 마커 생성
		        marker = new kakao.maps.Marker({
		            position: map.getCenter(),
		            map: map
		        });
		    }
		
		    // 주소를 검색해 지도와 마커 업데이트
		    function updateMap(address) {
		        geocoder.addressSearch(address, function(result, status) {
		            if (status === kakao.maps.services.Status.OK) {
		                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		                // 지도 중심 변경
		                map.setCenter(coords);
		
		                // 마커 위치 변경
		                marker.setPosition(coords);
		            } else {
		                console.error('주소 검색 실패:', status);
		                alert('입력한 주소를 찾을 수 없습니다.');
		            }
		        });
		    }
		
		    // 다음 주소 검색 API 호출
		    function daumPost() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                let addr = ''; // 검색 결과 주소 변수
		
		                if (data.userSelectedType === 'R') {
		                    addr = data.roadAddress; // 도로명 주소
		                } else {
		                    addr = data.jibunAddress; // 지번 주소
		                }
						$("#spaceAddr").val(addr);
		
		                // 지도와 마커 업데이트
		                updateMap(addr);
		            }
		        }).open();
		    }
		
		    // Kakao Maps API 로드 후 지도 초기화
		    kakao.maps.load(function() {
		        initializeMap();
		    });
		</script>

			<div class="line-group">
				<h3>실제 분위기가 잘 나타난 사진을 올려주세요.</h3>
				<div class="upload-section">
					<input type="file" id="fileInput" name="file" onchange="addFileToFormData(this)" multiple>
				</div>
				<div id="fileGrid">
					<!-- 이미지가 여기에 나타납니다 -->
				</div>
			</div>

			<script>
    let formData = new FormData();
    let fileNames = []; // 선택된 파일들의 이름을 저장
    let filePreviews = []; // 미리보기 저장
    let filesArray = []; // 선택된 파일들을 저장

    function addFileToFormData(input) {
        const files = Array.from(input.files);

        // 파일 추가 및 미리보기 생성
        files.forEach((file) => {
            const reader = new FileReader();
            formData.append("files", file); // 서버로 보낼 FormData에 추가
            fileNames.push(file.name); // 이름 추가
            filesArray.push(file); // 파일 배열에 추가

            reader.onload = (e) => {
                filePreviews.push(e.target.result); // 미리보기 저장
                updateFileGrid();
            };
            reader.readAsDataURL(file); // 파일 읽기
        });
    }

    function updateFileGrid() {
        const fileGrid = document.getElementById("fileGrid");
        fileGrid.innerHTML = ""; // 기존 내용 비우기

        filePreviews.forEach((src, index) => {
            const fileItem = document.createElement("div");
            fileItem.classList.add("file-item");

            // 첫번째 이미지는 "대표이미지" 표시
            if (index === 0) {
                const representativeLabel = document.createElement("div");
                representativeLabel.classList.add("representative");
                representativeLabel.textContent = "대표이미지";
                fileItem.appendChild(representativeLabel);
            }

            const img = document.createElement("img");
            img.src = src; // 미리보기 이미지 표시
            fileItem.appendChild(img);

            const deleteButton = document.createElement("button");
            deleteButton.classList.add("delete-btn");
            deleteButton.textContent = "×";
            deleteButton.onclick = () => removeFile(index); // x 버튼 클릭 시 호출되는 함수
            fileItem.appendChild(deleteButton);

            fileGrid.appendChild(fileItem);
        });
    }

    function removeFile(index) {
        formData.delete("files"); // FormData에서 모든 파일 삭제
        fileNames.splice(index, 1); // 선택된 파일 이름 삭제
        filePreviews.splice(index, 1); // 미리보기 삭제
        filesArray.splice(index, 1); // 삭제된 파일 객체도 삭제

        // 삭제 후 다시 FormData에 남아있는 파일들 추가
        filesArray.forEach((file) => {
            formData.append("files", file);
        });

        updateFileGrid(); // 화면 갱신
    }
</script>



			<div class="line-group">
				<h3 id="title" style="margin-top: 0px; margin-bottom: 10px;">장소 카테고리를 하나만 선택해 주세요.</h3>
				<div class="category-section">
					<label><input type="radio" name="category" value="1"> 파티룸</label> <label><input type="radio" name="category" value="2"> 연습실</label> <label><input type="radio" name="category" value="3"> 스터디룸</label> <label><input type="radio" name="category" value="4"> 공유주방</label> <label><input type="radio" name="category" value="5"> 스튜디오(촬영 스튜디오)</label> <label><input type="radio" name="category" value="6"> 카페</label> <label><input type="radio" name="category" value="7"> 오피스(코워킹 오피스)</label> <label><input type="radio" name="category" value="8"> 스몰웨딩</label> <label><input type="radio" name="category" value="9"> 운동시설</label> <label><input type="radio" name="category" value="10"> 가정집</label> <label><input type="radio" name="category" value="11"> 실외촬영</label> <label><input type="radio" name="category" value="12"> 당일캠핑</label> <label><input type="radio" name="category" value="13"> 갤러리</label> <label><input
						type="radio" name="category" value="14"
					> 컨퍼런스</label>

				</div>
			</div>

			<div class="line-group">
				<h3 id="title" style="margin-top: 0px; margin-bottom: 10px;">장소 제목을 지어볼까요?</h3>
				<input id="spaceName" type="text" placeholder="장소의 이름을 지어보세요." style="margin: 0px 0px 30px;" />

				<h3 id="title" style="margin-top: 0px; margin-bottom: 10px;">어떤 장소인지 알려주세요.</h3>
				<div id="spaceDesc" style="height: 400px; margin: 0px 0px 30px;"></div>
				<script type="text/javascript">
					var spaceDescQuill = new Quill('#spaceDesc', {
					    theme: 'snow',
					    placeholder: '장소의 분위기가 느껴질 수 있도록 나의 장소를 소개해주세요.',
					    modules: {
					        toolbar: [
					            ['bold', 'italic', 'underline', 'strike'],        // 서식 옵션
					            [{ 'header': 1 }, { 'header': 2 }],              // 헤더 레벨
					            [{ 'list': 'ordered'}, { 'list': 'bullet' }],    // 리스트 옵션
					            [{ 'indent': '-1'}, { 'indent': '+1' }],         // 들여쓰기
					            [{ 'size': ['small', false, 'large', 'huge'] }], // 글자 크기
					            [{ 'align': [] }]                                // 정렬
					        ]
					    }
					});
				</script>

				<h3 id="title" style="margin-top: 0px; margin-bottom: 10px;">장소 이용 팁💡</h3>
				<div id="spaceTip" style="height: 300px; margin: 0px 0px 30px;"></div>
				<script type="text/javascript">
					var spaceTipQuill = new Quill('#spaceTip', {
					    theme: 'snow',
					    placeholder: "장소의 특징이나 위치가 드러나게 한 줄 소개를 지어보세요. 예) 강남구의, 빈티지, 원룸, 베이지톤의, 평범한",
					    modules: {
					        toolbar: [
					            ['bold', 'italic', 'underline', 'strike'],        // 서식 옵션
					            [{ 'header': 1 }, { 'header': 2 }],              // 헤더 레벨
					            [{ 'list': 'ordered'}, { 'list': 'bullet' }],    // 리스트 옵션
					            [{ 'indent': '-1'}, { 'indent': '+1' }],         // 들여쓰기
					            [{ 'size': ['small', false, 'large', 'huge'] }], // 글자 크기
					            [{ 'align': [] }]                                // 정렬
					        ]
					    }
					});
				</script>

				<h3 id="title" style="margin-top: 0px; margin-bottom: 30px;">장소 정보를 더 알려주세요.</h3>

				<label for="parking" style="margin-bottom: 10px;">대여 가능 시간</label>
				<div style="margin-bottom: 30px;">
					<select id="spaceStartTime" style="width: 20%">
						<option value="">공간 오픈 시간</option>
						<option value="00">00시</option>
						<option value="01">01시</option>
						<option value="02">02시</option>
						<option value="03">03시</option>
						<option value="04">04시</option>
						<option value="05">05시</option>
						<option value="06">06시</option>
						<option value="07">07시</option>
						<option value="08">08시</option>
						<option value="09">09시</option>
						<option value="10">10시</option>
						<option value="11">11시</option>
						<option value="12">12시</option>
						<option value="13">13시</option>
						<option value="14">14시</option>
						<option value="15">15시</option>
						<option value="16">16시</option>
						<option value="17">17시</option>
						<option value="18">18시</option>
						<option value="19">19시</option>
						<option value="20">20시</option>
						<option value="21">21시</option>
						<option value="22">22시</option>
						<option value="23">23시</option>
						<option value="24">24시</option>
					</select>
					&nbsp;부터&nbsp;&nbsp;

					<select id="spaceEndTime" style="width: 20%">
						<option value="">공간 클로즈 시간</option>
						<option value="00">00시</option>
						<option value="01">01시</option>
						<option value="02">02시</option>
						<option value="03">03시</option>
						<option value="04">04시</option>
						<option value="05">05시</option>
						<option value="06">06시</option>
						<option value="07">07시</option>
						<option value="08">08시</option>
						<option value="09">09시</option>
						<option value="10">10시</option>
						<option value="11">11시</option>
						<option value="12">12시</option>
						<option value="13">13시</option>
						<option value="14">14시</option>
						<option value="15">15시</option>
						<option value="16">16시</option>
						<option value="17">17시</option>
						<option value="18">18시</option>
						<option value="19">19시</option>
						<option value="20">20시</option>
						<option value="21">21시</option>
						<option value="22">22시</option>
						<option value="23">23시</option>
						<option value="24">24시</option>
					</select>
					&nbsp;까지
				</div>


				<div class="spotgroup">
					<label for="parking" style="margin-bottom: 10px;">주차</label>
					<div>
						<button type="button" class="btn" id="parkingYesBtn" style="margin-right: 5px;">주차 가능</button>
						<button type="button" class="btn" id="parkingNoBtn">주차 안됨</button>
					</div>
					<div id="carCountDiv" class="hidden">
						<label for="spaceParking"></label> <input type="text" id="spaceParking" value="" placeholder="" /> 대
					</div>

					<label for="closeDay" style="margin-bottom: 10px; margin-top: 30px;">휴무일</label>
					<div>
						<button type="button" class="btn" id="closeDay1" style="margin-right: 5px;">없음</button>
						<button type="button" class="btn" id="closeDay2" style="margin-right: 5px;">주말</button>
						<button type="button" class="btn" id="closeDay3" style="margin-right: 5px;">평일</button>
						<button type="button" class="btn" id="closeDay4">호스트 설정</button>
						<div id="hostSettings" style="display: none; margin-top: 10px;">
							<button type="button" class="btn" id="Monday" style="margin-right: 5px;">월요일</button>
							<button type="button" class="btn" id="Tuesday" style="margin-right: 5px;">화요일</button>
							<button type="button" class="btn" id="Wednesday" style="margin-right: 5px;">수요일</button>
							<button type="button" class="btn" id="Thursday" style="margin-right: 5px;">목요일</button>
							<button type="button" class="btn" id="Friday" style="margin-right: 5px;">금요일</button>
							<button type="button" class="btn" id="Saturday" style="margin-right: 5px;">토요일</button>
							<button type="button" class="btn" id="Sunday" style="margin-right: 5px;">일요일</button>
						</div>
						<input id="spaceCloseDay" type="hidden" value=""> <input id="spaceCloseDayHost" type="hidden" value="">
					</div>
				</div>
				<script type="text/javascript">
					$(document).ready(function(){
						$('#closeDay1, #closeDay2, #closeDay3, #closeDay4').click(function() {
							if ($(this).hasClass('selected')) {
				                // 원래대로 배경색을 흰색으로 설정하고 selected 클래스 제거
				                $(this).css('background-color', '#eaeaea');
				                $(this).css('color', 'black');
				                $(this).removeClass('selected');
				                $('#hostSettings').hide();  // 호스트 설정 버튼 클릭 시 숨기기
				                $('#spaceCloseDay').val('');
				                $('#spaceCloseDayHost').val('');
				            } else {// 모든 버튼의 배경색과 텍스트 색을 리셋
				                $('#closeDay1, #closeDay2, #closeDay3, #closeDay4').css('background-color', '#eaeaea');
				                $('#closeDay1, #closeDay2, #closeDay3, #closeDay4').css('color', 'black');
				                
				                // 현재 클릭된 버튼의 배경색을 파란색으로 변경
				                $(this).css('background-color', '#3395E5');
				                $(this).css('color', 'white');
				                
				                // 선택된 버튼에 selected 클래스 추가
				                $('#closeDay1, #closeDay2, #closeDay3, #closeDay4').removeClass('selected'); // 이전에 선택된 버튼에 대한 selected 클래스 제거
				                $(this).addClass('selected');  // 현재 클릭된 버튼에 selected 클래스 추가

				                // 버튼 클릭에 맞는 값을 숨겨진 input에 할당
				                var btnText = $(this).text();  // 버튼의 텍스트 값 가져오기
				                if (btnText == "없음") {
				                    $('#spaceCloseDay').val('1');
				                    $('#spaceCloseDayHost').val('');
				                } else if (btnText == "주말") {
				                    $('#spaceCloseDay').val('2');
				                    $('#spaceCloseDayHost').val('');
				                } else if (btnText == "평일") {
				                    $('#spaceCloseDay').val('3');
				                    $('#spaceCloseDayHost').val('');
				                } else if (btnText == "호스트 설정") {
				                    $('#spaceCloseDay').val('4');
				                    $('#spaceCloseDayHost').val('');
				                    $('#hostSettings').toggle();  // display 상태를 변경 (보이거나 숨기기)
				                }
				            }
							
						});
						
						 // 요일 버튼 클릭 시
				        $('#hostSettings button').click(function() {
				            var selectedDay = $(this).text();
				            var firstLetter = selectedDay.charAt(0); // 첫 글자 추출 (M, T, W, T, F, S, S)

				            var currentDays = $('#spaceCloseDayHost').val(); // 기존에 선택된 요일들

				            // 만약 이미 선택된 요일이 아니면 추가, 이미 있으면 제거
				            if (currentDays.includes(firstLetter)) {
				                // 이미 선택된 요일이면 제거
				                var updatedDays = currentDays.replace(firstLetter, ''); // 해당 요일의 첫 글자 제거
				                $('#spaceCloseDayHost').val(updatedDays); // 업데이트된 요일 값 설정
				                $(this).css('background-color', '#eaeaea'); // 클릭된 요일 배경색 원래대로 돌리기
				                $(this).css('color', 'black'); // 클릭된 요일 배경색 원래대로 돌리기
				            } else {
				                // 선택된 요일이면 추가
				                var updatedDays = currentDays + firstLetter; // 기존값에 첫 글자 추가
				                $('#spaceCloseDayHost').val(updatedDays); // 업데이트된 요일 값 설정
				                $(this).css('background-color', '#3395E5'); // 선택된 요일 배경색 파란색으로 변경
				                $(this).css('color', 'white'); // 클릭된 요일 배경색 원래대로 돌리기
				            }
				        });
					})
				</script>

				<label for="rules" style="margin-bottom: 10px;"> 장소 이용 규칙</label> <span id="spans">중요한 내용을 미리 적어놨어요. 자유롭게 수정하세요!</span>
				<div id="spaceNotice" style="height: 400px;" spellcheck="false"></div>
				<script type="text/javascript">
					var spaceNoticeQuill = new Quill('#spaceNotice', {
					    theme: 'snow',
					    modules: {
					        toolbar: [
					            ['bold', 'italic', 'underline', 'strike'],        // 서식 옵션
					            [{ 'header': 1 }, { 'header': 2 }],              // 헤더 레벨
					            [{ 'list': 'ordered'}, { 'list': 'bullet' }],    // 리스트 옵션
					            [{ 'indent': '-1'}, { 'indent': '+1' }],         // 들여쓰기
					            [{ 'size': ['small', false, 'large', 'huge'] }], // 글자 크기
					            [{ 'align': [] }]                                // 정렬
					        ]
					    }
					});
					spaceNoticeQuill.root.innerHTML = `
					    <h3>[시간 엄수]</h3>
					    <p>계약된 시간을 꼭 준수하여 주시기 바랍니다.</p>
					    <p>이용요금은 [시작 시간] 및 [종료 시간]으로 계약됩니다.</p>
					    <p>촬영 준비 및 세팅, 장비 철수 및 장소 원상복구 시간은 예약 시간에 포함됩니다.</p>
					    <p>계약된 촬영 시간을 초과할 경우 호스트가 추가결제를 요청할 수 있습니다.</p>

					    <h3>[파손 주의]</h3>
					    <p>삼각대, 조명, 철제박스, 각종 의자, 기타 장비로 인한 나무 바닥과 벽지 파손에 꼭 주의하세요.</p>
					    <p>준비물 : 간단한 돗자리나 모포, 테니스공을 준비해 장비 밑에 깔아 주세요.</p>
					    <p>파손 시 : 현장에서 함께 확인 > 사진 촬영 > 견적 확인 후, 배상 요청을 진행하게 됩니다.</p>

					    <h3>[스탭 인원]</h3>
					    <p>설정한 최대 스탭 인원이 지켜지지 않을 경우, 호스트가 촬영을 취소하거나 추가결제를 요청할 수 있습니다.</p>

					    <h3>[취식 금지]</h3>
					    <p>공간에서 취식은 항상 금지되어있습니다. 부득이한 경우 호스트에게 먼저 양해를 꼭 구해주세요.</p>

					    <h3>[에티켓]</h3>
					    <p>주변 주민들을 위해 기본 에티켓을 지켜주세요.</p>
					    <p>주변 야외 촬영은 불가능합니다.</p>
					    <p>촬영 도중 발생한 쓰레기는 모두 정리해주셔야 합니다.</p>
					    <p>주차는 안내된 주차대수만 제공됩니다.</p>
					    <p>기존의 가구 세팅 및 구조를 필요에 의해 변경하신 경우 마감 시간 전에 원상복구 해주셔야 합니다.</p>
					`
				</script>
			</div>

			<div class="line-group">
				<h3>금액을 정해볼까요?</h3>
				<div class="input-group">
					<label for="minReservationTime">최소 예약 시간</label>
					<div class="counter">
						<button type="button" onclick="decrement('minReservationTime')">–</button>
						<input type="text" id="minReservationTime" value="1" readonly>
						<button type="button" onclick="increment('minReservationTime')">+</button>
					</div>
				</div>
				<div class="input-group">
					<label for="maxCapacity">최대 인원</label>
					<div class="counter">
						<button type="button" onclick="decrement('maxCapacity')">–</button>
						<input type="text" id="maxCapacity" value="1" readonly>
						<button type="button" onclick="increment('maxCapacity')">+</button>
					</div>
				</div>

				<h3>시간당 얼마를 받을까요?</h3>
				<label for="hourly-rate">시간당 요금</label> <input id="hourlyRate" type="text" id="hourly-rate" min="0" placeholder="예: 50,000"> 원
			</div>

			<div class="line-group">
				<h3>이제 마지막 단계예요! 결제 방식을 선택해 주세요.</h3>
				현재는 카카오페이 결제만 가능합니다.

				<div class="returnInfo">
	               <p id="return">
	                  <b style="font-size: 18px;">spaceUp 환불 규정</b><br />
	                  호스트 승인 전
	                  • 호스트 승인 전에 예약 취소 시 100% 환불돼요.
	                  
	                  호스트 승인 후 
	                  • 게스트 취소 시 - 결제 후 2시간 이내 또는 사용일 4일 전까지 취소하면 100% 환불돼요.(사용일 3일 전 환불 불가)
	                  • 호스트 귀책 사유 취소 시 - 100% 환불돼요.
	               </p>
	            </div>
			</div>

			<button type="button" class="success" id="btnRegSpace" style="margin: 0px;">등록 완료</button>
		</div>

		<script>
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

        const parkingYesBtn = document.getElementById('parkingYesBtn');
        const parkingNoBtn = document.getElementById('parkingNoBtn');
        const carCountDiv = document.getElementById('carCountDiv');

        parkingYesBtn.addEventListener('click', () => {
        	$("#spaceParking").val("");
            parkingYesBtn.classList.add('active');
            parkingNoBtn.classList.remove('active');
            carCountDiv.classList.remove('hidden');
        });

        parkingNoBtn.addEventListener('click', () => {
        	$("#spaceParking").val("0");
            parkingNoBtn.classList.add('active');
            parkingYesBtn.classList.remove('active');
            carCountDiv.classList.add('hidden');
        });
        
     	// 폼을 제출할 때 파일을 전송하는 이벤트
	    $('#btnRegSpace').on("click", function(){
	    	const spaceAddrDesc = spaceAddrDescQuill.root.innerHTML;
	    	const spaceDesc = spaceDescQuill.root.innerHTML;
	    	const spaceTip = spaceTipQuill.root.innerHTML;
	    	const spaceNotice = spaceNoticeQuill.root.innerHTML;
	    	
	    	// 공간 주소, 값이 비어있는지만 체크
	    	if ($.trim($("#spaceAddr").val()).length <= 0) {
	    	    alert("주소를 입력해주세요.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#spaceAddr").offset().top - 300
	    	    }, 500);
	    	    return;
	    	}
	    	
	    	// 이미지 최소 5개 이상 첨부
	    	const files = $("#fileInput")[0].files;
	    	if (formData.getAll("files").length < 5) {  
	            alert("파일을 최소 5개 이상 첨부해야 합니다.");
	            $('html, body').stop().animate({
	    	        scrollTop: $("#fileInput").offset().top - 300
	    	    }, 500);
	            return;  // 폼 제출을 방지
	        }
				    	

	    	// 공간 카테고리, 값이 비어있는지만 체크
	    	if ($("input:radio[name='category']:checked").length <= 0) {
	    	    alert("공간의 카테고리를 설정해주세요.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("input:radio[name='category']").offset().top - 300
	    	    }, 500);
	    	    return;
	    	}

	    	// 공간 이름, 값이 비어있는지 체크, 최소 6글자, 최대 30글자
	    	let spaceName = $.trim($("#spaceName").val());
	    	if (spaceName.length < 6 || spaceName.length > 30) {
	    	    alert("공간 이름은 6글자 이상 30글자 이하로 입력해주세요.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#spaceName").offset().top - 300
	    	    }, 500);
	    	    $("#spaceName").focus();
	    	    $("#spaceName").val("");
	    	    return;
	    	}

	    	// 공간 소개, 최소 16글자, 최대 2000글자, +7 해줘야함(quill에디터 <p></p>)
	    	if (spaceDesc.replace(/<[^>]+>/g, '').length < 16 || spaceDesc === "<p><br></p>" || spaceDesc.replace(/<[^>]+>/g, '').length > 2000) {
	    	    alert("공간 소개는 16글자 이상 2000글자 이하로 입력해주세요.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#spaceDesc").offset().top - 300
	    	    }, 500);
	    	    spaceDescQuill.setContents([]);
	    	    return;
	    	}
	    	
	    	// 공간 팁, 최소 8글자, 최대 30글자
	    	if (spaceTip.replace(/<[^>]+>/g, '').length < 8 || spaceTip === "<p><br></p>" || spaceTip.replace(/<[^>]+>/g, '').length > 30) {
	    	    alert("공간 팁은 8글자 이상 30글자 이하로 입력해주세요.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#spaceTip").offset().top - 300
	    	    }, 500);
	    	    spaceTipQuill.setContents([]);
	    	    return;
	    	}
	    	
	    	// 공간 오픈 시간, 숫자만 입력 가능, 최소 0, 최대 23
	    	let spaceStartTime = $.trim($("#spaceStartTime").val());
	    	if (!/^\d+$/.test(spaceStartTime) || parseInt(spaceStartTime, 10) < 0 || parseInt(spaceStartTime, 10) > 23) {
	    	    alert("공간 오픈 시간은 0부터 23 사이의 숫자만 입력해주세요.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#spaceStartTime").offset().top - 300
	    	    }, 500);
	    	    return;
	    	}

	    	// 공간 마감 시간, 숫자만 입력 가능, 최소 1, 최대 24, 오픈 시간보다 커야 함
	    	let spaceEndTime = $.trim($("#spaceEndTime").val());
	    	if (!/^\d+$/.test(spaceEndTime) || parseInt(spaceEndTime, 10) < 1 || 
	    			parseInt(spaceEndTime, 10) > 24 || parseInt(spaceEndTime, 10) <= parseInt(spaceStartTime, 10)) {
	    	    alert("공간 마감 시간은 1부터 24 사이의 숫자만 입력 가능하며 오픈 시간보다 커야 합니다.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#spaceEndTime").offset().top - 300
	    	    }, 500);
	    	    return;
	    	}

	    	// 주차 가능 대수, 숫자만 입력, 최대 100
	    	let spaceParking = $.trim($("#spaceParking").val());
	    	if (!/^\d+$/.test(spaceParking) || parseInt(spaceParking, 10) > 100) {
	    	    alert("주차 가능 대수는 숫자만 입력 가능하며 최대 100까지 입력 가능합니다.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#parkingYesBtn").offset().top - 300
	    	    }, 500);
	    	    $("#spaceParking").focus();
	    	    $("#spaceParking").val("");
	    	    return;
	    	}
			
	    	// 휴무요일, 값이 비어있는지만 체크
	    	if ($.trim($("#spaceCloseDay").val()).length <= 0) {
	    	    alert("휴무요일을 선택해주세요.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#closeDay1").offset().top - 300
	    	    }, 500);
	    	    return;
	    	}

	    	// 호스트 설정 휴무 요일, 월화수목금토일로만 구성된 문자열
	    	if ($("#spaceCloseDay").val() == "4") {
		    	let spaceCloseDayHost = $.trim($("#spaceCloseDayHost").val());
		    	if (!/^[월화수목금토일]+$/.test(spaceCloseDayHost)) {
		    	    alert("휴무 요일을 선택해주세요.");
		    	    $('html, body').stop().animate({
		    	        scrollTop: $("#closeDay1").offset().top - 300
		    	    }, 500);
		    	    return;
		    	}
	    	}
	    	
	    	// 공간 유의사항, 최소 30글자, 최대 1000글자
	    	if (spaceNotice.replace(/<[^>]+>/g, '').length < 30 || spaceNotice === "<p><br></p>" || spaceNotice.replace(/<[^>]+>/g, '').length > 1000) {
	    	    alert("공간 유의사항은 30글자 이상 1000글자 이하로 입력해주세요.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#spaceNotice").offset().top - 300
	    	    }, 500);
	    	    return;
	    	}

	    	// 최소 예약시간, 숫자만 입력, 최소 1 이상, 최대 24
	    	let minReservationTime = $.trim($("#minReservationTime").val());
	    	if (!/^\d+$/.test(minReservationTime) || parseInt(minReservationTime, 10) < 1 || parseInt(minReservationTime, 10) > 24) {
	    	    alert("최소 예약시간은 1부터 24 사이의 숫자만 입력 가능합니다.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#minReservationTime").offset().top - 300
	    	    }, 500);
	    	    $("#minReservationTime").focus();
	    	    $("#minReservationTime").val(1);
	    	    return;
	    	}

	    	// 최대 인원 수, 숫자만 입력, 최소 1 이상, 최대 999
	    	let maxCapacity = $.trim($("#maxCapacity").val());
	    	if (!/^\d+$/.test(maxCapacity) || parseInt(maxCapacity, 10) < 1 || parseInt(maxCapacity, 10) > 999) {
	    	    alert("최대 인원 수는 1부터 999 사이의 숫자만 입력 가능합니다.");
	    	    $('html, body').stop().animate({
	    	        scrollTop: $("#maxCapacity").offset().top - 300
	    	    }, 500);
	    	    $("#maxCapacity").focus();
	    	    $("#maxCapacity").val(1);
	    	    return;
	    	}

	    	// 시간 당 대여 금액, 숫자만 입력, 최소 1000 이상, 최대 999,999
	    	let hourlyRate = $.trim($("#hourlyRate").val());
			if (
			    !/^\d+$/.test(hourlyRate) || // 숫자 형식 체크
			    parseInt(hourlyRate, 10) < 1000 || // 최소 값
			    parseInt(hourlyRate, 10) > 999999 || // 최대 값
			    parseInt(hourlyRate, 10) % 1000 !== 0 // 1000원 단위 체크
			) {
			    alert("시간 당 대여 금액은 1,000원 단위로 1,000원 이상 1,000,000 미만으로 입력해주세요.");
			    $('html, body').stop().animate({
			        scrollTop: $("#hourlyRate").offset().top - 300
			    }, 500);
			    $("#hourlyRate").focus();
			    $("#hourlyRate").val("");
			    return;
			}
			
	    	formData.append("spaceAddr", $("#spaceAddr").val());  // 주소
			formData.append("spaceAddrDesc", spaceAddrDesc);  // 주소 상세
			formData.append("spaceType", $("input:radio[name='category']:checked").val());  //공간 카테고리
			formData.append("spaceName", $("#spaceName").val());  // 공간 이름
			formData.append("spaceDesc", spaceDesc);  // 공간 소개
			formData.append("spaceTip", spaceTip);  // 공간 팁
			formData.append("spaceParking", $("#spaceParking").val());  // 주차 가능 대수
			formData.append("spaceNotice", spaceNotice);  // 공간 유의 사항
			formData.append("minReservationTime", $("#minReservationTime").val());  // 최소 예약시간
			formData.append("maxCapacity", $("#maxCapacity").val());  // 최대 인원 수
			formData.append("hourlyRate", $("#hourlyRate").val());  // 시간 당 이용 금액
			formData.append("spaceCloseDay", $("#spaceCloseDay").val());  // 휴무 요일
			formData.append("spaceCloseDayHost", $("#spaceCloseDayHost").val());  // 호스트 설정 휴무 요일
			formData.append("spaceStartTime", $("#spaceStartTime").val());  // 공간 오픈 시간
			formData.append("spaceEndTime", $("#spaceEndTime").val());  // 공간 클로즈 시간
	    	 
	    	$.ajax({
	            url: '/space/regSpaceProc',  // 서버의 파일 처리 경로
	            type: 'POST',
	            data: formData,
	            processData: false,  // jQuery에서 데이터를 자동으로 처리하지 않게 설정
	            contentType: false,  // multipart/form-data 형식으로 보내기 위해 설정
	            success: function(res) {
	            	if(res.code == 1){
	            		location.href="/host/hostSpaceRegFormComplete";
	            	}
	            	else{
	            		alert("공간 등록에 실패하였습니다. 다시 시도해주세요.");
	            	}
	            },
	            error: function(xhr, status, error) {
	                console.error('공간 등록 실패:', error);
	            }
	        });
	    });
    </script>

	</form>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>