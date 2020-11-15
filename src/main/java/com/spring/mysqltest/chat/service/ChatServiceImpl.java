package com.spring.mysqltest.chat.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mysqltest.chat.dao.ChatDAO;
import com.spring.mysqltest.chat.vo.ChatVO;

@Service("chatService")
public class ChatServiceImpl implements ChatService {
	@Autowired
	ChatDAO chatDAO;

	@Override
	public ArrayList<ChatVO> listChatsByID(String fromID, String toID, String chatID) throws Exception {
		ArrayList<ChatVO> chatList = new ArrayList<ChatVO>();
		chatList=chatDAO.selectChatListByID(fromID, toID, chatID);
		return chatList;
	}

	@Override
	public ArrayList<ChatVO> listChatsByRecent(String fromID, String toID, int number) throws Exception {
		ArrayList<ChatVO> chatList = new ArrayList<ChatVO>();
		chatList=chatDAO.selectChatListByRecent(fromID, toID, number);
		return chatList;
	}

	// 채팅 전송
	@Override
	public int submit(ChatVO chat) throws Exception {
		return chatDAO.submit(chat);
	}


	@Override
	public void readChat(String fromID, String toID) throws Exception {
		chatDAO.readChat(fromID, toID);
	}

	@Override
	public int getAllUnreadChat(String userID) throws Exception {
		return chatDAO.getAllUnreadChat(userID);
	}

	@Override
	public ArrayList<ChatVO> getBox(String userID) throws Exception {
		ArrayList<ChatVO> chatList = new ArrayList<ChatVO>();
		chatList=chatDAO.getBox(userID);
		return chatList;
	}

	@Override
	public int getUnreadChat(String fromID, String toID) throws Exception {
		return chatDAO.getUnreadChat(fromID, toID);
	}

	@Override
	public String getProfile(String fromID) throws Exception {
		return chatDAO.getProfile(fromID);
	}
}
