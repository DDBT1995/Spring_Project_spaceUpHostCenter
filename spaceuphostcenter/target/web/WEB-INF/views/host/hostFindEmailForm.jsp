<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/css/host/hostFindEmailForm.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
      
<script>
$(document).ready(function(){
	$("#btnFindEmail").on("click", function() {    	    	    
    	location.href = "/host/hostShowEmailForm";
    });
});

</script>
</head>

<body>
    <div class="titles">
        <h3><span class="highlight">호스트</span> 이메일 찾기</h3>
    </div>

    <div class="find-container">
        <form>
            <div class="form-group">
                <label for="tel">전화번호</label>
                <input type="text" id="hostTel" name="hostTel" value="" placeholder="ex&#41;01011112222" required>
            </div>
        </form>

        <button type="button" id="btnFindEmail" class="btnFindEmail">찾기</button>
    </div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>