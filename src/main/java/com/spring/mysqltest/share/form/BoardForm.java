package com.spring.mysqltest.share.form;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import com.spring.mysqltest.member.vo.MemberVO;
public class BoardForm extends CommonForm {

	List<MultipartFile> files;
	private MemberVO memberVO;
	int board_seq;
	int board_parent_seq;
	int board_re_ref;
	int board_re_lev;
	int board_re_seq;
	String board_writer;
	String board_subject;
	String board_content;
	int board_hits;
	Date ins_date;
	String board_file;
	String delete_file;
	String item;
	String locat; //(수정)
	//정은수정
	String searchType;
	String keyword;
	
	@Override
	public String toString() {
	
		 return "BoardForm [searchType=" + searchType + ", keyword=" + keyword + "]";
	}
		
	public String getSearchType() {
		System.out.println("(form) 서치타입get : " + searchType);
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public MemberVO getMemberVO() {
			return memberVO;
		}

	public void setMemberVO(MemberVO memberVO) {
			this.memberVO = memberVO;
		}

	
	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public List<MultipartFile> getFiles() {
	        return files;
	    }
	 
	    public void setFiles(List<MultipartFile> files) {
	        this.files = files;
	    }

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public int getBoard_parent_seq() {
		return board_parent_seq;
	}

	public void setBoard_parent_seq(int board_parent_seq) {
		this.board_parent_seq = board_parent_seq;
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


	public Date getIns_date() {
		return ins_date;
	}

	public void setIns_date(Date ins_date) {
		this.ins_date = ins_date;
	}


    public String getBoard_file() {
        return board_file;
    }
 
    public void setBoard_file(String board_file) {
        this.board_file = board_file;
    }

    public String getDelete_file() {
        return delete_file;
    }
 
    public void setDelete_file(String delete_file) {
        this.delete_file = delete_file;
    }

	public String getLocat() {
		return locat;
	}

	public void setLocat(String locat) {
		this.locat = locat;
	}
}
