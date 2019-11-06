package com.rhymes.app.companyadmin.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rhymes.app.admin.payment.model.AdminPaymentDetailDTO;
import com.rhymes.app.admin.payment.model.AdminPaymentParam;
import com.rhymes.app.companyadmin.dao.CompanyAdminPaymentDAO;
import com.rhymes.app.companyadmin.model.AdminPaymentVbankDTO;
import com.rhymes.app.payment.model.DeliveryDTO;
import com.rhymes.app.payment.model.PaymentDTO;

@Repository
public class CompanyAdminPaymentDAOImpl implements CompanyAdminPaymentDAO {

	@Autowired
	SqlSession SqlSession;
	String ns = "adminCompanyPayment.";
	
	// 주문내역
	@Override
	public List<PaymentDTO> getOrderSuccessList(AdminPaymentParam param) {
		return SqlSession.selectList(ns + "getOrderSuccessList", param);
	}

	// 주문내역 총 개수
	@Override
	public List<PaymentDTO> getOrderSuccessCount(AdminPaymentParam param) {
		return SqlSession.selectList(ns + "getOrderSuccessCount", param);
	}

	// 마켓명
	@Override
	public String getMarketName(String userid) {
		return SqlSession.selectOne(ns + "getMarketName", userid);
	}

	// 내 업체만 주문상세내역 조회
	@Override
	public List<AdminPaymentDetailDTO> getOrderDetail(PaymentDTO dto) {
		return SqlSession.selectList(ns + "getOrderDetail", dto);
	}

	// 업체별 무통장입금 관리
	@Override
	public List<AdminPaymentVbankDTO> getVbankList(String userid) {
		return SqlSession.selectList(ns + "getVbankList", userid);
	}

	// 결제완료로 변경
	@Override
	public boolean paymentfinish(String seq) {
		int b = SqlSession.update(ns + "paymentfinish", seq);
		return b>0?true:false;
	}

	// 배송관리
	@Override
	public List<DeliveryDTO> getDeliveryList(String userid) {
		return SqlSession.selectList(ns + "getDeliveryList", userid);
	}

	// 배송준비 중 -> 배송 중
	@Override
	public boolean getDeliveryIng(DeliveryDTO dto) {
		int b = SqlSession.update(ns + "getDeliveryIng", dto);
		return b>0?true:false;
	}
	
	// 배송중 -> 배송완료
	@Override
	public boolean getDeliveryFinish(DeliveryDTO dto) {
		int b = SqlSession.update(ns + "getDeliveryFinish", dto);
		int b1 = SqlSession.insert(ns + "getDeliveryFinishEdate", dto);
		
		if(b > 0 && b1 > 0) {
			return true;
		}
		return false;
	}

	// 추가 적립금 저장
	@Override
	public boolean add_point(PaymentDTO dto) {
		int b = SqlSession.insert(ns + "add_point", dto);
		return b>0?true:false;
	}

}
