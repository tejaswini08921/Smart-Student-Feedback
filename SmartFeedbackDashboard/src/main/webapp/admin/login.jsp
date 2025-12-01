<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Academic Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
    <style>
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 2rem;
        }
        
        .login-card {
            border-top: 4px solid var(--mauve-medium);
            box-shadow: 0 10px 30px rgba(109, 76, 92, 0.15);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .login-icon {
            background: var(--gradient-mauve);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            color: white;
            font-size: 2rem;
        }
        
        .form-floating:focus-within {
            z-index: 2;
        }
        
        input[type="text"] {
            margin-bottom: -1px;
            border-bottom-right-radius: 0;
            border-bottom-left-radius: 0;
        }
        
        input[type="password"] {
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <div class="login-container">
            <div class="card login-card">
                <div class="card-body p-4">
                    <!-- Header -->
                    <div class="login-header">
                        <div class="login-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <h2 class="h4 fw-bold text-primary mb-2">Admin Login</h2>
                        <p class="text-muted mb-0">Access the analytics dashboard</p>
                    </div>
                    
                    <!-- Error Message -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <!-- Login Form -->
                    <form action="login" method="post">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="username" name="username" 
                                   placeholder="Username" required autofocus>
                            <label for="username">
                                <i class="fas fa-user me-2"></i>Username
                            </label>
                        </div>
                        
                        <div class="form-floating mb-4">
                            <input type="password" class="form-control" id="password" name="password" 
                                   placeholder="Password" required>
                            <label for="password">
                                <i class="fas fa-key me-2"></i>Password
                            </label>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100 py-2 mb-3">
                            <i class="fas fa-sign-in-alt me-2"></i>Sign In
                        </button>
                        
                        <div class="text-center">
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i>
                                Default: admin / admin123
                            </small>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Back to Home Link -->
            <div class="text-center mt-4">
                <a href="../index.jsp" class="text-decoration-none">
                    <i class="fas fa-arrow-left me-2"></i>Back to Student Portal
                </a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>