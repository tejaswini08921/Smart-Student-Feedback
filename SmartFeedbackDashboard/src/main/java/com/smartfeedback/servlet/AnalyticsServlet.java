package com.smartfeedback.servlet;

import com.smartfeedback.dao.FeedbackDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/analytics")
public class AnalyticsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackDAO feedbackDAO;

    public void init() {
        feedbackDAO = new FeedbackDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get all analytics data for charts
            List<Object[]> courseAnalytics = feedbackDAO.getAverageRatingsPerCourse();
            List<Object[]> instructorAnalytics = feedbackDAO.getInstructorPerformance();
            List<Object[]> ratingDistribution = feedbackDAO.getRatingDistribution();
            int totalFeedback = feedbackDAO.getTotalFeedbackCount();

            // Set attributes for analytics page
            request.setAttribute("courseAnalytics", courseAnalytics);
            request.setAttribute("instructorAnalytics", instructorAnalytics);
            request.setAttribute("ratingDistribution", ratingDistribution);
            request.setAttribute("totalFeedback", totalFeedback);

            // Forward to analytics page
            request.getRequestDispatcher("/admin/analytics.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading analytics data: " + e.getMessage());
            request.getRequestDispatcher("/admin/analytics.jsp").forward(request, response);
        }
    }
}