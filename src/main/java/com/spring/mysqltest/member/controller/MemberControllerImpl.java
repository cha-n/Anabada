package com.spring.mysqltest.member.controller;


import org.springframework.stereotype.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mysqltest.member.service.MemberService;
import com.spring.mysqltest.member.vo.MemberVO;

@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl implements MemberController {
	
	String _IMAGE_REPO = "/home/anabada/images/profile"; //파일이 저장될 경로
	
	@Autowired
	private MemberService memberService;
	@Autowired
	MemberVO member;

	@Override
	@RequestMapping(value="/checkId" ,method = RequestMethod.POST) //id 중복 체크
	public @ResponseBody String checkId(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String result = memberService.checkId(id);
		return result;
	}
	
	@Override
	@RequestMapping(value="/checkName" ,method = RequestMethod.POST) //닉네임 중복 체크
	public @ResponseBody String checkName(@RequestParam("n_name") String n_name, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String result = memberService.checkName(n_name);
		return result;
	}
	
	@Override
	@RequestMapping(value="/addMember" ,method = RequestMethod.POST) //회원가입
	public ModelAndView addMember(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		memberService.addMember(memberVO);
		ModelAndView mav = new ModelAndView("redirect:/main");
		return mav;
	}
	
	@RequestMapping(value="/loginForm" ,method = RequestMethod.GET) //loginForm으로 이동
	public ModelAndView loginForm(@RequestParam(value= "action", required=false) String action, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName="member/loginForm";
		HttpSession session = request.getSession();
		if(session.getAttribute("action") == null && action!=null)
			session.setAttribute("action", action);
		System.out.println("action:"+action);
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	@Override
	@RequestMapping(value = "/login", method = RequestMethod.POST) //로그인
	public @ResponseBody String login(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		member=memberService.login(memberVO);
		String result="false";
		if(member!=null) { //v.member 테이블에 있는 정보이면 세션에 정보 저장
			HttpSession session = request.getSession();
		    session.setAttribute("member", member);
		    session.setAttribute("log", true);
		    result="true";
		}
		return result;
	}
	
	@Override
	@RequestMapping(value = "/logout", method =  RequestMethod.GET) //로그아웃
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.removeAttribute("member");
		session.removeAttribute("log");
		session.removeAttribute("action");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/main");
		return mav;
	}
	
	@RequestMapping(value="/myInfo" ,method = RequestMethod.GET) //myInfo로 이동
	public ModelAndView myInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName="member/myInfo";
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	@RequestMapping(value="/namePopUp" ,method = RequestMethod.GET) //n_name(닉네임) 변경 팝업
	public ModelAndView namePopUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName="member/namePopUp";
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	@RequestMapping(value="/modifyForm" ,method = RequestMethod.GET) //modifyForm으로 이동
	public ModelAndView modifyForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName="member/modifyForm";
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/updateName" ,method = RequestMethod.POST) //닉네임(n_name) 변경
	public @ResponseBody String updateName(@RequestParam("id") String id, @RequestParam("n_name") String n_name, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> memberMap = new HashMap<String, Object>();
		System.out.println("id="+id);
		System.out.println("n_name="+n_name);
		memberMap.put("id",id);
		memberMap.put("n_name",n_name);
		memberService.updateName(memberMap);
		HttpSession session = request.getSession();
	    member=(MemberVO) session.getAttribute("member");
	    member.setN_name(n_name);
	    session.setAttribute("member", member); //session에 저장된 member의 n_name값 변경
	    String result="";
	    result="ok";
	    return result;
	}
	
	@Override
	@RequestMapping(value="/updateMember" ,method = RequestMethod.POST) //2020.05.30 수정
	public ResponseEntity<String> updateMember(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {	
	    request.setCharacterEncoding("utf-8");
	    Map<String,Object> memberMap = new HashMap<String,Object>();
	    HttpSession session = request.getSession();
	    member=(MemberVO) session.getAttribute("member");
	    
		Enumeration enu=request.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=request.getParameter(name);
			memberMap.put(name,value);
		}
		
		String id=(String) memberMap.get("id");
		String n_name=(String) memberMap.get("n_name");
		String pwd=(String) memberMap.get("pwd");
		String address=(String) memberMap.get("address");
		String name=(String) memberMap.get("name");
	    
		String message;
		ResponseEntity<String> resEnt=null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
	    try {
	    	String imgChange=(String) memberMap.get("imgChange");
			if(imgChange.equals("o")) { //프로필사진 이미지를 바꿨다면
				String profile= upload(request); //폴더에 파일 업로드
				memberMap.put("profile",profile);
				System.out.println("이미지 변화o");
				memberService.updateMember1(memberMap); //회원정보 변경 (프로필사진 포함)
			}
			else if(imgChange.equals("x")) { //프로필사진 이미지를 바꾸지 않았다면
				String profile=member.getProfile();
				memberMap.put("profile",profile);
				System.out.println("이미지 변화x");
				memberService.updateMember2(memberMap); //회원정보 변경 (프로필사진 포함X)
			}
			else { //프로필을 삭제했다면
				memberMap.put("profile",null);
				memberService.updateMember1(memberMap);
				deleteProfile(id);
			}
			String profile=(String) memberMap.get("profile");
			member.setId(id);
			member.setN_name(n_name);
			member.setPwd(pwd);
			member.setAddress(address);
			member.setProfile(profile);
			member.setName(name);
			session.setAttribute("member", member); //session에 저장된 member 변경
			message = "<script>";
			message += " alert('개인정보를 수정했습니다.');";
			message += " location.href='"+request.getContextPath()+"/member/myInfo';";
			message +=" </script>";
			resEnt = new ResponseEntity<String>(message, responseHeaders, HttpStatus.CREATED);
			}catch(Exception e) {
				message = "<script>";
				message += " alert('오류가 발생했습니다. 다시 시도해주세요.');";
				message += " location.href='"+request.getContextPath()+"/member/myInfo';";
				message +=" </script>";
				resEnt = new ResponseEntity<String>(message, responseHeaders, HttpStatus.CREATED);
			}
	    return resEnt;
	}
	
	private String upload(MultipartHttpServletRequest multipartRequest) throws Exception { //2020.05.30 수정
		
		MultipartFile multifile = multipartRequest.getFile("profile");
		String fileName=null;
		
		if(multifile.getSize()!=0) {
			String originalName=multifile.getOriginalFilename(); //원본파일명
			String ext=originalName.substring(originalName.length()-3,originalName.length()); //확장자명
		    HttpSession session = multipartRequest.getSession();
		    member=(MemberVO) session.getAttribute("member");
		    fileName=member.getId();
			deleteProfile(fileName);
		    
			multifile.transferTo(new File(_IMAGE_REPO+"/"+fileName+"."+ext));
			fileName=fileName+"."+ext;
		}
		return fileName;
	}
	private void deleteProfile(String fileName) {
	    File f1=new File(_IMAGE_REPO+"/"+fileName+".jpg"); //jpg 프로필
	    File f2=new File(_IMAGE_REPO+"/"+fileName+".png"); //png 프로필
	    File f3=new File(_IMAGE_REPO+"/"+fileName+".gif"); //gif 프로필
	    
	    if(f1.exists()) { //jpg 프로필 사진이 이미 존재하면
	    	System.out.println("하드에 jpg 프로필사진 존재");
	    	f1.delete(); //삭제
	    }
	    else if(f2.exists()) { //png 프로필 사진이 이미 존재하면
	    	System.out.println("하드에 png 프로필사진 존재");
	    	f2.delete(); //삭제
	    }
	    else if(f3.exists()) { //gif 프로필 사진이 이미 존재하면
	    	System.out.println("하드에 gif 프로필사진 존재");
	    	f3.delete(); //삭제
	    }
	    else {
	    	System.out.println("하드에 프로필사진 없음");
	    }
	}
	
	@RequestMapping("/download")
	protected void download(@RequestParam("profile") String profile, HttpServletResponse response)throws Exception {
		OutputStream out = response.getOutputStream();
		String f = _IMAGE_REPO + "/" + profile;
		File file = new File(f);
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName=" + profile);
		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8];
		while (true) {
			int count = in.read(buffer); 
			if (count == -1) 
				break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}
	
}