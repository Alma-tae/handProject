package com.naver.peekaboo21.service.review;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.naver.peekaboo21.model.review.dto.CommentsDTO;

public interface CommentsService {
	public List<CommentsDTO> list(Integer rno, int start, int end, HttpSession session);

	public int count(int rno);

	public void create(CommentsDTO dto);

	public void update(CommentsDTO dto);

	public void delete(Integer cno);

	public CommentsDTO detail(int cno);
}
