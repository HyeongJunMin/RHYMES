package com.rhymes.app.Store.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rhymes.app.Store.dao.PurchaseDao;
import com.rhymes.app.Store.model.BasketDto;
import com.rhymes.app.Store.model.BasketListDto;
import com.rhymes.app.Store.model.ProductDto;
import com.rhymes.app.Store.model.StockDto;
import com.rhymes.app.Store.model.WishlistDto;

@Repository
public class PurchaseDaoImpl implements PurchaseDao {
	
	@Autowired
	SqlSession sqlSession;
	
	String ns = "purchase.";
	
	@Override
	public ProductDto getProductDetail(int p_seq) throws Exception {
		return sqlSession.selectOne(ns + "getProductDetail", p_seq);
	}

	@Override
	public List<StockDto> getSizeList(int p_seq) throws Exception {
		return sqlSession.selectList(ns + "getSizeList", p_seq);
	}

	@Override
	public boolean insertBasket(BasketDto basket) throws Exception {
		int n = sqlSession.insert(ns + "insertBakset", basket);
		return n>0?true:false;
	}

	@Override
	public boolean chkBasket(BasketDto basket) throws Exception {
		int n = sqlSession.selectOne(ns + "chkBasket", basket);
		return n>0?true:false;
	}

	@Override
	public List<BasketListDto> getBasketList(String id) throws Exception {
		return sqlSession.selectList(ns + "getBasketList", id);
	}

	@Override
	public void deleteBasket(int b_seq) throws Exception {
		sqlSession.delete(ns + "deleteBasket", b_seq);
	}

	@Override
	public int updateBaksetQ(BasketDto basket) throws Exception {
		int n = sqlSession.update(ns + "updateBasketQ", basket);
		System.out.println("다오 수정된 수량 : " + basket.getP_quantity());
		System.out.println("다오 수정대상 : " + basket.getStock_seq());
		return n;
	}

	@Override
	public int deleteBasektAll(BasketDto basket) throws Exception {
		int n = sqlSession.delete(ns + "deleteBasketAll", basket);
		return n;
	}

	@Override
	public boolean insertWishlist(WishlistDto wish) throws Exception {
		int n = sqlSession.insert(ns + "insertWishlist", wish);
		return n>0?true:false;
	}

	@Override
	public boolean chkWishlist(WishlistDto wish) throws Exception {
		int n = sqlSession.selectOne(ns + "chkWishlist", wish);
		return n>0?true:false;
	}

	@Override
	public boolean deleteWishlist(WishlistDto wish) throws Exception {
		int n = sqlSession.delete(ns + "deleteWishlist", wish);
		return n>0?true:false;
	}



	
	
	
	
}
