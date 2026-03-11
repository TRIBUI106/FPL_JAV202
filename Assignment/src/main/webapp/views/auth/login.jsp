<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - PolyCoffee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .login-card { max-width: 400px; margin-top: 100px; border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .btn-primary { border-radius: 10px; padding: 12px; font-weight: 600; }
    </style>
</head>
<body>
    <div class="container d-flex justify-content-center">
        <div class="card login-card p-4">
            <div class="text-center mb-4">
                <h2 class="fw-bold">PolyCoffee</h2>
                <p class="text-muted">Sign in to your account</p>
            </div>
            
            <c:if test="${not empty message}">
                <div class="alert alert-danger mb-3">${message}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/login" method="post">
                <div class="mb-3">
                    <label class="form-label small fw-bold">Email address</label>
                    <input type="email" name="email" class="form-control" placeholder="staff@polycoffee.com" required>
                </div>
                <div class="mb-4">
                    <label class="form-label small fw-bold">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 mb-3">Login</button>
            </form>
            
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/" class="text-decoration-none small">← Back to home</a>
            </div>
        </div>
    </div>
</body>
</html>
