package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Space;

@Repository("spaceDao")
public interface SpaceDao {
    //호스트의 공간 리스트 조회
    public List<Space> spaceList(Space space);
    
    //호스트의 공간 총 갯수
    public int spaceTotalCnt(String hostEmail);
    
    //공간 인서트
    public int insertSpace(Space space);
    
    //인서트 한 공간 ID 조회
    public long getInsertedSpaceId();
    
    //공간 상태 업데이트
    public int spaceStatusUpdate(Space space);
    
    //공간 ID, 호스트 이메일로 공간 조회
    public Space spaceSelectBySpaceIdHostEmail(Space space);
    
    //공간 업데이트
    public int spaceUpdate(Space space);
}
