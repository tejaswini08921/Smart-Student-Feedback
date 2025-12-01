<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics Dashboard - Academic Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
    <style>
        /* Additional dashboard-specific styles */
        .dashboard-header {
            border-bottom: 2px solid var(--border-light);
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .quick-stats {
            background: var(--bg-white);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            border: 1px solid var(--border-light);
        }
        
        .stat-value {
            font-size: 2.25rem;
            font-weight: 700;
            color: var(--mauve-dark);
            line-height: 1;
        }
        
        .stat-label {
            color: var(--text-medium);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 0.5rem;
        }
        
        .rating-badge {
            min-width: 50px;
            text-align: center;
        }
        
        .search-box {
            max-width: 400px;
        }
        
        .table-actions {
            white-space: nowrap;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark shadow">
        <div class="container">
            <a class="navbar-brand fw-bold" href="../index.jsp">
                <i class="fas fa-graduation-cap me-2"></i>Academic Feedback
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="../index.jsp">
                    <i class="fas fa-home me-1"></i>Home
                </a>
                <a class="nav-link active" href="dashboard">
                    <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                </a>
                <a class="nav-link" href="analytics">
                    <i class="fas fa-chart-bar me-1"></i>Analytics
                </a>
            </div>
        </div>
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
            <a class="nav-link active" href="dashboard">
                <i class="fas fa-tachometer-alt me-1"></i>Dashboard
            </a>
            <a class="nav-link" href="analytics">
                <i class="fas fa-chart-bar me-1"></i>Analytics
            </a>
            <a class="nav-link" href="profile">
                <i class="fas fa-user-cog me-1"></i>Profile
            </a>
            <a class="nav-link" href="logout">
                <i class="fas fa-sign-out-alt me-1"></i>Logout
            </a>
        </div>
    </div>
</nav>
    </nav>

    <!-- Main Content -->
    <div class="container-fluid py-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 col-xl-2 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h6 class="card-title fw-bold text-primary mb-3">
                            <i class="fas fa-cog me-2"></i>Admin Panel
                        </h6>
                        <div class="list-group list-group-flush">
                            <a href="dashboard" class="list-group-item list-group-item-action active">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                            <a href="analytics" class="list-group-item list-group-item-action">
                                <i class="fas fa-chart-bar me-2"></i>Analytics
                            </a>
                            <a href="export" class="list-group-item list-group-item-action">
                                <i class="fas fa-download me-2"></i>Export Data
                            </a>
                            <a href="../index.jsp" class="list-group-item list-group-item-action">
                                <i class="fas fa-arrow-left me-2"></i>Back to Home
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Stats -->
                <div class="card mt-4">
                    <div class="card-body">
                        <h6 class="card-title fw-bold text-primary mb-3">
                            <i class="fas fa-chart-line me-2"></i>Quick Stats
                        </h6>
                        <div class="quick-stats">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <div class="stat-value">
                                        <c:choose>
                                            <c:when test="${not empty totalFeedback}">${totalFeedback}</c:when>
                                            <c:otherwise>0</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="stat-label">Total Feedback</div>
                                </div>
                                <i class="fas fa-comments fa-2x text-muted"></i>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="stat-value">
                                        <c:choose>
                                            <c:when test="${not empty courseAnalytics and not empty courseAnalytics[0]}">
                                                <fmt:formatNumber value="${courseAnalytics[0][1]}" pattern="#.##"/>
                                            </c:when>
                                            <c:otherwise>0.0</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="stat-label">Avg Rating</div>
                                </div>
                                <i class="fas fa-star fa-2x text-muted"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content Area -->
            <div class="col-lg-9 col-xl-10">
                <!-- Page Header -->
                <div class="dashboard-header">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h2 class="fw-bold text-primary mb-1">
                                <i class="fas fa-tachometer-alt me-2"></i>Analytics Dashboard
                            </h2>
                            <p class="text-muted mb-0">Monitor and analyze student feedback data</p>
                        </div>
                        <a href="export" class="btn btn-success">
                            <i class="fas fa-download me-2"></i>Export CSV
                        </a>
                    </div>
                    
                    <!-- Search Box -->
                    <div class="search-box">
                        <form action="dashboard" method="get" class="input-group">
                            <input type="text" name="search" class="form-control" 
                                   placeholder="Search courses or instructors..." 
                                   value="${searchTerm}">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search"></i>
                            </button>
                            <c:if test="${not empty searchTerm}">
                                <a href="dashboard" class="btn btn-outline-secondary">
                                    <i class="fas fa-times"></i>
                                </a>
                            </c:if>
                        </form>
                        <c:if test="${not empty searchTerm}">
                            <small class="text-muted mt-2 d-block">
                                Showing results for: "${searchTerm}"
                            </small>
                        </c:if>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stats-card-primary text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <div class="text-white-50 small">Total Feedback</div>
                                        <div class="h3 fw-bold">
                                            <c:choose>
                                                <c:when test="${not empty totalFeedback}">${totalFeedback}</c:when>
                                                <c:otherwise>0</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-comments fa-2x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stats-card-success text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <div class="text-white-50 small">Avg Rating</div>
                                        <div class="h3 fw-bold">
                                            <c:choose>
                                                <c:when test="${not empty courseAnalytics and not empty courseAnalytics[0]}">
                                                    <fmt:formatNumber value="${courseAnalytics[0][1]}" pattern="#.##"/>
                                                </c:when>
                                                <c:otherwise>0.0</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-star fa-2x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stats-card-warning text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <div class="text-white-50 small">Courses</div>
                                        <div class="h3 fw-bold">
                                            <c:choose>
                                                <c:when test="${not empty courseAnalytics}">${courseAnalytics.size()}</c:when>
                                                <c:otherwise>0</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-book fa-2x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stats-card-info text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <div class="text-white-50 small">Instructors</div>
                                        <div class="h3 fw-bold">
                                            <c:choose>
                                                <c:when test="${not empty instructorAnalytics}">${instructorAnalytics.size()}</c:when>
                                                <c:otherwise>0</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-chalkboard-teacher fa-2x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Feedback Table -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0 fw-bold">
                            <i class="fas fa-list me-2"></i>Feedback Submissions
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Student</th>
                                        <th>Course</th>
                                        <th>Instructor</th>
                                        <th>Rating</th>
                                        <th>Comments</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty feedbackList}">
                                            <c:forEach var="feedback" items="${feedbackList}">
                                                <tr>
                                                    <td class="fw-semibold">${feedback.id}</td>
                                                    <td>
                                                        <div class="fw-semibold">${feedback.studentName}</div>
                                                        <small class="text-muted">${feedback.studentEmail}</small>
                                                    </td>
                                                    <td>${feedback.courseName}</td>
                                                    <td>${feedback.instructorName}</td>
                                                    <td>
                                                        <span class="badge rating-badge bg-${feedback.rating >= 4 ? 'success' : feedback.rating >= 3 ? 'warning' : 'danger'}">
                                                            ${feedback.rating}/5
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <c:if test="${not empty feedback.comments}">
                                                            <span class="d-inline-block text-truncate" style="max-width: 200px;">
                                                                ${feedback.comments}
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${empty feedback.comments}">
                                                            <span class="text-muted">-</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <small class="text-muted">
                                                            ${feedback.submissionDate}
                                                        </small>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="7" class="text-center py-5">
                                                    <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                                    <h5 class="text-muted">No feedback submissions</h5>
                                                    <p class="text-muted">
                                                        <c:if test="${not empty searchTerm}">
                                                            No results match your search.
                                                        </c:if>
                                                    </p>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Analytics Overview -->
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header">
                                <h6 class="card-title mb-0 fw-bold">
                                    <i class="fas fa-chart-line me-2"></i>Top Courses
                                </h6>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty courseAnalytics}">
                                        <c:forEach var="course" items="${courseAnalytics}" varStatus="status" end="4">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <div>
                                                    <div class="fw-semibold">${course[0]}</div>
                                                    <small class="text-muted">${course[2]} feedbacks</small>
                                                </div>
                                                <div class="text-end">
                                                    <div class="h5 mb-0 text-primary">
                                                        <fmt:formatNumber value="${course[1]}" pattern="#.##"/>
                                                    </div>
                                                    <small class="text-muted">avg rating</small>
                                                </div>
                                            </div>
                                            <c:if test="${!status.last}"><hr class="my-2"></c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-4">
                                            <i class="fas fa-chart-line fa-2x text-muted mb-2"></i>
                                            <p class="text-muted mb-0">No course data available</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header">
                                <h6 class="card-title mb-0 fw-bold">
                                    <i class="fas fa-users me-2"></i>Instructor Performance
                                </h6>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty instructorAnalytics}">
                                        <c:forEach var="instructor" items="${instructorAnalytics}" varStatus="status" end="4">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <div>
                                                    <div class="fw-semibold">${instructor[0]}</div>
                                                    <small class="text-muted">${instructor[2]} ratings</small>
                                                </div>
                                                <div class="text-end">
                                                    <div class="h5 mb-0 text-primary">
                                                        <fmt:formatNumber value="${instructor[1]}" pattern="#.##"/>
                                                    </div>
                                                    <small class="text-muted">avg rating</small>
                                                </div>
                                            </div>
                                            <c:if test="${!status.last}"><hr class="my-2"></c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-4">
                                            <i class="fas fa-users fa-2x text-muted mb-2"></i>
                                            <p class="text-muted mb-0">No instructor data available</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="list-group list-group-flush">
    <a href="dashboard" class="list-group-item list-group-item-action active">
        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
    </a>
    <a href="analytics" class="list-group-item list-group-item-action">
        <i class="fas fa-chart-bar me-2"></i>Analytics
    </a>
    <a href="profile" class="list-group-item list-group-item-action">
        <i class="fas fa-user-cog me-2"></i>Profile
    </a>
    <a href="export" class="list-group-item list-group-item-action">
        <i class="fas fa-download me-2"></i>Export Data
    </a>
    <a href="logout" class="list-group-item list-group-item-action text-danger">
        <i class="fas fa-sign-out-alt me-2"></i>Logout
    </a>
</div>


    <!-- Footer -->
    <footer class="text-white text-center py-4 mt-4">
        <div class="container">
            <p class="mb-2">&copy; 2024 Academic Feedback System</p>
            <small class="text-light">Analytics Dashboard v1.0</small>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>