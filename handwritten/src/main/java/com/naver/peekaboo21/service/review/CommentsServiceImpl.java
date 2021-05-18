package com.naver.peekaboo21.service.review;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.naver.peekaboo21.model.review.dao.CommentsDAO;
import com.naver.peekaboo21.model.review.dto.CommentsDTO;

@Service
public class CommentsServiceImpl implements CommentsService {
	
	@Inject
	CommentsDAO commentsDao;

	@Override
	public List<CommentsDTO> list(Integer rno, int start, int end, HttpSession session) {
		List<CommentsDTO> items = commentsDao.list(rno, start, end);
		//String email = (String) session.getAttribute("email");
		return items;
	}

	@Override
	public int count(int rno) {
		return commentsDao.count(rno);
	}

	@Override
	public void create(CommentsDTO dto) {
		commentsDao.create(dto);
	}

	@Override
	public void update(CommentsDTO dto) {
		commentsDao.update(dto);
	}

	@Override
	public void delete(Integer cno) {
		commentsDao.delete(cno);
	}

	@Override
	public CommentsDTO detail(int cno) {
		return commentsDao.detail(cno);
	}

}
