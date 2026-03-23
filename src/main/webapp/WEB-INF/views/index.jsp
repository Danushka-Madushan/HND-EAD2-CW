<%-- 
    Document   : index
    Created on : Mar 16, 2026, 10:48:37 AM
    Author     : dm
--%>
<%
    Boolean isAuthenticated = (Boolean) session.getAttribute("isAuthenticated");
    if (isAuthenticated == null || !isAuthenticated) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        /* stop rendering the page */
        return;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Knowledge Hub</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/favicon.ico" />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    </head>
    <style>
        body {
            font-family: 'Noto Sans', sans-serif;
        }
    </style>

    <body class="bg-[#F5F7FA] min-h-screen text-[#2C2C2C]">

        <nav class="bg-white border-b border-gray-200 sticky top-0 z-50 shadow-sm">
            <div class="max-w-7xl mx-auto px-4 h-20 flex items-center justify-between relative">

                <div class="flex items-center gap-2">
                    <div class="w-10 h-10 bg-[#27138B] rounded-xl flex items-center justify-center shadow-lg transform -rotate-3">
                        <span class="text-white font-bold text-2xl">Q</span>
                    </div>
                    <span class="text-xl font-black tracking-tight text-[#27138B] hidden lg:block">KnowledgeHub</span>
                </div>

                <div class="absolute left-1/2 transform -translate-x-1/2">
                    <a href="${pageContext.request.contextPath}/newQuestion.jsp" class="bg-[#27138B] hover:bg-[#1e0e6b] text-white px-8 py-3 rounded-full font-bold text-sm transition-all shadow-md flex items-center gap-2 group whitespace-nowrap">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 group-hover:scale-125 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                        </svg>
                        Ask New Question
                    </a>
                </div>

                <form method="POST" action="${pageContext.request.contextPath}/logout" class="flex items-center gap-3">
                    <div class="flex items-center gap-3 bg-gray-50 p-1.5 pr-4 rounded-full border border-gray-100">
                        <img src="${avatar_url}" alt="Avatar" class="w-10 h-10 rounded-full border border-[#CDB0FF] object-cover">
                        <span class="text-sm font-bold hidden md:block">${userName}</span>
                    </div>

                    <button class="bg-red-50 hover:bg-red-100 text-red-600 px-4 py-2 rounded-lg text-xs font-bold transition-colors border border-red-200 cursor-pointer uppercase tracking-wider">
                        Logout
                    </button>
                </form>
            </div>
        </nav>

        <main class="max-w-7xl mx-auto px-4 py-10">
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">

                <div class="lg:col-start-2 lg:col-span-7 space-y-6">

                    <div class="flex items-center justify-start mb-2">
                        <h2 class="text-2xl font-bold tracking-tight text-[#27138B]">Recent Discussions</h2>
                    </div>

                    <c:if test="${empty questionList}">
                        <div class="bg-white rounded-3xl p-16 shadow-sm border border-gray-100 flex flex-col items-center text-center">
                            <div class="w-20 h-20 bg-gray-50 rounded-full flex items-center justify-center mb-6">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-gray-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
                                </svg>
                            </div>

                            <h3 class="text-xl font-black text-[#27138B] mb-2 tracking-tight">No discussions found</h3>
                            <p class="text-gray-400 text-sm max-w-xs mx-auto mb-8 leading-relaxed">
                                It looks like there aren't any questions here yet. Why not start the conversation yourself?
                            </p>

                            <a href="${pageContext.request.contextPath}/newQuestion.jsp" 
                               class="inline-flex items-center gap-2 text-[#27138B] font-black text-xs uppercase tracking-widest border-2 border-[#CDB0FF] px-6 py-3 rounded-xl hover:bg-[#CDB0FF] transition-all">
                                Start a discussion
                            </a>
                        </div>
                    </c:if>

                    <c:forEach var="q" items="${questionList}">
                        <div class="group bg-white rounded-2xl p-6 shadow-sm hover:shadow-md transition-all border border-gray-200 overflow-hidden">
                            <div class="flex flex-col gap-4">
                                <div class="flex items-center gap-3">
                                    <img src="${q.getOwnerAvatar()}" alt="Author" class="w-10 h-10 rounded-full border border-gray-100">
                                    <div>
                                        <p class="text-sm font-bold text-[#27138B]">${q.getOwnerName()}</p>
                                        <p class="text-xs text-gray-400 font-medium">Asked ${q.getCreatedTimeAgo()}</p>
                                    </div>
                                </div>

                                <h3 class="text-xl font-bold leading-snug group-hover:text-[#27138B] transition-colors cursor-pointer">
                                    ${q.getTitle()}
                                </h3>

                                <c:if test="${q.getImageUrl() != 'NULL-IMAGE'}">
                                    <div class="rounded-xl overflow-hidden border border-gray-100">
                                        <img src="${pageContext.request.contextPath}/serve/${q.getImageUrl()}" alt="${q.getTitle()}" class="w-full h-48 object-cover group-hover:scale-105 transition-transform duration-500">
                                    </div>
                                </c:if>

                                <c:choose>
                                    <c:when test="${q.getAnswerCount() == 0}">
                                        <div class="flex items-center justify-between mt-2 pt-4 border-t border-gray-50">
                                            <div class="flex items-center gap-2 bg-gray-50 text-gray-400 px-4 py-2 rounded-xl border border-gray-100">
                                                <span class="text-xs font-bold">No answers yet</span>
                                            </div>

                                            <a href="${pageContext.request.contextPath}/discussion/${q.getQuestionId()}" class="border-2 border-[#27138B] text-[#27138B] px-6 py-2 rounded-xl cursor-pointer text-xs font-bold hover:bg-[#27138B] hover:text-white transition-all">
                                                Be the first to answer
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="flex items-center justify-between mt-2 pt-4 border-t border-gray-50">
                                            <div class="flex items-center gap-2 bg-emerald-50 text-emerald-700 px-4 py-2 rounded-xl border border-emerald-100">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
                                                <path fill-rule="evenodd" d="M18 10c0 3.866-3.582 7-8 7a8.841 8.841 0 01-4.083-.98L2 17l1.338-3.123C2.493 12.767 2 11.434 2 10c0-3.866 3.582-7 8-7s8 3.134 8 7zM7 9H5v2h2V9zm8 0h-2v2h2V9zm-4 0H9v2h2V9z" clip-rule="evenodd" />
                                                </svg>
                                                <span class="text-xs font-black uppercase tracking-wide">${q.getAnswerCount()} Answers</span>
                                            </div>

                                            <a href="${pageContext.request.contextPath}/discussion/${q.getQuestionId()}" class="bg-[#27138B] text-white px-6 py-2.5 rounded-xl cursor-pointer text-xs font-bold hover:bg-[#CDB0FF] hover:text-[#27138B] transition-all shadow-sm">
                                                View Discussion
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </div>
                    </c:forEach>
                </div>

                <aside class="hidden lg:block lg:col-span-3 space-y-6">
                    <div class="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm">
                        <h4 class="font-bold text-[#27138B] mb-4 uppercase text-xs tracking-widest">Your Activity</h4>
                        <div class="space-y-4">
                            <div class="flex justify-between items-center">
                                <span class="text-gray-500 text-sm">Questions</span>
                                <span class="font-bold">${userActivity.getQuestionCount()}</span>
                            </div>
                            <div class="flex justify-between items-center">
                                <span class="text-gray-500 text-sm">Answers Given</span>
                                <span class="font-bold text-emerald-600">${userActivity.getAnswerCount()}</span>
                            </div>
                        </div>
                    </div>

                    <div class="bg-[#27138B] p-6 rounded-2xl shadow-lg text-white">
                        <h4 class="font-bold mb-2 text-sm">Community Tip</h4>
                        <p class="text-xs text-[#CDB0FF] leading-relaxed">
                            Answering questions helps you build reputation and climb the leaderboard!
                        </p>
                    </div>
                </aside>

            </div>
        </main>
    </body>
</html>
