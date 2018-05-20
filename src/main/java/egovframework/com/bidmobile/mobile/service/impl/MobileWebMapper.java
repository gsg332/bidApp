package egovframework.com.bidmobile.mobile.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 모바일 관리
 * 
 * @author 정진고
 * @since 2016.06.01
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 * 
 * </pre>
 */

@Mapper("mobileWebMapper")
public interface MobileWebMapper {
	
	/**
	 * 투찰업체 로그인
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<HashMap> getLogin(HashMap map) throws Exception;
	
	/**
	 * 투찰업체 공고 리스트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<HashMap> selectBusinessBidList(HashMap map) throws Exception;
	
	/**
	 * 이벤트 누적 투찰 개수
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectBusinessBidCnt(HashMap map) throws Exception;
	
	/**
	 * 가장 최신의 이벤트 정보 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public HashMap selectLastEventInfo(HashMap map) throws Exception;
	
	/**
	 * 투찰업체 공고 상세
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public HashMap selectBidDtl(HashMap map) throws Exception;
	
	/**
	 * 공고 리스크 정보 상세
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public HashMap selectBidRiskDtl(HashMap map) throws Exception;

	/**
	 * 투찰사 푸쉬 알람 reg_id 수정
	 * @param map
	 * @throws Exception
	 */
	public void updateRegId(HashMap map) throws Exception; 

	/**
	 * 투찰사 추천가격확인
	 * @param map
	 * @throws Exception
	 */
	public void updateChkDt(HashMap map) throws Exception; 
	

	/**
	 * 공지사항 리스트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<HashMap> selectNotiList(HashMap map) throws Exception; 

	/**
	 * 메세지 리스트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<HashMap> selectMsgList(HashMap map) throws Exception;
	
	public HashMap selectMsgView(HashMap map) throws Exception;
	
	public void updateConfirmMsg(HashMap map) throws Exception; 
	
	/**
	 * 모바일 버전
	 * @return
	 * @throws Exception
	 */
	public String getVersion(HashMap map) throws Exception; 
	
	/**
	 * 투찰업체 공고 상세1
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<HashMap> getBidDetailInfo1(HashMap map) throws Exception;
	
	

	/**
	 * 투찰사 투찰의향확인
	 * @param map
	 * @throws Exception
	 */
	public void updateConfirmInfo(HashMap map) throws Exception; 
	
	/**
	 * 추천구간 리스트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<HashMap> selectBidRangeList(HashMap map) throws Exception;
	
	public void updateMsgChkDt(HashMap map) throws Exception; 
	
	public List<HashMap> selectAddressList(HashMap map) throws Exception;
	
	public List<HashMap> selectGoodsInfo(HashMap map) throws Exception;
	
	public int updateBizGoodsInfo(HashMap map) throws Exception;
	
	public List<HashMap> selectGubunInfo(HashMap map) throws Exception;
	
	public int checkCompanyNo(HashMap map) throws Exception;
	
	public List<HashMap> selectBizTypeList(HashMap map) throws Exception;
	
	public List<HashMap> selectBusinessLicenseStandardList(HashMap map) throws Exception;
	
	public int insertBusiness(HashMap map) throws Exception;
	
	public int insertBusinessDetail(HashMap map) throws Exception;
	
	public int insertCompanyType(HashMap map) throws Exception;
	
	public int insertGoodsType(HashMap map) throws Exception;
	
	public int insertGoodsDirectType(HashMap map) throws Exception;
	
	public int insertCompanylicense(HashMap map) throws Exception;
	
	public int updateCompanyFileList(HashMap map) throws Exception;
	
	public HashMap selectEvalInfo(HashMap map) throws Exception;
	
	public HashMap insertCreditDgreeInfo(HashMap map) throws Exception;
	
	public int insertLog(HashMap map) throws Exception;
}
