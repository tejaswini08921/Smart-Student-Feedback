package com.smartfeedback.servlet;

import com.smartfeedback.dao.AdminDAO;
import com.smartfeedback.model.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    public void init() {
        adminDAO = new AdminDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Admin admin = (Admin) session.getAttribute("admin");
        request.setAttribute("admin", admin);
        request.getRequestDispatcher("/admin/profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Admin admin = (Admin) session.getAttribute("admin");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Verify current password
        Admin verifiedAdmin = adminDAO.authenticate(admin.getUsername(), currentPassword);
        
        if (verifiedAdmin == null) {
            request.setAttribute("errorMessage", "Current password is incorrect");
        } else if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New passwords do not match");
        } else if (newPassword.length() < 6) {
            request.setAttribute("errorMessage", "Password must be at least 6 characters");
        } else {
            // Update password
            boolean success = adminDAO.changePassword(admin.getId(), newPassword);
            if (success) {
                request.setAttribute("successMessage", "Password updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update password");
            }
        }
        
        request.setAttribute("admin", admin);
        request.getRequestDispatcher("/admin/profile.jsp").forward(request, response);
    }
}