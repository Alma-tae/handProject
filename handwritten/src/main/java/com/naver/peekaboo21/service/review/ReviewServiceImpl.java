package com.naver.peekaboo21.service.review;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.peekaboo21.model.review.dao.ReviewDAO;
import com.naver.peekaboo21.model.review.dto.ReviewDTO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	ReviewDAO reviewDao;

	@Transactional
	@Override
	public void create(ReviewDTO dto) throws Exception {
		String title = dto.getTitle();
		String writer = dto.getWriter();
		String content = dto.getContent();
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		writer = writer.replace("<", "&lt;");
		writer = writer.replace(">", "&gt;");
		content = content.replace("<", "&lt;");
		content = content.replace(">", "&gt;");
		title = title.replace("  ", "&nbsp;&nbsp;");
		writer = writer.replace("  ", "&nbsp;&nbsp;");
		content = content.replace("\n", "<br>");
		dto.setContent(content);
		dto.setTitle(title);
		dto.setWriter(writer);
		reviewDao.create(dto); //레코드 저장
		//String[] files=dto.getFiles(); //첨부파일 리스트
		//if(files==null) return; //첨부파일이 없으면 종료
	}

	@Override
	public ReviewDTO read(int rno) throws Exception {
		return reviewDao.read(rno);
	}

	@Transactional
	@Override
	public void update(ReviewDTO dto) throws Exception {
		reviewDao.update(dto);
		//String[] files=dto.getFiles();
		//if(files==null) return;
	}

	@Override
	public void delete(int rno) throws Exception {
		reviewDao.delete(rno);
	}

	@Override
	public List<ReviewDTO> listAll(int start, int end, String search_option, String keyword) throws Exception {
		return reviewDao.listAll(start, end, search_option, keyword);
	}

	@Override
	public void increaseViewcnt(int rno, HttpSession session) throws Exception {
		long update_time=0;
		if(session.getAttribute("update_time_"+rno)!=null) {
			update_time=(long)session.getAttribute("update_time_"+rno);
		}
		long current_time=System.currentTimeMillis();
		if(current_time - update_time > 5*1000) {
			reviewDao.increaseViewcnt(rno);
			session.setAttribute("update_time_"+rno, current_time);
		}
	}

	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		return reviewDao.countArticle(search_option, keyword);
	}

}
