package com.naver.peekaboo21.controller.shop;

import java.io.File;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.naver.peekaboo21.model.shop.dto.ProductDTO;
import com.naver.peekaboo21.service.shop.ProductService;

@Controller
@RequestMapping("/shop/product/*")
public class ProductController {

	@Inject
	ProductService productService;

	@RequestMapping("delete.do")
	public String delete(@RequestParam int product_id, HttpServletRequest request) {
		String filename = productService.fileInfo(product_id);
		if (filename != null && !filename.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path = application.getRealPath("/WEB-INF/views/images");
			File f = new File(path + filename);
			if (f.exists()) {
				f.delete();
			}
		}
		productService.deleteProduct(product_id);
		return "redirect:/shop/product/list.do";
	}

	@RequestMapping("write.do")
	public String write() {
		return "shop/product_write.page";
	}

	@RequestMapping("edit/{product_id}")
	public ModelAndView edit(@PathVariable("product_id") int product_id, ModelAndView mav) {
		mav.setViewName("/shop/product_edit.page"); // 편집 페이지
		mav.addObject("dto", productService.detailProduct(product_id));
		return mav;
	}

	@RequestMapping("insert.do")
	public String insert(@ModelAttribute ProductDTO dto, HttpServletRequest request) {
		String filename = "-";
		if (!dto.getFile1().isEmpty()) { // 첨부파일이 존재하면
			filename = dto.getFile1().getOriginalFilename(); // 파일 이름
			try {
				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/WEB-INF/views/images/"); // 배포경로
				new File(path).mkdir(); // 디렉토리 생성
				dto.getFile1().transferTo(new File(path + filename)); // 첨부파일 복사
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		dto.setPicture_url(filename); // 파일 이름 설정
		productService.insertProduct(dto); // 레코드 추가
		return "redirect:/shop/product/list.do";
	}

	@RequestMapping("update.do")
	public String update(@ModelAttribute ProductDTO dto, HttpServletRequest request) {
		String filename = "-";
		if (!dto.getFile1().isEmpty()) { // 첨부파일이 존재하면
			filename = dto.getFile1().getOriginalFilename(); // 파일 이름
			try {
				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/WEB-INF/views/images/");
				System.out.println(path);
				new File(path).mkdir(); // 디렉토리 생성
				// 첨부파일이 저장된 임시 디렉토리에서 배포 디렉토리로 복사
				dto.getFile1().transferTo(new File(path + filename));
			} catch (Exception e) {
				e.printStackTrace();
			}
			dto.setPicture_url(filename);
		} else { // 첨부파일이 없으면 기존 파일 정보 저장
			ProductDTO dto2 = productService.detailProduct(dto.getProduct_id());
			dto.setPicture_url(dto2.getPicture_url());
		}
		productService.updateProduct(dto); // 레코드 수정
		return "redirect:/shop/product/list.do";
	}

	@RequestMapping("list.do") // 세부적인 url pattern
	public ModelAndView list(ModelAndView mav) {
		mav.setViewName("/shop/product_list.page"); // 페이지의 이름
		mav.addObject("list", productService.listProduct()); // 데이터 저장
		return mav; // 출력 페이지로 이동
	}

	@RequestMapping("detail/{product_id}")
	public ModelAndView detail(@PathVariable int product_id, ModelAndView mav) {
		mav.setViewName("/shop/product_detail.page");
		mav.addObject("dto", productService.detailProduct(product_id));
		return mav;
	}
}
