package egovframework.com.bidmobile.mobile.web;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.View;

import egovframework.com.bidmobile.mobile.service.CmmnUtilService;
import egovframework.com.bidmobile.mobile.service.MobileWebService;
import egovframework.com.cmm.message.ResultStatus;

/**
 * 공지관리 클래스를 정의 한다
 * 
 * @author 정진고
 ** @since 2016.04.25
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2016.06.22  정진고          최초 생성
 * 
 * </pre>
 */
@Controller
public class MainController extends CommonController {

	@Autowired
	private View jSonView;

	@Resource(name = "mobileWebService")
	private MobileWebService mobileWebService;
	
	@Resource(name="cmmnUtilService")
	private CmmnUtilService cmmnUtilService;

	/**
	 * 공지관리 페이지 이동
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/main.do")
	public String mainPage(HttpServletRequest request, ModelMap model) throws Exception {

		return "/main/main";
	}

	/**
	 * 공지관리 페이지 이동
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bid/list.do")
	public String bidList(HttpServletRequest request, ModelMap model) throws Exception {

		List<HashMap> resultList = null;

		try {
			HashMap map = this.bind(request);

			map.put("business_no", String.valueOf(map.get("user")));

			resultList = mobileWebService.selectBusinessBidList(map);

			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			model.addAttribute("bidList", resultList);
			
			/*
			int eventBidCnt = mobileWebService.selectBusinessBidCnt(map);
			model.addAttribute("eventBidCnt", eventBidCnt);
			*/
			
