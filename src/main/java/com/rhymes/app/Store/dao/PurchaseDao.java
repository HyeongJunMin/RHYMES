package com.rhymes.app.Store.dao;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.rhymes.app.Store.model.BasketDto;
import com.rhymes.app.Store.model.BasketListDto;
import com.rhymes.app.Store.model.ProductDto;
import com.rhymes.app.Store.model.StockDto;
import com.rhymes.app.Store.model.WishlistDto;

public interface PurchaseDao extends Serializable {

	// 상품 상세페이지
	public ProductDto getProductDetail(int p_seq) throws Exception;
	// 재고번호별 제품사이즈 가져오기
	public List<StockDto> getSizeList(int p_seq) throws Exception;

	// 장바구니 등록
	public boolean insertBasket(BasketDto basket) throws Exception; 
	// 장바구니 체크
	public boolean chkBasket(BasketDto basket) throws Exception;
	// 장바구니 리스트 불러오기
	public List<BasketListDto> getBasketList(String id) throws Exception;
	// 장바구니 삭제
	public void deleteBasket(int b_seq) throws Exception;
	// 장바구니 수량 업데이트
	public int updateBaksetQ(BasketDto basket)throws Exception;
	// 장바구니 전체삭제
	public int deleteBasektAll(BasketDto basket)throws Exception;
	
	// 위시리스트 등록
	public boolean insertWishlist(WishlistDto wish)throws Exception;
	// 위시리스트 체크
	public boolean chkWishlist(WishlistDto wish)throws Exception;
	// 위시리스트 삭제
	public boolean deleteWishlist(WishlistDto wish)throws Exception;
	
	
}
