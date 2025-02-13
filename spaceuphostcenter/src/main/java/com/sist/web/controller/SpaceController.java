package com.sist.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.sist.common.util.StringUtil;
import com.sist.web.model.Paging;
import com.sist.web.model.Response;
import com.sist.web.model.Space;
import com.sist.web.service.SpaceService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("spaceController")
public class SpaceController {
    private static Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;

    @Value("#{env['upload.space.dir']}")
    private String UPLOAD_SPACE_DIR;

    private static final int MYPAGE_LIST_COUNT = 6;
    private static final int MYPAGE_PAGE_COUNT = 5;

    @Autowired
    private SpaceService spaceService;

    // 공간 상태 값 업데이트
    @RequestMapping(value = "/space/statusUpdate", method = RequestMethod.GET)
    @ResponseBody
    public Response<Object> statusUpdate(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> resAjax = new Response<Object>();

	long spaceId = HttpUtil.get(request, "spaceId", (long) -1);
	String status = HttpUtil.get(request, "status");

	if (spaceId != -1 && !StringUtil.isEmpty(status)) {
	    Space space = new Space();

	    space.setSpaceId(spaceId);
	    space.setStatus(status);

	    if (spaceService.spaceStatusUpdate(space) > 0) {
		resAjax.setResponse(1, "업데이트 성공");
	    } else {
		resAjax.setResponse(404, "업데이트 실패");
	    }
	} else {
	    resAjax.setResponse(400, "전달 받은 값이 비어있습니다.");
	}

	return resAjax;
    }

    // 호스트의 공간 리스트 조회
    @RequestMapping(value = "/host/hostMyPage", method = RequestMethod.GET)
    public String spaceList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

	String hostEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	int curPage = HttpUtil.get(request, "curPage", 1);

	List<Space> spaceList = new ArrayList<Space>();
	Paging paging = null;
	Space space = new Space();

	if (!StringUtil.isEmpty(hostEmail)) {
	    space.setHostEmail(hostEmail);
	}

	int totalSpaceCnt = spaceService.spaceTotalCnt(hostEmail);

	if (totalSpaceCnt > 0) {
	    paging = new Paging("/host/hostMypage", totalSpaceCnt, MYPAGE_LIST_COUNT, MYPAGE_PAGE_COUNT, curPage,
		    "curPage");

	    space.setStartRow(paging.getStartRow());
	    space.setEndRow(paging.getEndRow());

	    spaceList = spaceService.spaceList(space);
	}

	model.addAttribute("spaceList", spaceList);
	model.addAttribute("curPage", curPage);
	model.addAttribute("paging", paging);

