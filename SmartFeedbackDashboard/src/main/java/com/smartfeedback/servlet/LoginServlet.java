package com.smartfeedback.servlet;

import com.smartfeedback.dao.AdminDAO;
import com.smartfeedback.model.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    public void init() {
        adminDAO = new AdminDAO();
        adminDAO.initializeAdmin(); // Create table and default admin
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Admin admin = adminDAO.authenticate(username, password);
        
        if (admin != null) {
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setAttribute("adminName", admin.getUsername());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            // Redirect to dashboard
            response.sendRedirect("dashboard");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // If already logged in, redirect to dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect("dashboard");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}