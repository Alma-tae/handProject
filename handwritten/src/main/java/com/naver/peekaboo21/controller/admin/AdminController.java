package com.naver.peekaboo21.controller.admin;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.naver.peekaboo21.model.member.dto.MemberDTO;
import com.naver.peekaboo21.service.admin.AdminService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

	@Inject
	AdminService adminService;
	
	@RequestMapping("login.do")
	public String login() {
		return "admin/login.page";
	}
	
	@RequestMapping("login_check.do")
	public ModelAndView login_check(MemberDTO dto, HttpSession session, ModelAndView mav) {
		String name=adminService.loginCheck(dto);
		if(name != null) {
			session.setAttribute("admin_email", dto.getEmail());
			session.setAttribute("admin_name", name);
			session.setAttribute("email", dto.getEmail());
			session.setAttribute("name", name);
			mav.setViewName("admin/admin.page");
			mav.addObject("message", "success");
		}else {
			mav.setViewName("admin/login.page");
			mav.addObject("message", "error");
		}
		return mav;
	}
	
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/admin/login.do";
	}
	
	@RequestMapping("page.do")
	public String page() {
		return "admin/admin.page";
	}
}
