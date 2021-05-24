package com.naver.peekaboo21.controller.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.naver.peekaboo21.model.review.dto.ReviewDTO;
import com.naver.peekaboo21.service.review.CommentsService;
import com.naver.peekaboo21.service.review.Pager;
import com.naver.peekaboo21.service.review.ReviewService;

@Controller
@RequestMapping("/review/*")
public class ReviewController {

	@Inject
	ReviewService reviewService;

	@Inject
	CommentsService commentsService;

	@GetMapping(value = "view.do")
	public ModelAndView view(@RequestParam int rno, @RequestParam int curPage, @RequestParam String search_option,
			@RequestParam String keyword, HttpSession session) throws Exception {
		reviewService.increaseViewcnt(rno, session);

		ReviewDTO dto = reviewService.read(rno);
		String content = dto.getContent();
		content = content.replace("&lt;", "<");
		content = content.replace("&gt;", ">");
		dto.setContent(content);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("review/view.page");
		mav.addObject("dto", dto);
		mav.addObject("curPage", curPage);
		mav.addObject("search_option", search_option);
		mav.addObject("keyword", keyword);

		return mav;
	}

	@RequestMapping("update.do")
	public String update(@ModelAttribute ReviewDTO dto) throws Exception {
		reviewService.update(dto);
		return "redirect:/review/list.do";
	}

	@RequestMapping("delete.do")
	public String delete(@RequestParam int rno) throws Exception {
		reviewService.delete(rno);
		return "redirect:/review/list.do";
	}

	@RequestMapping("getImages/{rno}")
	@ResponseBody
	public List<String> getImages(@PathVariable("rno") int rno) {
		return reviewService.getImages(rno);
	}

	@RequestMapping("list.do")
	public ModelAndView list(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String search_option, @RequestParam(defaultValue = "") String keyword)
			throws Exception {
		int count = reviewService.countArticle(search_option, keyword);
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<ReviewDTO> list = reviewService.listAll(start, end, search_option, keyword);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("review/list.page");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("count", count);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("pager", pager);
		mav.addObject("map", map);
		return mav;
	}

	@RequestMapping(value = "write.do")
	public String write() {
		return "review/write.page";
	}

	@RequestMapping(value = "insert.do")
	public String insert(@ModelAttribute ReviewDTO dto, HttpSession session) throws Exception {
		String writer = (String) session.getAttribute("email");
		dto.setWriter(writer);
		reviewService.create(dto);
		return "redirect:/review/list.do";
	}

	@RequestMapping("edit/{rno}")
	public ModelAndView edit(@PathVariable int rno, ModelAndView mav) throws Exception {
		mav.setViewName("review/edit.page");
		mav.addObject("dto", reviewService.read(rno));
		return mav;
	}

}
