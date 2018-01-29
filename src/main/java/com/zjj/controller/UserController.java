package com.zjj.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjj.service.UserService;

@Controller
public class UserController {
	private static Logger logger = Logger.getLogger(UserController.class);
	@Autowired
	private UserService userService;
	@Autowired
	private static long initialAccessCounts = 0;
	public static List<String> loginList = new ArrayList<String>();
	

	/* 定时任务 */
	static {
		TimerTask task = new TimerTask() {
			@Override
			public void run() {
			}
		};
		Timer timer = new Timer();
		long delay = 0;
		long intevalPeriod = 1800 * 1000;
		timer.scheduleAtFixedRate(task, delay, intevalPeriod);

	}

	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (ArrayUtils.isEmpty(cookies)) {
			return "index";
		} else {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("loginToken")) {
					if (loginList.contains(cookie.getValue())) {
						return "settings";
					}
				}
			}
		}
		
		return "index";
	}
	@RequestMapping(value = "/settings")
	public String settings() {
		return "settings";
	}

	@RequestMapping(value = "/login")
	@ResponseBody
	public Map<String, Object> login(HttpServletRequest request,HttpServletResponse response) {
		String randomCode = request.getSession().getAttribute("randCode").toString().toUpperCase();
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		String remoteRandomCode = request.getParameter("randomCode").toUpperCase();
		Map<String, Object> map = new HashMap<String, Object>();
		if (!randomCode.equals(remoteRandomCode)) {
			map.put("msg", "验证码错误");
			return map;
		}
		if (!"admin".equals(userName) || !"admin".equals(password)) {
			map.put("msg", "账号或密码错误");
			return map;
		}
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		map.put("msg", "success");
		Cookie cookie = new Cookie("loginToken",uuid);
		loginList.add(uuid);
		response.addCookie(cookie);
		return map;
	}

	@RequestMapping(value = "/ems")
	@ResponseBody
	public Map<String, Object> emsInf(HttpServletRequest request) {
		return null;

	}

}
