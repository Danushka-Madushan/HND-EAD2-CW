<%-- 
    Document   : discussions
    Created on : Mar 22, 2026, 3:06:27 PM
    Author     : Danushka-Madushan
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
        
        <main class="max-w-4xl mx-auto px-4 pb-10">
            <a href="${pageContext.request.contextPath}/home" class="text-base font-bold text-[#27138B] hover:underline flex items-center gap-2 my-6">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                Back to Discussions
            </a>
            <article class="bg-white rounded-3xl shadow-sm border border-gray-200 overflow-hidden mb-8">
                <div class="p-8 lg:p-10">
                    <div class="flex items-center gap-3 mb-6">
                        <img src="${questionContent.getOwnerAvatar()}" alt="Author" class="w-10 h-10 rounded-full border border-gray-100">
                        <div>
                            <p class="text-sm font-bold text-[#27138B]">${questionContent.getOwnerName()}</p>
                            <p class="text-xs text-gray-400 font-medium">Asked ${questionContent.getCreatedTimeAgo()}</p>
                        </div>
                    </div>

                    <h1 class="text-2xl font-black text-[#27138B] mb-6 leading-tight">
                        ${questionContent.getTitle()}
                    </h1>

                    <div class="prose max-w-none text-gray-700 leading-relaxed mb-8">
                        ${questionContent.getDescription()}
                    </div>

                    <c:if test="${questionContent.getImageUrl() != 'NULL-IMAGE'}">
                        <div class="mb-6">
                            <img src="${pageContext.request.contextPath}/serve/${questionContent.getImageUrl()}" alt="Code Screenshot" class="w-full rounded-2xl border border-gray-100 shadow-inner">
                        </div>
                    </c:if>
                </div>
            </article>

            <section class="mb-12">
                <h2 class="text-xl font-bold text-[#27138B] mb-4">Your Answer</h2>
                <form action="${pageContext.request.contextPath}/postAnswer" method="POST" class="bg-white p-6 rounded-2xl shadow-sm border border-gray-200">
                    <input type="hidden" name="questionId" value="${questionContent.getQuestionId()}">
                    <textarea name="answerContent" rows="5" required
                              class="w-full px-5 py-4 rounded-xl border border-gray-200 focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] outline-none transition-all placeholder:text-gray-300 mb-4"
                              placeholder="Write your detailed answer here..."></textarea>
                    <div class="flex justify-end">
                        <button type="submit" class="bg-[#27138B] cursor-pointer hover:bg-[#1e0e6b] text-white px-8 py-3 rounded-xl font-bold text-sm transition-all shadow-md">
                            Post Answer
                        </button>
                    </div>
                </form>
            </section>

            <section class="space-y-6">
                <div class="flex items-center justify-between border-b border-gray-200 pb-4">
                    <h2 class="text-xl font-bold text-[#27138B]">${questionContent.getAnswerCount()} Answers</h2>
                </div>

                <c:forEach var="q" items="${questionContent.getAnswers()}">
                    <c:choose>
                        <c:when test="${q.isAccepted()}">
                            <div class="bg-emerald-50/50 border-2 border-emerald-200 rounded-3xl p-6 lg:p-8 relative overflow-hidden">
                                <div class="absolute top-0 right-0 bg-emerald-500 text-white px-4 py-1.5 rounded-bl-2xl flex items-center gap-2 shadow-sm">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                                    </svg>
                                    <span class="text-[10px] font-black uppercase tracking-widest">Accepted Answer</span>
                                </div>

                                <div class="flex flex-col gap-4">
                                    <div class="flex items-center gap-3">
                                        <img src="${q.getOwnerAvatar()}" class="w-8 h-8 rounded-full">
                                        <p class="text-sm font-bold text-emerald-900">${q.getOwnerName()}<span class="text-xs text-emerald-600/60 font-medium ml-2">${q.getPostedAgo()}</span></p>
                                    </div>
                                    <div class="text-emerald-900 leading-relaxed">
                                        ${q.getContent()}
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="bg-white border border-gray-200 rounded-3xl p-6 lg:p-8 shadow-sm">
                                <div class="flex flex-col gap-4">
                                    <div class="flex items-center gap-3">
                                        <img src="${q.getOwnerAvatar()}" class="w-8 h-8 rounded-full">
                                        <p class="text-sm font-bold text-[#27138B]">${q.getOwnerName()} <span class="text-xs text-gray-400 font-medium ml-2">${q.getPostedAgo()}</span></p>
                                    </div>
                                    <div class="text-gray-700 leading-relaxed">
                                        ${q.getContent()}
                                    </div>

                                    <c:if test="${questionContent.getOwnerId() == sessionScope.userId}">
                                        <div class="flex justify-end">
                                            <form action="${pageContext.request.contextPath}/markAccepted" method="POST">
                                                <input type="hidden" name="answerId" value="${q.getAnswerId()}">
                                                <input type="hidden" name="questionId" value="${questionContent.getQuestionId()}">
                                                <button type="submit" class="flex cursor-pointer items-center gap-2 border-2 border-[#CDB0FF] text-[#27138B] hover:bg-[#CDB0FF] px-4 py-2 rounded-xl text-xs font-black transition-all">
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                                                    </svg>
                                                    Mark as Accepted
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </section>
        </main>
        <script>
            function Failed() {
                Swal.fire({
                    title: 'Failed to Post Answer',
                    text: "There was an error while posting your answer. Please try again.",
                    icon: 'error',
                    buttonsStyling: false,
                    confirmButtonText: "OK",
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                    allowEnterKey: false,
                    showCloseButton: false,
                    customClass: {
                        confirmButton: "w-32 py-3 rounded-lg transition-colors shadow-md bg-[#27138B] hover:bg-[#1e0e6b] text-white font-semibold"
                    }
                });
            };

            function FailedMark() {
                Swal.fire({
                    title: 'Failed to Mark Answer',
                    text: "There was an error while marking your answer as accpted. Please try again.",
                    icon: 'error',
                    buttonsStyling: false,
                    confirmButtonText: "OK",
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                    allowEnterKey: false,
                    showCloseButton: false,
                    customClass: {
                        confirmButton: "w-32 py-3 rounded-lg transition-colors shadow-md bg-[#27138B] hover:bg-[#1e0e6b] text-white font-semibold"
                    }
                });
            };

            const status = "${sessionScope.status}";

            switch (status) {
                case "FAILED": {
                    Failed();
                    break;
                }
                case "FAILED_MARK_ACCEPTED": {
                    FailedMark();
                    break;
                }
            }
        </script>
        <c:remove var="status" scope="session" />
    </body>
</html>