	return "/host/hostMyPage";
    }

    // 호스트의 공간 등록 페이지 이동
    @RequestMapping(value = "/host/hostSpaceRegForm", method = RequestMethod.GET)
    public String hostSpaceRegForm(HttpServletRequest request, HttpServletResponse response) {
	return "/host/hostSpaceRegForm";
    }

    // 공간등록
    @RequestMapping(value = "/space/regSpaceProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> regSpaceProc(MultipartHttpServletRequest request, HttpServletResponse response) {
	Response<Object> resAjax = new Response<Object>();

	String hostEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	int spaceType = HttpUtil.get(request, "spaceType", -1);
	String spaceName = HttpUtil.get(request, "spaceName", "");
	String spaceDesc = HttpUtil.get(request, "spaceDesc", "");
	String spaceTip = HttpUtil.get(request, "spaceTip", "");
	String spaceParking = HttpUtil.get(request, "spaceParking", "");
	int spaceMaxCapacity = HttpUtil.get(request, "maxCapacity", -1);
	String spaceAddr = HttpUtil.get(request, "spaceAddr", "");
	String spaceAddrDesc = HttpUtil.get(request, "spaceAddrDesc", "");
	int spaceCloseDay = HttpUtil.get(request, "spaceCloseDay", -1);
	String spaceNotice = HttpUtil.get(request, "spaceNotice", "");
	String spaceCloseDayHost = HttpUtil.get(request, "spaceCloseDayHost", "");
	int spaceStartTime = HttpUtil.get(request, "spaceStartTime", -1);
	int spaceEndTime = HttpUtil.get(request, "spaceEndTime", -1);
	int minReservationTime = HttpUtil.get(request, "minReservationTime", -1);
	int hourlyRate = HttpUtil.get(request, "hourlyRate", -1);


	List<MultipartFile> files = request.getFiles("files"); // "files"는 HTML의 파일 input name 속성과 일치해야 합니다.

	Space space = null;

	// 필수 입력 값이 비어있을 때
	if (StringUtil.isEmpty(hostEmail) || spaceType == -1 || StringUtil.isEmpty(spaceName)
		|| StringUtil.isEmpty(spaceDesc) || StringUtil.isEmpty(spaceTip) || StringUtil.isEmpty(spaceParking)
		|| spaceMaxCapacity == -1 || StringUtil.isEmpty(spaceAddr) || spaceCloseDay == -1
		|| StringUtil.isEmpty(spaceNotice) || spaceStartTime == -1 || spaceEndTime == -1
		|| minReservationTime == -1 || hourlyRate == -1) {

	    resAjax.setResponse(-400, "필수 입력 값이 비어있습니다.");
	    // spaceCloseDay가 4일 때, spaceCloseDayHost가 비어있을 경우
	} else if (spaceCloseDay == 4 && StringUtil.isEmpty(spaceCloseDayHost)) {
	    resAjax.setResponse(-401, "호스트 설정 휴무일이 비어있습니다.");
	    // 모든 조건 만족, DB 인서트
	} else {
	    space = new Space();
	    space.setHostEmail(hostEmail); // 호스트 이메일
	    space.setSpaceType(spaceType); // 공간 유형
	    space.setSpaceName(spaceName); // 공간 명
	    space.setSpaceDesc(spaceDesc); // 공간 설명
	    space.setSpaceTip(spaceTip); // 공간 한줄 소개
	    space.setSpaceParking(spaceParking); // 주차 가능 차량 수
	    space.setSpaceMaxCapacity(spaceMaxCapacity); // 공간 최대 인원 수
	    space.setSpaceAddr(spaceAddr); // 공간 주소
	    space.setSpaceAddrDesc(spaceAddrDesc); // 공간 주소 설명 (비어도 상관 없음)
	    space.setSpaceCloseDay(spaceCloseDay); // 공간 휴무일
	    space.setSpaceNotice(spaceNotice); // 공간 유의사항
	    space.setSpaceCloseDayHost(spaceCloseDayHost); // 공간 휴무일 호스트 설정 (spaceCloseDay가 4일때만 필수)
	    space.setSpaceStartTime(spaceStartTime); // 공간 시작 시간
	    space.setSpaceEndTime(spaceEndTime); // 공간 종료 시간
	    space.setMinReservationTime(minReservationTime); // 최소 예약 시간
	    space.setSpaceHourlyRate(hourlyRate); // 시간 당 공간 대여비
	}
	try {
	    spaceService.insertSpaceWithFiles(space, files); // Space 객체와 files를 전달
	    resAjax.setResponse(1, "성공");
	} catch (Exception e) {
	    resAjax.setResponse(0, "업데이트 실패");
	    e.printStackTrace();
	}
	return resAjax;
    }

    // 공간수정
    @RequestMapping(value = "/space/updateSpaceProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> updateSpaceProc(MultipartHttpServletRequest request, HttpServletResponse response) {
	Response<Object> resAjax = new Response<Object>();

	long spaceId = HttpUtil.get(request, "spaceId", (long) -1);
	String hostEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	int spaceType = HttpUtil.get(request, "spaceType", -1);
	String spaceName = HttpUtil.get(request, "spaceName", "");
	String spaceDesc = HttpUtil.get(request, "spaceDesc", "");
	String spaceTip = HttpUtil.get(request, "spaceTip", "");
	String spaceParking = HttpUtil.get(request, "spaceParking", "");
	int spaceMaxCapacity = HttpUtil.get(request, "maxCapacity", -1);
	String spaceAddr = HttpUtil.get(request, "spaceAddr", "");
	String spaceAddrDesc = HttpUtil.get(request, "spaceAddrDesc", "");
	int spaceCloseDay = HttpUtil.get(request, "spaceCloseDay", -1);
	String spaceNotice = HttpUtil.get(request, "spaceNotice", "");
	String spaceCloseDayHost = HttpUtil.get(request, "spaceCloseDayHost", "");
	int spaceStartTime = HttpUtil.get(request, "spaceStartTime", -1);
	int spaceEndTime = HttpUtil.get(request, "spaceEndTime", -1);
	int minReservationTime = HttpUtil.get(request, "minReservationTime", -1);
	int hourlyRate = HttpUtil.get(request, "hourlyRate", -1);

	List<MultipartFile> files = request.getFiles("files");

	// 기존 파일 이름을 리스트로 변환
	String existingFileNamesJson = HttpUtil.get(request, "existingFileNames", "[]");
	List<String> existingFileNames = null;
	ObjectMapper objectMapper = new ObjectMapper();

	try {
	    // TypeReference를 사용하여 명확히 List<String>로 변환
	    existingFileNames = objectMapper.readValue(existingFileNamesJson, new TypeReference<List<String>>() {
	    });
	} catch (Exception e) {
	    resAjax.setResponse(0, "파일 이름 변환 실패");
	    e.printStackTrace();
	    return resAjax;
	}
	
	Space space = null;

	// 필수 입력 값이 비어있을 때
	if (spaceId == -1 || StringUtil.isEmpty(hostEmail) || spaceType == -1 || StringUtil.isEmpty(spaceName)
		|| StringUtil.isEmpty(spaceDesc) || StringUtil.isEmpty(spaceTip) || StringUtil.isEmpty(spaceParking)
		|| spaceMaxCapacity == -1 || StringUtil.isEmpty(spaceAddr) || spaceCloseDay == -1
		|| StringUtil.isEmpty(spaceNotice) || spaceStartTime == -1 || spaceEndTime == -1
		|| minReservationTime == -1 || hourlyRate == -1) {

	    resAjax.setResponse(-400, "필수 입력 값이 비어있습니다.");
	    // spaceCloseDay가 4일 때, spaceCloseDayHost가 비어있을 경우
	} else if (spaceCloseDay == 4 && StringUtil.isEmpty(spaceCloseDayHost)) {
	    resAjax.setResponse(-401, "호스트 설정 휴무일이 비어있습니다.");
	    // 모든 조건 만족, DB 인서트
	} else {
	    space = new Space();
	    space.setSpaceId(spaceId);
	    space.setHostEmail(hostEmail); // 호스트 이메일
	    space.setSpaceType(spaceType); // 공간 유형
	    space.setSpaceName(spaceName); // 공간 명
	    space.setSpaceDesc(spaceDesc); // 공간 설명
	    space.setSpaceTip(spaceTip); // 공간 한줄 소개
	    space.setSpaceParking(spaceParking); // 주차 가능 차량 수
	    space.setSpaceMaxCapacity(spaceMaxCapacity); // 공간 최대 인원 수
	    space.setSpaceAddr(spaceAddr); // 공간 주소
	    space.setSpaceAddrDesc(spaceAddrDesc); // 공간 주소 설명 (비어도 상관 없음)
	    space.setSpaceCloseDay(spaceCloseDay); // 공간 휴무일
	    space.setSpaceNotice(spaceNotice); // 공간 유의사항
	    space.setSpaceCloseDayHost(spaceCloseDayHost); // 공간 휴무일 호스트 설정 (spaceCloseDay가 4일때만 필수)
	    space.setSpaceStartTime(spaceStartTime); // 공간 시작 시간
	    space.setSpaceEndTime(spaceEndTime); // 공간 종료 시간
	    space.setMinReservationTime(minReservationTime); // 최소 예약 시간
	    space.setSpaceHourlyRate(hourlyRate); // 시간 당 공간 대여비
	}

	try {
	    spaceService.updateSpaceWithFiles(space, files, existingFileNames); // Space 객체와 files를 전달
	    resAjax.setResponse(1, "성공");
	} catch (Exception e) {
	    resAjax.setResponse(0, "업데이트 실패");
	    e.printStackTrace();
	}
	return resAjax;
    }

    // 호스트의 공간 등록 완료 페이지 이동
    @RequestMapping(value = "/host/hostSpaceRegFormComplete", method = RequestMethod.GET)
    public String hostSpaceRegFormComplete(HttpServletRequest request, HttpServletResponse response) {
	return "/host/hostSpaceRegFormComplete";
    }

    // 호스트의 공간 수정 페이지 이동
    @RequestMapping(value = "/host/hostSpaceUpdateForm", method = RequestMethod.POST)
    public String spaceUpdateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

	String hostEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long spaceId = HttpUtil.get(request, "spaceId", (long) -1);

	Space search = new Space();
	Space space = null;
	List<String> existingFileNames = null;

	if (spaceId != -1 && !StringUtil.isEmpty(hostEmail)) {
	    search.setHostEmail(hostEmail);
	    search.setSpaceId(spaceId);

	    space = spaceService.spaceSelectBySpaceIdHostEmail(search);
	    existingFileNames = spaceService.getSpaceFileNames(space);
	}

	if (space != null) {
	    model.addAttribute("space", space);
	    model.addAttribute("existingFileNames", new Gson().toJson(existingFileNames));
	    return "/host/hostSpaceUpdateForm";

	} else {
	    model.addAttribute("errorMessage", "존재하지 않는 공간입니다.");
	    return "/host/hostSpaceUpdateForm";
	}
    }
}
