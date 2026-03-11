<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reports - PolyCoffee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../common/header.jsp" />

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0">Analytics & Reports</h2>
            
            <form action="" method="get" class="d-flex gap-2">
                <input type="date" name="from" class="form-control shadow-sm border-0" value="${param.from}">
                <input type="date" name="to" class="form-control shadow-sm border-0" value="${param.to}">
                <button type="submit" class="btn btn-primary shadow-sm px-4">Filter</button>
            </form>
        </div>

        <div class="row g-4 mb-5">
            <!-- Top Selling -->
            <div class="col-md-6">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0 fw-bold">Top 5 Best Selling Beverages</h5>
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="bg-light small">
                                <tr>
                                    <th class="ps-4">Rank</th>
                                    <th>Beverage</th>
                                    <th>Quantity Sold</th>
                                    <th class="text-end pe-4">Revenue</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${topDrinks}" varStatus="status">
                                    <tr>
                                        <td class="ps-4">
                                            <span class="badge rounded-circle border p-2
                                                ${status.index == 0 ? 'bg-warning text-dark border-warning' : 'bg-light text-muted'}">
                                                ${status.index + 1}
                                            </span>
                                        </td>
                                        <td class="fw-bold">${item.drinkName}</td>
                                        <td>${item.totalQuantitySold} cups</td>
                                        <td class="text-end pe-4 fw-bold text-success"><fmt:formatNumber value="${item.totalRevenue}" pattern="#,###"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Revenue Daily -->
            <div class="col-md-6">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0 fw-bold">Revenue by Day</h5>
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="bg-light small">
                                <tr>
                                    <th class="ps-4">Date</th>
                                    <th>Orders</th>
                                    <th class="text-end pe-4">Total Revenue</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="row" items="${revenueReport}">
                                    <tr>
                                        <td class="ps-4"><fmt:formatDate value="${row.revenueDate}" pattern="yyyy-MM-dd"/></td>
                                        <td class="fw-bold">${row.totalBills} bills</td>
                                        <td class="text-end pe-4 fw-bold text-primary"><fmt:formatNumber value="${row.totalRevenue}" pattern="#,###"/></td>
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
