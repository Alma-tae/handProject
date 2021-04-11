package com.naver.peekaboo21.service.notice;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.peekaboo21.model.notice.dao.NoticeDAO;
import com.naver.peekaboo21.model.notice.dto.NoticeDTO;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Inject
	NoticeDAO noticeDao;

	@Override
	public void deleteFile(String fullName) {
		noticeDao.deleteFile(fullName);
	}

	@Override
	public List<String> getAttach(int nno) {
		return noticeDao.getAttach(nno);
	}

	@Transactional
	@Override
	public void create(NoticeDTO dto) throws Exception {
		String title = dto.getTitle();
		String writer = dto.getWriter();
		String content = dto.getContent();
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		writer = writer.replace("<", "&lt;");
		writer = writer.replace(">", "&gt;");
		content = content.replace("<", "&lt;");
		content = content.replace(">", "&gt;");
		title = title.replace("  ", "&nbsp;&nbsp;");
		writer = writer.replace("  ", "&nbsp;&nbsp;");
		content = content.replace("\n", "<br>");
		dto.setContent(content);
		dto.setTitle(title);
		dto.setWriter(writer);
		noticeDao.create(dto); //레코드 저장
		String[] files=dto.getFiles(); //첨부파일 리스트
		if(files==null) return; //첨부파일이 없으면 종료
		for(String name : files) {
			noticeDao.addAttach(name); //첨부파일 목록 저장
		}
	}

	@Override
	public NoticeDTO read(int nno) throws Exception {
		return noticeDao.read(nno);
	}

	@Transactional
	@Override
	public void update(NoticeDTO dto) throws Exception {
		noticeDao.update(dto);
		String[] files=dto.getFiles();
		if(files == null) return;
		for(String name : files) {
			noticeDao.updateAttach(name, dto.getNno());
		}
	}

	@Override
	public void delete(int nno) throws Exception {
		noticeDao.delete(nno);
	}

	@Override
	public List<NoticeDTO> listAll(int start, int end, String search_option, String keyword) throws Exception {
		return noticeDao.listAll(start, end, search_option, keyword);
	}

	@Override
	public void increaseViewcnt(int nno, HttpSession session) throws Exception {
		long update_time=0;
		if(session.getAttribute("update_time_"+nno)!=null) {
			update_time=(long)session.getAttribute("update_time_"+nno);
		}
		long current_time = System.currentTimeMillis();
		if(current_time - update_time > 5*1000) {
			noticeDao.increaseViewcnt(nno);
			session.setAttribute("update_time+"+nno, current_time);
		}
	}

	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		return noticeDao.countArticle(search_option, keyword);
	}

}
