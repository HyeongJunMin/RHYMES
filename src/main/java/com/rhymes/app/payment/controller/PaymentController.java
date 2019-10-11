package com.rhymes.app.payment.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rhymes.app.member.model.mypage.MemberCouponDTO;
import com.rhymes.app.payment.model.OrderDTO;
import com.rhymes.app.payment.service.PaymentService;
import com.rhymes.app.payment.util.Coolsms;

@Controller
public class PaymentController {

	@Autowired
	private PaymentService PaymentService;

	// 처음
	@RequestMapping("/daraewelcome")
	public String welcome() {
		System.out.println("daraewelcome");

		return "/payment/welcome";
	}

	// 단일제품 구매
	// @GetMapping("/payment")
	@RequestMapping(value = "/payment", method = { RequestMethod.POST, RequestMethod.GET })
	public String payment(Model model, String stock_seq, String p_quantity) throws Exception {
		System.out.println("daraepayment");

		System.out.println("상품재고 번호 : " + stock_seq);
		System.out.println("상품수량 : " + p_quantity);

		List<OrderDTO> basketList = new ArrayList<OrderDTO>();

		OrderDTO dto = new OrderDTO();
		dto.setStock_seq(Integer.parseInt(stock_seq));
		dto.setQuantity(Integer.parseInt(p_quantity));

		System.out.println("재고번호 : " + stock_seq + ", 수량 :" + p_quantity);

		// db 가져오기
		basketList.add(PaymentService.getOrder(dto));

		model.addAttribute("basketList", basketList);

		if (true) {
			// 로그인 되어있으면 결제 페이지로 이동
			return "/payment/payment";
		} else {
			// 로그인 안되어있으면 로그인창으로 이동
			return "/payment/nomembership";
		}

	}

	// 장바구니 리스트 구매
	@RequestMapping("/payment/basketOrder")
	public String basketOrder(Model model, String blist_stockseq, String blist_pQuantity, Principal pcp) throws Exception {
		System.out.println("================= 여기부터 payment ==================");

		String userid = pcp.getName();
		// 장바구니에서 문자열로 데이터를 가져왔다
		// 예) 신발/청바지/티셔츠			// blist_stockseq : 주문한 상품의 재고번호
		// 예) 100/80/95				// blist_pQuantity : 주문한 상품의 재고수량
		

		
		// 재고번호와 수량을 구분자인 /를 기준으로 배열로 바꿔서 리스트에 넣기
		// 매개변수로 받은 데이터를 /를 구분자로 자르면 데이터의 개수가 나온다
		String[] _sqArr = blist_stockseq.split("/");
		int[] sqArr = Arrays.stream(_sqArr).mapToInt(Integer::parseInt).toArray();
		String[] _pqArr = blist_pQuantity.split("/");
		int[] pqArr = Arrays.stream(_pqArr).mapToInt(Integer::parseInt).toArray();

		List<OrderDTO> bOlist = new ArrayList<OrderDTO>();

		for (int i = 0; i < sqArr.length; i++) {
			OrderDTO order = new OrderDTO();

			order.setStock_seq(sqArr[i]);
			order.setQuantity(pqArr[i]);
			bOlist.add(order);
		}


		
		// 장바구니로 데이터를 가져갈 리스트 생성
		List<OrderDTO> basketList = new ArrayList<OrderDTO>();
		
		// bOlist 리스트의 사이즈만큼 즉, 데이터의 개수만큼 for문을 돌린다
		// 예) 신발/청바지/티셔츠			라면 데이터의 개수는 3이다
		for (int i=0; i<bOlist.size(); i++) {
			OrderDTO dto = new OrderDTO();
			// 데이터를 가져오기 위해서 주문한 상품의 재고번호를 dto에 담고 매개변수로 DB에 보낸다
			dto.setStock_seq(bOlist.get(i).getStock_seq());

			// DB 주문한 상품의 정보 가져오기
			// 장바구니로 데이터를 가져갈 리스트에 넣는다
			basketList.add(PaymentService.getOrder(dto));

			// db로 받을 수 있는 건 재고수량이다
			// 주문수량은 매개변수로만 받을 수 있어서 직접 dto에 넣는다
			basketList.get(i).setQuantity(bOlist.get(i).getQuantity());
		}
		
		
		
		// DB 적립금 가져오기
		int point_amount = PaymentService.getPoint(userid);
		
		// DB 쿠폰 개수 가져오기
		int coupon_count = PaymentService.getCountCoupon(userid);
		

		model.addAttribute("point_amount", point_amount);
		model.addAttribute("coupon_count", coupon_count);
		model.addAttribute("basketList", basketList);

		if (true) {
			// 로그인 되어있으면 결제 페이지로 이동
			return "/payment/payment";
		} else {
			// 로그인 안되어있으면 로그인창으로 이동
			return "/payment/nomembership";
		}

	}

