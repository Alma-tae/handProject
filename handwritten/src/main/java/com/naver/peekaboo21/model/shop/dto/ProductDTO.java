package com.naver.peekaboo21.model.shop.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductDTO {
	private int product_id;
	private String product_name;
	private int price;
	private String description;
	private String picture_url;
	private MultipartFile file1;

}
