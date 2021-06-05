package com.naver.peekaboo21.service.member;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.naver.peekaboo21.model.member.dao.MemberDAO;
import com.naver.peekaboo21.model.member.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	MemberDAO memberDao;

	@Override
	public String loginCheck(MemberDTO dto, HttpSession session) {
		String name = memberDao.loginCheck(dto);
		if (name != null) {
			session.setAttribute("email", dto.getEmail());
			session.setAttribute("name", name);
		}
		return name;
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Override
	public void insert(MemberDTO dto) {
		memberDao.insert(dto);
	}

	@Override
	public int emailCheck(MemberDTO dto) throws Exception {
		int result = memberDao.emailCheck(dto);
		return result;
	}

}
