package com.rhymes.app.member.service;

import java.util.List;

import com.rhymes.app.member.model.MemBean;
import com.rhymes.app.member.model.MemberDTO;
import com.rhymes.app.member.model.MemberParam;
import com.rhymes.app.member.model.P_MemberDTO;
import com.rhymes.app.member.model.SellerBean;
import com.rhymes.app.member.model.SellerCRnumDTO;
import com.rhymes.app.member.model.SellerDTO;

public interface AdminMemberService{
	
	// memlist 페이징
	public List<MemBean> getmemlist(MemberParam param);
	
	// list 총 수
	public int getmemCount(MemberParam param);
	
	
	
	
}
