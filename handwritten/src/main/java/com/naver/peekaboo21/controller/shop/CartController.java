package com.naver.peekaboo21.controller.shop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.naver.peekaboo21.model.shop.dto.CartDTO;
import com.naver.peekaboo21.service.shop.CartService;

@Controller
@RequestMapping("/shop/cart/*")
public class CartController {

	@Inject
	CartService cartService;

	@RequestMapping("order.do")
	public String order() {
		return "shop/order.page";
	}

	@RequestMapping("delete.do")
	public String delete(@RequestParam int cart_id) {
		cartService.delete(cart_id);
		return "redirect:/shop/cart/list.do";
	}

	@RequestMapping("deleteAll.do")
	public String deleteAll(HttpSession session) {
		String email = (String) session.getAttribute("email");
		if (email != null) {
			cartService.deleteAll(email);
		}
		return "redirect:/shop/cart/list.do";
	}

	@RequestMapping("update.do")
	public String update(@RequestParam int[] amount, @RequestParam int[] cart_id, HttpSession session) {
		String email = (String) session.getAttribute("email");
		for (int i = 0; i < cart_id.length; i++) {
			if (amount[i] == 0) {
				cartService.delete(cart_id[i]);
			} else {
				CartDTO dto = new CartDTO();
				dto.setEmail(email);
				dto.setCart_id(cart_id[i]);
				dto.setAmount(amount[i]);
				cartService.modifyCart(dto);
			}
		}
		return "redirect:/shop/cart/list.do";
	}

	@RequestMapping("list.do")
	public ModelAndView list(HttpSession session, ModelAndView mav) {
		Map<String, Object> map = new HashMap<>();
		String email = (String) session.getAttribute("email");
		if (email != null) {
			List<CartDTO> list = cartService.listCart(email);
			int sumMoney = cartService.sumMoney(email);
			int fee = sumMoney >= 20000 ? 1000 : 2000;
			map.put("sumMoney", sumMoney);
			map.put("fee", fee);
			map.put("sum", sumMoney + fee);
			map.put("list", list);
			map.put("count", list.size());
			mav.setViewName("shop/cart_list.page");
			mav.addObject("map", map);
			return mav;
		} else {
			return new ModelAndView("member/login.page", "", null);
		}
	}

	@RequestMapping("insert.do")
	public String insert(@ModelAttribute CartDTO dto, HttpSession session) {
		String email = (String) session.getAttribute("email");
		if (email != null) {
			dto.setEmail(email);
			cartService.insert(dto); // 장바구니 레코드 추가
		}
		return "redirect:/shop/cart/list.do";
	}
}
