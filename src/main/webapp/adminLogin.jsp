<%-- 
    Document   : adminLogin
    Created on : Mar 22, 2026, 9:53:28 PM
    Author     : Danushka-Madushan
--%>

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
    <body class="bg-[#F5F7FA] min-h-screen flex items-center justify-center p-4">

        <div class="max-w-md w-full">

            <div class="flex flex-col items-center mb-8">
                <div class="w-16 h-16 bg-[#27138B] rounded-2xl flex items-center justify-center shadow-xl transform -rotate-6 mb-4">
                    <span class="text-white font-bold text-4xl">Q</span>
                </div>
                <h1 class="text-2xl font-black text-[#27138B] tracking-tight uppercase">Admin Control</h1>
            </div>

            <div class="bg-white rounded-3xl shadow-xl border-t-4 border-[#27138B] overflow-hidden">
                <form action="${pageContext.request.contextPath}/adminLogin" method="POST" class="p-10 space-y-6">

                    <div class="space-y-2">
                        <label for="email" class="text-xs font-black text-[#27138B] uppercase tracking-widest ml-1">Admin Email</label>
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.206" />
                                </svg>
                            </span>
                            <input type="email" id="email" name="email" required
                                   class="w-full pl-12 pr-5 py-4 bg-gray-50 border border-gray-200 rounded-2xl focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] focus:bg-white outline-none transition-all placeholder:text-gray-300"
                                   placeholder="admin@knowledgehub.com">
                        </div>
                    </div>

                    <div class="space-y-2">
                        <div class="flex justify-between items-center ml-1">
                            <label for="password" class="text-xs font-black text-[#27138B] uppercase tracking-widest">Password</label>
                        </div>
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                </svg>
                            </span>
                            <input type="password" id="password" name="password" required
                                   class="w-full pl-12 pr-5 py-4 bg-gray-50 border border-gray-200 rounded-2xl focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] focus:bg-white outline-none transition-all placeholder:text-gray-300"
                                   placeholder="••••••••">
                        </div>
                    </div>

                    <button type="submit" 
                            class="w-full bg-[#27138B] cursor-pointer hover:bg-[#1e0e6b] text-white py-4 rounded-2xl font-black uppercase tracking-widest text-sm transition-all shadow-lg hover:shadow-[#CDB0FF]/50 active:scale-[0.98]">
                        Secure Login
                    </button>

                </form>
            </div>

            <div class="text-center flex items-center justify-center mt-4">
                <a href="${pageContext.request.contextPath}/home" class="text-base font-bold text-[#27138B] hover:underline flex items-center gap-2 mt-6 mb-4">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    Back to KnowledgeHub
                </a>
            </div>
        </div>
        <script>
            function LoginSuccess(username) {
                Swal.fire({
                    title: 'Welcome Back,\n' + username + '!',
                    icon: 'success',
                    buttonsStyling: false,
                    confirmButtonText: "Explore",
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                    allowEnterKey: false,
                    showCloseButton: false,
                    customClass: {
                        confirmButton: "w-32 py-3 rounded-lg transition-colors shadow-md bg-[#27138B] hover:bg-[#1e0e6b] text-white font-semibold"
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = '${pageContext.request.contextPath}/adminDashboard';
                    }
                });
            }

            function InvalidCredential() {
                Swal.fire({
                    title: 'Incorrect Credentials',
                    text: "The email or password you entered is incorrect. Please try again.",
                    icon: 'warning',
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

            switch ("${status}") {
                case "FAILED":
                {
                    InvalidCredential();
                    break;
                }
                case "SUCCESS":
                {
                    LoginSuccess("${AdminUserName}");
                    break;
                }
            }
        </script>
    </body>
</html>
