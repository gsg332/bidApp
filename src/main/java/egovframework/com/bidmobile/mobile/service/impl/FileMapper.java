package egovframework.com.bidmobile.mobile.service.impl;

import java.util.HashMap;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("fileMapper")
public interface FileMapper {
	
	public int insert(HashMap map)throws Exception;
	
	public HashMap detail(HashMap map)throws Exception;

}
