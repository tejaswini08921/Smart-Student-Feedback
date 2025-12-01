package com.smartfeedback.model;

import java.sql.Timestamp;

public class Feedback {
    private int id;
    private String studentName;
    private String studentEmail;
    private String courseName;
    private String instructorName;
    private int rating;
    private String comments;
    private Timestamp submissionDate;
    
    // Constructors
    public Feedback() {}
    
    public Feedback(String studentName, String studentEmail, String courseName, 
                   String instructorName, int rating, String comments) {
        this.studentName = studentName;
        this.studentEmail = studentEmail;
        this.courseName = courseName;
        this.instructorName = instructorName;
        this.rating = rating;
        this.comments = comments;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getStudentEmail() { return studentEmail; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }
    
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    
    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }
    
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    
    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = comments; }
    
    public Timestamp getSubmissionDate() { return submissionDate; }
    public void setSubmissionDate(Timestamp submissionDate) { this.submissionDate = submissionDate; }
    
    @Override
    public String toString() {
        return "Feedback [id=" + id + ", studentName=" + studentName + ", courseName=" + courseName 
                + ", instructorName=" + instructorName + ", rating=" + rating + "]";
    }
}