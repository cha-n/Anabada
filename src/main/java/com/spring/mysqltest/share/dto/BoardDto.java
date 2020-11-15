package com.spring.mysqltest.share.dto;

import java.util.List;

import com.spring.mysqltest.member.vo.MemberVO;
import com.spring.mysqltest.seller.vo.ArticleVO;

public class BoardDto extends CommonDto {

    int board_seq;
    int board_re_ref;
    int board_re_lev;
    int board_re_seq;
    String board_writer;
    String board_subject;
    String board_content;
    int board_hits;
    String ins_date;
    String result;
	String item;
	String SELL_YN;
	String locat;
	private MemberVO memberVO;
	private ArticleVO articleVO;
	List<BoardFileDto> files;
	//(정은수정2)
	
	private BoardFileDto imgs;
	

	public BoardFileDto getImgs() {
		return imgs;
	}

	public void setImgs(BoardFileDto imgs) {
		this.imgs = imgs;
	}

	public int getBoard_seq() {
        return board_seq;
    }

	public void setBoard_seq(int board_seq) {
        this.board_seq = board_seq;
    }
 
    public int getBoard_re_ref() {
        return board_re_ref;
    }
 
    public void setBoard_re_ref(int board_re_ref) {
        this.board_re_ref = board_re_ref;
    }
 
    public int getBoard_re_lev() {
        return board_re_lev;
    }
 
    public void setBoard_re_lev(int board_re_lev) {
        this.board_re_lev = board_re_lev;
    }
 
    public int getBoard_re_seq() {
        return board_re_seq;
    }
 
    public void setBoard_re_seq(int board_re_seq) {
        this.board_re_seq = board_re_seq;
    }
 
    public String getBoard_writer() {
        return board_writer;
    }
 
    public void setBoard_writer(String board_writer) {
        this.board_writer = board_writer;
    }
 
    public String getBoard_subject() {
        return board_subject;
    }
 
    public void setBoard_subject(String board_subject) {
        this.board_subject = board_subject;
    }
 
    public String getBoard_content() {
        return board_content;
    }
 
    public void setBoard_content(String board_content) {
        this.board_content = board_content;
    }
 
    public int getBoard_hits() {
        return board_hits;
    }
 
    public void setBoard_hits(int board_hits) {
        this.board_hits = board_hits;
    }
 
 
    public String getIns_date() {
        return ins_date;
    }
 
    public void setIns_date(String ins_date) {
        this.ins_date = ins_date;
    }
 

 
    public String getResult() {
        return result;
    }
 
    public void setResult(String result) {
        this.result = result;
    }
 
    public List<BoardFileDto> getFiles() {
        return files;
    }
 
    public void setFiles(List<BoardFileDto> files) {
        this.files = files;
    }
    
    public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public String getSELL_YN() {
		return SELL_YN;
	}

	public void setSELL_YN(String sELL_YN) {
		SELL_YN = sELL_YN;
	}

	public String getLocat() {
		return locat;
	}

	public void setLocat(String locat) {
		this.locat = locat;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	public ArticleVO getArticleVO() {
		return articleVO;
	}

	public void setArticleVO(ArticleVO articleVO) {
		this.articleVO = articleVO;
	}
	

}
