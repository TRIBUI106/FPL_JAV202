<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="h-full">
<head>
    <meta charset="UTF-8">
    <title>404 - Bean Not Found | PolyCoffee</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
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
                            700: '#6F4E37',
                            800: '#5c402d',
                            900: '#4a3424',
                        },
                        cream: '#FDF7E4',
                        latte: '#A67B5B',
                        caramel: '#ECB176',
                        mocha: '#2D2424',
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                        display: ['Playfair Display', 'serif'],
                    },
                    animation: {
                        'morph': 'morph 8s ease-in-out infinite',
                    },
                    keyframes: {
                        morph: {
                            '0%, 100%': { borderRadius: '40% 60% 70% 30% / 40% 40% 60% 50%' },
                            '50%': { borderRadius: '70% 30% 50% 50% / 30% 30% 70% 70%' },
                        }
                    }
                }
            }
        }
    </script>
    <style type="text/tailwindcss">
        @layer components {
            .glass {
                @apply bg-white/40 backdrop-blur-xl border border-white/30 shadow-[0_8px_32px_0_rgba(111,78,55,0.1)];
            }
            .btn-coffee {
                @apply bg-coffee-700 text-white px-8 py-3.5 rounded-full font-semibold transition-all duration-500 hover:bg-coffee-800 hover:scale-105 active:scale-95 shadow-xl shadow-coffee-700/30 flex items-center gap-2;
            }
            .btn-soft {
                @apply bg-white/50 backdrop-blur-md text-coffee-800 border border-coffee-200/50 px-8 py-3.5 rounded-full font-semibold transition-all duration-500 hover:bg-cream/80 hover:border-coffee-300 shadow-lg flex items-center gap-2;
            }
        }
        .text-display { font-family: 'Playfair Display', serif; }
        .blob { @apply absolute blur-[100px] opacity-20 animate-morph; }
    </style>
</head>
<body class="bg-[#FCF9F3] text-mocha font-sans h-full flex flex-col items-center justify-center overflow-hidden">
    
    <!-- Background Decoration -->
    <div class="fixed inset-0 -z-10">
        <div class="blob w-[600px] h-[600px] bg-coffee-200 -top-20 -left-20"></div>
        <div class="blob w-[500px] h-[500px] bg-caramel/40 bottom-0 -right-20" style="animation-delay: -2s"></div>
    </div>

    <div class="max-w-2xl text-center px-6 relative">
        <div class="mb-12 relative inline-flex items-center justify-center">
            <span class="text-[180px] md:text-[240px] font-black opacity-[0.05] tracking-tighter text-display selection:bg-transparent -z-10 select-none">404</span>
            <div class="absolute inset-0 flex items-center justify-center">
                <div class="bg-coffee-700 p-8 rounded-[2.5rem] shadow-2xl rotate-12 animate-bounce">
                    <i class="bi bi-cup-hot text-white text-6xl"></i>
                </div>
            </div>
        </div>

        <h1 class="text-4xl md:text-5xl font-black mb-6 text-display tracking-tight">Bean Not Found.</h1>
        <p class="text-mocha/60 text-lg md:text-xl mb-12 font-light leading-relaxed">
            The brew you're looking for was never roasted or has evolved into something else. 
            Let's get you back to the main collection.
        </p>

        <div class="flex flex-col sm:flex-row gap-6 justify-center">
            <a href="${pageContext.request.contextPath}/" class="btn-coffee text-xl">
                Go to Homepage <i class="bi bi-house"></i>
            </a>
            <button onclick="history.back()" class="btn-soft text-xl">
                Go Back <i class="bi bi-arrow-left"></i>
            </button>
        </div>
    </div>

    <div class="fixed bottom-12 text-[10px] font-bold tracking-[0.4em] uppercase text-mocha/20">
        PolyCoffee &bull; Liquid Glass Architecture
    </div>

</body>
</html>
