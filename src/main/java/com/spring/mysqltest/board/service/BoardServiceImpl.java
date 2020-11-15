package com.spring.mysqltest.board.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.mysqltest.board.common.PagingUtil;
import com.spring.mysqltest.board.common.ResultUtil;
import com.spring.mysqltest.board.dao.BoardDAO;
import com.spring.mysqltest.board.dto.BoardDto;
import com.spring.mysqltest.board.dto.BoardFileDto;
import com.spring.mysqltest.board.dto.CommonDto;
import com.spring.mysqltest.board.form.BoardFileForm;
import com.spring.mysqltest.board.form.BoardForm;
import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.board.form.CommentVO;
import com.spring.mysqltest.board.form.CommonForm;
import com.spring.mysqltest.market.vo.VegatVO;
import com.spring.mysqltest.member.vo.MemberVO;
import com.spring.mysqltest.seller.vo.ArticleVO;


@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO boardDao;
	private CommentVO comment;

	/** 게시판 - 목록 조회 */
	@Override
    public ResultUtil getBoardList(BoardForm boardForm) throws Exception {
		
        ResultUtil resultUtil = new ResultUtil();
        CommonDto commonDto = new CommonDto();
 
        String keyword= boardForm.getKeyword();
        String searchType= boardForm.getSearchType();
               
        int totalCount;
        List<BoardDto> list;    //글 목록을 담을 변수 
        
        if (keyword == null || keyword.equals("")) {       	       	       
        	totalCount = boardDao.getBoardCnt(boardForm);
        	if (totalCount != 0) {
        		CommonForm commonForm = new CommonForm();
        		commonForm.setFunction_name(boardForm.getFunction_name());
        		commonForm.setCurrent_page_no(boardForm.getCurrent_page_no());
        		commonForm.setCount_per_page(16);
        		commonForm.setCount_per_list(16);
        		commonForm.setTatal_list_count(totalCount);
        		commonDto = PagingUtil.setPageUtil(commonForm);
        	}
 
        	boardForm.setLimit(commonDto.getLimit());
        	boardForm.setOffset(commonDto.getOffset()); 
        	list = boardDao.getBoardList(boardForm);
        	
        	}else {
            	// keyword 검색
    			/* 검색타입, 키워드 넘어오는거 확인
    			 * HashMap<String, Object> map = new HashMap<String, Object>();
    			 * map.put("keyword" , keyword); map.put("searchType" , searchType);
    			 * System.out.println("map확인: "+ map);
    			 */
    			
            	totalCount = boardDao.countSearch(boardForm);
            	if (totalCount != 0) {      			
            		CommonForm commonForm = new CommonForm();
            		commonForm.setFunction_name(boardForm.getFunction_name());
            		commonForm.setCurrent_page_no(boardForm.getCurrent_page_no());
            		commonForm.setCount_per_page(16);
           			commonForm.setCount_per_list(16);
           			commonForm.setTatal_list_count(totalCount);
           			commonDto = PagingUtil.setPageUtil(commonForm);
            	}
            	boardForm.setLimit(commonDto.getLimit());
            	boardForm.setOffset(commonDto.getOffset());
               
            	list = boardDao.listSearch(boardForm);  //글 목록들을 list에 담기.
                           
        	}
 
		for (BoardDto file : list) { 			
			file.setImgs(boardDao.selectThumbnail(file.getBoard_seq()));			
		  }
        
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("list", list);
        resultMap.put("totalCount", totalCount);
        resultMap.put("pagination", commonDto.getPagination());
        resultMap.put("keyword",keyword);  
        resultMap.put("searchType",searchType);
        resultUtil.setData(resultMap);
        resultUtil.setState("SUCCESS");
 
        return resultUtil;
    }
 
	/** 게시판 - 상세 조회 */
	@Override
    public BoardDto getBoardDetail(int boardSeq) throws Exception {
 
        BoardDto boardDto = new BoardDto();
        BoardForm boardForm= new BoardForm();
        boardDao.updateBoardHits(boardSeq);

 
        boardDto = boardDao.getBoardDetail(boardSeq);
 
        BoardFileForm boardFileForm = new BoardFileForm();
        boardFileForm.setBoard_seq(boardForm.getBoard_seq());
 
        boardDto.setFiles(boardDao.getBoardFileList(boardSeq));
 
        return boardDto;
    }
 
	 /** 게시판 - 등록 */
	@Override
    public BoardDto insertBoard(BoardForm boardForm) throws Exception {
 
        BoardDto boardDto = new BoardDto();
 
        int insertCnt = 0;
 
        int boardReRef = boardDao.getBoardReRef(boardForm);
        boardForm.setBoard_re_ref(boardReRef);
 
        insertCnt = boardDao.insertBoard(boardForm);
 
        List<BoardFileForm> boardFileList = getBoardFileInfo(boardForm);
        for (BoardFileForm boardFileForm : boardFileList) {
            boardDao.insertBoardFile(boardFileForm);
        }
 
        if (insertCnt > 0) {
            boardDto.setResult("SUCCESS");
        } else {
            boardDto.setResult("FAIL");
        }
 
        return boardDto;
    }
 
	/** 게시판 - 첨부파일 조회 */
	@Override
    public List<BoardFileForm> getBoardFileInfo(BoardForm boardForm) throws Exception {
 
        List<MultipartFile> files = boardForm.getFiles();
 
        List<BoardFileForm> boardFileList = new ArrayList<BoardFileForm>();
 
        BoardFileForm boardFileForm = new BoardFileForm();
 
        int boardSeq = boardForm.getBoard_seq();
        String fileName = null;
        String fileExt = null;
        String fileNameKey = null;
        String fileSize = null;
        // 파일이 저장될 Path 설정
        String filePath = "/home/anabada/images/sale";
 
        if (files != null && files.size() > 0) {
 
            File file = new File(filePath);
 
         // 디렉토리가 없으면 생성
            if (file.exists() == false) {
                file.mkdirs();
            }
 
            for (MultipartFile multipartFile : files) {
 
                fileName = multipartFile.getOriginalFilename();
                fileExt = fileName.substring(fileName.lastIndexOf("."));
             // 파일명 변경(uuid로 암호화) + 확장자
                fileNameKey = getRandomString() + fileExt;
                fileSize = String.valueOf(multipartFile.getSize());
 
                // 설정한 Path에 파일 저장
                file = new File(filePath + "/" + fileNameKey);
 
                multipartFile.transferTo(file);
 
                boardFileForm = new BoardFileForm();
                boardFileForm.setBoard_seq(boardSeq);
                boardFileForm.setFile_name(fileName);
                boardFileForm.setFile_name_key(fileNameKey);
                boardFileForm.setFile_path(filePath);
                boardFileForm.setFile_size(fileSize);
                boardFileList.add(boardFileForm);
            }
        }
 
        return boardFileList;
    }
 
	/** 게시판 - 삭제 */
	@Override
    public BoardDto deleteBoard(BoardForm boardForm) throws Exception {
 
        BoardDto boardDto = new BoardDto();
 
        int board_seq=boardForm.getBoard_seq();
        BoardFileForm boardFileForm=new BoardFileForm();
        boardFileForm.setBoard_seq(board_seq);
        String fileNameKey=boardDao.getFileNameKey(boardFileForm);
        File f=new File("/home/anabada/images/sale/"+fileNameKey);
	    if(f.exists()) {
	    	f.delete(); //삭제
	    }
	    int deleteCnt = boardDao.deleteBoard(boardForm);
 
        if (deleteCnt > 0) {
            boardDto.setResult("SUCCESS");
        } else {
            boardDto.setResult("FAIL");
        }
 
        return boardDto;
    }
 
	/** 게시판 - 수정*/
	@Override
    public BoardDto updateBoard(BoardForm boardForm) throws Exception {
 
        BoardDto boardDto = new BoardDto();
 
        int updateCnt = boardDao.updateBoard(boardForm);
 
        String deleteFile = boardForm.getDelete_file();
        if (!"".equals(deleteFile)) {
 
            String[] deleteFileInfo = deleteFile.split("!");
            System.out.println("삭제 deleteFileInfo 확인: "+deleteFileInfo);
            int boardSeq = Integer.parseInt(deleteFileInfo[0]);
            int fileNo = Integer.parseInt(deleteFileInfo[1]);
 
            BoardFileForm deleteBoardFileForm = new BoardFileForm();
            deleteBoardFileForm.setBoard_seq(boardSeq);
            deleteBoardFileForm.setFile_no(fileNo);
            System.out.println("삭제 fileno 확인 : ");
            
            String fileNameKey=boardDao.getFileNameKey(deleteBoardFileForm);
            
            File f=new File("/home/anabada/images/sale/"+fileNameKey);
            boardDao.deleteBoardFile(deleteBoardFileForm);
    	    if(f.exists()) {
    	    	f.delete(); //삭제
    	    }
        }
 
        List<BoardFileForm> boardFileList = getBoardFileInfo(boardForm);
        for (BoardFileForm boardFileForm : boardFileList) {
            boardDao.insertBoardFile(boardFileForm);
        }
        
        if (updateCnt > 0) {
            boardDto.setResult("SUCCESS");
        } else {
            boardDto.setResult("FAIL");
        }
 
        return boardDto;
    }
 
	/** 게시판 - 답글 등록 */
	@Override
    public BoardDto insertBoardReply(BoardForm boardForm) throws Exception {
 
        BoardDto boardDto = new BoardDto();
 
        BoardDto boardReplayInfo = boardDao.getBoardReplyInfo(boardForm);
 
        boardForm.setBoard_seq(boardReplayInfo.getBoard_seq());
        boardForm.setBoard_re_lev(boardReplayInfo.getBoard_re_lev());
        boardForm.setBoard_re_ref(boardReplayInfo.getBoard_re_ref());
        boardForm.setBoard_re_seq(boardReplayInfo.getBoard_re_seq());
 
        int insertCnt = 0;
 
        insertCnt += boardDao.updateBoardReSeq(boardForm);
 
        insertCnt += boardDao.insertBoardReply(boardForm);
 
        if (insertCnt > 0) {
            boardDto.setResult("SUCCESS");
        } else {
            boardDto.setResult("FAIL");
        }
 
        return boardDto;
    }
 
	/** 32글자의 랜덤한 문자열(숫자포함) 생성 */
    public static String getRandomString() {
 
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
    
	/** 영양소 */
    @Override
    public List<VegatVO> listVegats(String[] items) throws Exception {
    	List<VegatVO> vegatList = null;
    	vegatList = boardDao.selectVegats(items);
		return vegatList;
    }
    
	/** 아이템불러오기  */
    @Override
    public String listItems(int board_seq) throws Exception {
    	return boardDao.selectItems(board_seq);
    }
    
	/**정은수정2  게시판 - 목록 조회(판매) */
	@Override
    public ResultUtil getMyBoardList(BoardForm boardForm ,MemberVO member) throws Exception {
		
        ResultUtil resultUtil = new ResultUtil();
        CommonDto commonDto = new CommonDto();
     
        String user= boardForm.getBoard_writer();   //글폼에서  작성자 writer얻어옴
        
        String n_name= member.getN_name();  //이름가져오기    

        int totalCount=0;
		List<BoardDto> myboardList = null;
        
		if( n_name.equals(user)) { 
			 //본인이 쓴 글 보기 		 
			totalCount = boardDao.getMyBoardCnt(n_name);		
			if (totalCount != 0) {
				CommonForm commonForm = new CommonForm();
				commonForm.setFunction_name(boardForm.getFunction_name());        
				commonForm.setCurrent_page_no(boardForm.getCurrent_page_no());            
				commonForm.setCount_per_page(10);
				commonForm.setCount_per_list(10);
				commonForm.setTatal_list_count(totalCount);
				commonDto = PagingUtil.setPageUtil(commonForm);
			}
 
			member.setLimit(commonDto.getLimit()); //매퍼
			member.setOffset(commonDto.getOffset());
    
			myboardList = boardDao.getMyBoardList(member);
      
		} else { 
			//판매자 글정보 보기 
			totalCount = boardDao.getSellerBoardCnt(user);
			System.out.println("(서비스 판매자)totalCount: "+ totalCount);
			if (totalCount != 0) {
				CommonForm commonForm = new CommonForm();
				commonForm.setFunction_name(boardForm.getFunction_name()); 		
				commonForm.setCurrent_page_no(boardForm.getCurrent_page_no());
				commonForm.setCount_per_page(10);
				commonForm.setCount_per_list(10);
				commonForm.setTatal_list_count(totalCount);				
				commonDto = PagingUtil.setPageUtil(commonForm);
			}
			boardForm.setLimit(commonDto.getLimit()); // 매퍼
			boardForm.setOffset(commonDto.getOffset());
			myboardList = boardDao.getSellerBoardList(boardForm); 
		}
			
		for (BoardDto file : myboardList) { 			
			file.setImgs(boardDao.selectThumbnail(file.getBoard_seq()));			
		}
        HashMap<String, Object> resultboardMap = new HashMap<String, Object>();
        resultboardMap.put("list", myboardList);
        resultboardMap.put("totalCount", totalCount);
        resultboardMap.put("pagination", commonDto.getPagination());
 
        resultUtil.setData(resultboardMap);
        
        resultUtil.setState("SUCCESS");
 
        return resultUtil;
    }
       
	/**정은수정2  게시판 - 목록 조회(농부) */
	@Override
    public ResultUtil getMyFarmerList(ArticleVO articleVO ,MemberVO member,String user) throws Exception {
		
        ResultUtil resultUtil = new ResultUtil();
        CommonDto commonDto = new CommonDto();
            
        String n_name= member.getN_name();  //이름가져오기    
		int totalCount=0;
		List<ArticleVO> myfarmerList = null;
        
		 if( n_name.equals(user)) { 
			 totalCount = boardDao.getMyFarmerCnt(n_name);       
			 if (totalCount != 0) {
				 CommonForm commonForm = new CommonForm();
				 commonForm.setFunction_name(articleVO.getFunction_name());      
				 System.out.println("articleVO.getFunction_name(): "+ articleVO.getFunction_name());
				 commonForm.setCurrent_page_no(articleVO.getCurrent_page_no());            
				 commonForm.setCount_per_page(10);
				 commonForm.setCount_per_list(10);
				 commonForm.setTatal_list_count(totalCount);
				 commonDto = PagingUtil.setPageUtil(commonForm);
			 }
 
			 member.setLimit(commonDto.getLimit()); //매퍼
			 System.out.println("commonDto.getLimit(): "+ commonDto.getLimit());
			 member.setOffset(commonDto.getOffset());
       
 			 myfarmerList = boardDao.getMyFarmerList(member);
		
		 } else {
			 totalCount = boardDao.getMyFarmerCnt(user);	
			 System.out.println("(서비스) totalcnt : "+totalCount);
			 if (totalCount != 0) {
				 CommonForm commonForm = new CommonForm();
				 commonForm.setFunction_name(articleVO.getFunction_name());
				 System.out.println("articleVO.getFunction_name(): " + articleVO.getFunction_name());
				 commonForm.setCurrent_page_no(articleVO.getCurrent_page_no());
				 commonForm.setCount_per_page(10);
				 commonForm.setCount_per_list(10);
				 commonForm.setTatal_list_count(totalCount);
				 commonDto = PagingUtil.setPageUtil(commonForm);
			 }

			 articleVO.setLimit(commonDto.getLimit()); // 매퍼			 
			 articleVO.setOffset(commonDto.getOffset());
			 articleVO.setN_name(user);
			 myfarmerList = boardDao.getSellerFarmerList(articleVO);
			 
		 }
		 
		for (ArticleVO file : myfarmerList) { 			
				file.setImageFileName(boardDao.selectsellerThumbnail(file.getArticleNO()));			
		}		 
        HashMap<String, Object> resultfarmerMap = new HashMap<String, Object>();
        resultfarmerMap.put("list", myfarmerList);
        resultfarmerMap.put("totalCount", totalCount);
        resultfarmerMap.put("pagination", commonDto.getPagination());      

        resultUtil.setData(resultfarmerMap);  
        
        resultUtil.setState("SUCCESS");
 
        return resultUtil;
    }
       
	/** 내글 목록 삭제 */
	@Override
	public void deleteMyBoardList(BoardForm boardForm)throws Exception{
		boardDao.deleteMyBoard(boardForm);		
	}
    
	
	/** 내글 목록 삭제(농부) */
	@Override
	public void deleteMyFarmerList(ArticleVO articleVO)throws Exception{
		boardDao.deleteMyFarmer(articleVO);		
	}
	
	
	/** (판매)이미지썸네일 */
	@Override
	public BoardFileDto selectThumbnail(int board_seq) throws Exception {
		return boardDao.selectThumbnail(board_seq);
	}
	
	// 농부이미지 썸네일
	@Override
	public String selectsellerThumbnail(int board_seq) throws Exception {
		return boardDao.selectsellerThumbnail(board_seq);
	}
	
	
    /** 여기서부터 예슬 코드 */
    
    @Override
    public String getWriter(int board_seq) throws Exception {
    	return boardDao.getWriter(board_seq);
    }
    
	@Override
	public List<String> searchByKeyword(String keyword) throws Exception { //키워드로 품목 검색
		List<String> list=boardDao.searchByKeyword(keyword);
		return list;
	}
	
	@Override
	public List<CommentVO> listComments(int post_NO) throws Exception {
		List<CommentVO> commentList = null;
		commentList = boardDao.selectComments(post_NO);
		return commentList;
	}
	
	@Override
	public boolean addComment(CommentVO commentVO) throws Exception { //댓글 등록
		int NO=boardDao.select_commentNO();
		int seq=commentVO.getSeq();
		System.out.println("seq:"+seq);
		if(seq==1) { //댓글일 때
			System.out.println("댓글");
			commentVO.setParent_NO(NO);
		}
		else { //대댓글일 때
			System.out.println("대댓글");
			int parent_NO=commentVO.getParent_NO();
			comment=boardDao.checkSeq(parent_NO);
			
			if(comment.getSeq()==1) { //첫 댓글에 대한 대댓글일 때
				int tmp=boardDao.selectSeq(parent_NO); //해당 parent_NO에서의 최대 seq값+1 반환
				commentVO.setSeq(tmp);
				commentVO.setRe_name(comment.getN_name());
			}
			else {
				int tmp=comment.getParent_NO();
				commentVO.setParent_NO(tmp);
				commentVO.setSeq(boardDao.selectSeq(tmp));
				commentVO.setRe_name(comment.getN_name());
			}
		}
		commentVO.setComment_NO(NO);
		boardDao.insertComment(commentVO);
		boolean result=true;
		return result;
	}
	
	@Override
	public boolean deleteComment(int comment_NO) throws Exception { //댓글 삭제
		comment=boardDao.checkSeq(comment_NO);
		if(comment.getSeq()!=1) { //대댓글이면 그 댓글만 삭제
			boardDao.deleteComment2(comment_NO);
		}
		else { //대댓글이 아닌 댓글이면
			boardDao.deleteComment1(comment_NO);
		}
		boolean result=true;
		return result;
	}
	
	@Override
	public boolean updateComment(Map<String,Object> commentMap) throws Exception { //댓글 수정
		boardDao.updateComment(commentMap);
		boolean result=true;
		return result;
	}
	
	@Override
	public String checkSellBookmark(Map<String,Object> bookMap) throws Exception { //판매 카테고리에서 해당 글 북마크 여부 확인
		return boardDao.checkSellBookmark(bookMap);
	}
	
	@Override
	public boolean addSellBookmark(Map<String,Object> bookMap) throws Exception { //판매 카테고리에서 해당 글 북마크 설정
		boardDao.addSellBookmark(bookMap);
		boolean result=true;
		return result;
	}
	
	@Override
	public boolean deleteSellBookmark(Map<String,Object> bookMap) throws Exception { //판매 카테고리에서 해당 글 북마크 설정
		boardDao.deleteSellBookmark(bookMap);
		boolean result=true;
		return result;
	}
	
	@Override
	public Map<String,Object> select_Total_Bookmark(Map<String,Object> bookMap) throws Exception { //카테고리별 북마크한 글의 수
		Map<String,Object> resultCntMap=new HashMap<String,Object>();
		int cntBoard=boardDao.select_Total_Bookmark(bookMap);
		bookMap.put("category", "농부");
		int cntFarmer=boardDao.select_Total_Bookmark(bookMap);
		bookMap.put("category", "교환");
		int cntExchange=boardDao.select_Total_Bookmark(bookMap);
		bookMap.put("category", "나눔");
		int cntShare=boardDao.select_Total_Bookmark(bookMap);
		
		resultCntMap.put("cntBoard", cntBoard);
		resultCntMap.put("cntFarmer", cntFarmer);
		resultCntMap.put("cntExchange", cntExchange);
		resultCntMap.put("cntShare", cntShare);
		return resultCntMap;
	}
	
	@Override
	public List<BookmarkVO> listSellBookmark(Map<String,Object> bookMap) throws Exception { //판매 카테고리 중 회원이 추가해놓은 북마크 list
		List<BookmarkVO> bookmarkList = null;
		bookmarkList = boardDao.listSellBookmark(bookMap);
		return bookmarkList;
	}
	
	@Override
	public boolean updateSell_YN(Map<String,Object> boardMap) throws Exception { //sell_YN(판매여부) 변경
		boardDao.updateSell_YN(boardMap);
		boolean result=true;
		return result;
	}

	@Override
	public String add_delete_Bookmark(Map<String,Object> bookMap) throws Exception { //북마크 여부 판단 후 추가 및 삭제
		String exist=boardDao.checkSellBookmark(bookMap);
		if(exist.equals("true")) { //북마크가 존재하면 삭제
			boardDao.deleteSellBookmark(bookMap);
		}
		else { //북마크가 존재하지 않으면 추가
			boardDao.addSellBookmark(bookMap);
		}
		
		return exist;
	}
}