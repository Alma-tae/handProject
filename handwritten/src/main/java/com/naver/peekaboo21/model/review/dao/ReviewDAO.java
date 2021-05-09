package com.naver.peekaboo21.model.review.dao;

import java.util.List;

import com.naver.peekaboo21.model.review.dto.ReviewDTO;

public interface ReviewDAO {
	public void create(ReviewDTO dto) throws Exception;
	public ReviewDTO read(int rno) throws Exception;
	public void update(ReviewDTO dto) throws Exception;
	public void delete(int rno) throws Exception;
	public List<ReviewDTO> listAll(int start, int end, String search_option, String keyword) throws Exception;
	public void increaseViewcnt(int rno) throws Exception;
	public int countArticle(String search_option, String keyword) throws Exception;
}
