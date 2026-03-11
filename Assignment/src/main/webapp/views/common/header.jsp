<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<script>
    tailwind.config = {
        theme: {
            extend: {
                colors: {
                    coffee: {
                        50: '#fdf8f6',
                        100: '#f2e8e5',
                        200: '#eaddd7',
                        300: '#e0c1b3',
                        400: '#d3a08b',
                        500: '#c67f63',
                        600: '#b95d3b',
                        700: '#6F4E37', // Primary
                        800: '#5c402d',
                        900: '#4a3424',
                    },
                    cream: '#FDF7E4',
                    latte: '#A67B5B',
                    caramel: '#ECB176',
                    mocha: '#2D2424',
                },
                fontFamily: {
                    sans: ['Outfit', 'sans-serif'],
                },
                borderRadius: {
                    'coffee': '1.5rem',
                }
            }
        }
    }
</script>

<style type="text/tailwindcss">
    @layer components {
        .glass {
            @apply bg-white/70 backdrop-blur-md border border-white/20 shadow-xl;
        }
        .btn-coffee {
            @apply bg-coffee-700 text-white px-6 py-2.5 rounded-xl font-semibold transition-all duration-300 hover:bg-latte hover:scale-105 active:scale-95 shadow-lg shadow-coffee-700/20;
        }
        .btn-soft {
            @apply bg-white text-coffee-700 border border-coffee-100 px-6 py-2.5 rounded-xl font-semibold transition-all duration-300 hover:bg-cream hover:border-latte shadow-sm;
        }
        .nav-link-custom {
            @apply text-mocha/70 hover:text-coffee-700 font-medium px-4 py-2 transition-colors duration-200 relative;
        }
        .nav-link-active {
            @apply text-coffee-700 font-bold;
        }
        .nav-link-active::after {
            content: '';
            @apply absolute bottom-0 left-4 right-4 h-0.5 bg-coffee-700 rounded-full;
        }
    }
</style>

<nav class="sticky top-0 z-50 glass border-b border-coffee-100/50 px-4 md:px-8 py-3">
    <div class="max-w-7xl mx-auto flex items-center justify-between">
        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2 group">
            <div class="bg-coffee-700 p-2 rounded-xl group-hover:rotate-12 transition-transform duration-300">
                <i class="bi bi-cup-hot-fill text-white text-xl"></i>
            </div>
            <span class="text-2xl font-bold text-mocha">Poly<span class="text-coffee-700">Coffee</span></span>
        </a>

        <!-- Desktop Nav -->
        <div class="hidden md:flex items-center gap-2">
            <a href="${pageContext.request.contextPath}/" class="nav-link-custom ${pageContext.request.requestURI.endsWith('/home.jsp') || pageContext.request.requestURI.endsWith('/') ? 'nav-link-active' : ''}">Home</a>
            
            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/employee/pos" class="nav-link-custom ${pageContext.request.requestURI.contains('/pos') ? 'nav-link-active' : ''}">POS</a>
                
                <c:if test="${sessionScope.user.role}">
                    <div class="relative group">
                        <button class="nav-link-custom flex items-center gap-1">
                            Management <i class="bi bi-chevron-down text-[10px]"></i>
                        </button>
                        <div class="absolute top-full left-0 mt-2 w-48 glass rounded-2xl p-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 translate-y-2 group-hover:translate-y-0">
                            <a href="${pageContext.request.contextPath}/manager/categories" class="block px-4 py-2 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-colors">Categories</a>
                            <a href="${pageContext.request.contextPath}/manager/drinks" class="block px-4 py-2 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-colors">Drinks</a>
                            <a href="${pageContext.request.contextPath}/manager/staff" class="block px-4 py-2 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-colors">Staff List</a>
                            <div class="h-px bg-coffee-100 my-1 mx-2"></div>
                            <a href="${pageContext.request.contextPath}/manager/bills" class="block px-4 py-2 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-colors text-coffee-700 font-medium">Sales History</a>
                            <a href="${pageContext.request.contextPath}/manager/statistics" class="block px-4 py-2 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-colors text-coffee-700 font-medium">Reports</a>
                        </div>
                    </div>
                </c:if>
            </c:if>
        </div>

        <!-- Right Side -->
        <div class="flex items-center gap-4">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn-coffee py-2">Login</a>
                </c:when>
                <c:otherwise>
                    <div class="relative group">
                        <button class="flex items-center gap-3 glass px-4 py-2 rounded-2xl hover:bg-white transition-colors">
                            <div class="w-8 h-8 rounded-full bg-coffee-100 flex items-center justify-center text-coffee-700 font-bold">
                                ${sessionScope.user.fullName.substring(0,1)}
                            </div>
                            <span class="hidden sm:block font-semibold text-mocha text-sm">${sessionScope.user.fullName}</span>
                        </button>
                        <div class="absolute top-full right-0 mt-2 w-48 glass rounded-2xl p-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 translate-y-2 group-hover:translate-y-0">
                            <a href="${pageContext.request.contextPath}/auth/logout" class="block px-4 py-2 hover:bg-red-50 text-red-500 rounded-xl text-sm transition-colors flex items-center gap-2">
                                <i class="bi bi-box-arrow-right"></i> Logout
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>
