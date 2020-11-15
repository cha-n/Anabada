package com.spring.mysqltest.board.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mysqltest.board.common.ResultUtil;
import com.spring.mysqltest.board.dto.BoardDto;
import com.spring.mysqltest.board.form.BoardForm;
import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.board.form.CommentVO;
import com.spring.mysqltest.board.service.BoardService;
import com.spring.mysqltest.market.vo.VegatVO;
import com.spring.mysqltest.member.vo.MemberVO;
import com.spring.mysqltest.seller.vo.ArticleVO;

@Controller("boardController")
@RequestMapping(value = "/board")
public class BoardControllerImpl implements BoardController {
 
    @Autowired
    private BoardService boardService;
 
    /** 게시판 - 목록 페이지 이동 */
    @RequestMapping(value = "/boardList")
    public String boardList(HttpServletRequest request, HttpServletResponse response) throws Exception {
 
        return "board/boardList";
    }
 
    /** 게시판 - 목록 조회  */
    @Override
    @RequestMapping(value = "/getBoardList")
    @ResponseBody
    public ResultUtil getBoardList(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {
 
        ResultUtil resultUtils = boardService.getBoardList(boardForm);
 
        return resultUtils;
    }
 
    /** 게시판 - 상세 페이지 이동 */
    @RequestMapping(value = "/boardDetail",method = RequestMethod.GET)
    public ModelAndView boardDetail(@RequestParam("boardSeq") int boardSeq, @RequestParam(value="action",required=false) String action, @RequestParam(value="active",required=false) String active,HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String items = boardService.listItems(boardSeq); //해당 boardSeq의 item
    	String[] itemArr = items.split(",");
    	List<VegatVO> vegatList= boardService.listVegats(itemArr);
    	List<CommentVO> commentList = boardService.listComments(boardSeq); //댓글 목록
    	String writer=boardService.getWriter(boardSeq);
    	String result; //북마크가 되어 있는지 확인하기 위한 변수
    	
		HttpSession session = request.getSession();
		if(session.getAttribute("member") != null) {
			Map<String, Object> bookMap = new HashMap<String, Object>();
			String n_name=((MemberVO) session.getAttribute("member")).getN_name();
			bookMap.put("n_name",n_name);
			bookMap.put("post_NO",boardSeq);
			bookMap.put("category","판매");
			result=boardService.checkSellBookmark(bookMap);
		}
		else {
			result="false";
		} 	
   
    	String viewName="board/boardDetail";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("comments", commentList); //댓글 목록
		mav.addObject("writer", writer); //글쓴이
		mav.addObject("vegats", vegatList); //글내용 중 야채 및 과일 목록
		mav.addObject("itemArr",itemArr);  //boardDtos
		mav.addObject("result", result); //북마크가 되어 있는지 확인하기 위한 변수
		mav.addObject("action", action);
		mav.addObject("active", active); //내글목록 조회에서 넘어온지 확인
		return mav;
    }
 
    /** 게시판 - 상세 조회*/
    @Override
    @RequestMapping(value = "/getBoardDetail")
    @ResponseBody
    public BoardDto getBoardDetail(@RequestParam("boardSeq") int boardSeq,HttpServletRequest request, HttpServletResponse response) throws Exception {
 
        BoardDto boardDto = boardService.getBoardDetail(boardSeq);
 
        return boardDto;
    }
 
    /** 게시판 - 작성 페이지 이동 */
    @RequestMapping(value = "/boardWrite")
    public String boardWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
 
        return "board/boardWrite";
    }
 
