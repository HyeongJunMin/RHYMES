package com.rhymes.app.companyadmin.service;

import java.io.Serializable;
import java.util.List;

import com.rhymes.app.companyadmin.model.ProductManageDto;
import com.rhymes.app.member.model.SellerDTO;
import com.rhymes.app.store.model.ProductDto;
import com.rhymes.app.store.model.ProductParam;
import com.rhymes.app.store.model.StockDto;
import com.rhymes.app.store.model.category.Category2Dto;
import com.rhymes.app.store.model.category.Category3Dto;

public interface ProductManageService extends Serializable {

// 1.상품등록
	public List<Category2Dto> getCate2List(int c1_seq) throws Exception;
	public List<Category3Dto> getCate3List(int c1_seq) throws Exception;
	public int getPseq() throws Exception;
	public boolean insertProduct(ProductDto product) throws Exception;
	public boolean insertStock(StockDto stock) throws Exception;
	public String getSizeunit(int c2_seq) throws Exception;
	public SellerDTO getCname(SellerDTO seller) throws Exception;

// 2.상품조회
	public List<ProductDto> getProductList(ProductManageDto pParam) throws Exception;
	//product총갯수
	public int getProductCnt(ProductManageDto pParam) throws Exception;
	//상품 상세조회(stocklist)
	public List<StockDto> getStockList(StockDto stock) throws Exception;
}