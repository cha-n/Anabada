package com.spring.mysqltest.chat.dao;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.mysqltest.chat.vo.ChatVO;


@Repository("chatDAO")
public class ChatDAOImpl implements ChatDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<ChatVO> selectChatListByID(String fromID, String toID, String chatID) throws Exception {
		// System.out.println("@DAO listChatsByID()");
		ChatVO chat=new ChatVO();
		chat.setFromID(fromID);
		chat.setToID(toID);
		chat.setChatID(Integer.parseInt(chatID));
		
		List<ChatVO> chatList=sqlSession.selectList("mapper.chat.selectChatListByID", chat);
		ArrayList<ChatVO> chatList_ = new ArrayList<ChatVO>();
		
		for(ChatVO chatVO : chatList)
		{
			String FROMID=chatVO.getFromID();
			chatVO.setFromID(FROMID.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
			String TOID=chatVO.getToID();
			chatVO.setToID(TOID.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
			String CHATCONTENT=chatVO.getChatContent();
			chatVO.setChatContent(CHATCONTENT.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
			String CHATTIME=chatVO.getChatTime();
			int chatTime=Integer.parseInt(chatVO.getChatTime().substring(11, 13));
			String timeType="AM";
			if(chatTime>12) {
				timeType="PM";
				chatTime-=12;
			}
			chatVO.setChatTime(CHATTIME.substring(0,11) + " " + timeType + " " + chatTime + ":" + CHATTIME.substring(14,16));
			chatList_.add(chatVO);
		}

		return chatList_;
	}


	@Override
	public ArrayList<ChatVO> selectChatListByRecent(String fromID, String toID, int number) throws Exception { //NUMBER=CHATID !!
		// System.out.println("@DAO listChatsByRECENT()");
		ChatVO chat=new ChatVO();
		chat.setFromID(fromID);
		chat.setToID(toID);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("fromID", fromID);
		map.put("toID", toID);
		map.put("number", number);
		// System.out.println(map);

		List<ChatVO> chatList=sqlSession.selectList("mapper.chat.selectChatListByRecent", map);

		ArrayList<ChatVO> chatList_ = new ArrayList<ChatVO>();

		for(ChatVO chatVO : chatList)
		{
			String FROMID=chatVO.getFromID();
			chatVO.setFromID(FROMID.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
			String TOID=chatVO.getToID();
			chatVO.setToID(TOID.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
			String CHATCONTENT=chatVO.getChatContent();
			chatVO.setChatContent(CHATCONTENT.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
			String CHATTIME=chatVO.getChatTime();
			int chatTime=Integer.parseInt(chatVO.getChatTime().substring(11, 13));
			String timeType="AM";
			if(chatTime>12) {
				timeType="PM";
				chatTime-=12;
			}
			chatVO.setChatTime(CHATTIME.substring(0,11) + " " + timeType + " " + chatTime + ":" + CHATTIME.substring(14,16));
			chatList_.add(chatVO);
		}
		return chatList_;

	}

	@Override
	public ArrayList<ChatVO> getBox(String userID) throws Exception {
		// System.out.println("@DAO getBox()");
		ChatVO chat=new ChatVO();
		List<ChatVO> chatList=sqlSession.selectList("mapper.chat.selectBox", userID);
		

		ArrayList<ChatVO> chatList_ = new ArrayList<ChatVO>();
		for(ChatVO chatVO : chatList)
		{
			chatVO.setChatID(chatVO.getChatID());
			String FROMID=chatVO.getFromID();
			chatVO.setFromID(FROMID.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
			String TOID=chatVO.getToID();
			chatVO.setToID(TOID.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
			String CHATCONTENT=chatVO.getChatContent();
			chatVO.setChatContent(CHATCONTENT.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
			String CHATTIME=chatVO.getChatTime();
			int chatTime=Integer.parseInt(chatVO.getChatTime().substring(11, 13));
			String timeType="AM";
			if(chatTime>12) {
				timeType="PM";
				chatTime-=12;
			}
			chatVO.setChatTime(CHATTIME.substring(0,11) + " " + timeType + " " + chatTime + ":" + CHATTIME.substring(14,16));
			chatList_.add(chatVO);
		}
		
		for (int i = 0; i < chatList_.size(); i++) {
			ChatVO x = chatList_.get(i);
			for (int j = 0; j < chatList_.size(); j++) {
				ChatVO y = chatList_.get(j);
				if (x.getFromID().equals(y.getToID()) && x.getToID().equals(y.getFromID())) {
					if (x.getChatID() < y.getChatID()) {
						chatList_.remove(x);
						i--;
						break;
					} else {
						chatList_.remove(y);
						j--;
					}
				}
			}
		}
		return chatList_;
	}

	// 채팅 전송
	@Override
	public int submit(ChatVO chat) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("fromID", chat.getFromID());
		map.put("toID", chat.getToID());
		map.put("chatContent", chat.getChatContent());
		map.put("chatRead", 0);
		return sqlSession.insert("mapper.chat.insertChat", map);
	}

	// 채팅 읽음 확인(안 읽은 채팅 개수 0으로 초기화)
	@Override
	public void readChat(String fromID, String toID) throws Exception {
		ChatVO chat=new ChatVO();
		chat.setFromID(fromID);
		chat.setToID(toID);
		sqlSession.update("mapper.chat.readChat", chat);
	}

	// 안 읽은 채팅 개수 총 합
	@Override
	public int getAllUnreadChat(String userID) throws Exception {
		return sqlSession.selectOne("mapper.chat.getAllUnreadChat", userID);
	}

	// 안 읽은 채팅 개수
	@Override
	public int getUnreadChat(String fromID, String toID) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("fromID", fromID);
		map.put("toID", toID);
		return sqlSession.selectOne("mapper.chat.getUnreadChat", map);
	}

	// 사용자 프로필
	@Override
	public String getProfile(String fromID) throws Exception {
		return sqlSession.selectOne("mapper.chat.getProfile", fromID);
	}
}
