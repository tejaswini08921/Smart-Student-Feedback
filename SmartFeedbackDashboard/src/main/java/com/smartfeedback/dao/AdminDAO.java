package com.smartfeedback.dao;

import com.smartfeedback.model.Admin;
import com.smartfeedback.util.DBUtil;
import java.sql.*;

public class AdminDAO {
    
    // Create admin table and default admin
    public void initializeAdmin() {
        String createTableSQL = "CREATE TABLE IF NOT EXISTS admin (" +
                               "id INT PRIMARY KEY AUTO_INCREMENT, " +
                               "username VARCHAR(50) UNIQUE NOT NULL, " +
                               "password VARCHAR(100) NOT NULL, " +
                               "email VARCHAR(100) NOT NULL)";
        
        String checkAdminSQL = "SELECT COUNT(*) as count FROM admin WHERE username = 'admin'";
        String insertAdminSQL = "INSERT INTO admin (username, password, email) VALUES ('admin', 'admin123', 'admin@university.edu')";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Create table
            stmt.executeUpdate(createTableSQL);
            
            // Check if admin exists
            ResultSet rs = stmt.executeQuery(checkAdminSQL);
            if (rs.next() && rs.getInt("count") == 0) {
                // Insert default admin
                stmt.executeUpdate(insertAdminSQL);
                System.out.println("✅ Default admin created: username=admin, password=admin123");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Authenticate admin
    public Admin authenticate(String username, String password) {
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setEmail(rs.getString("email"));
                return admin;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Change admin password
    public boolean changePassword(int adminId, String newPassword) {
        String sql = "UPDATE admin SET password = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newPassword);
            stmt.setInt(2, adminId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}