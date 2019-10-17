package com.rhymes.app.admin.events.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rhymes.app.admin.events.dao.AdminPointsDAO;
import com.rhymes.app.admin.events.model.AdminPointsPagingDTO;
import com.rhymes.app.admin.events.model.PointsDTO;

@Service
public class AdminPointsService {

	@Autowired
	private AdminPointsDAO adminPointsDAO;
	
	/**총 적립금 지급내역 개수
	 * @return
	 */
	public int getTotalCountOfPoints(AdminPointsPagingDTO aPPDto) {
		return adminPointsDAO.getTotalCountOfPoints(aPPDto);
	}
	
	/** 페이징, 검색 조건에 맞는 적립금 내역 리턴
	 * @param aPPDto
	 * @return
	 */
	public List<PointsDTO> getPointsLogByConditions(AdminPointsPagingDTO aPPDto){
		return adminPointsDAO.getPointsLogByConditions(aPPDto);
	}
}
