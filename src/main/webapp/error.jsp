<%-- 
    Document   : error
    Created on : Mar 23, 2026, 10:34:26 AM
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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
  </head>
  <style>
    body {
      font-family: 'Noto Sans', sans-serif;
    }
  </style>
  <body class="bg-[#F5F7FA] min-h-screen flex items-center justify-center p-6 text-[#2C2C2C]">

    <div class="max-w-md w-full text-center">

      <div class="relative inline-block mb-10">
        <div class="w-24 h-24 bg-[#27138B] rounded-[2rem] flex items-center justify-center shadow-2xl transform rotate-12 group-hover:rotate-0 transition-transform duration-500">
          <span class="text-white font-black text-6xl">?</span>
        </div>
        <div class="absolute -top-4 -right-4 w-8 h-8 bg-[#CDB0FF] rounded-full opacity-50 animate-bounce"></div>
        <div class="absolute -bottom-2 -left-6 w-6 h-6 bg-[#27138B] rounded-lg opacity-20 animate-pulse"></div>
      </div>

      <h1 class="text-8xl font-black text-[#27138B] mb-2 tracking-tighter opacity-10">404</h1>
      <h2 class="text-3xl font-black text-[#27138B] mb-4 tracking-tight -mt-12 relative">
        Lost in the Hub?
      </h2>

      <p class="text-gray-500 font-medium leading-relaxed mb-10 px-4">
        The page you're looking for has either been moved, deleted, or never existed in our knowledge base. 
        <span class="block mt-2 text-[#27138B] font-bold">Let's get you back on track.</span>
      </p>

      <div class="flex flex-col gap-4">
        <a href="${pageContext.request.contextPath}/home" 
           class="inline-flex items-center justify-center gap-3 bg-[#27138B] hover:bg-[#1e0e6b] text-white px-10 py-4 rounded-2xl font-black uppercase tracking-widest text-sm transition-all shadow-lg hover:shadow-[#CDB0FF]/50 active:scale-95">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
          Explore Discussions
        </a>

        <button onclick="history.back()" class="text-xs font-black text-gray-400 hover:text-[#27138B] uppercase tracking-widest transition-colors cursor-pointer">
          Go Back to previous page
        </button>
      </div>

      <div class="mt-20 flex items-center justify-center gap-2 opacity-40">
        <div class="w-6 h-6 bg-[#27138B] rounded-lg flex items-center justify-center">
          <span class="text-white font-bold text-xs">Q</span>
        </div>
        <span class="text-sm font-black tracking-tight text-[#27138B] uppercase">KnowledgeHub</span>
      </div>
    </div>

  </body>
</html>
