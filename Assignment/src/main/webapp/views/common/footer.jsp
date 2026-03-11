<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="mt-auto py-12 bg-mocha text-white/50 border-t border-white/5">
    <div class="max-w-7xl mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-12 mb-12">
            <div>
                <div class="flex items-center gap-2 mb-6">
                    <div class="bg-coffee-700 p-1.5 rounded-lg">
                        <i class="bi bi-cup-hot-fill text-white"></i>
                    </div>
                    <span class="text-xl font-bold text-white">PolyCoffee</span>
                </div>
                <p class="text-sm leading-relaxed">
                    Elevating the Vietnamese coffee culture through digital excellence. 
                    Premium management for the finest brews.
                </p>
            </div>
            <div>
                <h4 class="text-white font-bold mb-6 uppercase tracking-widest text-xs">Quick Links</h4>
                <ul class="space-y-3 text-sm">
                    <li><a href="${pageContext.request.contextPath}/" class="hover:text-coffee-700 transition-colors">Digital Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/employee/pos" class="hover:text-coffee-700 transition-colors">Point of Sale</a></li>
                    <li><a href="#" class="hover:text-coffee-700 transition-colors">System Status</a></li>
                </ul>
            </div>
            <div>
                <h4 class="text-white font-bold mb-6 uppercase tracking-widest text-xs">Contact Hub</h4>
                <div class="flex items-center gap-4">
                    <a href="#" class="w-10 h-10 rounded-xl bg-white/5 hover:bg-coffee-700 hover:-translate-y-1 transition-all flex items-center justify-center text-white">
                        <i class="bi bi-github"></i>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-xl bg-white/5 hover:bg-coffee-700 hover:-translate-y-1 transition-all flex items-center justify-center text-white">
                        <i class="bi bi-envelope-at"></i>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-xl bg-white/5 hover:bg-coffee-700 hover:-translate-y-1 transition-all flex items-center justify-center text-white">
                        <i class="bi bi-linkedin"></i>
                    </a>
                </div>
            </div>
        </div>
        <div class="pt-12 border-t border-white/5 text-center text-[10px] font-bold tracking-[0.3em] uppercase">
            &copy; 2024 FPL_JAV202 &bull; Jakarta EE ProMax Edition
        </div>
    </div>
</footer>
