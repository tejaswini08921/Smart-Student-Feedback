<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Student Feedback System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        /* PROFESSIONAL DARK MAUVE THEME */
        :root {
            /* Mauve Color Palette */
            --mauve-dark: #6D4C5C;
            --mauve-medium: #8B6B7E;
            --mauve-light: #A993A1;
            --mauve-soft: #D1C2C9;
            --mauve-pastel: #E8DFE3;
            
            /* Accent Colors */
            --accent-gold: #C9A959;
            --accent-sage: #8A9A5B;
            --accent-slate: #708090;
            --accent-burgundy: #800020;
            
            /* Neutrals */
            --bg-light: #F8F6F7;
            --bg-white: #FFFFFF;
            --text-dark: #2D2D2D;
            --text-medium: #5A5A5A;
            --text-light: #FFFFFF;
            
            /* Gradients */
            --gradient-mauve: linear-gradient(135deg, var(--mauve-dark) 0%, var(--mauve-medium) 100%);
            --gradient-gold: linear-gradient(135deg, var(--accent-gold) 0%, #D4B483 100%);
            --gradient-sage: linear-gradient(135deg, var(--accent-sage) 0%, #9CAD7E 100%);
            --gradient-slate: linear-gradient(135deg, var(--accent-slate) 0%, #8F9BA8 100%);
            
            /* Shadows */
            --shadow-sm: 0 2px 8px rgba(109, 76, 92, 0.1);
            --shadow: 0 4px 20px rgba(109, 76, 92, 0.15);
            --shadow-lg: 0 8px 30px rgba(109, 76, 92, 0.2);
        }
        
        body {
            background-color: var(--bg-light);
            background-image: 
                radial-gradient(circle at 10% 20%, var(--mauve-pastel) 0%, transparent 40%),
                radial-gradient(circle at 90% 10%, rgba(139, 107, 126, 0.1) 0%, transparent 40%),
                radial-gradient(circle at 20% 90%, rgba(201, 169, 89, 0.05) 0%, transparent 40%);
            background-attachment: fixed;
            color: var(--text-dark);
            font-family: 'Inter', 'Segoe UI', 'Roboto', sans-serif;
            font-weight: 400;
            line-height: 1.7;
        }
        
        /* NAVIGATION - DARK MAUVE */
        .navbar {
            background: var(--gradient-mauve) !important;
            box-shadow: 0 4px 20px rgba(109, 76, 92, 0.25);
            border-bottom: 3px solid var(--accent-burgundy);
            padding: 1rem 0;
        }
        
        .navbar-brand {
            font-size: 1.6rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            color: white !important;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        }
        
        .navbar-nav .nav-link {
            font-weight: 600;
            padding: 0.5rem 1.2rem;
            border-radius: 25px;
            transition: all 0.3s ease;
            margin: 0 3px;
            color: white !important;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        /* CARDS - PROFESSIONAL DESIGN */
        .card {
            background: var(--bg-white);
            border: none;
            border-radius: 16px;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            overflow: hidden;
            border-top: 4px solid var(--mauve-medium);
            margin-bottom: 2rem;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
            border-top-color: var(--accent-gold);
        }
        
        .card-header {
            background: var(--gradient-mauve) !important;
            color: white !important;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            font-weight: 600;
            letter-spacing: 0.3px;
            padding: 1.2rem 1.5rem;
            font-size: 1.1rem;
        }
        
        /* FORM ELEMENTS */
        .form-control, .form-select {
            background: var(--bg-white);
            border: 2px solid var(--mauve-soft);
            border-radius: 10px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
            color: var(--text-dark);
            font-size: 0.95rem;
        }
        
        .form-control:focus, .form-select:focus {
            background: var(--bg-white);
            border-color: var(--mauve-medium);
            box-shadow: 0 0 0 0.25rem rgba(139, 107, 126, 0.25);
            transform: translateY(-1px);
        }
        
        .form-label {
            font-weight: 600;
            color: var(--mauve-dark);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
            letter-spacing: 0.3px;
        }
        
        /* STAR RATING - GOLD ACCENT */
        .rating-stars {
            display: flex;
            justify-content: center;
            gap: 12px;
            padding: 15px 0;
        }
        
        .star-label {
            font-size: 2.5rem;
            color: var(--mauve-soft);
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .star-label:hover {
            color: var(--accent-gold);
            transform: scale(1.2);
        }
        
        .rating-stars input:checked ~ .star-label,
        .rating-stars input:checked ~ .star-label ~ .star-label {
            color: var(--accent-gold);
        }
        
        /* BUTTONS */
        .btn-primary {
            background: var(--gradient-mauve);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(109, 76, 92, 0.2);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(109, 76, 92, 0.3);
            background: linear-gradient(135deg, var(--mauve-medium) 0%, var(--mauve-dark) 100%);
        }
        
        /* INFO CARDS - DIFFERENT PROFESSIONAL COLORS */
        .info-card-1 {
            background: linear-gradient(135deg, #F8F9FA 0%, #E9ECEF 100%) !important;
            color: var(--text-dark);
            border-top: 4px solid var(--accent-sage);
            border-left: none;
        }
        
        .info-card-2 {
            background: linear-gradient(135deg, #F8F9FA 0%, #E9ECEF 100%) !important;
            color: var(--text-dark);
            border-top: 4px solid var(--accent-slate);
            border-left: none;
        }
        
        .info-card-3 {
            background: linear-gradient(135deg, #F8F9FA 0%, #E9ECEF 100%) !important;
            color: var(--text-dark);
            border-top: 4px solid var(--accent-gold);
            border-left: none;
        }
        
        .info-card-1 i { color: var(--accent-sage); }
        .info-card-2 i { color: var(--accent-slate); }
        .info-card-3 i { color: var(--accent-gold); }
        
        /* TOAST NOTIFICATIONS */
        .toast {
            background: var(--bg-white);
            border: none;
            border-radius: 10px;
            box-shadow: var(--shadow-lg);
            border-left: 4px solid;
        }
        
        .toast.success {
            border-left-color: var(--accent-sage);
        }
        
        .toast.error {
            border-left-color: #DC3545;
        }
        
        .toast-header {
            border-radius: 10px 10px 0 0;
            font-weight: 600;
        }
        
        /* FOOTER */
        footer {
            background: linear-gradient(135deg, #343A40 0%, #495057 100%) !important;
            color: white;
            margin-top: 4rem;
            padding: 1.5rem 0;
            border-top: 3px solid var(--mauve-medium);
        }
        
        footer i.fa-heart {
            color: var(--accent-gold);
        }
        
        /* CUSTOM SCROLLBAR */
        ::-webkit-scrollbar {
            width: 10px;
        }
        
        ::-webkit-scrollbar-track {
            background: var(--bg-light);
            border-radius: 5px;
        }
        
        ::-webkit-scrollbar-thumb {
            background: var(--mauve-medium);
            border-radius: 5px;
            border: 2px solid var(--bg-light);
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: var(--mauve-dark);
        }
        
        /* RESPONSIVE */
        @media (max-width: 768px) {
            .star-label {
                font-size: 2rem;
            }
            
            .rating-stars {
                gap: 8px;
            }
            
            .btn-primary {
                padding: 0.6rem 1.5rem;
            }
            
            .card-header {
                padding: 1rem;
            }
        }
        
        /* TEXT COLORS */
        .text-primary { color: var(--mauve-medium) !important; }
        .text-muted { color: var(--text-medium) !important; }
        
        /* BADGES */
        .badge {
            font-weight: 600;
            letter-spacing: 0.3px;
            border-radius: 20px;
        }
        
        .badge.bg-light {
            background-color: var(--mauve-pastel) !important;
            color: var(--mauve-dark) !important;
        }
        
        /* ANIMATIONS */
        @keyframes subtleFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }
        
        .floating {
            animation: subtleFloat 3s ease-in-out infinite;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark shadow">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.jsp">
                <i class="fas fa-graduation-cap me-2"></i>Academic Feedback
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="admin/dashboard">
                    <i class="fas fa-chart-line me-1"></i>Analytics Dashboard
                </a>
            </div>
        </div>
    </nav>

    <!-- Toast Notifications -->
    <div class="toast-container position-fixed top-0 end-0 p-3">
        <c:if test="${not empty successMessage}">
            <div class="toast show success" role="alert">
                <div class="toast-header" style="background: linear-gradient(to right, var(--accent-sage), #9CAD7E); color: white;">
                    <i class="fas fa-check-circle me-2"></i>
                    <strong class="me-auto">Success</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body">${successMessage}</div>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="toast show error" role="alert">
                <div class="toast-header" style="background: linear-gradient(to right, #DC3545, #C82333); color: white;">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body">${errorMessage}</div>
            </div>
        </c:if>
    </div>

    <!-- Main Content -->
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-9 col-xl-8">
                <!-- Header Card -->
                <div class="card shadow-lg border-0 mb-4">
                    <div class="card-header text-center py-4">
                        <h1 class="h2 fw-bold mb-3">
                            <i class="fas fa-comment-alt me-2"></i>Student Feedback Portal
                        </h1>
                        <p class="lead mb-0">Share your academic experience to help enhance learning outcomes</p>
                    </div>
                </div>

                <!-- Feedback Form Card -->
                <div class="card shadow border-0 mb-4">
                    <div class="card-body p-4">
                        <form id="feedbackForm" action="submit-feedback" method="post" novalidate>
                            <div class="row">
                                <!-- Student Information -->
                                <div class="col-md-6 mb-3">
                                    <label for="studentName" class="form-label">
                                        <i class="fas fa-user me-2"></i>Full Name *
                                    </label>
                                    <input type="text" class="form-control" id="studentName" name="studentName" 
                                           value="${studentName}" required placeholder="Enter your full name">
                                    <div class="invalid-feedback">Please provide your name.</div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="studentEmail" class="form-label">
                                        <i class="fas fa-envelope me-2"></i>Email Address *
                                    </label>
                                    <input type="email" class="form-control" id="studentEmail" name="studentEmail" 
                                           value="${studentEmail}" required placeholder="your.email@university.edu">
                                    <div class="invalid-feedback">Please provide a valid email address.</div>
                                </div>
                            </div>

                            <div class="row">
                                <!-- Course & Instructor -->
                                <div class="col-md-6 mb-3">
                                    <label for="courseName" class="form-label">
                                        <i class="fas fa-book me-2"></i>Course Name *
                                    </label>
                                    <select class="form-select" id="courseName" name="courseName" required>
                                        <option value="">Select a course</option>
                                        <option value="Advanced Java Programming" ${courseName == 'Advanced Java Programming' ? 'selected' : ''}>Advanced Java Programming</option>
                                        <option value="Database Management Systems" ${courseName == 'Database Management Systems' ? 'selected' : ''}>Database Management Systems</option>
                                        <option value="Web Development Fundamentals" ${courseName == 'Web Development Fundamentals' ? 'selected' : ''}>Web Development Fundamentals</option>
                                        <option value="Data Structures & Algorithms" ${courseName == 'Data Structures & Algorithms' ? 'selected' : ''}>Data Structures & Algorithms</option>
                                        <option value="Software Engineering" ${courseName == 'Software Engineering' ? 'selected' : ''}>Software Engineering</option>
                                        <option value="Machine Learning" ${courseName == 'Machine Learning' ? 'selected' : ''}>Machine Learning</option>
                                    </select>
                                    <div class="invalid-feedback">Please select a course.</div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="instructorName" class="form-label">
                                        <i class="fas fa-chalkboard-teacher me-2"></i>Instructor Name *
                                    </label>
                                    <select class="form-select" id="instructorName" name="instructorName" required>
                                        <option value="">Select an instructor</option>
                                        <option value="Dr. Sarah Johnson" ${instructorName == 'Dr. Sarah Johnson' ? 'selected' : ''}>Dr. Sarah Johnson</option>
                                        <option value="Prof. Michael Brown" ${instructorName == 'Prof. Michael Brown' ? 'selected' : ''}>Prof. Michael Brown</option>
                                        <option value="Prof. Robert Davis" ${instructorName == 'Prof. Robert Davis' ? 'selected' : ''}>Prof. Robert Davis</option>
                                        <option value="Dr. Emily Wilson" ${instructorName == 'Dr. Emily Wilson' ? 'selected' : ''}>Dr. Emily Wilson</option>
                                        <option value="Prof. James Miller" ${instructorName == 'Prof. James Miller' ? 'selected' : ''}>Prof. James Miller</option>
                                    </select>
                                    <div class="invalid-feedback">Please select an instructor.</div>
                                </div>
                            </div>

                            <!-- Rating Section -->
                            <div class="mb-4">
                                <label class="form-label d-block text-center mb-3">
                                    <i class="fas fa-star me-2"></i>Course Rating *
                                </label>
                                <div class="rating-container">
                                    <div class="rating-stars mb-2">
                                        <input type="radio" id="star5" name="rating" value="5" class="d-none" ${param.rating == '5' ? 'checked' : ''}>
                                        <label for="star5" class="star-label"><i class="fas fa-star"></i></label>
                                        
                                        <input type="radio" id="star4" name="rating" value="4" class="d-none" ${param.rating == '4' ? 'checked' : ''}>
                                        <label for="star4" class="star-label"><i class="fas fa-star"></i></label>
                                        
                                        <input type="radio" id="star3" name="rating" value="3" class="d-none" ${param.rating == '3' ? 'checked' : ''}>
                                        <label for="star3" class="star-label"><i class="fas fa-star"></i></label>
                                        
                                        <input type="radio" id="star2" name="rating" value="2" class="d-none" ${param.rating == '2' ? 'checked' : ''}>
                                        <label for="star2" class="star-label"><i class="fas fa-star"></i></label>
                                        
                                        <input type="radio" id="star1" name="rating" value="1" class="d-none" ${param.rating == '1' ? 'checked' : ''}>
                                        <label for="star1" class="star-label"><i class="fas fa-star"></i></label>
                                    </div>
                                    <div class="text-center">
                                        <small class="text-muted d-block mb-1">Rate from 1 (Poor) to 5 (Excellent)</small>
                                    </div>
                                    <div class="invalid-feedback d-block text-center mt-1">Please select a rating.</div>
                                </div>
                            </div>

                            <!-- Comments -->
                            <div class="mb-4">
                                <label for="comments" class="form-label">
                                    <i class="fas fa-comment me-2"></i>Additional Comments
                                </label>
                                <textarea class="form-control" id="comments" name="comments" rows="4" 
                                          placeholder="Share constructive feedback about the course content, teaching methods, or suggestions for improvement...">${comments}</textarea>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i> Specific, constructive feedback is most valuable
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="text-center pt-2">
                                <button type="submit" class="btn btn-primary btn-lg px-4">
                                    <i class="fas fa-paper-plane me-2"></i>Submit Feedback
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Info Cards -->
                <div class="row mt-4">
                    <div class="col-md-4 mb-3">
                        <div class="card info-card-1 text-center border-0 shadow">
                            <div class="card-body py-3">
                                <i class="fas fa-user-shield fa-2x mb-2"></i>
                                <h6 class="card-title fw-bold mb-2">Confidential</h6>
                                <p class="card-text small mb-0">All feedback is anonymous and confidential</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card info-card-2 text-center border-0 shadow">
                            <div class="card-body py-3">
                                <i class="fas fa-chart-bar fa-2x mb-2"></i>
                                <h6 class="card-title fw-bold mb-2">Impactful</h6>
                                <p class="card-text small mb-0">Drives meaningful curriculum improvements</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card info-card-3 text-center border-0 shadow">
                            <div class="card-body py-3">
                                <i class="fas fa-handshake fa-2x mb-2"></i>
                                <h6 class="card-title fw-bold mb-2">Collaborative</h6>
                                <p class="card-text small mb-0">Enhances the teaching-learning partnership</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-white text-center py-4 mt-4">
        <div class="container">
            <p class="mb-2">&copy; 2024 Academic Feedback System. All rights reserved.</p>
            <small class="text-light">Designed to enhance educational excellence</small>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/script.js"></script>
    
    <script>
        // Star rating functionality
        document.addEventListener('DOMContentLoaded', function() {
            const stars = document.querySelectorAll('.star-label');
            
            stars.forEach(star => {
                star.addEventListener('click', function() {
                    const rating = this.previousElementSibling.value;
                    highlightStars(rating);
                });
                
                star.addEventListener('mouseover', function() {
                    const rating = this.previousElementSibling.value;
                    previewStars(rating);
                });
            });
            
            function highlightStars(rating) {
                stars.forEach((star, index) => {
                    if (index < 5 - rating) {
                        star.style.color = '#D1C2C9';
                    } else {
                        star.style.color = '#C9A959';
                    }
                });
            }
            
            function previewStars(rating) {
                stars.forEach((star, index) => {
                    if (index < 5 - rating) {
                        star.style.color = '#D1C2C9';
                    } else {
                        star.style.color = '#D4B483';
                    }
                });
            }
            
            // Initialize with checked star if exists
            const checkedStar = document.querySelector('.rating-stars input:checked');
            if (checkedStar) {
                highlightStars(checkedStar.value);
            }
        });
    </script>
</body>
</html>