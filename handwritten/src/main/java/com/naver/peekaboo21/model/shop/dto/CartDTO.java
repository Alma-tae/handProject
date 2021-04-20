package com.naver.peekaboo21.model.shop.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartDTO {
	private int cart_id;
	private String email;
	private String name;
	private int product_id;
	private String product_name;
	private int price;
	private int money;
	private int amount;
}
