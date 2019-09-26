package com.rhymes.app.customer.daoimpl;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rhymes.app.customer.dao.NoticeDao;
import com.rhymes.app.customer.model.CustomerParam;
import com.rhymes.app.customer.model.NoticeDto;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Autowired
	SqlSession sqlSession;
	String ns = "Notice.";
	
	//����Ʈ��������
	@Override
	public List<NoticeDto> getNoticeList(CustomerParam param) {
		
		List<NoticeDto> list = new ArrayList<NoticeDto>();

		list = sqlSession.selectList(ns+"getNoticeList", param);
		
		
		return list;
	}

	
	
	//getcount
	@Override
	public int getNoticeCount(CustomerParam param) {
		
		
		
		return sqlSession.selectOne(ns+"getNoticeCount", param);
	}




	//detail
	@Override
	public NoticeDto getNoticeDetail(int seq) {
		
		return sqlSession.selectOne(ns+"getNoticeDetail", seq);
	}

	
	//readcount ����
	@Override
	public boolean NoticeUpRead(int seq) {
		int n = sqlSession.update(ns + "NoticeUpRead", seq);
		return n>0?true:false;
	}


	//notice �ø���
	@Override
	public boolean NoticeUpload(NoticeDto dto) {
		
		int n = sqlSession.insert(ns+"NoticeUpload", dto);
		
		return n>0?true:false;
	}

	//����
	@Override
	public boolean NoticeUpdateAf(NoticeDto dto) {
		
		int n = sqlSession.update(ns+"NoticeUpdateAf", dto);
		
		return n>0?true:false;
	}

	
	//�����̸� ��������
	@Override
	public String getfilename(int seq) {
	
		return sqlSession.selectOne(ns+"NoticeFilename", seq);
	}


	//����
	@Override
	public boolean NoticeDelete(int seq) {
		int n = sqlSession.delete(ns+"NoticeDelete", seq);
		
		return n>0?true:false;
	}
	
	
	
	
	
}
