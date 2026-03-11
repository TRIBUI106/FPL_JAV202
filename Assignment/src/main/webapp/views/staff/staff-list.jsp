<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Management - PolyCoffee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Staff Directory</h2>
            <a href="${pageContext.request.contextPath}/manager/staff/form" class="btn btn-primary">
                <i class="bi bi-person-plus"></i> Register New Staff
            </a>
        </div>
        
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <table class="table table-hover mb-0 align-middle">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4">Full Name</th>
                            <th>Email Address</th>
                            <th>Phone</th>
                            <th>Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${staffList}">
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-circle me-3 bg-primary-subtle text-primary fw-bold rounded-circle d-flex align-items-center justify-content-center"
                                             style="width: 40px; height: 40px;">
                                            ${s.fullName.substring(0, 1)}
                                        </div>
                                        <span class="fw-bold">${s.fullName}</span>
                                    </div>
                                </td>
                                <td>${s.email}</td>
                                <td><code class="text-dark">${s.phone}</code></td>
                                <td>
                                    <span class="badge ${s.active ? 'bg-success' : 'bg-danger'} rounded-pill">
                                        ${s.active ? 'Active' : 'Locked'}
                                    </span>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="${pageContext.request.contextPath}/manager/staff/form?id=${s.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                    <c:choose>
                                        <c:when test="${s.active}">
                                            <a href="${pageContext.request.contextPath}/manager/staff/status?id=${s.id}&active=0" 
                                               class="btn btn-sm btn-outline-danger" title="Lock Account"><i class="bi bi-lock"></i></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/manager/staff/status?id=${s.id}&active=1" 
                                               class="btn btn-sm btn-outline-success" title="Unlock Account"><i class="bi bi-unlock"></i></a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