	// 주문페이지에서 결제 후 결제완료창으로 이동
	@RequestMapping("/paymentAf")
	public String paymentAf(Model model) {
		System.out.println("daraepaymentAf");
		
		// 이메일로 결제내역을 보낸다
		
		// 적립금 차감한다
		
		// 사용한 쿠폰을 지운다
		
		// 주문한 상품수량만큼 재고수량에서 차감한다
		
		// db에 결제내역을 저장한다
		
		// 배송내역 저장

		return "/payment/paymentAf";
	}
	
	/** 자바 메일 발송 *
	 * @throws MessagingException
	 * @throws AddressException **/
	@RequestMapping(value = "/mailSender")
	public void mailSender() throws AddressException, MessagingException {
		System.out.println("메일발송 컨트롤러");
		
		// 네이버일 경우 smtp.naver.com 을 입력합니다.
		// Google일 경우 smtp.gmail.com 을 입력합니다.
		String host = "smtp.naver.com";
		
		final String username = "ogbgt5"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요.
		final String password = "nahdl^*^zrb15"; //네이버 이메일 비밀번호를 입력해주세요.
		int port=465; //포트번호
		
		// 메일 내용
		String recipient = "onep577@naver.com";

		//받는 사람의 메일주소를 입력해주세요.
		String subject = "메일테스트"; //메일 제목 입력해주세요.
		String body = username+"님으로 부터 메일을 받았습니다."; //메일 내용 입력해주세요.
		
		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성
		
		// SMTP 서버 정보 설정
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		//Session 생성
		//Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			String un=username;
			String pw=password;
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true); //for debug
		Message mimeMessage = new MimeMessage(session); //MimeMessage 생성
		mimeMessage.setFrom(new InternetAddress("ogbgt5@naver.com")); //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요.
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
		mimeMessage.setSubject(subject); //제목셋팅
		mimeMessage.setText(body); //내용셋팅
		Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
	}

		
	// 주문페이지에서 비회원으로 주문할때 본인인증
	@ResponseBody
	@RequestMapping(value = "/sendsms", method = RequestMethod.GET)
	public String sendSms(HttpServletRequest request) throws Exception {
		System.out.println("본인인증");
		System.out.println("받는번호 : " + (String) request.getParameter("to"));
		System.out.println("인증번호 : " + (String) request.getParameter("text"));

		String api_key = "NCS4ZFTWNHGBIKUM";
		String api_secret = "TPH57XEIXFFDAUXJV3EBNDDS633YNFG2";

		Coolsms coolsms = new Coolsms(api_key, api_secret);

		HashMap<String, String> set = new HashMap<String, String>();

		set.put("to", (String) request.getParameter("to")); // 받는 사람
		set.put("from", "01083256825"); // 발신번호
		set.put("text", "안녕하세요 인증번호는 [" + (String) request.getParameter("text") + "]입니다"); // 문자내용
		set.put("type", "sms"); // 문자 타입

		System.out.println(set);

		JSONObject result = coolsms.send(set); // 보내기&전송결과받기

		if ((boolean) result.get("status") == true) {
			// 메시지 보내기 성공 및 전송결과 출력
			System.out.println("성공");
			System.out.println(result.get("group_id")); // 그룹아이디
			System.out.println(result.get("result_code")); // 결과코드
			System.out.println(result.get("result_message")); // 결과 메시지
			System.out.println(result.get("success_count")); // 메시지아이디
			System.out.println(result.get("error_count")); // 여러개 보낼시 오류난 메시지 수
		} else {
			// 메시지 보내기 실패
			System.out.println("실패");
			System.out.println(result.get("code")); // REST API 에러코드
			System.out.println(result.get("message")); // 에러메시지
		}

		return "success";
	}
	
	// 결제페이지에서 쿠폰 가져오기
	@RequestMapping(value = "/payment_coupon", method = RequestMethod.GET)
	public String payment_coupon(Model model, Principal pcp) {
		System.out.println("쿠폰 컨트롤러");
		String userid = pcp.getName();
		
		// DB 쿠폰 가져오기
		List<MemberCouponDTO> coupon_code = PaymentService.getAllCoupon(userid);

		model.addAttribute("coupon_code", coupon_code);
		
		return "/payment/coupon";
	}

}
