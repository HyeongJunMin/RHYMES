package com.rhymes.app.Store.service;

import java.util.List;

import com.rhymes.app.Store.model.DetailParam;
import com.rhymes.app.Store.model.PreviewDto;


public interface PreviewService {

	//Preview list가져오기
	public List<PreviewDto> getPreviewList(DetailParam param);
	
	//Preview count
	public int getPreviewCount(DetailParam param);
}
