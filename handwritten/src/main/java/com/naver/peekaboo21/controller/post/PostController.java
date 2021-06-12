package com.naver.peekaboo21.controller.post;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.naver.peekaboo21.service.post.PostService;

@Controller
@RequestMapping("/post/*")
public class PostController {
	private String key = "API key";
	
	@Autowired
	private PostService postService;
	
	@RequestMapping("list.do")
	public String data(HttpSession session) {
		session.setAttribute("category", "data");
		
		return "post/list.page";
	}

	@ResponseBody
	@RequestMapping("postOffice")
	public String postoffice() {
		StringBuilder url = new StringBuilder("");
		url.append("?ServiceKey=" + key);
		return "";
	}
}
