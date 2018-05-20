package egovframework.com.bidmobile.mobile.service.impl;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import egovframework.com.bidmobile.mobile.service.MobileWebService;
import egovframework.com.bidmobile.util.MailUtil;


@Service("mobileWebService")
@Transactional(rollbackFor = { Exception.class }, propagation = Propagation.REQUIRED)
public  class MobileWebServiceImpl  implements MobileWebService{
	
	@Resource(name = "mobileWebMapper")
	private MobileWebMapper mobileWebMapper;

	@Override
	public List<HashMap> getLogin(HashMap map) throws Exception{
		
		return 	mobileWebMapper.getLogin(map);
		
	}
	
	@Override
	public List<HashMap> selectBusinessBidList(HashMap map) throws Exception{
		
		return 	mobileWebMapper.selectBusinessBidList(map);
		
	}
	
	@Override
	public int selectBusinessBidCnt(HashMap map) throws Exception{
		
		return 	mobileWebMapper.selectBusinessBidCnt(map);
		
	}
	
	@Override
	public HashMap selectLastEventInfo(HashMap map) throws Exception{
		
		return 	mobileWebMapper.selectLastEventInfo(map);
		
	}
	
	@Override
	public HashMap selectBidDtl(HashMap map) throws Exception{
		
		return 	mobileWebMapper.selectBidDtl(map);
		
	}
	
	@Override
	public HashMap selectBidRiskDtl(HashMap map) throws Exception{
		
		return 	mobileWebMapper.selectBidRiskDtl(map);
		
	}
	
	@Override
	public void updateRegId(HashMap map) throws Exception {
		mobileWebMapper.updateRegId(map);
	}
	
	@Override
	public void updateChkDt(HashMap map) throws Exception {
		mobileWebMapper.updateChkDt(map);
	}
	
	@Override
	public List<HashMap> selectNotiList(HashMap map) throws Exception{
		
		return 	mobileWebMapper.selectNotiList(map);
	}
	
	@Override
	public List<HashMap> selectMsgList(HashMap map) throws Exception{
		
		return 	mobileWebMapper.selectMsgList(map);
	}
	
	@Override
	public HashMap selectMsgView(HashMap map) throws Exception{
		
		return 	mobileWebMapper.selectMsgView(map);
	}
	
	@Override
	public void updateConfirmMsg(HashMap map) throws Exception {
		mobileWebMapper.updateConfirmMsg(map);
	}
	
	@Override
	public String getVersion(HashMap map) throws Exception{
		
		return 	mobileWebMapper.getVersion(map);
	}
	
	@Override
	public List<HashMap> getBidDetailInfo1(HashMap map) throws Exception{
		
		return 	mobileWebMapper.getBidDetailInfo1(map);
		
	}
	
	@Override
	public void updateConfirmInfo(HashMap map) throws Exception {
		mobileWebMapper.updateConfirmInfo(map);
	}
	

	@Override
	public List<HashMap> selectBidRangeList(HashMap map) throws Exception{
		return 	mobileWebMapper.selectBidRangeList(map);
	}
	
	@Override
	public void updateMsgChkDt(HashMap map) throws Exception {
		mobileWebMapper.updateMsgChkDt(map);
	}
	/*
	@Override
	public void sendBidCntToAdmin(Map<String,Object> map) {
		
		try {
			List<HashMap> bidInfo = null;
				
			MailUtil mu = new MailUtil();
				
			HashMap commandMap = new HashMap();
			commandMap.put("subject","기업 누적 투찰 개수 정보");  //subject
			commandMap.put("msgText", "Company Name : " + map.get("company_nm") +  "<br/><br/> Business No : " + map.get("business_no") + "<br/><br/> 누적 투찰 개수 : " + map.get("eventBidCnt") + " [ " + map.get("startDate") + "~" + map.get("endDate") + " ]");  //message
			commandMap.put("to","bid@in-con.biz");
			//commandMap.put("to","gsg332@nate.com");
			commandMap.put("email","bid@in-con.biz");     
			commandMap.put("emailPw","whekf00!!");     
			commandMap.put("emailHost","smart.whoismail.net");    
			commandMap.put("emailPort","587");
			
			mu.sendMailLink(commandMap, bidInfo);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	*/
	@Override
	public List<HashMap> selectAddressList(HashMap map) throws Exception {
		return mobileWebMapper.selectAddressList(map);
	}
	
	@Override
	public List<HashMap> selectGoodsInfo(HashMap map) throws Exception {
		return mobileWebMapper.selectGoodsInfo(map);
	}

	@Override
	public int updateBizGoodsInfo(HashMap map) throws Exception {
		return mobileWebMapper.updateBizGoodsInfo(map);
	}
	
	@Override
	public List<HashMap> selectGubunInfo(HashMap map) throws Exception {
		return mobileWebMapper.selectGubunInfo(map);
	}
	
	@Override
	public int checkCompanyNo(HashMap map) throws Exception{
		return mobileWebMapper.checkCompanyNo(map);
	}
	
	@Override
	public List<HashMap> selectBizTypeList(HashMap map) throws Exception{
		return mobileWebMapper.selectBizTypeList(map);
	}
	
	@Override
	public List<HashMap> selectBusinessLicenseStandardList(HashMap map) throws Exception{
		return mobileWebMapper.selectBusinessLicenseStandardList(map);
	}
	
	@Override
	public int insertBusiness(HashMap map) throws Exception{
		return mobileWebMapper.insertBusiness(map);
	}
	
	@Override
	public int insertBusinessDetail(HashMap map) throws Exception{
		return mobileWebMapper.insertBusinessDetail(map);
	}
	
	@Override
	public int insertCompanyType(HashMap map) throws Exception{
		return mobileWebMapper.insertCompanyType(map);
	}
	
	@Override
	public int insertGoodsType(HashMap map) throws Exception{
		return mobileWebMapper.insertGoodsType(map);
	}
	
	@Override
	public int insertGoodsDirectType(HashMap map) throws Exception{
		return mobileWebMapper.insertGoodsDirectType(map);
	}
	
	@Override
	public int insertCompanylicense(HashMap map) throws Exception{
		return mobileWebMapper.insertCompanylicense(map);
	}
	
	@Override
	public int updateCompanyFileList(HashMap map) throws Exception{
		return mobileWebMapper.updateCompanyFileList(map);
	}
	
	@Override
	public HashMap selectEvalInfo(HashMap map) throws Exception{
		return mobileWebMapper.selectEvalInfo(map);
	}
	
	@Override
	public HashMap insertCreditDgreeInfo(HashMap map) throws Exception{
		return mobileWebMapper.insertCreditDgreeInfo(map);
	}
	
	@Override
	public int insertLog(HashMap map) throws Exception{
		return mobileWebMapper.insertLog(map);
	}
	
}
