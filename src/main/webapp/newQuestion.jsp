<%-- 
    Document   : newQuestion
    Created on : Mar 21, 2026, 2:58:34 PM
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
                    <button disabled class="bg-[#27138B] opacity-50 cursor-not-allowed text-white px-8 py-3 rounded-full font-bold text-sm flex items-center gap-2 whitespace-nowrap">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                        </svg>
                        New Question
                    </button>
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

        <main class="max-w-3xl mx-auto px-4 pb-12">
            <a href="${pageContext.request.contextPath}/home" class="text-base font-bold text-[#27138B] hover:underline flex items-center gap-2 mt-6 mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                Back to Discussions
            </a>
            <div class="mb-8">
                <h1 class="text-3xl font-black text-[#27138B] tracking-tight">Ask a Public Question</h1>
                <p class="text-gray-500 mt-2">Be specific and imagine you’re asking a question to another person.</p>
            </div>

            <div class="bg-white rounded-3xl shadow-xl border border-gray-200 overflow-hidden">
                <form action="${pageContext.request.contextPath}/upload" method="POST" enctype="multipart/form-data" class="p-8">

                    <div class="space-y-2">
                        <label for="title" class="text-lg font-bold text-[#27138B] block">Title</label>
                        <p class="text-xs text-gray-400">Be specific and imagine you’re asking a question to another person.</p>
                        <input type="text" id="title" name="title" required
                               class="w-full px-5 py-4 rounded-xl border border-gray-200 focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] outline-none transition-all placeholder:text-gray-300"
                               placeholder="e.g. Is there an R function for finding the index of an element in a list?">
                    </div>

                    <div class="space-y-2">
                        <label for="description" class="text-lg font-bold text-[#27138B] block">Description</label>
                        <p class="text-xs text-gray-400">Include all the information someone would need to answer your question.</p>
                        <textarea id="description" name="description" rows="8" required
                                  class="w-full px-5 py-4 rounded-xl border border-gray-200 focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] outline-none transition-all placeholder:text-gray-300"
                                  placeholder="Provide details about your problem..."></textarea>
                    </div>

                    <div class="space-y-4">
                        <span class="text-lg font-bold text-[#27138B] block">Add an Image <span class="text-gray-300 font-normal text-sm">(Optional)</span></span>

                        <div class="flex items-center justify-center w-full">
                            <label for="image-upload" class="flex flex-col items-center justify-center w-full h-44 border-2 border-dashed border-gray-200 rounded-2xl cursor-pointer bg-gray-50 hover:bg-gray-100 transition-colors">
                                <div id="upload-placeholder" class="flex flex-col items-center justify-center pt-5 pb-6">
                                    <svg class="w-10 h-10 mb-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path></svg>
                                    <p class="mb-2 text-sm text-gray-500"><span class="font-bold">Click to upload</span> or drag and drop</p>
                                    <p class="text-xs text-gray-400">PNG, JPG or WEBP (MAX. 2MB)</p>
                                </div>
                                <img id="image-preview" class="hidden h-full w-full object-cover p-2 rounded-2xl" />
                                <input id="image-upload" name="image" type="file" class="hidden" accept="image/*" onchange="previewImage(event)" />
                            </label>
                        </div>
                    </div>

                    <div class="pt-6 border-t border-gray-50 flex items-center justify-end">
                        <button type="submit" 
                                class="bg-[#27138B] hover:bg-[#1e0e6b] text-white px-10 py-4 rounded-xl cursor-pointer font-bold transition-all shadow-lg hover:shadow-2xl">
                            Post Your Question
                        </button>
                    </div>
                </form>
            </div>
        </main>

        <script>
            function previewImage(event) {
                const reader = new FileReader();
                const output = document.getElementById('image-preview');
                const placeholder = document.getElementById('upload-placeholder');

                reader.onload = function () {
                    output.src = reader.result;
                    output.classList.remove('hidden');
                    placeholder.classList.add('hidden');
                };

                if (event.target.files[0]) {
                    reader.readAsDataURL(event.target.files[0]);
                }
            }
            ;

            function Success() {
                Swal.fire({
                    title: "Question Posted Successfully",
                    icon: 'success',
                    buttonsStyling: false,
                    confirmButtonText: "View",
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                    allowEnterKey: false,
                    showCloseButton: false,
                    customClass: {
                        confirmButton: "w-32 py-3 rounded-lg transition-colors shadow-md bg-[#27138B] hover:bg-[#1e0e6b] text-white font-semibold"
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = '${pageContext.request.contextPath}/home';
                    }
                });
            }
            ;

            function Failed() {
                Swal.fire({
                    title: 'Failed to Post Question',
                    text: "There was an error while posting your question. Please try again.",
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
            }
            ;

            switch ("${status}") {
                case "FAILED":
                {
                    Failed();
                    break;
                }
                case "SUCCESS":
                {
                    Success();
                    break;
                }
            }
        </script>

    </body>
</html>
