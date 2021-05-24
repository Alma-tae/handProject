package com.naver.peekaboo21.controller.review;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.naver.peekaboo21.model.review.dto.CommentsDTO;
import com.naver.peekaboo21.service.review.CommentsService;
import com.naver.peekaboo21.service.review.Pager;

@RestController
@RequestMapping("/comments/*")
public class CommentsController {
	
	@Inject
	CommentsService commentsService;
	
	@RequestMapping("insert.do") //댓글 저장
	public void insert(@ModelAttribute CommentsDTO dto, HttpSession session) {
		String email = (String)session.getAttribute("email"); //사용자 아이디
		dto.setCommenter(email);
		//System.out.println("con dto:"+dto);
		commentsService.create(dto);
	}
	
	@RequestMapping(value="/delete/{cno}", method=RequestMethod.DELETE)
	public ResponseEntity<String> delete(@PathVariable("cno")int cno){
		ResponseEntity<String> entity=null; 
		try {
			commentsService.delete(cno); //레코드 삭제
			entity=new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//ResponseBody : 객체 -> json
	//RequestBody : json 형식의 데이터를 객체로 변환
	@RequestMapping(value="insert_rest.do", method=RequestMethod.POST)
	public ResponseEntity<String> insert_rest(@RequestBody CommentsDTO dto, HttpSession session){
		ResponseEntity<String> entity=null;
		try {
			String email=(String)session.getAttribute("email");
			dto.setCommenter(email);
			commentsService.create(dto);
			entity=new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);					
		}
		return entity;
	}
	//댓글 내용
	@RequestMapping(value="/detail/{cno}", method=RequestMethod.GET)
	public ModelAndView comments_detail(@PathVariable("cno") int cno, ModelAndView mav) {
		CommentsDTO dto = commentsService.detail(cno);
		System.out.println("detail:"+dto);
		mav.setViewName("review/comments_detail.part"); //페이지의 이름
		mav.addObject("dto", dto);
		return mav;
	}
	//rest uri 방식
	//댓글 리스트, 페이지 나누기 처리
	@RequestMapping(value="/list/{rno}/{curPage}", method=RequestMethod.GET)
	public ModelAndView comments_list(@PathVariable("rno") int rno, @PathVariable int curPage, ModelAndView mav, HttpSession session) {
		int count=commentsService.count(rno);
		Pager pager=new Pager(count, curPage);
		int start=pager.getPageBegin(); //레토드 시작 번호
		int end=pager.getPageEnd();//레코드 끝 번호
		List<CommentsDTO> list=commentsService.list(rno, start, end, session);
		mav.setViewName("review/comments_list.part");
		mav.addObject("list", list);
		mav.addObject("pager", pager);
		return mav;
	}
	@RequestMapping("list.do")
	public ModelAndView list(@RequestParam int rno, @RequestParam(defaultValue="1")int curPage, ModelAndView mav, HttpSession session) {
		int count = commentsService.count(rno);
		Pager pager=new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<CommentsDTO> list = commentsService.list(rno, start, end, session);
		mav.setViewName("review/comments_list.part");
		mav.addObject("list", list);
		mav.addObject("pager", pager);
		return mav;
	}
	//put - 전체 내용 수정, patch - 부분 내용 수정
	@RequestMapping(value="/update/{cno}", method= {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> update(@PathVariable("cno")int cno, @RequestBody CommentsDTO dto){
		ResponseEntity<String> entity=null;
		try {
			dto.setCno(cno);
			commentsService.update(dto);
			entity=new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//RequestBody : 전달된 json 형식의 데이터를 객체로 변환
	@RequestMapping("list_json.do")
	public @ResponseBody List<CommentsDTO> list_json(@RequestParam(defaultValue="1")int curPage,@RequestParam int rno, HttpSession session){
		int count=10;
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<CommentsDTO> list = commentsService.list(rno, start, end, session);
		return list;
 	}

}
