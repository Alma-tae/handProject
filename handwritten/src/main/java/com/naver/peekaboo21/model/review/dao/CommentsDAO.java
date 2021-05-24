package com.naver.peekaboo21.model.review.dao;

import java.util.List;

import com.naver.peekaboo21.model.review.dto.CommentsDTO;

public interface CommentsDAO {
	public List<CommentsDTO> list(Integer rno, int start, int end);

	public int count(int rno);

	public void create(CommentsDTO dto);

	public void update(CommentsDTO dto);

	public void delete(Integer cno);

	public CommentsDTO detail(int cno);
}
