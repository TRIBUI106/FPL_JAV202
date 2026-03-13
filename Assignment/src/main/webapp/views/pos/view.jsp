<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <title>POS Hub - PolyCoffee</title>
</head>
<body class="bg-cream font-sans min-h-full h-screen overflow-hidden flex flex-col">

    <jsp:include page="../common/header.jsp" />

    <main class="flex-grow overflow-hidden px-4 md:px-8 pb-4">
        <div class="max-w-[1600px] mx-auto h-full flex flex-col lg:flex-row gap-6">
            
            <!-- Menu Area (Left) -->
            <div class="flex-grow flex flex-col min-h-0 py-4">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h1 class="text-3xl font-bold text-mocha">Menu</h1>
                        <p class="text-mocha/50 text-sm">Select items to add to the order</p>
                    </div>
                    <div class="relative w-72">
                        <i class="bi bi-search absolute left-4 top-1/2 -translate-y-1/2 text-mocha/30"></i>
                        <input type="text" placeholder="Search menu..." 
                               class="w-full glass bg-white/50 pl-11 pr-4 py-3 rounded-2xl focus:bg-white outline-none transition-all placeholder:text-mocha/20 text-sm">
                    </div>
                </div>

                <!-- Category Filter Pills (Soft Scrollable) -->
                <div class="flex gap-2 overflow-x-auto pb-4 no-scrollbar">
                    <button class="bg-coffee-700 text-white px-5 py-2 rounded-full text-sm font-semibold whitespace-nowrap">All Drinks</button>
                    <c:forEach var="cat" items="${categories}">
                        <button class="glass px-5 py-2 rounded-full text-sm font-medium text-mocha hover:bg-white whitespace-nowrap transition-colors">${cat.name}</button>
                    </c:forEach>
                </div>

                <!-- Drinks Grid -->
                <div class="flex-grow overflow-y-auto pr-2 custom-scroll grid grid-cols-2 md:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-6 h-full content-start pb-10">
                    <c:forEach var="d" items="${drinks}">
                        <div class="group relative glass p-3 rounded-coffee cursor-pointer transition-all hover:bg-white"
                             onclick="location.href='${pageContext.request.contextPath}/employee/pos/add?drinkId=${d.id}${not empty currentBill ? '&billId=' : ''}${currentBill.id}'">
                            
                            <!-- Image Container -->
                            <div class="aspect-square rounded-2xl overflow-hidden mb-3 relative">
                                <c:choose>
                                    <c:when test="${not empty d.image}">
                                        <img src="${pageContext.request.contextPath}/uploads/${d.image}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="w-full h-full bg-coffee-50 flex items-center justify-center text-latte text-3xl">
                                            <i class="bi bi-cup-hot"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="absolute inset-0 bg-black/0 group-hover:bg-black/10 transition-colors flex items-center justify-center">
                                    <div class="bg-white p-2 rounded-full scale-0 group-hover:scale-100 transition-transform text-coffee-700 shadow-xl">
                                        <i class="bi bi-plus-lg"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="px-1 text-center">
                                <h3 class="font-bold text-mocha mb-1 truncate">${d.name}</h3>
                                <div class="text-coffee-700 font-bold"><fmt:formatNumber value="${d.price}" pattern="#,###"/> đ</div>
                                <span class="text-[10px] uppercase tracking-wider text-mocha/30 font-bold">${d.category.name}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Receipt Sidebar (Right) -->
            <div class="lg:w-[450px] flex flex-col py-4 h-full">
                <div class="glass h-full rounded-coffee overflow-hidden flex flex-col bg-white">
                    <div class="p-6 border-b border-coffee-50">
                        <div class="flex items-center justify-between mb-1">
                            <h2 class="text-xl font-bold text-mocha capitalize">Current Ticket</h2>
                            <span class="text-[10px] font-bold bg-coffee-50 text-coffee-700 px-2 py-1 rounded">#${not empty currentBill ? currentBill.code : 'DRAFT'}</span>
                        </div>
                        <p class="text-mocha/40 text-xs">Serving: <span class="text-latte font-bold">${sessionScope.user.fullName}</span></p>
                    </div>

                    <!-- Items List -->
                    <div class="flex-grow overflow-y-auto p-6 custom-scroll">
                        <c:choose>
                            <c:when test="${not empty currentBill.billDetails}">
                                <div class="space-y-4">
                                    <c:forEach var="item" items="${currentBill.billDetails}">
                                        <div class="group relative flex items-center gap-4 bg-coffee-50/50 p-3 rounded-2xl hover:bg-coffee-50 transition-colors">
                                            <div class="w-12 h-12 rounded-xl overflow-hidden glass flex-shrink-0">
                                                <c:if test="${not empty item.drink.image}"><img src="${pageContext.request.contextPath}/uploads/${item.drink.image}" class="w-full h-full object-cover"></c:if>
                                            </div>
                                            <div class="flex-grow">
                                                <h4 class="text-sm font-bold text-mocha mb-1">${item.drink.name}</h4>
                                                <div class="flex items-center justify-between">
                                                    <span class="text-latte font-bold text-xs"><fmt:formatNumber value="${item.price}" pattern="#,###"/> đ</span>
                                                    
                                                    <!-- Quantity Control -->
                                                    <div class="flex items-center glass rounded-lg overflow-hidden h-7">
                                                        <button class="px-2 text-mocha/40 hover:bg-white" 
                                                                onclick="location.href='${pageContext.request.contextPath}/employee/pos/update?billId=${currentBill.id}&drinkId=${item.drink.id}&quantity=${item.quantity - 1}'">
                                                            <i class="bi bi-dash"></i>
                                                        </button>
                                                        <span class="w-8 text-center text-xs font-bold text-mocha">${item.quantity}</span>
                                                        <button class="px-2 text-mocha/40 hover:bg-white"
                                                                onclick="location.href='${pageContext.request.contextPath}/employee/pos/update?billId=${currentBill.id}&drinkId=${item.drink.id}&quantity=${item.quantity + 1}'">
                                                            <i class="bi bi-plus"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="h-full flex flex-col items-center justify-center text-center opacity-20 py-20">
                                    <i class="bi bi-cup-hot text-7xl mb-4"></i>
                                    <p class="font-bold">Cart is empty</p>
                                    <p class="text-sm">Start by selecting a brew</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Checkout Footer -->
                    <div class="p-6 bg-coffee-50/50 border-t border-coffee-100">
                        <div class="flex items-center justify-between mb-6">
                            <span class="text-mocha/50 font-medium">Grand Total</span>
                            <span class="text-3xl font-bold text-mocha"><fmt:formatNumber value="${currentBill.total}" pattern="#,###"/> đ</span>
                        </div>

                        <div class="flex gap-3">
                            <button class="flex-grow btn-coffee py-4 flex items-center justify-center gap-2 group" 
                                    ${empty currentBill.billDetails ? 'disabled' : ''}
                                    onclick="if(confirm('Finalize order?')) location.href='${pageContext.request.contextPath}/employee/pos/checkout?billId=${currentBill.id}'">
                                <span>PRINT & PAY</span>
                                <i class="bi bi-arrow-right group-hover:translate-x-1 transition-transform"></i>
                            </button>
                            <c:if test="${not empty currentBill.billDetails}">
                                <button class="w-14 h-14 bg-red-100 text-red-500 rounded-xl hover:bg-red-500 hover:text-white transition-all flex items-center justify-center shrink-0"
                                        onclick="if(confirm('Void this ticket?')) location.href='${pageContext.request.contextPath}/employee/pos/cancel?billId=${currentBill.id}'">
                                    <i class="bi bi-trash3-fill"></i>
                                </button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <style>
        .custom-scroll::-webkit-scrollbar { width: 6px; }
        .custom-scroll::-webkit-scrollbar-track { background: transparent; }
        .custom-scroll::-webkit-scrollbar-thumb { @apply bg-coffee-100 rounded-full; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
    </style>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
