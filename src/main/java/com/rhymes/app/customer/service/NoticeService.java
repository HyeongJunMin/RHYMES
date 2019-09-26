package com.rhymes.app.customer.service;

import java.util.List;

import com.rhymes.app.customer.model.CustomerParam;
import com.rhymes.app.customer.model.NoticeDto;

public interface NoticeService {

	//notice ����Ʈ �������� 
	public List<NoticeDto> getNoticeList(CustomerParam param);
	
	//notice count
	public int getNoticeCount(CustomerParam param);
		
	//readcount ����
	public boolean NoticeUpRead(int seq);
	
	//notice ������ ��������
	public NoticeDto getNoticeDetail(int seq);
	
	//notice upload
	public boolean NoticeUpload(NoticeDto dto);
	
	//notice ����
	public boolean NoticeUpdateAf(NoticeDto dto);

	//notice �����̸� ��������
	public String getfilename(int seq);
	
	//notice ����
	public boolean NoticeDelete(int seq);	
	
}
