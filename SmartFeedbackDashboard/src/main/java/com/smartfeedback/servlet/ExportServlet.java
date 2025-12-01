package com.smartfeedback.servlet;

import com.smartfeedback.dao.FeedbackDAO;
import com.smartfeedback.model.Feedback;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/admin/export")
public class ExportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackDAO feedbackDAO;

    public void init() {
        feedbackDAO = new FeedbackDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"student_feedback.csv\"");
        
        try (PrintWriter writer = response.getWriter()) {
            // Write CSV headers
            writer.println("ID,Student Name,Student Email,Course Name,Instructor Name,Rating,Comments,Submission Date");
            
            // Get all feedback
            List<Feedback> feedbackList = feedbackDAO.getAllFeedback();
            
            // Write data rows
            for (Feedback feedback : feedbackList) {
                writer.printf("%d,%s,%s,%s,%s,%d,%s,%s%n",
                    feedback.getId(),
                    escapeCsv(feedback.getStudentName()),
                    escapeCsv(feedback.getStudentEmail()),
                    escapeCsv(feedback.getCourseName()),
                    escapeCsv(feedback.getInstructorName()),
                    feedback.getRating(),
                    escapeCsv(feedback.getComments()),
                    feedback.getSubmissionDate()
                );
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error generating CSV export: " + e.getMessage());
        }
    }
    
    private String escapeCsv(String value) {
        if (value == null) return "";
        // If value contains comma, quote, or newline, wrap in quotes and escape existing quotes
        if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }
}