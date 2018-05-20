package egovframework.com.bidmobile.mobile.service.impl;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userInfoMapper")
public interface UserInfoMapper {
	
	public Map get(Map map) throws Exception; //
	
	public Map getEmail(Map map) throws Exception;
	
	public void update(Map map)throws Exception;

	public String selectRandomPass(Map map)throws Exception;

	public void updatePassword(Map map)throws Exception;
}
