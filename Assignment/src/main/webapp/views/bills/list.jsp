<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <title>Sales Audit - PolyCoffee</title>
</head>
<body class="bg-cream font-sans min-h-full">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-7xl mx-auto px-4 py-12">
        <div class="mb-16">
            <h1 class="text-4xl font-black text-mocha mb-2">Transaction Ledger</h1>
            <p class="text-latte font-bold text-xs tracking-widest uppercase">System Sales Audit & History</p>
        </div>

        <div class="flex flex-col lg:flex-row gap-10 items-start">
            
            <!-- Ledger List -->
            <div class="flex-grow w-full">
                <div class="glass overflow-hidden rounded-[2.5rem]">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left order-collapse">
                            <thead>
                                <tr class="bg-white/50 border-b border-coffee-50">
                                    <th class="px-10 py-6 text-[10px] font-black text-mocha/30 uppercase tracking-widest">Reference</th>
                                    <th class="px-6 py-6 text-[10px] font-black text-mocha/30 uppercase tracking-widest">Timepoint</th>
                                    <th class="px-6 py-6 text-[10px] font-black text-mocha/30 uppercase tracking-widest">Amount</th>
                                    <th class="px-6 py-6 text-[10px] font-black text-mocha/30 uppercase tracking-widest text-center">Status</th>
                                    <th class="px-10 py-6 text-[10px] font-black text-mocha/30 uppercase tracking-widest text-right">Audit</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-coffee-50/50">
                                <c:forEach var="b" items="${bills}">
                                    <tr class="group hover:bg-white/40 transition-colors ${bill.id == b.id ? 'bg-coffee-50/50' : ''}">
                                        <td class="px-10 py-6">
                                            <div class="bg-mocha text-white text-[10px] font-black px-2 py-1 rounded-md inline-block mb-1">${b.code}</div>
                                            <div class="text-xs font-bold text-latte uppercase tracking-tighter italic">Secured Ledger</div>
                                        </td>
                                        <td class="px-6 py-6">
                                            <div class="text-sm font-bold text-mocha capitalize"><fmt:formatDate value="${b.createdAt}" pattern="MMMM dd, yyyy"/></div>
                                            <div class="text-[10px] font-medium text-mocha/30 italic"><fmt:formatDate value="${b.createdAt}" pattern="hh:mm a"/></div>
                                        </td>
                                        <td class="px-6 py-6">
                                            <div class="font-black text-mocha text-lg"><fmt:formatNumber value="${b.total}" pattern="#,###"/> <span class="text-[10px] opacity-20">đ</span></div>
                                        </td>
                                        <td class="px-6 py-6 text-center">
                                            <span class="inline-flex py-1 px-4 rounded-full text-[10px] font-black border tracking-widest
                                                ${b.status == 'FINISHED' ? 'bg-emerald-50 text-emerald-600 border-emerald-100' : (b.status == 'CANCELLED' ? 'bg-red-50 text-red-600 border-red-100' : 'bg-caramel/10 text-caramel border-caramel/20')}">
                                                ${b.status}
                                            </span>
                                        </td>
                                        <td class="px-10 py-6 text-right">
                                            <a href="?id=${b.id}" class="w-10 h-10 inline-flex items-center justify-center rounded-2xl bg-white text-mocha hover:bg-coffee-700 hover:text-white shadow-sm border border-coffee-50 transition-all">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Detail Sidebar -->
            <c:if test="${not empty bill}">
                <div class="lg:w-[450px] sticky top-32 shrink-0">
                    <div class="glass p-8 rounded-[3rem] bg-white border-2 border-coffee-700/5 shadow-2xl shadow-coffee-700/10">
                        <div class="flex items-center justify-between mb-8 pb-6 border-b border-coffee-50">
                            <div>
                                <h2 class="text-xl font-black text-mocha">Audit View</h2>
                                <p class="text-[10px] font-bold text-latte tracking-[0.2em] uppercase">Detailed Ledger Recipt</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/manager/bills" class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-red-50 text-mocha/30 hover:text-red-500 transition-colors">
                                <i class="bi bi-x-lg"></i>
                            </a>
                        </div>

                        <div class="space-y-6 mb-10">
                            <c:forEach var="item" items="${bill.billDetails}">
                                <div class="flex items-center justify-between group">
                                    <div class="flex items-center gap-4">
                                        <div class="w-10 h-10 bg-coffee-50 rounded-xl flex items-center justify-center text-coffee-700 font-black text-xs">
                                            ${item.quantity}<span class="text-[8px] ml-0.5">X</span>
                                        </div>
                                        <div>
                                            <h4 class="font-bold text-mocha text-sm">${item.drink.name}</h4>
                                            <p class="text-[10px] text-mocha/30 font-bold uppercase tracking-tighter italic">Unit Price: <fmt:formatNumber value="${item.price}" pattern="#,###"/> đ</p>
                                        </div>
                                    </div>
                                    <div class="text-mocha font-black text-sm">
                                        <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> <span class="text-[8px] opacity-20 italic">đ</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="bg-coffee-50/50 p-8 rounded-[2rem] space-y-4">
                            <div class="flex justify-between text-[10px] font-black tracking-widest uppercase mb-2">
                                <span class="text-mocha/30">MetaData</span>
                                <span class="text-coffee-700">Audit Proof</span>
                            </div>
                            <div class="flex justify-between items-center text-sm">
                                <span class="text-mocha/40 font-bold">Transaction Status</span>
                                <span class="font-black text-emerald-600">${bill.status}</span>
                            </div>
                            <div class="flex justify-between items-center text-sm">
                                <span class="text-mocha/40 font-bold">Authenticated User</span>
                                <span class="font-black text-mocha italic">${bill.user.fullName}</span>
                            </div>
                            <div class="flex justify-between items-center text-sm">
                                <span class="text-mocha/40 font-bold">System Ref</span>
                                <span class="font-black text-mocha italic">#0${bill.id}</span>
                            </div>
                            
                            <hr class="border-coffee-100 my-4">
                            
                            <div class="flex justify-between items-center">
                                <span class="text-lg font-black text-mocha">Total Value</span>
                                <span class="text-2xl font-black text-coffee-700"><fmt:formatNumber value="${bill.total}" pattern="#,###"/> <span class="text-xs italic opacity-20">đ</span></span>
                            </div>
                        </div>

                        <button onclick="window.print()" class="w-full mt-8 btn-soft py-4 flex items-center justify-center gap-2 group">
                            <i class="bi bi-printer text-latte group-hover:scale-110 transition-transform"></i>
                            Export Proof (PDF)
                        </button>
                    </div>
                </div>
            </c:if>

        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
