package com.naver.peekaboo21.service.review;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.naver.peekaboo21.model.review.dto.ReviewDTO;

public interface ReviewService {
	public void deleteImages(String image_url);

	public List<String> getImages(int rno);

	public void create(ReviewDTO dto) throws Exception;

	public ReviewDTO read(int rno) throws Exception;

	public void update(ReviewDTO dto) throws Exception;

	public void delete(int rno) throws Exception;

	public List<ReviewDTO> listAll(int start, int end, String search_option, String keyword) throws Exception;

	public void increaseViewcnt(int rno, HttpSession session) throws Exception;

	public int countArticle(String search_option, String keyword) throws Exception;
}
