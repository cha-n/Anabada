package com.spring.mysqltest.seller.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.member.vo.MemberVO;
import com.spring.mysqltest.seller.service.BoardService;
import com.spring.mysqltest.seller.vo.ArticleVO;
import com.spring.mysqltest.seller.vo.Criteria;
import com.spring.mysqltest.seller.vo.ImageVO;
import com.spring.mysqltest.seller.vo.PageMaker;
import com.spring.mysqltest.seller.vo.ReviewVO;

@Controller("sellerController")
@RequestMapping(value = "/seller")
public class BoardControllerImpl implements BoardController {
	private static final String ARTICLE_IMAGE_REPO = "/home/anabada/images/article_image";
	@Autowired
	BoardService boardService;
	@Autowired
	ArticleVO articleVO;
	@Autowired
	ImageVO imageVO;
	@Autowired
	MemberVO member;
	ReviewVO review;

	// 글 목록
	@Override
	@RequestMapping(value = "/listArticles", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView listArticles(@RequestParam(value = "keyword", required = false) String keyword, @RequestParam(value = "writer", required = false) String writer, Criteria cri,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		member = (MemberVO) session.getAttribute("member");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		String userID;
		if(member!=null) {
			userID = member.getN_name();
		}
		else {
			userID="";
		}

		String viewName;
		List<ArticleVO> articlesList;
		if ((writer == null || writer.equals("")) && keyword != null) { // 키워드 O, 작성자 X
			// keyword 검색
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("keyword", keyword);
			if (userID.equals("admin")) { // 관리자
				pageMaker.setTotalCount(boardService.countAllArticlesList_searchedByKeyword(keyword)); // 총 게시글 수
				map.put("page", cri.getPage());
				map.put("perPageNum", cri.getPerPageNum());
				map.put("pageStart", cri.getPageStart());
				articlesList = boardService.listArticles_admin_searchedByKeyword(map);
			} else { // 사용자
				System.out.println("@"+boardService.countAcceptedArticlesList_searchedByKeyword(keyword));
				pageMaker.setTotalCount(boardService.countAcceptedArticlesList_searchedByKeyword(keyword)); // 승인된 게시글 수
				map.put("page", cri.getPage());
				map.put("perPageNum", cri.getPerPageNum());
				map.put("pageStart", cri.getPageStart());
				articlesList = boardService.listArticles_searchedByKeyword(map);
			}

		} else if ((keyword == null || keyword.equals("")) && writer != null){	// 키워드 X, 작성자 O
			// writer 검색
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("writer", writer);
			if (userID.equals("admin")) {	// 관리자
				pageMaker.setTotalCount(boardService.countAllArticlesList_searchedByWriter(writer)); // 총 게시글 수
				map.put("page", cri.getPage());
				map.put("perPageNum", cri.getPerPageNum());
				map.put("pageStart", cri.getPageStart());
				articlesList = boardService.listArticles_admin_searchedByWriter(map);
			} else {	// 사용자
				pageMaker.setTotalCount(boardService.countAcceptedArticlesList_searchedByWriter(writer)); // 승인된 게시글 수
				map.put("page", cri.getPage());
				map.put("perPageNum", cri.getPerPageNum());
				map.put("pageStart", cri.getPageStart());
				articlesList = boardService.listArticles_searchedByWriter(map);
			}
			System.out.println("writer : "+writer+" "+map);

		} else {	// 키워드 X, 작성자 X
			if (userID.equals("admin")) {
				// 관리자
				pageMaker.setTotalCount(boardService.countAllArticlesList()); // 총 게시글 수
				articlesList = boardService.listArticles_admin(cri);
			} else {
				// 사용자
				pageMaker.setTotalCount(boardService.countAcceptedArticlesList()); // 승인된 게시글 수
				articlesList = boardService.listArticles(cri);
			}
		}
		for (ArticleVO article : articlesList) {
			article.setImageFileName(boardService.selectThumbnail(article.getArticleNO()));
		}
		viewName = "seller/listArticles";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("articlesList", articlesList);
		mav.addObject("pageMaker", pageMaker);
		mav.addObject("keyword", keyword);
		mav.addObject("writer", writer);
		return mav;
	}

	// 승인하기
	@Override
	@RequestMapping(value = "/accept", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity acceptArticle(@RequestParam("articleNO") int articleNO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("@Controller /acceptArticle articleNO : " + articleNO);
		response.setContentType("text/html; charset=UTF-8");
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			boardService.acceptArticle(articleNO);
			message = "<script>";
			message += " alert('글을 승인하였습니다.');";
			message += " location.href='" + request.getContextPath() + "/seller/listArticles';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			message = "<script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요.');";
			message += " location.href='" + request.getContextPath() + "/seller/listArticles';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	// 글 수정
	@RequestMapping(value="/modForm" ,method=RequestMethod.POST)
	public ModelAndView modifyGoodsForm(@RequestParam("articleNO") int articleNO, HttpServletRequest request, HttpServletResponse response)  throws Exception {
	  String viewName="seller/modArticle";
		ModelAndView mav = new ModelAndView(viewName);
		Map articleMap = new HashMap();
		articleMap = boardService.viewArticle(articleNO);
		mav.addObject("articleMap",articleMap);
		return mav;
	}


	// 글 수정할 때 삭제한 이미지 폴더에서 삭제
	public void deleteExistFile(String fileName, String articleNO) throws Exception {
	    File f=new File(ARTICLE_IMAGE_REPO+"/"+articleNO+"/"+fileName);
	    Map<String,Object> imageMap = new HashMap<String,Object>();
	    imageMap.put("articleNO", articleNO);
	    imageMap.put("imageFileName", fileName);

	    if(f.exists()) { 
	    	f.delete();
	    	boardService.deleteExistedImage(imageMap);
	    }
	    else {
	    	System.out.println("파일이 존재하지 않습니다.");
	    }
	}

	// 글 수정
	@RequestMapping(value="/modArticle" ,method=RequestMethod.POST)
	public ResponseEntity modArticle(MultipartHttpServletRequest request, HttpServletResponse response)  throws Exception {
		Map articleMap = new HashMap();
		Enumeration enu = request.getParameterNames();
		String imageFileName = null;


		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = request.getParameter(name);
			articleMap.put(name, value);
		}

		String articleNO=(String) articleMap.get("articleNO");
		int existedNum=Integer.parseInt(((String) articleMap.get("existedImageNum")));
		for(int i=1; i<=existedNum; i++) {
			if(articleMap.containsKey("imageFileNO"+i)==true) {
				String fileName=(String) articleMap.get("imageFileName"+i);
				deleteExistFile(fileName, articleNO);
			}
		}
		List<String> fileList = upload(request);
		List<ImageVO> imageFileList = new ArrayList<ImageVO>();
		if (fileList != null && fileList.size() != 0) {
			for (String fileName : fileList) {
				ImageVO imageVO = new ImageVO();
				imageVO.setImageFileName(fileName);
				imageFileList.add(imageVO);
			}
			articleMap.put("imageFileList", imageFileList);
		}

		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		String articleNo = articleMap.get("articleNO")+"";

		try {
			boardService.modArticle(articleMap);
			boardService.modArticleImage(imageFileList);
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					imageFileName = imageVO.getImageFileName();
					System.out.println("imagefilename="+imageFileName);
					File srcFile = new File(ARTICLE_IMAGE_REPO + "/" + "temp" + "/" + imageFileName);
					File destDir = new File(ARTICLE_IMAGE_REPO + "/" + articleNO); // destDir.mkdirs();
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
			message = "<script>";
			message += " location.href='" + request.getContextPath() + "/seller/viewArticle?articleNO=" + articleNo +"';";
			message += "</script>";
			resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		}catch(Exception e) {
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					imageFileName = imageVO.getImageFileName();
					File srcFile = new File(ARTICLE_IMAGE_REPO + "/" + "temp" + "/" + imageFileName);
					srcFile.delete();
				}
			}
			message = "<script>";
			message += "alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요.');";
			message += "location.href='" + request.getContextPath() + "/seller/listArticles'; ";
			message += "</script>";
			resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEntity;
	}


	// 글 삭제
	@Override
	@RequestMapping(value = "/removeArticle", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity removeArticle(@RequestParam("articleNO") int articleNO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			boardService.removeArticle(articleNO);
			

			message = "<script>";
			message += " alert('글을 삭제하였습니다.');";
			message += " location.href='" + request.getContextPath() + "/seller/listArticles';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			message = "<script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요.');";
			message += " location.href='" + request.getContextPath() + "/seller/listArticles';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	// 새 글 쓰기 창
	@RequestMapping(value = "/*Form", method = RequestMethod.GET)
	private ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = "seller/articleForm";
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}

	// 글 추가
	@Override
	@RequestMapping(value = "/addNewArticle", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity addNewArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		String imageFileName = null;
		Map articleMap = new HashMap();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			articleMap.put(name, value);
		}

		// 로그인 시 세션에 저장된 회원 정보에서 글쓴이 아이디를 가져와 Map에 저장.
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		String n_name = memberVO.getN_name();
		articleMap.put("n_name", n_name);

		List<String> fileList = upload(multipartRequest);
		List<ImageVO> imageFileList = new ArrayList<ImageVO>();
		if (fileList != null && fileList.size() != 0) {
			for (String fileName : fileList) {
				ImageVO imageVO = new ImageVO();
				imageVO.setImageFileName(fileName);
				imageFileList.add(imageVO);
			}
			articleMap.put("imageFileList", imageFileList);
		}
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			int articleNO = boardService.addNewArticle(articleMap);
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					imageFileName = imageVO.getImageFileName();
					File srcFile = new File(ARTICLE_IMAGE_REPO + "/" + "temp" + "/" + imageFileName);
					File destDir = new File(ARTICLE_IMAGE_REPO + "/" + articleNO); // destDir.mkdirs();
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}

			message = "<script>";
			message += " alert('새 글을 추가하였습니다.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/seller/listArticles'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					imageFileName = imageVO.getImageFileName();
					File srcFile = new File(ARTICLE_IMAGE_REPO + "/" + "temp" + "/" + imageFileName);
					srcFile.delete();
				}
			}

			message = " <script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');');";
			message += " location.href='" + multipartRequest.getContextPath() + "/seller/listArticles'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	
	// 글 상세 조회
	@RequestMapping(value = "/viewArticle", method = RequestMethod.GET)
	public ModelAndView viewArticle(@RequestParam("articleNO") int articleNO,@RequestParam(value = "action", required = false) String action,  @RequestParam(value = "active", required = false) String active,HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = "seller/viewArticle";

		String result; // 북마크

		HttpSession session = request.getSession();
		if(session.getAttribute("member") != null) {
			Map<String,Object> bookMap=new HashMap<String,Object>();
			bookMap.put("post_NO",articleNO);
			bookMap.put("category","농부");
			String n_name=((MemberVO) session.getAttribute("member")).getN_name();
			bookMap.put("n_name",n_name);
			result=boardService.checkFarmerBookmark(bookMap);
		}
		else {
			result="false";
		}
		
		boardService.updateArticleHits(articleNO);
		String profile = boardService.getProfile(articleNO);
		Map articleMap = boardService.viewArticle(articleNO);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		mav.addObject("articleMap", articleMap);
		mav.addObject("result", result);
		mav.addObject("action", action);
		mav.addObject("active", active);
		mav.addObject("profile", profile);
		return mav;
	}

	// 이미지 업로드
	private List<String> upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		List<String> fileList= new ArrayList<String>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while(fileNames.hasNext()){
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName=mFile.getOriginalFilename();


			if(originalFileName!=null && originalFileName!="") {
				fileList.add(originalFileName);
				File file = new File(ARTICLE_IMAGE_REPO +"/"+ fileName);
				if(mFile.getSize()!=0){
					//File Null Check
					if(! file.exists()){
						// 경로에 파일이 존재하지 않는 경우
						if(file.getParentFile().mkdirs()){
							// 경로에 해당 디렉토리 생성
								file.createNewFile(); // 파일 생성
						}
					}
					mFile.transferTo(new File(ARTICLE_IMAGE_REPO +"/"+"temp"+ "/"+originalFileName)); // 임시로 저장된 multipartFile 실제 파일로 전송
				}
			}
		}
		return fileList;
	}


	@Override
	@RequestMapping(value="/listFarmerBookmark" ,method = RequestMethod.POST)
	public @ResponseBody List<BookmarkVO> listFarmerBookmark(@RequestParam("n_name") String n_name, @RequestParam("page") int page, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> bookMap=new HashMap<String,Object>();
		bookMap.put("n_name", n_name);
		bookMap.put("page", page);
		List<BookmarkVO> bookmarkList=boardService.listFarmerBookmark(bookMap); 	// 회원이 추가해놓은 북마크 list
		return bookmarkList;
	}

	@Override
	@RequestMapping(value="/writeReviewForm" ,method = RequestMethod.POST) // 리뷰 작성 폼으로 이동
	public ModelAndView writeReviewForm(@RequestParam("articleNO") int articleNO, @RequestParam("orderNO") int orderNO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		articleVO=boardService.selectItemInfo(articleNO);
		String viewName = "seller/writeReviewForm";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("article", articleVO);
		mav.addObject("articleNO", articleNO);
		mav.addObject("orderNO", orderNO);
		return mav;
	}

	@Override
	@RequestMapping(value = "/addReview", method = RequestMethod.POST) // 리뷰 작성
	@ResponseBody
	public ResponseEntity addReview(@ModelAttribute("reviewVO") ReviewVO reviewVO, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
	    member=(MemberVO) session.getAttribute("member");
	    String n_name=member.getN_name();
	    reviewVO.setN_name(n_name);

		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			boardService.addReview(reviewVO);
			message = "<script>";
			message += " alert('리뷰를 작성하였습니다.');";
			message += " location.href='"+request.getContextPath()+"/order/myOrder';";
			message +=" </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			message = " <script>";
			message +=" alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');');";
			message += " location.href='" + request.getContextPath() + "/order/myOrder'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	@Override
	@RequestMapping(value="/myReview" ,method = RequestMethod.GET) // 회원의 리뷰 목록
	public ModelAndView myReview(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
	    member=(MemberVO) session.getAttribute("member");
	    String n_name=member.getN_name();
		List<ReviewVO> reviewList=boardService.selectMyReviewList(n_name);
		String viewName = "seller/myReview";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("reviewList", reviewList);
		return mav;
	}

	@Override
	@RequestMapping(value="/modReview" ,method = RequestMethod.POST) // 회원의 리뷰 수정폼으로 이동
	public ModelAndView modReview(@RequestParam("review_NO") int review_NO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		review=boardService.selectMyReview(review_NO);
		String viewName = "seller/modReview";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("review", review);
		return mav;
	}

	@Override
	@RequestMapping(value = "/modifyReview", method = RequestMethod.POST) // 리뷰 수정
	@ResponseBody
	public ResponseEntity modifyReview(@ModelAttribute("reviewVO") ReviewVO reviewVO, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			boardService.updateReview(reviewVO);
			message = "<script>";
			message += " alert('리뷰를 수정하였습니다.');";
			message += " location.href='"+request.getContextPath()+"/seller/myReview';";
			message +=" </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			message = " <script>";
			message +=" alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');');";
			message += " location.href='" + request.getContextPath() + "/sellermyReview'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	@Override
	@RequestMapping(value = "/deleteReview", method = RequestMethod.POST) // 리뷰 삭제
	@ResponseBody
	public ResponseEntity deleteReview(@RequestParam("review_NO") int review_NO, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			boardService.deleteReview(review_NO);
			message = "<script>";
			message += " alert('리뷰를 삭제하였습니다.');";
			message += " location.href='"+request.getContextPath()+"/seller/myReview';";
			message +=" </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			message = " <script>";
			message +=" alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');');";
			message += " location.href='" + request.getContextPath() + "/sellermyReview'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	@RequestMapping(value="/vegatPopUp" ,method = RequestMethod.GET) // 품목 선택 팝업
	public String vegatPopUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "seller/vegatPopUp";
	}
}
