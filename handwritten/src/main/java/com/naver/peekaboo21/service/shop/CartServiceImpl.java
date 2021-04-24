package com.naver.peekaboo21.service.shop;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.naver.peekaboo21.model.shop.dao.CartDAO;
import com.naver.peekaboo21.model.shop.dto.CartDTO;

@Service
public class CartServiceImpl implements CartService {

	@Inject
	CartDAO cartDao;
	
	@Override
	public List<CartDTO> cartMoney() {
		return cartDao.cartMoney();
	}

	@Override
	public List<CartDTO> listCart(String email) {
		return cartDao.listCart(email);
	}

	@Override
	public void insert(CartDTO dto) {
		cartDao.insert(dto);
	}

	@Override
	public void delete(int cart_id) {
		cartDao.delete(cart_id);
	}

	@Override
	public void deleteAll(String email) {
		cartDao.deleteAll(email);
	}

	@Override
	public void update(int cart_id) {

	}

	@Override
	public int sumMoney(String email) {
		return cartDao.sumMoney(email);
	}

	@Override
	public int countCart(String email, int product_id) {
		return cartDao.countCart(email, product_id);
	}

	@Override
	public void updateCart(CartDTO dto) {
		cartDao.updateCart(dto);
	}

	@Override
	public void modifyCart(CartDTO dto) {
		cartDao.modifyCart(dto);
	}

}
