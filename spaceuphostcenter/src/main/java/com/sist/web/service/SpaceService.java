package com.sist.web.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sist.web.dao.SpaceDao;
import com.sist.web.model.Space;

@Service("spaceService")
public class SpaceService {

    private static Logger logger = LoggerFactory.getLogger(HostService.class);

    @Value("#{env['upload.space.dir']}")
    private String UPLOAD_SPACE_DIR;

    @Autowired
    private SpaceDao spaceDao;

    // 호스트의 공간 리스트 조회
    public List<Space> spaceList(Space space) {
	List<Space> spaceList = null;
	try {
	    spaceList = spaceDao.spaceList(space);
	} catch (Exception e) {
	    logger.error("[spaceService] spaceList Exception", e);
	}
	return spaceList;
    }

    // 호스트의 공간 총 갯수
    public int spaceTotalCnt(String hostEmail) {
	int cnt = 0;
	try {
	    cnt = spaceDao.spaceTotalCnt(hostEmail);
	} catch (Exception e) {
	    logger.error("[spaceService] spaceTotalCnt Exception", e);
	}
	return cnt;
    }

    // 공간 인서트(인서트와 spaceId 조회 트랜잭션)
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void insertSpaceWithFiles(Space space, List<MultipartFile> files) throws Exception {
	int result = spaceDao.insertSpace(space);

	List<String> existingFileNames = null;

	if (result <= 0) {
	    throw new Exception("Space 업데이트 실패");
	} else {
	    // 방금 추가된 space_id 값 조회
	    long insertSpaceSeq = spaceDao.getInsertedSpaceId();
	    space.setSpaceId(insertSpaceSeq);
	}

	// 2. 파일 처리 작업 (파일 저장 및 DB에 파일 정보 삽입)
	if (files != null && !files.isEmpty()) {
	    saveFiles(space, files, existingFileNames); // 파일 저장 메서드
	}
    }

    // 공간 상태 업데이트
    public int spaceStatusUpdate(Space space) {
	int result = 0;
	try {
	    result = spaceDao.spaceStatusUpdate(space);
	} catch (Exception e) {
	    logger.error("[spaceService] spaceStatusUpdate Exception", e);
	}
	return result;
    }

    // 공간 ID와 호스트 이메일으 통한 공간 정보 조회
    public Space spaceSelectBySpaceIdHostEmail(Space search) {
	Space space = null;

	try {
	    space = spaceDao.spaceSelectBySpaceIdHostEmail(search);
	} catch (Exception e) {
	    logger.error("[spaceService] spaceSelectBySpaceIdHostEmail Exception", e);
	}

	return space;
    }

    public List<String> getSpaceFileNames(Space space) {
	// spaceId에 해당하는 디렉토리 경로
	File spaceDir = new File(UPLOAD_SPACE_DIR + "/" + space.getSpaceType() + "/" + space.getSpaceId());

	// 디렉토리가 없으면 빈 리스트 반환
	if (!spaceDir.exists() || !spaceDir.isDirectory()) {
	    return Collections.emptyList();
	}

	// 파일 이름 리스트를 저장할 ArrayList 생성
	List<String> fileNames = new ArrayList<>();

	// 해당 디렉토리의 파일 목록을 가져옴
	File[] files = spaceDir.listFiles();

	// 파일 목록이 null이 아니라면, 각 파일을 하나씩 처리
	if (files != null) {
	    for (File file : files) {
		if (file.isFile()) { // 파일인 경우만 처리
		    fileNames.add(file.getName()); // 파일 이름을 리스트에 추가
		}
	    }
	}

	return fileNames; // 파일 이름 리스트 반환
    }

    // 공간 업데이트
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void updateSpaceWithFiles(Space space, List<MultipartFile> files, List<String> existingFileNames)
	    throws Exception {
	int result = spaceDao.spaceUpdate(space);

	if (result <= 0) {
	    throw new Exception("Space 업데이트 실패");
	}

	saveFiles(space, files, existingFileNames); // 파일 저장 메서드

	// 2. 파일 처리 작업 (파일 저장 및 DB에 파일 정보 삽입)
//	if (files != null && !files.isEmpty()) {
//	    saveFiles(space, files, existingFileNames); // 파일 저장 메서드
//	}
    }

    private void saveFiles(Space space, List<MultipartFile> files, List<String> existingFileNames) throws IOException {
	// 파일 저장 디렉토리 설정
	String fileDir = UPLOAD_SPACE_DIR + "/" + space.getSpaceType() + "/" + space.getSpaceId();
	File dir = new File(fileDir);

	// 저장 디렉토리가 존재하지 않으면 생성
	if (!dir.exists()) {
	    boolean isCreated = dir.mkdirs();
	    if (!isCreated) {
		throw new IOException("디렉토리 생성 실패: " + fileDir);
	    }
	}

	// 저장 폴더
	File[] existingFiles = dir.listFiles();

	// 기존 파일에서 클라이언트에서 삭제된 파일들 삭제
	if (existingFiles != null) {
	    for (File existingFile : existingFiles) {
		// 파일 이름이 existingFileNames에 없으면 삭제
		if (!existingFileNames.contains(existingFile.getName())) {
		    boolean isDeleted = existingFile.delete(); // 기존 파일 삭제
		    if (!isDeleted) {
			// 삭제 실패 시 처리 (로깅 혹은 예외 던지기)
			System.out.println("파일 삭제 실패: " + existingFile.getAbsolutePath());
		    }
		}
	    }
	}

	// 남은 기존 파일들 이름 변경

	int newFileSeq = 1; // 새로운 파일 시퀀스
	for (File existingFile : existingFiles) {
	    // 파일 이름이 existingFileNames에 존재하면 이름 변경
	    if (existingFileNames.contains(existingFile.getName())) {
		// 새 파일 이름 생성
		String newFileName = space.getSpaceId() + "_" + newFileSeq++ + ".jpg";
		File renamedFile = new File(fileDir, newFileName);

		// 파일 이름 변경
		boolean isRenamed = existingFile.renameTo(renamedFile);
		if (isRenamed) {
		    System.out.println(
			    "파일 이름 변경 성공: " + existingFile.getAbsolutePath() + " -> " + renamedFile.getAbsolutePath());
		} else {
		    // 실패 시 로깅 처리
		    System.out.println("파일 이름 변경 실패: " + existingFile.getAbsolutePath());
		}
	    }
	}

	// 새로운 파일들 저장
	int fileSeq = 1;
	for (MultipartFile file : files) {
	    if (!file.isEmpty()) {
		// 저장할 파일 경로 및 이름 생성
		String filePath;
		File destFile;

		// 파일이 이미 존재할 경우 fileSeq 증가
		do {
		    filePath = fileDir + "/" + space.getSpaceId() + "_" + fileSeq + ".jpg";
		    destFile = new File(filePath);
		    fileSeq++;
		} while (destFile.exists()); // 파일이 존재하면 fileSeq를 계속 증가시킴

		// 파일 저장 (예외 처리)
		try {
		    file.transferTo(destFile); // 새 파일 저장
		    System.out.println("파일 저장 성공: " + destFile.getAbsolutePath());
		} catch (IOException e) {
		    e.printStackTrace();
		    throw new IOException("파일 저장 실패: " + filePath, e);
		}
	    }
	}

    }

}
