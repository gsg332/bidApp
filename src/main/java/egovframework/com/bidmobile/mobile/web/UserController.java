package egovframework.com.bidmobile.mobile.web;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import egovframework.com.bidmobile.mobile.service.CmmnUtilService;
import egovframework.com.bidmobile.mobile.service.MobileWebService;
import egovframework.com.bidmobile.mobile.service.UserService;
import egovframework.com.bidmobile.util.MailUtil;
import egovframework.com.cmm.message.ResultStatus;
import net.sf.json.JSONObject;



@Controller
public class UserController extends CommonController {
	
	@Autowired
	private View jSonView;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="cmmnUtilService")
	private CmmnUtilService cmmnUtilService;
	
	@Resource(name = "mobileWebService")
	private MobileWebService mobileWebService;

	static Logger log = Logger.getLogger(UserController.class.getName());
	
	@RequestMapping(value="/user/login.do", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View login(HttpServletRequest request,Model model, Map<String,Object> data) {
		HttpSession session = request.getSession();
		
		Map  result  = null;
		try {
			
			Map<String, Object> map = new HashMap<String, Object>();
			String login_id="A";
			String RandomPass = "";
			if(null==request.getParameter("epno"))  login_id="A";
			else login_id=request.getParameter("epno");
			
			String pwd;
			if(null==request.getParameter("eppw"))  pwd="A";
			else pwd=request.getParameter("eppw");
			
			
			map.put("user_id",  login_id  );
			map.put("pwd",  pwd  );
			
			result =  userService.get(map);
			
//			userService.update(map);
			
			if(result==null){
		 		model.addAttribute("loginOK", "false");
		 		model.addAttribute("resultCode", ResultStatus.OK.value());
				model.addAttribute("total", 100);
				model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			
		 	} else {
		 		session.setAttribute("loginOK", "true");
				session.setAttribute("loginid", String.valueOf(result.get("business_no")));
				session.setAttribute("loginidnum", result.get(""));
				session.setAttribute("loginidNM", result.get("company_nm"));
				
				HashMap logMap = new HashMap();
				logMap.put("business_no", login_id);
				logMap.put("type", "LOGIN");
				mobileWebService.insertLog(logMap);
				
				model.addAttribute("loginOK", "true");
				model.addAttribute("resultCode", ResultStatus.OK.value());
				model.addAttribute("total", 100);
				model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
				
				model.addAttribute("login_id",String.valueOf(result.get("business_no")) );
				model.addAttribute("login_nm",result.get("company_nm") );
				if(!request.getParameter("epno").equals("108005") && !request.getParameter("epno").equals("107984")){
					/*
					RandomPass = userService.selectRandomPass(map);
					map.put("pwd", RandomPass);
					userService.updatePassword(map);
					session.setAttribute("login_pwd", RandomPass);
					*/
					session.setAttribute("login_pwd", String.valueOf(result.get("pwd")));
				}else{
					session.setAttribute("login_pwd", String.valueOf(result.get("pwd")));
				}
				
		 	}
			
		} catch(Exception e) {
			model.addAttribute("loginOK", "false");
			model.addAttribute("resultCode", ResultStatus.FAIL.value());
			model.addAttribute("resultMessage", ResultStatus.FAIL.getReasonPhrase());
			e.printStackTrace();
		}
		
		return jSonView;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value="/user/sendPassword.do", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View sendPassword(HttpServletRequest request,Model model, Map<String,Object> data) {
		
		Map  result  = null;
		try {
			
			Map<String, Object> map = new HashMap<String, Object>();
			String login_id="A";
			if(null==request.getParameter("epno"))  login_id="A";
			else login_id=request.getParameter("epno");

			
			map.put("user_id",  login_id  );
			
			result =  userService.getEmail(map);
			
//			userService.update(map);
			
			if(result==null){
		 		model.addAttribute("emailOK", "false");
		 		model.addAttribute("resultCode", ResultStatus.OK.value());
				model.addAttribute("total", 100);
				model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			
		 	} else {	
				if(result.get("email").equals("")){
					model.addAttribute("emailOK", "false");
					model.addAttribute("resultCode", ResultStatus.FAIL.value());
					model.addAttribute("resultMessage", ResultStatus.FAIL.getReasonPhrase());
				}else{
					List<HashMap> bidInfo = null;
					String RandomPass = userService.selectRandomPass(map);
					
					MailUtil mu = new MailUtil();
					
					HashMap commandMap = new HashMap();
					commandMap.put("subject","조달관리 시스템 1회용 비밀번호 안내");  //subject
					commandMap.put("msgText","비밀번호 : "+RandomPass);  //message
					commandMap.put("to",result.get("email"));  
					commandMap.put("email","bid@in-con.biz");     
					commandMap.put("emailPw","whekf00!!");     
					commandMap.put("emailHost","smart.whoismail.net");    
					commandMap.put("emailPort","587");   
					
					mu.sendMailLink(commandMap, bidInfo);
					
					map.put("pwd", RandomPass);
					userService.updatePassword(map);
					
					model.addAttribute("emailOK", "true");
					model.addAttribute("email", result.get("email"));
					model.addAttribute("resultCode", ResultStatus.OK.value());
					model.addAttribute("total", 100);
					model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
					
					HashMap logMap = new HashMap();
					logMap.put("business_no", login_id);
					logMap.put("type", "SEND_PASSWORD");
					mobileWebService.insertLog(logMap);
				}
		 	}
		} catch(Exception e) {
			model.addAttribute("emailOK", "false");
			model.addAttribute("resultCode", ResultStatus.FAIL.value());
			model.addAttribute("resultMessage", ResultStatus.FAIL.getReasonPhrase());
			e.printStackTrace();
		}
		
		return jSonView;
	}
	
	@RequestMapping(value="/user/logout.do", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View loginout(HttpServletRequest request,Model model, Map<String,Object> data) throws Exception{
		HttpSession session = request.getSession();
	  	
	 	JSONObject obj = new JSONObject();
		obj.put("loginOK","false");  
		session.setAttribute("loginOK", "false");
	    
		HashMap logMap = new HashMap();
		logMap.put("business_no", session.getAttribute("loginid"));
		logMap.put("type", "LOGOUT");
		mobileWebService.insertLog(logMap);
	
		return jSonView;
	 
	}
	
	@RequestMapping(value="/user/joinForm.do")
	public String joinForm(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap map = this.bind(request);

		List<HashMap> addressList = mobileWebService.selectAddressList(map);
		
		map.put("evalType", "기업규모");
		map.put("evalGroup", "신용평가");
		List<HashMap> bizTypeList = mobileWebService.selectBizTypeList(map);
		
		map.put("evalType", "신용평가");
		List<HashMap> creditEvalList = mobileWebService.selectBizTypeList(map);
		
		model.addAttribute("addressList", addressList);
		model.addAttribute("bizTypeList", bizTypeList);
		model.addAttribute("creditEvalList", creditEvalList);
		
		return "/user/join";
	}
	
	@RequestMapping(value="/user/checkCompanyNo.do")
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View checkCompanyNo(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap map = this.bind(request);

		int existCnt = mobileWebService.checkCompanyNo(map);
		
		model.addAttribute("result", existCnt);
		
		return jSonView;
	}
	
	@RequestMapping(value="/user/bizGoodsInfoListPopup.do")
	public String bizGoodsInfoListPopup(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap map = this.bind(request);
		return "/user/bizGoodsInfoListPopup";
	}
	
	public float getEvalPointInfo(String evalGubun, String amount, String evalGroup, String evalType, String evalNm, String type) throws Exception {

		float point = 0; 
		
		HashMap map = new HashMap();
		map.put("eval_gubun", evalGubun);
		map.put("amount", amount);
		map.put("eval_group", evalGroup);
		map.put("eval_type", evalType);
		map.put("eval_nm", evalNm);
		map.put("type", type);
		if("fromStartDt".equals(type) || "fromFemaleDt".equals(type)){
			map.put("pastYear", evalNm);
		}
		
		HashMap evalInfo = mobileWebService.selectEvalInfo(map);
		
		if(evalInfo != null && evalInfo.get("val") != null){
			point = Float.parseFloat(evalInfo.get("val") + "");
		}
		
		return point;
	}
	
	@Autowired private FileSystemResource fsResource;

	@SuppressWarnings("unchecked")
	@RequestMapping(value="/user/join.do", method=RequestMethod.POST)
	public View join(HttpServletRequest request, HttpServletResponse response, Model model) {

		try {
			HashMap map = this.bind(request);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd", Locale.KOREAN);
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd", Locale.KOREAN);
			
			String businessNo = null;
			String inputScale[] = ((String) map.get("scale")).split("\\^");
			String inputGrade[] = ((String) map.get("credit_cd")).split("\\^");

			if (map != null) {
				map.put("gubun", "A");
				map.put("unuse_yn", "N");
				map.put("scale_cd",inputScale[0]);
				mobileWebService.insertBusiness(map);
				businessNo = map.get("business_no").toString();
				
				map.put("credit_cd", inputGrade[0]);
				
				String startDt = (String) map.get("start_dt");
				String creditDt = (String) map.get("credit_dt");
				String femaleDt = (String) map.get("female_dt");
				String scaleDt = (String) map.get("scale_dt");
				
				startDt = sdf2.format(sdf.parse(startDt)) ;
				map.put("start_dt", startDt);
				creditDt = sdf2.format(sdf.parse(creditDt)) ;
				map.put("credit_dt", creditDt);
				if(!StringUtils.isEmpty(femaleDt)){
					femaleDt = sdf2.format(sdf.parse(femaleDt)) ;
					map.put("female_dt", femaleDt);
				}
				scaleDt = sdf2.format(sdf.parse(scaleDt)) ;
				map.put("scale_dt", scaleDt);
				
				map.put("female_yn", "여성기업".equals(map.get("female_yn"))? "Y" : "N");
				
				mobileWebService.insertBusinessDetail(map);
			}
			String companyType = (String) map.get("bizGubunInfos");
			String[] companyTypeList = companyType.split("\\^");
			for(int i=0; i<companyTypeList.length;i++){
				map.put("company_type_cd", companyTypeList[i]);
				mobileWebService.insertCompanyType(map);	
			}
			String goodsType = (String) map.get("bizGoodsInfos");
			String[] goodsTypeList = goodsType.split("\\^");
			for(int j=0; j<goodsTypeList.length;j++){
				map.put("goods_no", goodsTypeList[j]);
				mobileWebService.insertGoodsType(map);	
			}
			String goodsDirect = (String) map.get("bizGoodsDirects");
			String[] goodsdirectList = goodsDirect.split("\\^");
			for(int i=0; i<goodsdirectList.length;i++){
				String[] goodsDirectItem = goodsdirectList[i].split(":");
				map.put("goods_no", goodsDirectItem[0]);
				map.put("limit_dt", sdf2.format(sdf.parse(goodsDirectItem[1])));
				mobileWebService.insertGoodsDirectType(map);	
			}
			
			float totalPoint = 0;

			String startDt = (String) map.get("start_dt");
			Date startDate = sdf2.parse(startDt);
			Date currDate = new Date();
			long pastTime = currDate.getTime() - startDate.getTime();
			long pastYear = (pastTime / (24 * 60 * 60 * 1000)) / 365;
			String femaleDt = (String) map.get("female_dt");
			Date femaleDate = sdf2.parse(femaleDt);
			long femalePastTime = currDate.getTime() - femaleDate.getTime();
			long femalePastYear = (femalePastTime / (24 * 60 * 60 * 1000)) / 365;
			
			String bizCreditDegrees = (String) map.get("bizCreditDegrees");
			String[] bizCreditDegreeList = bizCreditDegrees.split("\\^");
			
			for(int i=0; i<bizCreditDegreeList.length; i++){
				map.put("cd_nm", bizCreditDegreeList[i]);
				mobileWebService.insertCreditDgreeInfo(map);
			}
			
			HashMap licenseMap = new HashMap();
			
			String[] licenseGubun1 = {"조달청","조달청중소기업", "지방자치단체", "국방", "중기청", "국제"};
			String[] licenseGubun2 = {"고시금액미만","고시금액~10억원"};
			
			for(int i=0; i<licenseGubun1.length; i++){
				for(int y=0; y<licenseGubun2.length; y++){
				
					totalPoint = 0;
					licenseMap.clear();
					
					//신용평가 - 등급접수
					totalPoint += getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "신용평가", "신용평가", inputGrade[1], null);
					//신용평가 - 기업규모
					totalPoint += getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "신용평가", "기업규모", inputScale[1], null);
					//신용평가 - 창업기간
					totalPoint += getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "신용평가", "창업기간", String.valueOf(pastYear), "fromStartDt");
					//신인도
					boolean addInnovateBiz1 = false;
					boolean addInnovateBiz2 = false;
					for(int z=0; z<bizCreditDegreeList.length; z++){
						if("여성기업".equals(bizCreditDegreeList[z])){
							if(i == 2 || i == 4){ //지방자치단체일 경우, 여성기업 연차 상관 없이 여성기업이면 점수부여.
								totalPoint += getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "신인도", "여성기업", "여성기업", null);
							}else{
								totalPoint += getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "신인도", "여성기업", String.valueOf(femalePastYear), "fromFemaleDt");
							}
						}else{
							if((i == 2 || i == 3) && ((bizCreditDegreeList[z].indexOf("혁신형") > -1 && bizCreditDegreeList[z].indexOf("기업") > -1) || "제조기업".equals(bizCreditDegreeList[z]))) { //국방
								if((i == 2 && !addInnovateBiz1) || (i == 3 && !addInnovateBiz2)){
									if(bizCreditDegrees.indexOf("제조기업") > -1 && (bizCreditDegrees.indexOf("혁신형") > -1  && bizCreditDegrees.indexOf("기업") > -1)){
										totalPoint += getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "신인도", "혁신형기업^제조기업", "혁신형기업^제조기업", null);
									}else if(bizCreditDegrees.indexOf("혁신형") > -1 && bizCreditDegrees.indexOf("기업") > -1){
										totalPoint += getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "신인도", "혁신형기업", "혁신형기업", null);
									}
									
									if(i == 2){
										addInnovateBiz1 = true;
									}else if(i == 3){
										addInnovateBiz2 = true;
									}
								}
							}else{
								totalPoint += getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "신인도", bizCreditDegreeList[z], bizCreditDegreeList[z], null);
							}
						}
					}
					totalPoint += getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "신인도", "기업규모", inputScale[1], null);
					totalPoint += getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "가격점수", "가격점수", "가격점수", null);
					
					licenseMap.put("business_no", businessNo);
					
					if (i == 0 && y == 0) {
						licenseMap.put("license_cd", "101");
					}else if(i == 0 && y == 1) {
						licenseMap.put("license_cd", "102");
					}else if(i == 1 && y == 0) {
						licenseMap.put("license_cd", "201");
					}else if(i == 1 && y == 1) {
						licenseMap.put("license_cd", "202");
					}else if(i == 2 && y == 0) {
						licenseMap.put("license_cd", "301");
					}else if(i == 2 && y == 1) {
						licenseMap.put("license_cd", "303");
					}else if(i == 3 && y == 0) {
						licenseMap.put("license_cd", "401");
					}else if(i == 3 && y == 1) {
						licenseMap.put("license_cd", "402");
					}else if(i == 4 && y == 0) {
						licenseMap.put("license_cd", "501");
					}else if(i == 4 && y == 1) {
						licenseMap.put("license_cd", "502");
					}else if(i == 5 && y == 0) {
						licenseMap.put("license_cd", "601");
					}else if(i == 5 && y == 1) {
						licenseMap.put("license_cd", "602");
					}
					
					if(totalPoint >= getEvalPointInfo(licenseGubun1[i], licenseGubun2[y], "적격통과점수", "적격통과점수", "적격통과점수", null)){
						mobileWebService.insertCompanylicense(licenseMap);
					}
				}
			}
            
            /*
            List<HashMap> standardList = mobileWebService.selectBusinessLicenseStandardList(map);
			for(Map standard : standardList){
				String bidType = (String) standard.get("bid_type");
				String amount = (String) standard.get("amount");
				String gradeList = null;
				if(!StringUtils.isEmpty(standard.get("grade"))){
					gradeList = (String) standard.get("grade");
				}
				String companyScaleList = null;
				if(!StringUtils.isEmpty(standard.get("company_scale"))){
					companyScaleList = (String) standard.get("company_scale");
				}
				String fromBizOpenList = null;
				if(!StringUtils.isEmpty(standard.get("from_biz_open"))){
					fromBizOpenList = (String) standard.get("from_biz_open");
				}
				float bidPriceScore = 0;
				if(!StringUtils.isEmpty(standard.get("bid_price_score"))){
					bidPriceScore = Float.parseFloat(standard.get("bid_price_score") + "");
				}
				String creditDegreeList = null;
				if(!StringUtils.isEmpty(standard.get("credit_degree"))){
					creditDegreeList = (String) standard.get("credit_degree");
				}
				float passScore = 0;
				if(!StringUtils.isEmpty(standard.get("pass_score"))){
					passScore = Float.parseFloat(standard.get("pass_score") + "");
				}
				
				float gradeScore = 0;
				if(!StringUtils.isEmpty(gradeList)){
					String cutGrade = gradeList.substring(gradeList.indexOf("^" + inputGrade[1]) + 1);
					if(cutGrade.indexOf("^") > -1){
						cutGrade = cutGrade.substring(0, cutGrade.indexOf("^"));
					}
					gradeScore = Float.parseFloat(cutGrade.split(":")[1]);
				}
				
				String startDt = (String) map.get("start_dt");
				Date startDate = sdf2.parse(startDt);
				Date currDate = new Date();
				long pastTime = currDate.getTime() - startDate.getTime();
				long pastYear = (pastTime / (24 * 60 * 60 * 1000)) / 365;
				float fromBizOpenScore = 0;
				if(!StringUtils.isEmpty(fromBizOpenList)){
					String fromBizOpens[] = fromBizOpenList.split("\\^");
					for(int y=0; y<fromBizOpens.length; y++){
						String fromBizOpen[] = fromBizOpens[y].split("년:");
						String[] yearTerm = fromBizOpen[0].split("~");
						if(Integer.parseInt(yearTerm[0]) <= pastYear && pastYear < Integer.parseInt(yearTerm[1])){
							fromBizOpenScore = Float.parseFloat(fromBizOpen[1]);
						}
					}
				}
				
				float creditDegreeScore = 0;
				if(!StringUtils.isEmpty(creditDegreeList)){
					String bizCreditDegrees = (String) map.get("bizCreditDegrees");
					String[] bizCreditDegreeList = bizCreditDegrees.split("\\^");
					for(int y=0; y<bizCreditDegreeList.length; y++){
						int bizCreditDegreeIndex = creditDegreeList.indexOf("^" + bizCreditDegreeList[y]);
						if(bizCreditDegreeIndex > -1){
							String cutCreditDegree = creditDegreeList.substring(bizCreditDegreeIndex);
							
							if("여성기업".equals(bizCreditDegreeList[y])){
								int lastIndexFemale = cutCreditDegree.lastIndexOf("^여성기업");
								cutCreditDegree = cutCreditDegree.substring(1, lastIndexFemale + cutCreditDegree.substring(lastIndexFemale).indexOf("^", 1));
								String creditDegrees[] = cutCreditDegree.replaceAll("여성기업", "").split("\\^");
								
								float finalFemaleScore = 0;
								if(creditDegrees.length == 1){ // 개업년수는 상관 없고 무조건 여성기업일 경우
									finalFemaleScore = Float.parseFloat(creditDegrees[0].split(":")[1]); 
								}else{ // 개업연수 상관 있고 여성기업일 경우
									for(int z=0; z<creditDegrees.length; z++){
										String creditDegree[] = creditDegrees[z].split("년:");
										String[] yearTerm = creditDegree[0].split("~");
										
										String femaleDt = (String) map.get("female_dt");
										if(!StringUtils.isEmpty(femaleDt)){
											Date femaleDate = sdf2.parse(femaleDt);
											long pastTime2 = currDate.getTime() - femaleDate.getTime(); 
											long pastYear2 = (pastTime2 / (24 * 60 * 60 * 1000)) / 365;
										
											if(yearTerm.length == 1){
												if(pastYear2 < Integer.parseInt(yearTerm[0])){
													finalFemaleScore = Float.parseFloat(creditDegree[1]);
												}
											}else{
												if(Integer.parseInt(yearTerm[0]) <= pastYear2 && pastYear2 < Integer.parseInt(yearTerm[1])){
													finalFemaleScore = Float.parseFloat(creditDegree[1]);
												}
											}
										}
									}
								}
								creditDegreeScore += finalFemaleScore;
							}else{
								int cutCreditDegreeIndex = cutCreditDegree.indexOf("^", 1);
								if(cutCreditDegreeIndex > -1 && cutCreditDegreeIndex != 0){
									cutCreditDegree = cutCreditDegree.substring(1, cutCreditDegreeIndex);
								}
								creditDegreeScore += Float.parseFloat(cutCreditDegree.split(":")[1]);
							}
						}
					}
				}
				
				float scaleScore = 0;
				if(!StringUtils.isEmpty(companyScaleList)){
					String cutScale = companyScaleList.substring(companyScaleList.indexOf(inputScale[1]));
					int cutScaleIndex = cutScale.indexOf("^", 1);
					if(cutScaleIndex > -1 && cutScaleIndex != 0){
						cutScale = cutScale.substring(1, cutScaleIndex);
					}
					scaleScore = Float.parseFloat(cutScale.split(":")[1]); 
				}
				
				int bizCreditDegreeIndex = creditDegreeList.indexOf(inputScale[1]);
				if(bizCreditDegreeIndex > -1){
					String cutCreditDegree = creditDegreeList.substring(bizCreditDegreeIndex);
					int cutCreditDegreeIndex = cutCreditDegree.indexOf("^", 1);
					if(cutCreditDegreeIndex > -1 && cutCreditDegreeIndex != 0){
						cutCreditDegree = cutCreditDegree.substring(1, cutCreditDegreeIndex);
					}
					creditDegreeScore += Float.parseFloat(cutCreditDegree.split(":")[1]);
				}
				
				float totalScore =  gradeScore + fromBizOpenScore + scaleScore + creditDegreeScore + bidPriceScore;

				HashMap licenseMap = new HashMap();
				
				if(totalScore >= passScore){
					licenseMap.put("business_no", businessNo);
					
					if("조달청".equals(bidType)){
						if("고시금액미만".equals(amount)){
							licenseMap.put("license_cd", "101");
						}else if("고시금액~10억원".equals(amount)){
							licenseMap.put("license_cd", "102");
						}
					}else if("조달청중소기업".equals(bidType)){
						if("고시금액미만".equals(amount)){
							licenseMap.put("license_cd", "201");
						}else if("고시금액~10억원".equals(amount)){
							licenseMap.put("license_cd", "202");
						}
					}else if("지방자치단체".equals(bidType)){
						if("고시금액미만".equals(amount)){
							licenseMap.put("license_cd", "301");
						}else if("고시금액~10억원".equals(amount)){
							licenseMap.put("license_cd", "303");
						}
					}else if("국방".equals(bidType)){
						if("고시금액미만".equals(amount)){
							licenseMap.put("license_cd", "401");
						}else if("고시금액~10억원".equals(amount)){
							licenseMap.put("license_cd", "402");
						}
					}else if("중기청".equals(bidType)){
						if("고시금액미만".equals(amount)){
							licenseMap.put("license_cd", "501");
						}else if("고시금액~10억원".equals(amount)){
							licenseMap.put("license_cd", "502");
						}
					}else if("조달청국제".equals(bidType)){
						if("고시금액미만".equals(amount)){
							licenseMap.put("license_cd", "601");
						}else if("고시금액~10억원".equals(amount)){
							licenseMap.put("license_cd", "602");
						}
					}
					
					mobileWebService.insertCompanylicense(licenseMap);
				}
			}*/

			/**
			 * 파일 업로드
			 */
			MultipartHttpServletRequest multiPartReq = (MultipartHttpServletRequest) request;

			List<MultipartFile> fileList = multiPartReq.getFiles("files");

			HashMap fileMap = new HashMap();
			for(int i=0; i<fileList.size(); i++){
				String folderPath = "business/"+businessNo+"/";
				File dir = new File(fsResource.getPath()+folderPath);  // 폴더경로지정
				String realFileName = fileList.get(i).getOriginalFilename(); 
				//fileList.get(i).getOriginalFilename()
				String extFile = realFileName.substring(realFileName.lastIndexOf(".") + 1);
				String fileId = UUID.randomUUID().toString();

				//System.out.println("file length : " + fileList.get(i).getBytes().length);
	            //System.out.println("file name : " + realFileName);
            	
            	if(!dir.isDirectory()){
            		dir.mkdirs();
            	}
            	
            	fileMap.put("file_id", fileId);
            	fileMap.put("org_file_name", realFileName);
            	fileMap.put("file_path", folderPath);
            	fileMap.put("real_file_path", fsResource.getPath() + folderPath + fileId +"."+extFile);
            	fileMap.put("real_file_name", fileId +"."+extFile);
            	fileMap.put("file_size", fileList.get(i).getBytes().length);
            	fileMap.put("file_ext", extFile);
            	
            	cmmnUtilService.upload(fileMap);
            	
                File outFileName = new File(fsResource.getPath() + folderPath + fileId + "." + extFile);

                FileOutputStream fileoutputStream = new FileOutputStream(outFileName);
                fileoutputStream.write(fileList.get(i).getBytes());
                fileoutputStream.close();

	            fileMap.put("file_id" + (i+1), fileId);
			}
			
			fileMap.put("business_no", businessNo);
			mobileWebService.updateCompanyFileList(fileMap);

			model.addAttribute("status", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return jSonView;
	}

	/**
	 * 제조물품 목록 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/goodsInfo.do")
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View goodsInfo(HttpServletRequest request, ModelMap model) throws Exception {
		try {
			HashMap map = this.bind(request);
			
			int page = Integer.parseInt(String.valueOf(map.get("page")));
			int listCnt = Integer.parseInt(String.valueOf(map.get("listCnt")));
			
			map.put("start", (page-1) * listCnt);
			map.put("listCnt", listCnt);

			List<HashMap> goodsInfoList = mobileWebService.selectGoodsInfo(map);

			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			model.addAttribute("goodsInfoList", goodsInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jSonView;
	}
	
	/**
	 * 제조 물품 목록 등록
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/registGoodsInfoList.do")
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View registGoodsInfoList(HttpServletRequest request, ModelMap model) throws Exception {
		try {
			HashMap map = this.bind(request);
			
			int result = mobileWebService.updateBizGoodsInfo(map);

			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			model.addAttribute("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jSonView;
	}
	
	/**
	 * 업종 목록 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/gubunInfo.do")
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View gubunInfo(HttpServletRequest request, ModelMap model) throws Exception {
		try {
			HashMap map = this.bind(request);
			
			int page = Integer.parseInt(String.valueOf(map.get("page")));
			int listCnt = Integer.parseInt(String.valueOf(map.get("listCnt")));
			
			map.put("start", (page-1) * listCnt);
			map.put("listCnt", listCnt);

			List<HashMap> gubunInfoList = mobileWebService.selectGubunInfo(map);

			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			model.addAttribute("gubunInfoList", gubunInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jSonView;
	}
	
	/**
	 * 직접생산물품 목록 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/goodsDirect.do")
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View goodsDirect(HttpServletRequest request, ModelMap model) throws Exception {
		try {
			HashMap map = this.bind(request);
			
			int page = Integer.parseInt(String.valueOf(map.get("page")));
			int listCnt = Integer.parseInt(String.valueOf(map.get("listCnt")));
			
			map.put("start", (page-1) * listCnt);
			map.put("listCnt", listCnt);

			List<HashMap> goodsDirectList = mobileWebService.selectGoodsInfo(map);

			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			model.addAttribute("goodsDirectList", goodsDirectList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jSonView;
	}
	
}
