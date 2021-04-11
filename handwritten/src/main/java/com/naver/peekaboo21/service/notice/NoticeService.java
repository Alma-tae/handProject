package com.naver.peekaboo21.service.notice;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.naver.peekaboo21.model.notice.dto.NoticeDTO;

public interface NoticeService {
	public void deleteFile(String fullName);
	public List<String> getAttach(int nno);
	public void create(NoticeDTO dto) throws Exception;
	public NoticeDTO read(int nno) throws Exception;
	public void update(NoticeDTO dto) throws Exception;
	public void delete(int nno) throws Exception;
	public List<NoticeDTO> listAll(int start, int end, String search_option, String keyword) throws Exception;
	public void increaseViewcnt(int nno, HttpSession session) throws Exception;
	public int countArticle(String search_option, String keyword) throws Exception;
}
