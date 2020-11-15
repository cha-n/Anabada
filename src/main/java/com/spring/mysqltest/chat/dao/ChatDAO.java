package com.spring.mysqltest.chat.dao;

import java.util.ArrayList;

import com.spring.mysqltest.chat.vo.ChatVO;


public interface ChatDAO {
	public ArrayList<ChatVO> selectChatListByID(String fromID, String toID, String chatID) throws Exception;
	public ArrayList<ChatVO> selectChatListByRecent(String fromID, String toID, int number) throws Exception;
	public int submit(ChatVO chat) throws Exception;	// 채팅 전송
	int getAllUnreadChat(String userID) throws Exception;	// 안 읽은 모든 메세지 갯수
	void readChat(String fromID, String toID) throws Exception;	// 읽은 메세지 체크
	ArrayList<ChatVO> getBox(String userID) throws Exception;	// 메세지함
	public int getUnreadChat(String fromID, String toID) throws Exception;	// 대화 상대 별 안 읽은 메세지 갯수
	public String getProfile(String fromID) throws Exception;		// 프로필 사진 가져오기
}
