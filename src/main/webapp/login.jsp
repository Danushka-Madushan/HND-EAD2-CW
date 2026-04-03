<%-- Document : index Created on : Mar 16, 2026, 10:17:10 AM Author : dm --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
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

    <body class="bg-[#F5F7FA] min-h-screen flex items-center justify-center p-4 font-sans text-[#2C2C2C]">
        <div class="w-full max-w-md bg-white rounded-xl shadow-lg border border-gray-200 overflow-hidden">

            <div class="bg-[#27138B] p-8 text-center">
                <h1 class="text-white text-2xl font-bold tracking-tight">Knowledge Hub</h1>
                <p class="text-[#CDB0FF] text-sm mt-2">Ask questions, share expertise, and find answers.</p>
            </div>

            <div class="p-8">
                <form action="${pageContext.request.contextPath}/login" method="POST" class="space-y-6">
                    <div>
                        <label for="email" class="block text-sm font-semibold mb-2">Email</label>
                        <input type="email" id="email" name="email"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] outline-none transition-all placeholder:text-gray-400"
                               placeholder="Enter your email" required>
                    </div>

                    <div>
                        <div class="flex justify-between mb-2">
                            <label for="password" class="text-sm font-semibold">Password</label>
                        </div>
                        <input type="password" id="password" name="password"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] outline-none transition-all placeholder:text-gray-400"
                               placeholder="••••••••" required>
                    </div>

                    <div class="pt-2">
                        <button type="submit"
                                class="w-full bg-[#27138B] hover:bg-[#1e0e6b] text-white font-bold py-3 rounded-lg transition-colors shadow-md">
                            Sign In
                        </button>
                    </div>
                </form>

                <div class="mt-8 pt-6 border-t border-gray-100 text-center">
                    <p class="text-sm text-gray-600">
                        New to the community?
                        <a href="${pageContext.request.contextPath}/register.jsp" class="text-[#27138B] font-bold hover:underline ml-1">Create an account</a>
                    </p>
                </div>
            </div>

            <div class="bg-gray-50 px-8 py-4 text-center">
                <p class="text-xs text-gray-500 italic">Join 10,000+ users solving problems together.</p>
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
                        window.location.href = '${pageContext.request.contextPath}/home';
                    }
                });
            }

            function UserBanned() {
                Swal.fire({
                    title: 'User Banned',
                    text: "Your account has been banned, please contact the administrator.",
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
                case "BANNED":
                {
                    UserBanned();
                    break;
                }
                case "SUCCESS":
                {
                    LoginSuccess(<c:out value="${userName}" />);
                    break;
                }
            }
        </script>
    </body>
</html>
