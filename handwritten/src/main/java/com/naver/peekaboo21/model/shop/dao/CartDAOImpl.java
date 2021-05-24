package com.naver.peekaboo21.model.shop.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.naver.peekaboo21.model.shop.dto.CartDTO;

@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	SqlSession sqlSession;

	@Override
	public List<CartDTO> cartMoney() {
		return sqlSession.selectList("cart.cart_money");
	}

	@Override
	public List<CartDTO> listCart(String email) {
		return sqlSession.selectList("cart.listCart", email);
	}

	@Override
	public void insert(CartDTO dto) {
		sqlSession.insert("cart.insert", dto);
	}

	@Override
	public void delete(int cart_id) {
		sqlSession.delete("cart.delete", cart_id);
	}

	@Override
	public void deleteAll(String email) {
		sqlSession.delete("cart.deleteAll", email);
	}

	@Override
	public void update(int cart_id) {
	}

	@Override
	public int sumMoney(String email) {
		return sqlSession.selectOne("cart.sumMoney", email);
	}

	@Override
	public int countCart(String email, int product_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("product_id", product_id);
		return sqlSession.selectOne("cart.countCart", map);
	}

	@Override
	public void updateCart(CartDTO dto) {
		sqlSession.update("cart.update", dto);
	}

	@Override
	public void modifyCart(CartDTO dto) {
		sqlSession.update("cart.modify", dto);
	}

}
