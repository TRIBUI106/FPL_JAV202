<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>POS - PolyCoffee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .pos-container { height: calc(100vh - 100px); overflow: hidden; }
        .menu-scroll { height: 100%; overflow-y: auto; padding-right: 15px; }
        .cart-container { height: 100%; display: flex; flex-column: column; }
        .cart-items { flex-grow: 1; overflow-y: auto; }
        .drink-card { transition: transform 0.2s; cursor: pointer; border: none; border-radius: 12px; }
        .drink-card:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .drink-img { height: 120px; object-fit: cover; border-radius: 12px 12px 0 0; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="../common/header.jsp" />

    <div class="container-fluid px-4">
        <div class="row pos-container">
            <!-- Left: Menu Side -->
            <div class="col-lg-8 menu-scroll">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3 class="fw-bold mb-0">Beverage Menu</h3>
                    <div class="input-group w-50 shadow-sm rounded">
                        <span class="input-group-text bg-white border-0"><i class="bi bi-search"></i></span>
                        <input type="text" class="form-control border-0" placeholder="Search drinks...">
                    </div>
                </div>

                <div class="row row-cols-2 row-cols-md-3 row-cols-xl-4 g-4 mb-5">
                    <c:forEach var="d" items="${drinks}">
                        <div class="col">
                            <div class="card h-100 drink-card shadow-sm" onclick="location.href='${pageContext.request.contextPath}/employee/pos/add?drinkId=${d.id}${not empty currentBill ? '&billId=' : ''}${currentBill.id}'">
                                <c:choose>
                                    <c:when test="${not empty d.image}">
                                        <img src="${pageContext.request.contextPath}/uploads/${d.image}" class="card-img-top drink-img">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="bg-secondary-subtle drink-img d-flex align-items-center justify-content-center text-secondary fs-1">
                                            <i class="bi bi-cup-hot"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body p-3 text-center">
                                    <h6 class="fw-bold mb-1">${d.name}</h6>
                                    <div class="text-primary fw-bold"><fmt:formatNumber value="${d.price}" pattern="#,###"/> đ</div>
                                    <small class="text-muted small">${d.category.name}</small>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Right: Cart Side -->
            <div class="col-lg-4 border-start bg-white p-4 cart-container shadow-sm border-radius-start-lg">
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <h4 class="fw-bold mb-0"><i class="bi bi-receipt"></i> Current Bill</h4>
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2">
                        ${not empty currentBill ? currentBill.code : 'New Ticket'}
                    </span>
                </div>

                <div class="cart-items">
                    <c:choose>
                        <c:when test="${not empty currentBill.billDetails}">
                            <div class="list-group list-group-flush">
                                <c:forEach var="item" items="${currentBill.billDetails}">
                                    <div class="list-group-item px-0 border-0 mb-3 bg-light rounded-3 p-3">
                                        <div class="d-flex justify-content-between align-items-top mb-2">
                                            <div class="fw-bold text-dark">${item.drink.name}</div>
                                            <div class="fw-bold text-primary"><fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> đ</div>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted"><fmt:formatNumber value="${item.price}" pattern="#,###"/> / unit</small>
                                            <div class="input-group input-group-sm w-50 shadow-sm rounded">
                                                <button class="btn btn-outline-secondary border-0" onclick="location.href='${pageContext.request.contextPath}/employee/pos/update?billId=${currentBill.id}&drinkId=${item.drink.id}&quantity=${item.quantity - 1}'"><i class="bi bi-dash"></i></button>
                                                <input type="text" class="form-control text-center border-0 bg-white" value="${item.quantity}" readonly>
                                                <button class="btn btn-outline-secondary border-0" onclick="location.href='${pageContext.request.contextPath}/employee/pos/update?billId=${currentBill.id}&drinkId=${item.drink.id}&quantity=${item.quantity + 1}'"><i class="bi bi-plus"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="bi bi-cart3 display-1 text-light"></i>
                                <p class="text-muted mt-3">Ready to take an order. Select items from the menu.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="cart-footer border-top pt-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fs-5 text-muted">Total Amount</span>
                        <span class="fs-2 fw-bold text-dark"><fmt:formatNumber value="${currentBill.total}" pattern="#,###"/> đ</span>
                    </div>

                    <div class="row g-2">
                        <div class="col-8">
                            <button class="btn btn-primary btn-lg w-100 py-3 fw-bold rounded-4 shadow-sm" 
                                    ${empty currentBill.billDetails ? 'disabled' : ''}
                                    onclick="if(confirm('Confirm payment and print receipt?')) location.href='${pageContext.request.contextPath}/employee/pos/checkout?billId=${currentBill.id}'">
                                <i class="bi bi-check-circle-fill me-2"></i> CHECKOUT
                            </button>
                        </div>
                        <div class="col-4">
                            <button class="btn btn-outline-danger btn-lg w-100 py-3 rounded-4" 
                                    ${empty currentBill.billDetails ? 'disabled' : ''}
                                    onclick="if(confirm('Are you sure you want to cancel this bill?')) location.href='${pageContext.request.contextPath}/employee/pos/cancel?billId=${currentBill.id}'">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
