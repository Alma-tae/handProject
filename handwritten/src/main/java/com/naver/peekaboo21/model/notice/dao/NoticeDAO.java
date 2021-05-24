package com.naver.peekaboo21.model.notice.dao;

import java.util.List;

import com.naver.peekaboo21.model.notice.dto.NoticeDTO;

public interface NoticeDAO {
	public void deleteFile(String fullName);

	public List<String> getAttach(int nno);

	public void addAttach(String fullName);

	public void updateAttach(String fullName, int nno);

	public void create(NoticeDTO dto) throws Exception;

	public NoticeDTO read(int nno) throws Exception;

	public void update(NoticeDTO dto) throws Exception;

	public void delete(int nno) throws Exception;

	public List<NoticeDTO> listAll(int start, int end, String search_option, String keyword) throws Exception;

	public void increaseViewcnt(int nno) throws Exception;

	public int countArticle(String search_option, String keyword) throws Exception;
}
