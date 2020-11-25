package com.kh.bom.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.admin.model.vo.Event;
@Repository
public class AdminDaoImpl implements AdminDao {

	@Override
	public List<Event> selectEvent(SqlSession session) {
		return session.selectList("admin.selectEvent");
	}

}
