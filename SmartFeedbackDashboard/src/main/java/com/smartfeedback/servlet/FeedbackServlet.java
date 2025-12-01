package com.smartfeedback.servlet;

import com.smartfeedback.dao.FeedbackDAO;
import com.smartfeedback.model.Feedback;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/submit-feedback")
public class FeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackDAO feedbackDAO;

    public void init() {
        feedbackDAO = new FeedbackDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String studentName = request.getParameter("studentName");
        String studentEmail = request.getParameter("studentEmail");
        String courseName = request.getParameter("courseName");
        String instructorName = request.getParameter("instructorName");
        String ratingStr = request.getParameter("rating");
        String comments = request.getParameter("comments");

        // Server-side validation
        StringBuilder errorMessage = new StringBuilder();
        
        if (studentName == null || studentName.trim().isEmpty()) {
            errorMessage.append("Student name is required.\\n");
        }
        if (studentEmail == null || studentEmail.trim().isEmpty()) {
            errorMessage.append("Student email is required.\\n");
        }
        if (courseName == null || courseName.trim().isEmpty()) {
            errorMessage.append("Course name is required.\\n");
        }
        if (instructorName == null || instructorName.trim().isEmpty()) {
            errorMessage.append("Instructor name is required.\\n");
        }
        if (ratingStr == null || ratingStr.trim().isEmpty()) {
            errorMessage.append("Rating is required.\\n");
        }

        // If validation errors, return to form with error message
        if (errorMessage.length() > 0) {
            request.setAttribute("errorMessage", errorMessage.toString());
            request.setAttribute("studentName", studentName);
            request.setAttribute("studentEmail", studentEmail);
            request.setAttribute("courseName", courseName);
            request.setAttribute("instructorName", instructorName);
            request.setAttribute("comments", comments);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        try {
            int rating = Integer.parseInt(ratingStr);
            
            // Validate rating range
            if (rating < 1 || rating > 5) {
                request.setAttribute("errorMessage", "Rating must be between 1 and 5.");
                request.setAttribute("studentName", studentName);
                request.setAttribute("studentEmail", studentEmail);
                request.setAttribute("courseName", courseName);
                request.setAttribute("instructorName", instructorName);
                request.setAttribute("comments", comments);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }

            // Create Feedback object
            Feedback feedback = new Feedback(studentName, studentEmail, courseName, 
                                           instructorName, rating, comments);

            // Save to database
            boolean success = feedbackDAO.addFeedback(feedback);

            if (success) {
                request.setAttribute("successMessage", "Thank you! Your feedback has been submitted successfully.");
            } else {
                request.setAttribute("errorMessage", "Sorry, there was an error submitting your feedback. Please try again.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid rating format.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again.");
        }

        // Return to form page
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect to home page if accessed via GET
        response.sendRedirect("index.jsp");
    }
}