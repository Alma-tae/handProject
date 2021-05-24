package com.naver.peekaboo21.model.review.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.naver.peekaboo21.model.review.dto.CommentsDTO;

@Repository
public class CommentsDAOImpl implements CommentsDAO {

	@Inject
	SqlSession sqlSession;

	@Override
	public List<CommentsDTO> list(Integer rno, int start, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("rno", rno);
		return sqlSession.selectList("comments.listComments", map);
	}

	@Override
	public int count(int rno) {
		return sqlSession.selectOne("comments.count", rno);
	}

	@Override
	public void create(CommentsDTO dto) {
		sqlSession.insert("comments.insertComments", dto);
	}

	@Override
	public void update(CommentsDTO dto) {
		sqlSession.update("comments.update", dto);
	}

	@Override
	public void delete(Integer cno) {
		sqlSession.delete("comments.delete", cno);
	}

	@Override
	public CommentsDTO detail(int cno) {
		return sqlSession.selectOne("comments.detail", cno);
	}

}
