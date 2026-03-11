<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>PolyCoffee - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100">

    <jsp:include page="common/header.jsp" />

    <main class="container py-5">
        <div class="p-5 mb-4 bg-light rounded-3 shadow-sm text-center">
            <h1 class="display-5 fw-bold">Welcome to PolyCoffee</h1>
            <p class="col-md-8 mx-auto fs-4 text-muted">
                Premium Coffee Shop Management System. Efficient POS, detailed reporting, and effortless catalog management.
            </p>
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary btn-lg px-4 gap-3">Get Started</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/employee/pos" class="btn btn-primary btn-lg px-4 gap-3">Go to POS</a>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="row g-4 py-5 row-cols-1 row-cols-lg-3">
            <div class="feature col text-center">
                <div class="feature-icon d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-2 mb-3 px-4 py-2 rounded">
                    <i class="bi bi-cart-plus"></i>
                </div>
                <h3 class="fs-4">Fast POS</h3>
                <p>Swift order entry and billing for your staff.</p>
            </div>
            <div class="feature col text-center">
                <div class="feature-icon d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-2 mb-3 px-4 py-2 rounded">
                    <i class="bi bi-graph-up"></i>
                </div>
                <h3 class="fs-4">Powerful Reports</h3>
                <p>Track your revenue and best sellers in real-time.</p>
            </div>
            <div class="feature col text-center">
                <div class="feature-icon d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-2 mb-3 px-4 py-2 rounded">
                    <i class="bi bi-shield-lock"></i>
                </div>
                <h3 class="fs-4">Role Based</h3>
                <p>Secure access for managers and employees.</p>
            </div>
        </div>
    </main>

    <jsp:include page="common/footer.jsp" />

</body>
</html>
