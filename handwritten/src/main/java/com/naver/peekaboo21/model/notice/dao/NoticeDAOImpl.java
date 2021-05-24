package com.naver.peekaboo21.model.notice.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.naver.peekaboo21.model.notice.dto.NoticeDTO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {

	@Inject
	SqlSession sqlSession;

	@Override
	public void deleteFile(String fullName) {
		sqlSession.delete("notice.deleteAttach", fullName);
	}

	@Override
	public List<String> getAttach(int nno) {
		return sqlSession.selectList("notice.getAttach", nno);
	}

	@Override
	public void addAttach(String fullName) {
		sqlSession.insert("notice.addAttach", fullName);
	}

	@Override
	public void updateAttach(String fullName, int nno) {
		Map<String, Object> map = new HashMap<>();
		map.put("fullName", fullName);
		map.put("nno", nno);
		sqlSession.insert("notice.updateAttach", map);
	}

	@Override
	public void create(NoticeDTO dto) throws Exception {
		sqlSession.insert("notice.insert", dto);
	}

	@Override
	public NoticeDTO read(int nno) throws Exception {
		return sqlSession.selectOne("notice.view", nno);
	}

	@Override
	public void update(NoticeDTO dto) throws Exception {
		sqlSession.update("notice.updateArticle", dto);
	}

	@Override
	public void delete(int nno) throws Exception {
		sqlSession.delete("notice.deleteArticle", nno);
	}

	@Override
	public List<NoticeDTO> listAll(int start, int end, String search_option, String keyword) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("notice.listAll", map);
	}

	@Override
	public void increaseViewcnt(int nno) throws Exception {
		sqlSession.update("notice.increaseViewcnt", nno);
	}

	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		return sqlSession.selectOne("notice.countArticle", map);
	}

}
