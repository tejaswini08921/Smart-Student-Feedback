package com.smartfeedback.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/admin/*")
public class AuthFilter implements Filter {
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String loginURI = httpRequest.getContextPath() + "/admin/login";
        String loginPage = httpRequest.getContextPath() + "/admin/login.jsp";
        
        boolean loggedIn = (session != null && session.getAttribute("admin") != null);
        boolean loginRequest = httpRequest.getRequestURI().equals(loginURI) || 
                               httpRequest.getRequestURI().equals(loginPage);
        
        if (loggedIn || loginRequest) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login.jsp");
        }
    }
}