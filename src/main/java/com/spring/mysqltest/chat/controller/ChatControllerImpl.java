package com.spring.mysqltest.chat.controller;

import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mysqltest.chat.dao.ChatDAO;
import com.spring.mysqltest.chat.service.ChatService;
import com.spring.mysqltest.chat.vo.ChatVO;
import com.spring.mysqltest.member.vo.MemberVO;

@Controller("chatController")
//@RequestMapping(value="/chatting")
public class ChatControllerImpl implements ChatController {

	@Autowired
	private ChatService chatService;
	private MemberVO member;

	@RequestMapping(value="/chat" ,method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView chat(@RequestParam(value="toID",required=false) String toID, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName;
		HttpSession session = request.getSession();
		member = (MemberVO) session.getAttribute("member");
		if (member==null) {
				viewName = "member/loginForm";
		}else {
				String userID = member.getN_name();
				session.setAttribute("userID", userID);
				viewName = "chat/chatting";
		}
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("toID", toID);
		return mav;
	}

	@RequestMapping(value = "/list", produces = "application/test; charset=utf8", method = RequestMethod.POST)
	public @ResponseBody String list(@RequestParam(value = "fromID", required = false) String fromID,
			@RequestParam(value = "toID", required = false) String toID,
			@RequestParam(value = "listType", required = false) String listType, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (fromID == null || fromID.equals("") || toID == null || toID.equals("") || listType == null
				|| listType.equals("")) {
			return "";
		} else {
			try {
				String result = getID(URLDecoder.decode(fromID, "UTF-8"), URLDecoder.decode(toID, "UTF-8"), listType);
				return result;
			} catch (Exception e) {
				return "";
			}
		}
	}

	public String getID(String fromID, String toID, String chatID) throws Exception {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		List<ChatVO> chatList = chatService.listChatsByID(fromID, toID, chatID);
		if (chatList.size() == 0)
			return "";
		for (int i = 0; i < chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getFromID() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToID() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"},");
			result.append("{\"value\": \"" + chatService.getProfile(chatList.get(i).getFromID()) + "\"}]");
			if (i != chatList.size() - 1)
				result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() - 1).getChatID() + "\"}");
		chatService.readChat(fromID, toID);
		return result.toString();
	}

	@Override
	@RequestMapping(value = "/submit", method = RequestMethod.POST)
	public @ResponseBody int submit(@RequestParam(value = "fromID", required = false) String fromID,
			@RequestParam(value = "toID", required = false) String toID,
			@RequestParam(value = "chatContent", required = false) String chatContent, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (fromID == null || fromID.equals("") || toID == null || toID.equals("") || chatContent == null
				|| chatContent.equals("")) {
			return 0;
		} else {
			ChatVO chat = new ChatVO();
			fromID = URLDecoder.decode(fromID, "UTF-8");
			toID = URLDecoder.decode(toID, "UTF-8");
			chatContent = URLDecoder.decode(chatContent, "UTF-8");
			chat.setFromID(fromID);
			chat.setToID(toID);
			chat.setChatContent(chatContent);
			return chatService.submit(chat);
		}
	}

	// 안 읽은 메세지 개수
	@Override
	@RequestMapping(value = "/chatUnread", method = RequestMethod.POST)
	public @ResponseBody String getAllUnreadChat(@RequestParam(value = "userID", required = false) String userID,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ChatController chatUnread userID : " + userID);
		if (userID == null || userID.equals("userID")) {
			System.out.println("null");
			return "";
		} else {
			userID = URLDecoder.decode(userID, "UTF-8");
			String res = chatService.getAllUnreadChat(userID) + "";
			return res;
		}
	}

	// 메세지함
	@RequestMapping(value = "/listBox", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView listBox(@RequestParam(value = "userID", required = false) String userID, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName;
		HttpSession session = request.getSession();
		member = (MemberVO) session.getAttribute("member");
		if (member==null) {
				viewName = "member/loginForm";
		}else {
				userID = member.getN_name();
				session.setAttribute("userID", userID);
				viewName = "chat/box";
		}
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}

	//box.jsp
	@RequestMapping(value = "/chatBox", produces = "application/test; charset=utf8", method = RequestMethod.POST)
	public @ResponseBody String box(@RequestParam(value = "userID", required = false) String userID,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (userID == null || userID.equals("")) {
			return "";
		} else {
			try {
				userID = URLDecoder.decode(userID, "UTF-8");
				return getBox(userID);
			} catch (Exception e) {
				return "";
			}
		}
	}

	public String getBox(String userID) throws Exception {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		List<ChatVO> chatList = chatService.getBox(userID);
		if (chatList.size() == 0)
			return "";
		for (int i = 0; i < chatList.size(); i++) {
			String unread = "";
			if(userID.equals(chatList.get(i).getToID())) {
				unread = chatService.getUnreadChat(chatList.get(i).getFromID(), userID) + "";
				if(unread.equals("0")) unread = "";
			}
			result.append("[{\"value\": \""+chatList.get(i).getFromID()+"\"},");
			result.append("{\"value\": \""+chatList.get(i).getToID()+"\"},");
			result.append("{\"value\": \""+chatList.get(i).getChatContent()+"\"},");
			result.append("{\"value\": \""+chatList.get(i).getChatTime()+"\"},");
			result.append("{\"value\": \""+ unread +"\"}]");
			if (i!=chatList.size()-1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() - 1).getChatID() + "\"}");
		return result.toString();
	}

}
