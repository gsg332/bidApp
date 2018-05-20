package egovframework.com.bidmobile.mobile.service;

import java.util.HashMap;
import java.util.Map;

public interface UserService {
	Map get(Map map) throws Exception;
	
	Map getEmail(Map map) throws Exception;
	
	public void update(Map map)throws Exception;
	
	String selectRandomPass(Map map)throws Exception;
	
	public void updatePassword(Map map)throws Exception;
}
