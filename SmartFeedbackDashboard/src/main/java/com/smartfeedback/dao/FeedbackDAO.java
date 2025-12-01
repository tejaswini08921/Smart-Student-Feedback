package com.smartfeedback.dao;

import com.smartfeedback.model.Feedback;
import com.smartfeedback.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {
    
    // Add new feedback
    public boolean addFeedback(Feedback feedback) {
        String sql = "INSERT INTO feedback (student_name, student_email, course_name, instructor_name, rating, comments) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, feedback.getStudentName());
            stmt.setString(2, feedback.getStudentEmail());
            stmt.setString(3, feedback.getCourseName());
            stmt.setString(4, feedback.getInstructorName());
            stmt.setInt(5, feedback.getRating());
            stmt.setString(6, feedback.getComments());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all feedback
    public List<Feedback> getAllFeedback() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT * FROM feedback ORDER BY submission_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt("id"));
                feedback.setStudentName(rs.getString("student_name"));
                feedback.setStudentEmail(rs.getString("student_email"));
                feedback.setCourseName(rs.getString("course_name"));
                feedback.setInstructorName(rs.getString("instructor_name"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComments(rs.getString("comments"));
                feedback.setSubmissionDate(rs.getTimestamp("submission_date"));
                
                feedbackList.add(feedback);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return feedbackList;
    }
    
    // Search feedback by course or instructor
    public List<Feedback> searchFeedback(String searchTerm) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT * FROM feedback WHERE course_name LIKE ? OR instructor_name LIKE ? ORDER BY submission_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, "%" + searchTerm + "%");
            stmt.setString(2, "%" + searchTerm + "%");
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt("id"));
                feedback.setStudentName(rs.getString("student_name"));
                feedback.setStudentEmail(rs.getString("student_email"));
                feedback.setCourseName(rs.getString("course_name"));
                feedback.setInstructorName(rs.getString("instructor_name"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComments(rs.getString("comments"));
                feedback.setSubmissionDate(rs.getTimestamp("submission_date"));
                
                feedbackList.add(feedback);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return feedbackList;
    }
    
    // Get average rating per course
    public List<Object[]> getAverageRatingsPerCourse() {
        List<Object[]> analytics = new ArrayList<>();
        String sql = "SELECT course_name, AVG(rating) as avg_rating, COUNT(*) as feedback_count " +
                    "FROM feedback GROUP BY course_name ORDER BY avg_rating DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Object[] data = new Object[3];
                data[0] = rs.getString("course_name");
                data[1] = rs.getDouble("avg_rating");
                data[2] = rs.getInt("feedback_count");
                analytics.add(data);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return analytics;
    }
    
    // Get instructor performance
    public List<Object[]> getInstructorPerformance() {
        List<Object[]> analytics = new ArrayList<>();
        String sql = "SELECT instructor_name, AVG(rating) as avg_rating, COUNT(*) as feedback_count " +
                    "FROM feedback GROUP BY instructor_name ORDER BY avg_rating DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Object[] data = new Object[3];
                data[0] = rs.getString("instructor_name");
                data[1] = rs.getDouble("avg_rating");
                data[2] = rs.getInt("feedback_count");
                analytics.add(data);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return analytics;
    }
    
    // Get total feedback count
    public int getTotalFeedbackCount() {
        String sql = "SELECT COUNT(*) as total FROM feedback";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Get rating distribution
    public List<Object[]> getRatingDistribution() {
        List<Object[]> distribution = new ArrayList<>();
        String sql = "SELECT rating, COUNT(*) as count FROM feedback GROUP BY rating ORDER BY rating";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Object[] data = new Object[2];
                data[0] = rs.getInt("rating");
                data[1] = rs.getInt("count");
                distribution.add(data);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return distribution;
    }
}