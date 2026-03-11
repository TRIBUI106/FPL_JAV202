<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <title>PolyCoffee - Premium Brews</title>
</head>
<body class="bg-cream font-sans min-h-full flex flex-column">

    <jsp:include page="common/header.jsp" />

    <main class="flex-grow">
        <!-- Hero Section -->
        <section class="max-w-7xl mx-auto px-4 py-16 md:py-24 text-center">
            <div class="inline-flex items-center gap-2 bg-white/50 px-4 py-2 rounded-full text-coffee-700 text-sm font-bold mb-8 shadow-sm">
                <span class="flex h-2 w-2 rounded-full bg-coffee-700 animate-pulse"></span>
                PREMIUM COFFEE EXPERIENCE
            </div>
            
            <h1 class="text-5xl md:text-7xl font-bold text-mocha mb-8 leading-tight">
                Fuel Your Passion With <br/>
                <span class="text-coffee-700">Perfectly Brewed</span> Coffee.
            </h1>
            
            <p class="text-mocha/60 text-lg md:text-xl max-w-2xl mx-auto mb-12">
                Elevate your daily routine with our artisanal coffee management system. 
                Fast, reliable, and designed for coffee lovers.
            </p>

            <div class="flex flex-col sm:flex-row gap-4 justify-center">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/auth/login" class="btn-coffee text-lg px-10 py-4">Explore Menu</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/employee/pos" class="btn-coffee text-lg px-10 py-4">Go to POS Dashboard</a>
                    </c:otherwise>
                </c:choose>
                <a href="#features" class="btn-soft text-lg px-10 py-4">Our Features</a>
            </div>
        </section>

        <!-- Stats Section -->
        <section id="features" class="max-w-7xl mx-auto px-4 py-20">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="glass p-8 rounded-coffee transition-transform hover:-translate-y-2 duration-300">
                    <div class="w-14 h-14 bg-coffee-50 rounded-2xl flex items-center justify-center text-coffee-700 text-2xl mb-6">
                        <i class="bi bi-lightning-charge-fill"></i>
                    </div>
                    <h3 class="text-xl font-bold text-mocha mb-3">Ultra-Fast POS</h3>
                    <p class="text-mocha/60">Speed matters. Process orders in seconds with our optimized interface designed for rush hours.</p>
                </div>

                <div class="glass p-8 rounded-coffee transition-transform hover:-translate-y-2 duration-300">
                    <div class="w-14 h-14 bg-coffee-50 rounded-2xl flex items-center justify-center text-coffee-700 text-2xl mb-6">
                        <i class="bi bi-bar-chart-fill"></i>
                    </div>
                    <h3 class="text-xl font-bold text-mocha mb-3">Live Analytics</h3>
                    <p class="text-mocha/60">Data is power. Track your performance, best sellers, and revenue trends with elegant visual reports.</p>
                </div>

                <div class="glass p-8 rounded-coffee transition-transform hover:-translate-y-2 duration-300">
                    <div class="w-14 h-14 bg-coffee-50 rounded-2xl flex items-center justify-center text-coffee-700 text-2xl mb-6">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <h3 class="text-xl font-bold text-mocha mb-3">Secure Assets</h3>
                    <p class="text-mocha/60">Protected catalog. Manage your drinks, staff, and categories with a secure role-based permissions system.</p>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="common/footer.jsp" />

</body>
</html>
