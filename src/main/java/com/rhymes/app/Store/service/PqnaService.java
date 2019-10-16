package com.rhymes.app.Store.service;

import java.util.List;

import com.rhymes.app.Store.model.DetailParam;
import com.rhymes.app.Store.model.PqnaDto;
import com.rhymes.app.customer.model.CustomerParam;

public interface PqnaService{

	//Pqna list가져오기
	public List<PqnaDto> getPqnaList(DetailParam param);
	
	//Pqna count
	public int getPqnaCount(DetailParam param);
	 
	//Pqna 업로드
	public boolean PqnaUpload(PqnaDto dto);
		
	//Pqna 디테일
	public PqnaDto getPqnaDetail(int seq);
	
	//Pqna 수정
	public boolean PqnaUpdateAf(PqnaDto dto);
	
	//Pqna 삭제
	public boolean PqnaDelete(int seq);
	
	//Pqna 답글
	public boolean PqnaAnswer(PqnaDto dto)throws Exception;
}
