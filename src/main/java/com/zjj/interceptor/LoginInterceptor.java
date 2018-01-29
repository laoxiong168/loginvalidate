package com.zjj.interceptor;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.zjj.controller.UserController;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	private List<String> excludedUrls;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String loginToken = "";
		// 是否有cookie
		Cookie[] cookies = request.getCookies();
		if (ArrayUtils.isEmpty(cookies)) {
			request.getRequestDispatcher("/index.do").forward(request, response);
			return false;
		} else {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("loginToken")) {
					loginToken = cookie.getValue();
					break;
				}
			}
		}

		if (StringUtils.isBlank(loginToken)) {
			request.getRequestDispatcher("/index.do").forward(request, response);
			return false;
		} else {
			if (UserController.loginList.contains(loginToken)) {
				return true;
			}else {
				request.getRequestDispatcher("/index.do").forward(request, response);
				return false;
			}
		}


	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

	public List<String> getExcludedUrls() {
		return excludedUrls;
	}

	public void setExcludedUrls(List<String> excludedUrls) {
		this.excludedUrls = excludedUrls;
	}

}
