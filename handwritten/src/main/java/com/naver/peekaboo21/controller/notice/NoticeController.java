package com.naver.peekaboo21.controller.notice;

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

import com.naver.peekaboo21.model.notice.dto.NoticeDTO;
import com.naver.peekaboo21.service.notice.Pager;
import com.naver.peekaboo21.service.notice.NoticeService;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {

	@Inject
	NoticeService noticeService;
	
	@GetMapping(value="view.do")
	public ModelAndView view(@RequestParam int nno, @RequestParam int curPage, 
			@RequestParam String search_option, @RequestParam String keyword, 
			HttpSession session) throws Exception{
		noticeService.increaseViewcnt(nno, session);
		
		
		NoticeDTO dto=noticeService.read(nno);
		String content=dto.getContent();
		content=content.replace("&lt;", "<");
		content=content.replace("&gt;", ">");
		dto.setContent(content);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("notice/view.page");
		mav.addObject("dto", dto);
		mav.addObject("curPage", curPage);
		mav.addObject("search_option", search_option);
		mav.addObject("keyword", keyword);
		
		return mav;
	}
	
	@RequestMapping("update.do")
	public String update(@ModelAttribute NoticeDTO dto) throws Exception{ 
		noticeService.update(dto);
		return "redirect:/notice/list.do";
	}
	
	@RequestMapping("delete.do")
	public String delete(@RequestParam int nno) throws Exception{ 
		noticeService.delete(nno);
		return "redirect:/notice/list.do";
	}
	
	@RequestMapping("getAttach/{nno}")
	@ResponseBody 
	public List<String> getAttach(@PathVariable("nno") int nno){
		return noticeService.getAttach(nno);
	}
	
	@RequestMapping("list.do")
	public ModelAndView list(@RequestParam(defaultValue="1") int curPage, 
			@RequestParam(defaultValue="all") String search_option,
			@RequestParam(defaultValue="") String keyword) throws Exception{
		int count=noticeService.countArticle(search_option, keyword); 
		Pager pager = new Pager(count, curPage);
		int start=pager.getPageBegin(); 
		int end=pager.getPageEnd(); 
		List<NoticeDTO> list = noticeService.listAll(start, end, search_option, keyword);
		ModelAndView mav=new ModelAndView();
		mav.setViewName("notice/list.page"); 
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("count", count);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("pager", pager);
		mav.addObject("map", map); 
		return mav; 
	}
	@RequestMapping(value="write.do")
	public String write() {
		return "notice/write.page";
	}
	@RequestMapping(value="insert.do")
	public String insert(@ModelAttribute NoticeDTO dto, HttpSession session) throws Exception{
		String writer = (String)session.getAttribute("email");
		dto.setWriter(writer);
		noticeService.create(dto);
		return "redirect:/notice/list.do";
	}

	@RequestMapping("edit/{nno}")
	public ModelAndView edit(@PathVariable int nno, ModelAndView mav) throws Exception {
		mav.setViewName("notice/edit.page");
		mav.addObject("dto", noticeService.read(nno));
		return mav;
	}
}
