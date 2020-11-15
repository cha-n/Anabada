package com.spring.mysqltest.chat.service;

import java.util.ArrayList;

import com.spring.mysqltest.chat.vo.ChatVO;

public interface ChatService {
	public ArrayList<ChatVO> listChatsByID(String fromID, String toID, String chatID) throws Exception;
	public ArrayList<ChatVO> listChatsByRecent(String fromID, String toID, int number) throws Exception;
	public int submit(ChatVO chat) throws Exception;
	void readChat(String fromID, String toID) throws Exception;
	int getAllUnreadChat(String userID) throws Exception;
	ArrayList<ChatVO> getBox(String userID) throws Exception;
	int getUnreadChat(String fromID, String toID) throws Exception;
	String getProfile(String fromID) throws Exception;	// 프로필 사진 가져오기
}
