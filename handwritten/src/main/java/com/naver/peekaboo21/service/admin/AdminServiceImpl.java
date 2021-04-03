package com.naver.peekaboo21.service.admin;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.naver.peekaboo21.model.admin.AdminDAO;
import com.naver.peekaboo21.model.member.dto.MemberDTO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Inject
	AdminDAO adminDao;

	@Override
	public String loginCheck(MemberDTO dto) {
		return adminDao.loginCheck(dto);
	}

}
