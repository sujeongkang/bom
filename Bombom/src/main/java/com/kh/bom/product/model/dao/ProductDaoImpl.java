package com.kh.bom.product.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.review.model.vo.Review;

@Repository
public class ProductDaoImpl implements ProductDao {
	
	@Override
	public Product selectProductOne(SqlSession session, String pdtNo) {
		return session.selectOne("product.selectProductOne",pdtNo);
	}
	
	@Override
	public List<ProductOption> selectpdtOption(SqlSession session, String pdtNo) {
		return session.selectList("product.selectpdtOption", pdtNo);
	}

	@Override
	public List<Inquiry> inquiryList(SqlSession session, String pdtNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("inquiry.inquiryList",pdtNo,new RowBounds((cPage-1)*numPerpage,numPerpage));
	}

	@Override
	public int inquiryCount(SqlSession session, String pdtNo) {
		return session.selectOne("inquiry.inquiryCount",pdtNo);
	}
	
	@Override
	public List<Review> reviewList(SqlSession session, String pdtNo, int cPage, int numPerpage) {
		return session.selectList("review.reviewList",pdtNo,new RowBounds((cPage-1)*numPerpage,numPerpage));
	}

	@Override
	public int reviewCount(SqlSession session, String pdtNo) {
		return session.selectOne("review.reviewCount",pdtNo);
	}
	
	@Override
	public String reviewAvg(SqlSession session, String pdtNo) {
		return session.selectOne("review.reviewAvg", pdtNo);
	}

	@Override
	public Product selectproductDate(SqlSession session, String pdtNo) {
		return session.selectOne("product.selectproductDate", pdtNo);
	}
	
	@Override
	public List<Product> slidelist(SqlSession session) {
		return session.selectList("product.slidelist");
	}

	@Override
	public int productCount(SqlSession session, String category,String soldout) {
		Map<String,String> map=new HashMap();
		map.put("category", category);
		map.put("soldout",soldout);
		return session.selectOne("product.count",map);
	}
	@Override
	public int countSale(SqlSession session,String soldout) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap();
		map.put("soldout",soldout);
		return session.selectOne("product.countSale",map);
	}
	@Override
	public List<Product> selectProductList(SqlSession session,int cPage,int numPerPage,String sort,String soldout,String category) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap();
		map.put("sort", sort);
		map.put("category", category);
		map.put("soldout",soldout);
		return session.selectList("product.productList",map,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}
	@Override
	public List<Product> selectNewCateList(SqlSession session,String category) {
		// TODO Auto-generated method stub
		Map<String,String> map=new HashMap();
		map.put("category", category);
		return session.selectList("product.newCateList",map);
	}
	@Override
	public List<Product> selectSaleList(SqlSession session, int cPage, int numPerPage, String sort, String soldout,String category) {
		// TODO Auto-generated method stub
		Map<String,String> map=new HashMap();
		map.put("sort", sort);
		map.put("soldout", soldout);
		return session.selectList("product.saleList",map);
	}






}
