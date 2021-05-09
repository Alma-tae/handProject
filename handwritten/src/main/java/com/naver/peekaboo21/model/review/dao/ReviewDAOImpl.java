package com.naver.peekaboo21.model.review.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.naver.peekaboo21.model.review.dto.ReviewDTO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Inject
	SqlSession sqlSession;

	@Override
	public void create(ReviewDTO dto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public ReviewDTO read(int rno) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(ReviewDTO dto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int rno) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public List<ReviewDTO> listAll(int start, int end, String search_option, String keyword) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void increaseViewcnt(int rno) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
