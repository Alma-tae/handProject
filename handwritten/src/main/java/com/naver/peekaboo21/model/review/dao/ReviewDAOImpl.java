package com.naver.peekaboo21.model.review.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		sqlSession.insert("review.insert", dto);
	}

	@Override
	public ReviewDTO read(int rno) throws Exception {
		return sqlSession.selectOne("review.view", rno);
	}

	@Override
	public void update(ReviewDTO dto) throws Exception {
		sqlSession.update("review.updateArticle", dto);
	}

	@Override
	public void delete(int rno) throws Exception {
		sqlSession.delete("review.deleteArticle", rno);
	}

	@Override
	public List<ReviewDTO> listAll(int start, int end, String search_option, String keyword) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("review.listAll", map);
	}

	@Override
	public void increaseViewcnt(int rno) throws Exception {
		sqlSession.update("review.increaseViewcnt", rno);
	}

	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		return sqlSession.selectOne("review.countArticle", map);
	}

	@Override
	public void deleteImages(String image_url) {
		sqlSession.delete("review.deleteImages", image_url);
	}

	@Override
	public List<String> getImages(int rno) {
		return sqlSession.selectList("review.getImages", rno);
	}

	@Override
	public void addImages(String image_url) {
		sqlSession.insert("review.addImages", image_url);
	}

	@Override
	public void updateImages(String image_url, int rno) {
		Map<String, Object> map = new HashMap<>();
		map.put("image_url", image_url);
		map.put("rno", rno);
		sqlSession.insert("review.updateImages", map);
	}

}
