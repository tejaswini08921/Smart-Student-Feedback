<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile - Academic Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark shadow">
        <div class="container">
            <a class="navbar-brand fw-bold" href="../index.jsp">
                <i class="fas fa-graduation-cap me-2"></i>Academic Feedback
            </a>
            <div class="navbar-nav ms-auto">
                <span class="nav-link">
                    <i class="fas fa-user me-1"></i>${adminName}
                </span>
                <a class="nav-link" href="dashboard">
                    <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                </a>
                <a class="nav-link active" href="profile">
                    <i class="fas fa-user-cog me-1"></i>Profile
                </a>
                <a class="nav-link" href="logout">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 col-xl-2 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h6 class="card-title fw-bold text-primary mb-3">
                            <i class="fas fa-cog me-2"></i>Admin Panel
                        </h6>
                        <div class="list-group list-group-flush">
                            <a href="dashboard" class="list-group-item list-group-item-action">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                            <a href="analytics" class="list-group-item list-group-item-action">
                                <i class="fas fa-chart-bar me-2"></i>Analytics
                            </a>
                            <a href="profile" class="list-group-item list-group-item-action active">
                                <i class="fas fa-user-cog me-2"></i>Profile Settings
                            </a>
                            <a href="logout" class="list-group-item list-group-item-action text-danger">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-lg-9 col-xl-10">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="fw-bold text-primary">
                        <i class="fas fa-user-cog me-2"></i>Admin Profile
                    </h2>
                    <a href="dashboard" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                    </a>
                </div>
                
                <!-- Messages -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Profile Info Card -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0 fw-bold">
                            <i class="fas fa-user me-2"></i>Profile Information
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Username</label>
                                    <input type="text" class="form-control" value="${admin.username}" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Email</label>
                                    <input type="email" class="form-control" value="${admin.email}" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Admin ID</label>
                            <input type="text" class="form-control" value="ADM-${admin.id}" readonly>
                        </div>
                    </div>
                </div>
                
                <!-- Change Password Card -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0 fw-bold">
                            <i class="fas fa-key me-2"></i>Change Password
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="profile" method="post">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label">Current Password</label>
                                        <input type="password" class="form-control" id="currentPassword" 
                                               name="currentPassword" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">New Password</label>
                                        <input type="password" class="form-control" id="newPassword" 
                                               name="newPassword" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                        <input type="password" class="form-control" id="confirmPassword" 
                                               name="confirmPassword" required>
                                    </div>
                                </div>
                            </div>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>
                                Password must be at least 6 characters long
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Update Password
                            </button>
                        </form>
                    </div>
                </div>
                
                <!-- Security Notes -->
                <div class="alert alert-warning mt-4">
                    <div class="d-flex">
                        <i class="fas fa-shield-alt fa-2x me-3"></i>
                        <div>
                            <h6 class="alert-heading fw-bold">Security Recommendations</h6>
                            <ul class="mb-0">
                                <li>Use a strong, unique password</li>
                                <li>Change your password regularly</li>
                                <li>Never share your credentials</li>
                                <li>Log out after each session</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-white text-center py-4 mt-4">
        <div class="container">
            <p class="mb-2">&copy; 2024 Academic Feedback System</p>
            <small class="text-light">Logged in as: ${adminName}</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>