			HashMap lastEventInfo = mobileWebService.selectLastEventInfo(map);
			model.addAttribute("lastEventInfo", lastEventInfo);
		} catch (Exception e) {

		}
		return "/bid/list";
	}

	/**
	 * 공지관리 페이지 이동
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bid/detail.do")
	public String biddetail(HttpServletRequest request, ModelMap model) throws Exception {

		HashMap resultList = null;
		HashMap resultList1 = null;

		try {
			HashMap map = this.bind(request);

			map.put("business_no", String.valueOf(map.get("user")));

			mobileWebService.updateChkDt(map);
			resultList = mobileWebService.selectBidDtl(map);
			resultList1 = mobileWebService.selectBidRiskDtl(map);

			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			model.addAttribute("bidInfo", resultList);
			model.addAttribute("riskInfo", resultList1);
		} catch (Exception e) {

		}

		return "/bid/detail";
	}
	/**
	 * 공지관리 페이지 이동
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bid/detail1.do")
	public String detail1(HttpServletRequest request, ModelMap model) throws Exception {
		
		HashMap resultList = null;
		try {
			HashMap map = this.bind(request);

			map.put("business_no", String.valueOf(map.get("user")));

			resultList = mobileWebService.selectBidDtl(map);
			
			model.addAttribute("bidInfo", resultList);
			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
		} catch (Exception e) {
			
		}
		
		return "/bid/detail1";
	}
	/**
	 * 공지관리 페이지 이동
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bid/detail2.do")
	public String detail2(HttpServletRequest request, ModelMap model) throws Exception {
		
		HashMap resultList = null;
		List<HashMap> resultList2 = null;
		try {
			HashMap map = this.bind(request);

			map.put("business_no", String.valueOf(map.get("user")));

			resultList = mobileWebService.selectBidDtl(map);
			resultList2 = mobileWebService.selectBidRangeList(map);
			
			model.addAttribute("bidInfo", resultList);
			model.addAttribute("bidRange", resultList2);
			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
		} catch (Exception e) {
			
		}
		
		return "/bid/detail2";
	}
	
	/**
	 * 공지관리 페이지 이동
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bid/detail3.do")
	public String detail3(HttpServletRequest request, ModelMap model) throws Exception {
		
		return "/bid/detail3";
	}

	/**
	 * 공지관리 페이지 이동
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/notice/list.do")
	public String noticeList(HttpServletRequest request, ModelMap model) throws Exception {

		List<HashMap> resultList1 = null;
		List<HashMap> resultList2 = null;
		List<HashMap> resultList3 = null;

		try {
			HashMap map = this.bind(request);

			map.put("notice_type", "1");
			resultList1 = mobileWebService.selectNotiList(map);

			map.put("notice_type", "2");
			resultList2 = mobileWebService.selectNotiList(map);
			
			map.put("notice_type", "3");
			resultList3 = mobileWebService.selectNotiList(map);

			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			model.addAttribute("notiList", resultList1);
			model.addAttribute("newsList", resultList2);
			model.addAttribute("fileList", resultList3);
		} catch (Exception e) {

		}
		return "/notice/list";
	}

	/**
	 * 공지관리 페이지 이동
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/msg/list.do")
	public String msgList(HttpServletRequest request, ModelMap model) throws Exception {

		List<HashMap> resultList = null;

		try {
			HashMap map = this.bind(request);

			map.put("business_no", String.valueOf(map.get("user")));
			//
			mobileWebService.updateMsgChkDt(map);
			resultList = mobileWebService.selectMsgList(map);

			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			model.addAttribute("msgList", resultList);
		} catch (Exception e) {

		}
		return "/msg/list";
	}
	
	@RequestMapping(value = "/msg/view.do")
	public String msgView(HttpServletRequest request, ModelMap model) throws Exception {

		HashMap resultView = null;

		try {
			HashMap map = this.bind(request);

			map.put("message_id", map.get("message_id"));
			
			resultView = mobileWebService.selectMsgView(map);

			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			model.addAttribute("msgView", resultView);
		} catch (Exception e) {

		}
		return "/msg/view";
	}
	
	@RequestMapping(value = "/msg/saveMsg.do", method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View saveMsg(HttpServletRequest request, Model model) {
		try {
			HashMap map = this.bind(request);
			
			map.put("business_no", String.valueOf(map.get("user")));
			
			mobileWebService.updateConfirmMsg(map);
			
			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			
		} catch (Exception e) {
			model.addAttribute("resultCode", ResultStatus.FAIL.value());
			model.addAttribute("resultMessage", ResultStatus.FAIL.getReasonPhrase());
			e.printStackTrace();
		}
		
		return jSonView;
	}

	/**
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/bid/nonBid.do", method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View nonBid(HttpServletRequest request, Model model) {
		try {
			HashMap map = this.bind(request);
			
			map.put("business_no", String.valueOf(map.get("user")));

			mobileWebService.updateConfirmInfo(map);
			
			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());

		} catch (Exception e) {
			model.addAttribute("resultCode", ResultStatus.FAIL.value());
			model.addAttribute("resultMessage", ResultStatus.FAIL.getReasonPhrase());
			e.printStackTrace();
		}

		return jSonView;
	}
	
	/**
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/bid/saveBid.do", method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public View saveBid(HttpServletRequest request, Model model) {
		try {
			HashMap map = this.bind(request);
			
			map.put("business_no", String.valueOf(map.get("user")));
			map.put("company_nm", String.valueOf(map.get("companyNm")));
			
			mobileWebService.updateConfirmInfo(map);
			
			model.addAttribute("resultCode", ResultStatus.OK.value());
			model.addAttribute("resultMessage", ResultStatus.OK.getReasonPhrase());
			
			/*			
			int eventBidCnt = mobileWebService.selectBusinessBidCnt(map);
			model.addAttribute("eventBidCnt", eventBidCnt);

			map.put("eventBidCnt", eventBidCnt);
			*/
			
			HashMap lastEventInfo = mobileWebService.selectLastEventInfo(map);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			map.put("startDate", sdf.format(lastEventInfo.get("start_date")));
			map.put("endDate", sdf.format(lastEventInfo.get("end_date")));

			/*
			if(eventBidCnt != 0 && eventBidCnt%50==0){ //투찰 누적 개수가 50개 단위가 될 때마다 관리자에게 이메일 알림.
				mobileWebService.sendBidCntToAdmin(map);				
			}
			*/
		} catch (Exception e) {
			model.addAttribute("resultCode", ResultStatus.FAIL.value());
			model.addAttribute("resultMessage", ResultStatus.FAIL.getReasonPhrase());
			e.printStackTrace();
		}
		
		return jSonView;
	}

	@RequestMapping("/file/download.do")
	public void download(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)throws Exception{
		cmmnUtilService.download(model,request,response);
	}

}
