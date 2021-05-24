package com.naver.peekaboo21.service.shop;

import java.util.List;

import com.naver.peekaboo21.model.shop.dto.CartDTO;

public interface CartService {
	public List<CartDTO> cartMoney();

	public List<CartDTO> listCart(String email);

	public void insert(CartDTO dto);

	public void delete(int cart_id);

	public void deleteAll(String email);

	public void update(int cart_id);

	public int sumMoney(String email);

	public int countCart(String email, int product_id);

	public void updateCart(CartDTO dto);

	public void modifyCart(CartDTO dto);
}
