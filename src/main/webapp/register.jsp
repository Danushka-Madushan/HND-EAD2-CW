<%-- 
    Document   : register
    Created on : Mar 16, 2026, 11:03:27 AM
    Author     : dm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Knowledge Hub</title>
        <link rel="icon" type="image/png" href="favicon.ico" />
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
    <body class="bg-[#F5F7FA] min-h-screen flex items-center justify-center p-6 font-sans text-[#2C2C2C]">
        <div class="w-full max-w-2xl bg-white rounded-2xl shadow-xl border border-gray-200 overflow-hidden">

            <div class="bg-[#27138B] p-8 text-center">
                <h1 class="text-white text-2xl font-bold tracking-tight">Create Your Account</h1>
                <p class="text-[#CDB0FF] text-sm mt-2">Join the community and start sharing knowledge.</p>
            </div>

            <form action="${pageContext.request.contextPath}/register" method="POST" class="p-8 lg:p-10">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">

                    <div class="flex flex-col items-center justify-center space-y-4 border-b md:border-b-0 md:border-r border-gray-100 pb-8 md:pb-0 md:pr-8">
                        <label class="block text-sm font-semibold text-center w-full">Choose Your Avatar</label>
                        <div class="relative group">
                            <img id="avatar-preview" src="https://picsum.photos/500" alt="Profile Preview" 
                                 class="w-40 h-40 rounded-full object-cover border-4 border-[#CDB0FF] shadow-inner transition-opacity duration-300">
                            <div id="loader" class="absolute inset-0 flex items-center justify-center bg-white/50 rounded-full hidden">
                                <div class="w-6 h-6 border-2 border-[#27138B] border-t-transparent rounded-full animate-spin"></div>
                            </div>
                        </div>
                        <button type="button" onclick="refreshAvatar()" 
                                class="flex items-center gap-2 px-4 py-2 bg-gray-100 hover:bg-[#CDB0FF] hover:text-[#27138B] rounded-full text-xs font-bold transition-all uppercase tracking-wider">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                            </svg>
                            Shuffle Image
                        </button>
                        <p class="text-[10px] text-gray-400 italic">Click shuffle until you find one you like!</p>
                    </div>

                    <div class="space-y-4">
                        <div>
                            <label for="name" class="block text-sm font-semibold mb-1">Name (Nickname)</label>
                            <input required value="${name}" type="text" id="name" name="name" placeholder="John Doe"
                                   class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] outline-none transition-all">
                        </div>

                        <div>
                            <label for="email" class="block text-sm font-semibold mb-1">Email Address</label>
                            <input required value="${email}" type="email" id="email" name="email" placeholder="name@example.com"
                                   class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] outline-none transition-all">
                        </div>

                        <div>
                            <label for="password" class="block text-sm font-semibold mb-1">Password</label>
                            <input required minlength="8" maxlength="16" type="password" id="password" name="password" placeholder="••••••••"
                                   class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] outline-none transition-all">
                        </div>

                        <div>
                            <label for="password_confirmation" class="block text-sm font-semibold mb-1">Confirm Password</label>
                            <input required minlength="8" maxlength="16" type="password" id="password_confirmation" name="password_confirmation" placeholder="••••••••"
                                   class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-[#CDB0FF] focus:border-[#27138B] outline-none transition-all">
                        </div>

                    </div>
                </div>

                <div class="mt-10 space-y-4">
                    <input id="avatar_link" name="avatar_link" hidden />
                    <button type="submit" 
                            class="w-full bg-[#27138B] hover:bg-[#1e0e6b] text-white font-bold py-3 rounded-lg transition-colors shadow-md">
                        Complete Registration
                    </button>
                    <p class="text-center text-sm text-gray-600">
                        Already a member? 
                        <a href="${pageContext.request.contextPath}/login.jsp" class="text-[#27138B] font-bold hover:underline">Log in here</a>
                    </p>
                </div>
            </form>
        </div>

        <script>
            function RegistrationSuccess() {
                Swal.fire({
                    title: 'Registration Complete',
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
                        window.location.href = 'login.jsp';
                    }
                });
            }

            function PasswordMismatch() {
                Swal.fire({
                    title: 'Password Mismatch',
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

            function EmailInUse() {
                Swal.fire({
                    title: 'Email Already Registered',
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

            function UnknownError() {
                Swal.fire({
                    title: 'Try Again',
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

            function refreshAvatar() {
                const img = document.getElementById('avatar-preview');
                const avatar_input = document.getElementById("avatar_link");
                const loader = document.getElementById('loader');

                loader.classList.remove('hidden');
                img.style.opacity = '0.4';

                img.onload = function () {
                    loader.classList.add('hidden');
                    img.style.opacity = '1';
                };

                img.onerror = function () {
                    loader.classList.add('hidden');
                    img.style.opacity = '1';
                    console.error("Failed to load new avatar.");
                };

                img.removeAttribute('src');

                const unique = Date.now() + Math.random();
                const newSrc = "https://picsum.photos/seed/" + unique + "/500/500";
                img.src = newSrc;
                avatar_input.value = newSrc;
            }

            switch ("${status}") {
                case "EMAIL_IN_USE":
                {
                    EmailInUse();
                    break;
                }
                case "PASS_NOT_MATCH":
                {
                    PasswordMismatch();
                    break;
                }
                case "FAILED":
                {
                    UnknownError();
                    break;
                }
                case "SUCCESS":
                {
                    RegistrationSuccess();
                    break;
                }
            }

            refreshAvatar();
        </script>
    </body>
</html>
