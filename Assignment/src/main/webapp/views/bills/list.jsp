<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sales History - PolyCoffee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../common/header.jsp" />

    <div class="container py-4">
        <h2 class="mb-4 fw-bold">Sales History</h2>
        
        <div class="row g-4">
            <!-- List Side -->
            <div class="col-md-${not empty bill ? '7' : '12'}">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">Code</th>
                                    <th>Date</th>
                                    <th>Total</th>
                                    <th>Status</th>
                                    <th class="text-end pe-4">Details</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="b" items="${bills}">
                                    <tr class="${bill.id == b.id ? 'table-primary-subtle' : ''}">
                                        <td class="ps-4 fw-bold">${b.code}</td>
                                        <td><fmt:formatDate value="${b.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                        <td class="fw-bold"><fmt:formatNumber value="${b.total}" pattern="#,###"/> đ</td>
                                        <td>
                                            <span class="badge rounded-pill 
                                                ${b.status == 'FINISHED' ? 'bg-success' : (b.status == 'CANCELLED' ? 'bg-danger' : 'bg-warning')}">
                                                ${b.status}
                                            </span>
                                        </td>
                                        <td class="text-end pe-4">
                                            <a href="?id=${b.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-eye"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Detail Side (Conditional) -->
            <c:if test="${not empty bill}">
                <div class="col-md-5">
                    <div class="card shadow-sm border-0 sticky-top" style="top: 20px;">
                        <div class="card-header bg-primary text-white py-3 border-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0 fw-bold">Bill Details</h5>
                                <a href="${pageContext.request.contextPath}/manager/bills" class="btn-close btn-close-white"></a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="mb-4">
                                <div class="small text-muted mb-1">REFERENCE CODE</div>
                                <div class="fw-bold text-dark fs-5">${bill.code}</div>
                            </div>
                            
                            <table class="table table-sm table-borderless align-middle mb-4">
                                <thead class="border-bottom small text-muted fw-bold">
                                    <tr>
                                        <th>ITEM</th>
                                        <th class="text-center">QTY</th>
                                        <th class="text-end">SUBTOTAL</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${bill.billDetails}">
                                        <tr>
                                            <td>${item.drink.name}</td>
                                            <td class="text-center">${item.quantity}</td>
                                            <td class="text-end fw-bold"><fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                            <div class="bg-light p-3 rounded-3">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Status</span>
                                    <span class="fw-bold text-primary">${bill.status}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Served By</span>
                                    <span class="fw-bold">${bill.user.fullName}</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <span class="fs-5 fw-bold">Grand Total</span>
                                    <span class="fs-4 fw-bold text-dark"><fmt:formatNumber value="${bill.total}" pattern="#,###"/> đ</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
