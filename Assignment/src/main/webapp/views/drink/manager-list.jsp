<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Drinks - PolyCoffee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Drink Management</h2>
            <a href="${pageContext.request.contextPath}/manager/drinks/form" class="btn btn-primary">
                <i class="bi bi-plus-lg"></i> Add New Drink
            </a>
        </div>
        
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <table class="table table-hover mb-0 align-middle">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4">Image</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="d" items="${drinks}">
                            <tr>
                                <td class="ps-4">
                                    <div class="rounded-circle bg-light border d-flex align-items-center justify-content-center overflow-hidden" 
                                         style="width: 48px; height: 48px;">
                                        <c:choose>
                                            <c:when test="${not empty d.image}">
                                                <img src="${pageContext.request.contextPath}/uploads/${d.image}" class="w-100 h-100 object-fit-cover">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-cup-hot fs-4 text-muted"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td>
                                    <div class="fw-bold">${d.name}</div>
                                    <small class="text-muted d-block text-truncate" style="max-width: 250px;">${d.description}</small>
                                </td>
                                <td><span class="badge bg-info-subtle text-info border border-info-subtle">${d.category.name}</span></td>
                                <td class="fw-bold"><fmt:formatNumber value="${d.price}" pattern="#,###"/> VNĐ</td>
                                <td>
                                    <span class="badge ${d.active ? 'bg-success' : 'bg-secondary'} rounded-pill">
                                        ${d.active ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="${pageContext.request.contextPath}/manager/drinks/form?id=${d.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                    <a href="${pageContext.request.contextPath}/manager/drinks/delete?id=${d.id}" 
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Delete this drink?')"><i class="bi bi-trash"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty drinks}">
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">No drinks found in the catalog.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
