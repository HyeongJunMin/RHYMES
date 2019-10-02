package com.rhymes.app.used.ServiceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rhymes.app.member.model.MemberDTO;
import com.rhymes.app.member.model.P_MemberDTO;
import com.rhymes.app.used.Service.UsedService;
import com.rhymes.app.used.dao.UsedDao;
import com.rhymes.app.used.model.CommentsDto;
import com.rhymes.app.used.model.ProductsDto;

@Service
public class UsedServiceImpl implements UsedService {
	@Autowired UsedDao usedDao;

	@Override
	public boolean UsedWrite(ProductsDto dto) {
		// TODO Auto-generated method stub
		return usedDao.UsedWrite(dto);
	}

	@Override
	public List<ProductsDto> getUsedList() {
		// TODO Auto-generated method stub
		return usedDao.getUsedList();
	}

	@Override
	public ProductsDto getUsedDetail(int seq) {
		// TODO Auto-generated method stub
		return usedDao.getUsedDetail(seq);
	}

	@Override
	public int getSellerCount(String parameter) {
		// TODO Auto-generated method stub
		return usedDao.getSellerCount(parameter);
	}

	@Override
	public P_MemberDTO getMemberDto(String userid) {
		// TODO Auto-generated method stub
		return usedDao.getMemberDto(userid);
	}

	@Override
	public boolean setSellerMember(String s_id) {
		// TODO Auto-generated method stub
		return usedDao.setSellerMember(s_id);
	}

	@Override
	public boolean setSellerMember(P_MemberDTO p_MemberDTO) {
		// TODO Auto-generated method stub
		return usedDao.setSellerMember(p_MemberDTO);
	}

	@Override
	public boolean addlikes(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return usedDao.addlikes(map);
	}

	@Override
	public boolean getlikes(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return usedDao.getlikes(map);
	}

	@Override
	public int getboardlikes(int seq) {
		// TODO Auto-generated method stub
		return usedDao.getboardlikes(seq);
	}

	@Override
	public boolean deletelikes(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return usedDao.deletelikes(map);
	}

	@Override
	public List<CommentsDto> getComments(int seq) {
		// TODO Auto-generated method stub
		return usedDao.getComments(seq);
	}
	
	
}
