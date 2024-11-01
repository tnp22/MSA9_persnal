package filter;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import shop.dao.UserRepository;
import shop.dto.PersistentLogin;
import shop.dto.User;


/**
 * Servlet Filter implementation class LoginFilter
 */

@WebFilter(description = "로그인 필터", urlPatterns = { "/*" })
public class LoginFilter extends HttpFilter implements Filter {
	
	
	UserRepository userRepository;
	
    /**
     * @see HttpFilter#HttpFilter()
     */
    public LoginFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		this.userRepository = new UserRepository();
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// 쿠키 확인
		// 1. 자동 로그인 여부
		// 2. 인증 토큰
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		Cookie[] cookies = httpRequest.getCookies();
		
		String rememberMe = null;
		String token = null;
		
		
		if( cookies != null) {
			for(Cookie cookie : cookies) {
				String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode(cookie.getValue(),"UTF-8");
				switch (cookieName) {
					case "rememberMe" : rememberMe = cookieValue; break;
					case "token" : token = cookieValue; break;
				}
			}
			System.out.println("LoginFilter...");
			System.out.println("rememberMe : "+rememberMe);
			System.out.println("token : "+token);
			
			// 로그인 여부 확인
			HttpSession session = httpRequest.getSession();
			String loginId = (String) session.getAttribute("loginId");
			User loginUser = (User) session.getAttribute("loginUser");
			
			// 이미 로그인 됨
			if( loginId != null && loginUser != null) {
				chain.doFilter(request, response);
				System.out.println("로그인된 사용자 : "+loginId);
				return;
			}
			
			// 자동 로그인 & 토큰 OK
			if(rememberMe != null && token != null) {
				PersistentLogin persistenceLogins = userRepository.selectTokenByToken(token);
				/*삭제요망*/
				//boolean isValid = userRepository.isValid(token);
				// 토큰이 존재, 유효
				if(persistenceLogins != null) {
					loginId = persistenceLogins.getUserId();
					loginUser = userRepository.getUserById(loginId);
					//로그인 처리
					session.setAttribute("loginId",loginId);
					session.setAttribute("loginUser", loginUser);
					System.out.println("자동 로그인 성공 : "+loginUser);
				}
			}
		}
		chain.doFilter(request, response);
	}
	
	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}
	
}
