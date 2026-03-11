<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${staff == null ? 'New Staff' : 'Edit Staff'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../common/header.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow border-0">
                    <div class="card-header bg-white border-0 py-3">
                        <h4 class="mb-0 fw-bold">${staff == null ? 'Staff Registration' : 'Edit Staff Profile'}</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger mb-3 py-2 small">${error}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/manager/staff/save" method="post">
                            <input type="hidden" name="id" value="${staff.id}">
                            
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Full Name</label>
                                <input type="text" name="fullName" class="form-control" value="${staff.fullName}" required>
                            </div>

                            <c:if test="${staff == null}">
                                <div class="mb-3">
                                    <label class="form-label small fw-bold">Email Address</label>
                                    <input type="email" name="email" class="form-control" value="${staff.email}" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-bold">Initial Password</label>
                                    <input type="password" name="password" class="form-control" placeholder="Min 6 chars" required minlength="6">
                                </div>
                            </c:if>

                            <div class="mb-3">
                                <label class="form-label small fw-bold">Phone Number</label>
                                <input type="text" name="phone" class="form-control" value="${staff.phone}" required pattern="0[0-9]{9}">
                            </div>

                            <div class="mb-4">
                                <label class="form-label small fw-bold">Status</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="active" value="1" ${staff.active || staff == null ? 'checked' : ''}>
                                    <label class="form-check-label">Active / Enabled</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="active" value="0" ${not staff.active && staff != null ? 'checked' : ''}>
                                    <label class="form-check-label">Locked / Disabled</label>
                                </div>
                            </div>

                            <div class="d-flex gap-2 border-top pt-3">
                                <button type="submit" class="btn btn-primary px-4">Save Profile</button>
                                <a href="${pageContext.request.contextPath}/manager/staff" class="btn btn-light">Cancel</a>
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
