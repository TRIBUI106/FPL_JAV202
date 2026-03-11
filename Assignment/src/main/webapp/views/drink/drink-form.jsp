<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${drink == null ? 'Add Drink' : 'Edit Drink'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../common/header.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow border-0">
                    <div class="card-header bg-white border-0 py-3">
                        <h4 class="mb-0 fw-bold">${drink == null ? 'New Drink Entry' : 'Edit Drink Entry'}</h4>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/manager/drinks/save" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="${drink.id}">
                            
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Drink Name</label>
                                <input type="text" name="name" class="form-control" value="${drink.name}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Category</label>
                                <select name="categoryId" class="form-select" required>
                                    <option value="">Select Category</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.id}" ${drink.category.id == cat.id ? 'selected' : ''}>${cat.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label small fw-bold">Price (VNĐ)</label>
                                <input type="number" name="price" class="form-control" value="${drink.price}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label small fw-bold">Description</label>
                                <textarea name="description" class="form-control" rows="3">${drink.description}</textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label small fw-bold">Product Image</label>
                                <input type="file" name="image" class="form-control" accept="image/*">
                                <c:if test="${not empty drink.image}">
                                    <div class="mt-2">
                                        <img src="${pageContext.request.contextPath}/uploads/${drink.image}" class="rounded border p-1" style="width: 100px;">
                                        <small class="text-muted d-block">Current Image</small>
                                    </div>
                                </c:if>
                            </div>

                            <div class="mb-4">
                                <label class="form-label small fw-bold">Availability Status</label>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" name="active" value="1" ${drink.active || drink == null ? 'checked' : ''}>
                                    <label class="form-check-label">Currently Active for Orders</label>
                                </div>
                            </div>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary px-4">Save Beverage</button>
                                <a href="${pageContext.request.contextPath}/manager/drinks" class="btn btn-light">Back to List</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
