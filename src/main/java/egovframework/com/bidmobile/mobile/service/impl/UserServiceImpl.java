package egovframework.com.bidmobile.mobile.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.bidmobile.mobile.service.UserService;


@Service("userService")
public class UserServiceImpl implements UserService {

	
	@Resource(name = "userInfoMapper")
	private UserInfoMapper userInfoMapper; 
	
	
	@Override
	public Map get(Map map) throws Exception {
		// TODO Auto-generated method stub
		return userInfoMapper.get(map);
	}
	
	@Override
	public Map getEmail(Map map) throws Exception {
		// TODO Auto-generated method stub
		return userInfoMapper.getEmail(map);
	}
	
	public void update(Map map)throws Exception{
		userInfoMapper.update(map);
	}

	public String selectRandomPass(Map map) throws Exception {
		return userInfoMapper.selectRandomPass(map);
	}
	
	public void updatePassword(Map map)throws Exception{
		userInfoMapper.updatePassword(map);
	}
}
