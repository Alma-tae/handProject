package com.naver.peekaboo21.controller.member;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.naver.peekaboo21.model.member.dto.MemberDTO;
import com.naver.peekaboo21.service.member.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	MemberService memberService;

	@RequestMapping("join.do")
	public String join() {
		return "member/join.page";
	}

	@ResponseBody
	@RequestMapping("emailCheck")
	public int emailCheck(MemberDTO dto) {
		int result = memberService.emailCheck(dto);
		return result;
	}

	@RequestMapping("insert.do")
	public String insert(@ModelAttribute MemberDTO dto) {
		//System.out.println("dto::"+dto);
		memberService.insert(dto);
		return "member/login.page";
	}

	@RequestMapping("login.do")
	public String login() {
		return "member/login.page";
	}

	@RequestMapping("login_check.do")
	public ModelAndView login_check(@ModelAttribute MemberDTO dto, HttpSession session) {
		String name = memberService.loginCheck(dto, session);
		ModelAndView mav = new ModelAndView();
		if (name != null) {
			mav.setViewName("home.page");
		} else {
			mav.setViewName("member/login.page");
			mav.addObject("message", "error");
		}
		return mav;
	}

	@RequestMapping("logout.do")
	public ModelAndView logout(HttpSession session, ModelAndView mav) {
		memberService.logout(session);
		mav.setViewName("member/login.page");
		mav.addObject("message", "logout");
		return mav;
	}

	@RequestMapping("view.do")
	public String view() {
		return "member/view.page";
	}
}