    /** 게시판 - 등록 */
    @Override
    @RequestMapping(value = "/insertBoard")
    @ResponseBody
    public BoardDto insertBoard(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {
 
        BoardDto boardDto = boardService.insertBoard(boardForm);
 
        return boardDto;
    }
 
    /** 게시판 - 삭제*/
    @Override
    @RequestMapping(value = "/deleteBoard")
    @ResponseBody
    public BoardDto deleteBoard(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {
 
        BoardDto boardDto = boardService.deleteBoard(boardForm);
 
        return boardDto;
    }
 
    /** 게시판 - 수정 페이지 이동 */
    @RequestMapping(value = "/boardUpdate")
    public String boardUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
 
        return "board/boardUpdate";
    }
 
    /** 게시판 - 수정 */
    @Override
    @RequestMapping(value = "/updateBoard")
    @ResponseBody
    public BoardDto updateBoard(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {
 
        BoardDto boardDto = boardService.updateBoard(boardForm);
 
        return boardDto;
    }
 
    /** 게시판 - 답글 페이지 이동 */
    @RequestMapping(value = "/boardReply")
    public String boardReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
 
        return "board/boardReply";
    }
 
    /** 게시판 - 답글 등록 */
    @Override
    @RequestMapping(value = "/insertBoardReply")
    @ResponseBody
    public BoardDto insertBoardReply(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {
 
        BoardDto boardDto = boardService.insertBoardReply(boardForm);
 
        return boardDto;
    }
 
    /** 게시판 - 첨부파일 다운로드 */
    @RequestMapping("/fileDownload")                      
    public ModelAndView fileDownload(@RequestParam("fileNameKey") String fileNameKey
                                    ,@RequestParam("fileName") String fileName
                                    ,@RequestParam("filePath") String filePath) throws Exception {
          
    	/** 첨부파일 정보 조회 */
        Map<String, Object> fileInfo = new HashMap<String, Object>();
        fileInfo.put("fileNameKey", fileNameKey);
        fileInfo.put("fileName", fileName);
        fileInfo.put("filePath", filePath);
     
        return new ModelAndView("fileDownloadUtil", "fileInfo", fileInfo);
    }
    
    
    
	/** 정은수정2 내가쓴글 목록 페이지 이동 */
	@RequestMapping(value = "/myBoardList")
	public String BoardList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return "board/myBoardList";
	}
   
	/**정은 수정2 내가쓴글 목록 조회  */
	 @Override	  
	 @RequestMapping(value = "/getMyBoardList")	  
	 @ResponseBody 
	 public ResultUtil getMyBoardList(HttpServletRequest request,HttpServletResponse response,BoardForm boardForm) throws Exception { 
		 HttpSession session=request.getSession(); 
		 	 
		 //String n_name=((MemberVO)(session.getAttribute("member"))).getN_name();    //이름 얻어와서
		 MemberVO memberVO=new MemberVO();
		 
		 memberVO= (MemberVO) session.getAttribute("member");		  //MemberVO member 추가해주고 넣음.		
		 
		 System.out.println("(컨트롤러) 함수이름() : "+boardForm.getFunction_name());
		
		 ResultUtil resultUtils = boardService.getMyBoardList(boardForm,memberVO); //왜 멤버에서 받아왔지? 로그인 세션 받아서 이름으로 해당자료를 얻으려구 
		 
		 System.out.println("(컨트롤러) 이름이 잘 넘어가는지"+memberVO.getN_name());
	  	 
		  return resultUtils;
	  	}
	 
	 /**내가쓴글 목록 페이지 이동(농부) */
	@RequestMapping(value = "/myFarmerList")
	public String FramerList(HttpServletRequest request, HttpServletResponse response) throws Exception {

			return "board/myFarmerList";
	}
		
	/**내가쓴글 목록 조회(농부)  */
	@Override	  
	@RequestMapping(value = "/getMyFarmerList")	  
	@ResponseBody 
	public ResultUtil getMyFarmerList(HttpServletRequest request,HttpServletResponse response,ArticleVO articleVO) throws Exception { 
		 System.out.println("컨트롤러 들어옴");
		 String user= request.getParameter("user");
		 System.out.println("(컨트롤러) user " + user);
		
		 HttpSession session=request.getSession(); 
		 
		 //String n_name=((MemberVO)(session.getAttribute("member"))).getN_name();    //이름 얻어와서
		 MemberVO memberVO=new MemberVO();
			 
		 memberVO= (MemberVO) session.getAttribute("member");		  //MemberVO member 추가해주고 넣음.		
								
		 ResultUtil resultUtils = boardService.getMyFarmerList(articleVO,memberVO,user); 
					  	 
		  return resultUtils;
	 }
    /**내글목록 삭제*/
    @Override
    @RequestMapping(value="/deleteMyBoardList", method= RequestMethod.POST)
    public @ResponseBody int deleteMyBoardList(@RequestParam(value="chbox[]") List<String> chArr, BoardForm boardForm,HttpServletRequest request, HttpServletResponse response) throws Exception{
    	HttpSession session=request.getSession();     	
    	String n_name=((MemberVO)(session.getAttribute("member"))).getN_name(); //이름 얻어와서
    	
    	int result=0;
    	int  board_seq=0;
 
    	for(String i: chArr) {
    		board_seq=Integer.parseInt(i);
    		boardForm.setBoard_seq(board_seq);
    		boardService.deleteMyBoardList(boardForm);
    	}
    	result=1;
    	
    	return result;
    }
    
    /**내글목록 삭제-농부*/
    @Override
    @RequestMapping(value="/deleteMyFarmerList", method= RequestMethod.POST)
    public @ResponseBody int deleteMyFarmerList(@RequestParam(value="chbox[]") List<String> chArr, ArticleVO articleVO,HttpServletRequest request, HttpServletResponse response) throws Exception{
    	HttpSession session=request.getSession();     	
    	String n_name=((MemberVO)(session.getAttribute("member"))).getN_name(); //이름 얻어와서
    	
    	int result=0;
    	int  articleNO=0;
 
    	for(String i: chArr) {
    		articleNO=Integer.parseInt(i);
    		articleVO.setArticleNO(articleNO);
    		boardService.deleteMyFarmerList(articleVO);
    	}
    	result=1;
    	
    	return result;
    }
    
    
    /** 여기서부터 예슬 코드 */
	@RequestMapping(value="/vegatPopUp" ,method = RequestMethod.GET) /**품목 선택 팝업창 */
	public ModelAndView vegatPopUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName="board/vegatPopUp";
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	//@Override
	@RequestMapping(value="/searchVegatsByKeyword",method = RequestMethod.GET,produces = "application/text; charset=utf8")
	public @ResponseBody String  searchVegatsByKeyword(@RequestParam("keyword") String keyword,
			                                  HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		System.out.println(keyword);
		if(keyword == null || keyword.equals(""))
		   return null;
	    List<String> keywordList =boardService.searchByKeyword(keyword);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword", keywordList);
		 		
	    String jsonInfo = jsonObject.toString();
	    System.out.println(jsonInfo);
	    return jsonInfo ;
	}
	
	@Override
	@RequestMapping(value="/addComment" ,method = RequestMethod.POST) /**댓글 등록 */
	public @ResponseBody String addComment(@ModelAttribute("commentVO") CommentVO commentVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean result=boardService.addComment(commentVO);
		if(result==true){
			return "ok";
		}
		else{
			return "no";	
		}
	}
	
	@Override
	@RequestMapping(value="/deleteComment" ,method = RequestMethod.POST) /**댓글 삭제 */
	public @ResponseBody String deleteComment(@RequestParam("comment_NO") int comment_NO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		  boolean result=boardService.deleteComment(comment_NO);
		  if(result==true){ 
			  return "ok";
		  }
		  else{
			  return "no";	
		  }
	}
	
	@Override
	@RequestMapping(value="/updateComment" ,method = RequestMethod.POST) /**댓글 수정 */
	public @ResponseBody String updateComment(@RequestParam("comment_NO") int comment_NO, @RequestParam("content") String content, @RequestParam("secret") char secret, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> commentMap = new HashMap<String, Object>();
		commentMap.put("comment_NO",comment_NO);
		commentMap.put("content",content);
		commentMap.put("secret",secret);
		boolean result=boardService.updateComment(commentMap);
		  if(result==true){ 
			  return "ok";
		  }
		  else{
			  return "no";	
		  }
	}
	
	@Override
	@RequestMapping(value="/addSellBookmark" ,method = RequestMethod.POST) /**북마크 추가 */
	public @ResponseBody String addSellBookmark(@RequestParam("post_NO") int post_NO, @RequestParam("n_name") String n_name, @RequestParam("category") String category, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("postNO:"+post_NO+" n_name:"+ n_name+" category:"+category);
		Map<String, Object> bookMap = new HashMap<String, Object>();
		bookMap.put("post_NO",post_NO);
		bookMap.put("n_name",n_name);
		bookMap.put("category",category); 	//(수정)
		boolean result=boardService.addSellBookmark(bookMap);
		  if(result==true) { 
			  return "ok";
		  }
		  else {
			  return "no";	
		  }
	}

	@Override
	@RequestMapping(value="/deleteSellBookmark" ,method = RequestMethod.POST) /**북마크 해제 */
	public @ResponseBody String deleteSellBookmark(@RequestParam("post_NO") int post_NO, @RequestParam("n_name") String n_name, @RequestParam("category") String category, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("postNO:"+post_NO+" n_name:"+ n_name+" category:"+category);
		Map<String, Object> bookMap = new HashMap<String, Object>();
		bookMap.put("post_NO",post_NO);
		bookMap.put("n_name",n_name);
		bookMap.put("category",category);
		boolean result=boardService.deleteSellBookmark(bookMap);
		  if(result==true) { 
			  return "ok";
		  }
		  else {
			  return "no";	
		  }
	}
	
	@Override
	@RequestMapping(value="/myBookmark" ,method = RequestMethod.GET)
	public ModelAndView myBookmark(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HttpSession session=request.getSession();     	
    	String n_name=((MemberVO)(session.getAttribute("member"))).getN_name();
		Map<String, Object> bookMap = new HashMap<String, Object>();
		Map<String, Object> resultCntMap = new HashMap<String, Object>();
		
		bookMap.put("category", "판매");
		bookMap.put("n_name", n_name);
		resultCntMap=boardService.select_Total_Bookmark(bookMap);
		String viewName="board/myBookmark";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("resultCntMap",resultCntMap);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/listBoardBookmark" ,method = RequestMethod.POST)
	public @ResponseBody List<BookmarkVO> listBoardBookmark(@RequestParam String n_name, @RequestParam("page") int page, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> bookMap=new HashMap<String,Object>();
		bookMap.put("n_name", n_name);
		bookMap.put("page", page);
		List<BookmarkVO> bookmarkList=boardService.listSellBookmark(bookMap); /**회원이 추가해놓은 북마크 list */
		return bookmarkList;
	}
	
	@Override
	@RequestMapping(value="/updateSell_YN" ,method = RequestMethod.POST) /**sell_YN(판매여부) 변경 */
	public @ResponseBody String updateSell_YN(@RequestParam("board_seq") int board_seq, @RequestParam("sell_YN") String sell_YN, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> boardMap = new HashMap<String, Object>();
		boardMap.put("board_seq",board_seq);
		boardMap.put("sell_YN",sell_YN);
		boolean result=boardService.updateSell_YN(boardMap);
		  if(result==true) { 
			  return "ok";
		  }
		  else {
			  return "no";	
		  }
	}
	@RequestMapping(value="/locatPopUp" ,method = RequestMethod.GET) /**장소 설정 팝업창 */
	public ModelAndView locatPopUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName="board/locatPopUp";
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}

	@Override
	@RequestMapping(value="/add_delete_Bookmark" ,method = RequestMethod.POST) /**글 목록에서 북마크 추가,삭제 */
	public @ResponseBody String add_delete_Bookmark(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String,Object> bookMap=new HashMap<String,Object>();
		
		Enumeration enu = request.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = request.getParameter(name);
			bookMap.put(name, value);
		}
		String result=boardService.add_delete_Bookmark(bookMap);
		
		if(result.equals("true")) {
			result="exist";
		}
		else {
			result="n_exist";
		}
		return result;
	}
}