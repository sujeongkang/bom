package com.kh.bom.order.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.order.model.service.OrderService;
import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.product.model.vo.Product;

@Controller
@SessionAttributes("loginMember")
public class OrderController {

	@Autowired
	private OrderService service;
	@Autowired
	private AdminService pService;
	@Autowired
	private MemberService mService;

	// 헤더에서 장바구니 화면으로 전환
	@RequestMapping("/order/basket")
	public ModelAndView goBasket(ModelAndView mv, String memNo, HttpSession session) {
		System.out.println(memNo);
		Member login = (Member)mService.selectMemberOne(memNo);
		System.out.println("장바구니 연결 - 회원 : "+login);
		// 회원이 갖고있는 장바구니 불러오기
		List<Basket> list = service.selectBasket(memNo);
		//회원정보 보내주기
		mv.addObject("loginMember", login);
		mv.addObject("list", list);
		mv.setViewName("order/basket");
		return mv;
	}

	// 상품상세페이지에서 장바구니 화면으로 전환
	@RequestMapping("order/productBasket")
	public ModelAndView goBasketWithProduct(ModelAndView mv, String memNo, String pdtNo) {
		// 상품번호랑 갯수 가져와서 insert하기
		// 멤버에 해당하는 장바구니 불러오기
		// 장바구니 안에 담긴 상품 불러오기
		// 각 pdtNo에 해당하는 상품을 출력하기 위한 리스트 가져오기
		List<Product> plist = pService.selectProductList();

		mv.addObject("plist", plist);
		mv.setViewName("order/basket");
		return mv;
	}

	// 장바구니에서 상품 하나 삭제하기
	@RequestMapping("order/deleteBasketOne")
	public ModelAndView deleteBasketOne(ModelAndView m, String pdtNo, String basketNo, String memNo) {
		System.out.println(pdtNo);
		System.out.println(basketNo);
		
		int result = service
				.deleteBasketOne(Basket.builder().pdtNo(pdtNo).basketNo(basketNo).build());
		List<Basket> list = new ArrayList<Basket>();
		// 삭제가 성공하면 삭제된 이후 리스트 넘겨주기
		if (result > 0) {
			System.out.println("삭제성공!");
			list = service.selectBasket(memNo);
			m.addObject("list", list);
			m.setViewName("order/basket");
		}else {
			m.addObject("msg", "서버에러");
			m.addObject("loc","/order/basket");
			m.addObject("icon","error");
			m.setViewName("common/msg");
		}
		return m;
	}

	// 결제화면으로 전환
	@RequestMapping("/order/doOrder")
	public ModelAndView doOrder(ModelAndView mv, Basket b,
			HttpSession session) {
		System.out.println(b);
		Member m = (Member)session.getAttribute("loginMember");
		System.out.println("결제하기 - 회원 : "+m);
		//장바구니 리스트중 회원번호 한개만 뽑아오기
		String[] memNo = b.getMemNo().split(",");
		List<Basket> list = service.selectBasket(memNo[0]);
		mv.addObject("basketNo", b.getBasketNo());
		mv.addObject("loginMember",m);
		mv.addObject("list", list);
		mv.setViewName("order/order");
		return mv;
	}

	// 결제하기
	@RequestMapping("/order/insertOrder")
	public ModelAndView insertOrder(Order order, ModelAndView mv) {
		System.out.println(order);

		// orderNo만들기
		String orderNo = "";
		String today = new SimpleDateFormat("yyyyMMdd").format(new Date());// 등록날짜가져오기
		int ran = (int) (Math.floor(Math.random() * 1000000) + 100000); // 6자리 랜덤숫자
		orderNo = today + "-" + ran;
		order.setOrderNo(orderNo);

		int result = service.insertOrder(order);
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "주문이 완료되었습니다! 금방 배송해 드릴게요!";
			loc = "redirect:/mypage/orderStatus";
			icon = "success";
		} else {
			msg = "결제에 실패했어요ㅠㅠ";
			loc = "/";
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");

		return mv;
	}

}
