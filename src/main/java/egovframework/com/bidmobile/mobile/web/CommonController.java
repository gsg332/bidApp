package egovframework.com.bidmobile.mobile.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;


@Controller
public class CommonController {
	
	public HashMap bind(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException, InstantiationException, ClassNotFoundException, UnsupportedEncodingException {
		HashMap map = new HashMap();
		Enumeration headerNames = request.getParameterNames();

		while (headerNames.hasMoreElements()) {
			String name = (String) headerNames.nextElement();
			String value = request.getParameter(name);
			map.put(name, value);
		}
		if(request.getSession() !=null){
			map.put("user", request.getSession().getAttribute("loginid"));
			map.put("companyNm", request.getSession().getAttribute("loginidNM"));
		}

		return map;
	}
	
	public HashMap bindEncoding(HttpServletRequest request, String encodeStr) throws IllegalArgumentException, IllegalAccessException, InstantiationException, ClassNotFoundException {
		HashMap map = new HashMap();
		Enumeration headerNames = request.getParameterNames();
		try{
			while (headerNames.hasMoreElements()) {
				String name = (String) headerNames.nextElement();
				String value = URLDecoder.decode(request.getParameter(name),encodeStr);
				map.put(name, value);
			}
			if(request.getSession() !=null){
				map.put("user", request.getSession().getAttribute("loginid"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return map;
	}

}
