<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Categories - PolyCoffee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="container py-4">
        <h2 class="mb-4">Category Management</h2>
        
        <div class="row g-4">
            <!-- Form Card -->
            <div class="col-md-4">
                <div class="card shadow-sm border-0 border-top border-primary border-4">
                    <div class="card-body">
                        <h5 class="card-title fw-bold mb-3">${category == null ? 'Add New Category' : 'Edit Category'}</h5>
                        <form action="${pageContext.request.contextPath}/manager/categories/save" method="post">
                            <input type="hidden" name="id" value="${category.id}">
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Name</label>
                                <input type="text" name="name" class="form-control" value="${category.name}" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">${category == null ? 'Create' : 'Save Changes'}</button>
                            <c:if test="${category != null}">
                                <a href="${pageContext.request.contextPath}/manager/categories" class="btn btn-light w-100 mt-2">Cancel</a>
                            </c:if>
                        </form>
                    </div>
                </div>
            </div>

            <!-- List Card -->
            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Name</th>
                                    <th>Status</th>
                                    <th class="text-end pe-4">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cat" items="${categories}">
                                    <tr>
                                        <td class="ps-4 text-muted">${cat.id}</td>
                                        <td><span class="fw-medium">${cat.name}</span></td>
                                        <td>
                                            <span class="badge ${cat.active ? 'bg-success' : 'bg-secondary'} rounded-pill">
                                                ${cat.active ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td class="text-end pe-4">
                                            <a href="?id=${cat.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                            <a href="${pageContext.request.contextPath}/manager/categories/delete?id=${cat.id}" 
                                               class="btn btn-sm btn-outline-danger"
                                               onclick="return confirm('Delete this category?')"><i class="bi bi-trash"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
