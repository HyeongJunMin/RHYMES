package com.rhymes.app.companyadmin.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rhymes.app.admin.payment.model.AdminPaymentParam;
import com.rhymes.app.companyadmin.service.CompanyAdminPaymentService;
import com.rhymes.app.payment.model.PaymentDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin/company/payment")
@Controller
public class CompanyAdminPaymentController {

	@Autowired
	CompanyAdminPaymentService com_admin_paymentService;
	
	@GetMapping("/success")
	public String success(Model model, AdminPaymentParam param, Principal pcp) {
		log.warn("company/success : " + pcp.getName());
		
		//페이징
		// 클릭한 페이지
		int sn = param.getPageNumber();	//0 1 2
		int start = sn * param.getRecordCountPerPage() + 1;	// 1 11 21
		int end = (sn + 1) * param.getRecordCountPerPage(); // 10 20 30
		
		param.setStart(start);
		param.setEnd(end);
		param.setUserid(pcp.getName());
		
		// list
		List<PaymentDTO> orderSuccessList = com_admin_paymentService.getOrderSuccessList(param);
		// list 총 개수
		int totalRecordCount = com_admin_paymentService.getOrderSuccessCount(param);

		// list 총 개수와 클릭한 페이지를 set
		param.setTotalRecordCount(totalRecordCount);
		param.setPageNumber(sn);

		model.addAttribute("orderSuccessList", orderSuccessList);
		model.addAttribute("param", param);		
		
		return "company/success";
	}	
}