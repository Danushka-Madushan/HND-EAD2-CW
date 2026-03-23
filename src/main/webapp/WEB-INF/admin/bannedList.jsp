<%-- 
    Document   : bannedList
    Created on : Mar 23, 2026, 2:48:57 PM
    Author     : dm
--%>
<%
  Boolean isAuthenticated = (Boolean) session.getAttribute("isAdminAuthenticated");
  if (isAuthenticated == null || !isAuthenticated) {
    response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
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
  <body class="bg-[#F5F7FA] min-h-screen text-[#2C2C2C]">

    <nav class="bg-[#27138B] border-b border-[#1e0e6b] sticky top-0 z-50 shadow-md">
      <div class="max-w-7xl mx-auto px-6 h-20 flex items-center justify-between">
        <div class="flex items-center gap-4">
          <div class="w-10 h-10 bg-white rounded-xl flex items-center justify-center shadow-lg transform -rotate-3">
            <span class="text-[#27138B] font-bold text-2xl">Q</span>
          </div>
          <div>
            <span class="text-white font-black tracking-tight uppercase text-lg block leading-none">Admin Portal</span>
            <span class="text-[#CDB0FF] text-[10px] font-bold uppercase tracking-[0.2em]">Banned User Management</span>
          </div>
        </div>

        <div class="flex items-center gap-6">
          <div class="flex flex-col items-end">
            <span class="text-[10px] font-bold text-[#CDB0FF] uppercase tracking-widest">Logged in as</span>
            <span class="text-white font-bold text-sm">${AdminUserName}</span>
          </div>
          <form method="POST" action="${pageContext.request.contextPath}/adminLogout">
            <button class="bg-white/10 hover:bg-red-500 text-white px-5 py-2.5 rounded-xl text-xs font-black transition-all border border-white/20 uppercase tracking-wider cursor-pointer">
              Logout
            </button>
          </form>
        </div>
      </div>
    </nav>

    <main class="max-w-7xl mx-auto px-6 py-10">

      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
        <div class="bg-white p-6 rounded-3xl border border-gray-200 shadow-sm flex items-center justify-between">
          <div>
            <p class="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1">Registered Users</p>
            <h3 class="text-3xl font-black text-[#27138B]">${dashboardData.getTotalUsers()}</h3>
          </div>
          <div class="w-12 h-12 bg-[#F5F7FA] rounded-2xl flex items-center justify-center text-[#27138B]">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
          </div>
        </div>

        <div class="bg-white p-6 rounded-3xl border border-gray-200 shadow-sm flex items-center justify-between">
          <div>
            <p class="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1">Active Posts</p>
            <h3 class="text-3xl font-black text-[#27138B]">${dashboardData.getTotalPosts()}</h3>
          </div>
          <div class="w-12 h-12 bg-[#F5F7FA] rounded-2xl flex items-center justify-center text-[#27138B]">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10l4 4v10a2 2 0 01-2 2zM7 8h5m-5 4h5m-5 4h10" />
            </svg>
          </div>
        </div>

        <div class="bg-white p-6 rounded-3xl border-2 border-red-100 shadow-sm flex items-center justify-between">
          <div>
            <p class="text-[10px] font-black text-red-400 uppercase tracking-widest mb-1">Currently Banned</p>
            <h3 class="text-3xl font-black text-red-600">${dashboardData.getTotalBannedUsers()}</h3>
          </div>
          <div class="w-12 h-12 bg-red-50 rounded-2xl flex items-center justify-center text-red-600">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728L5.636 5.636m12.728 12.728A9 9 0 115.636 5.636" />
            </svg>
          </div>
        </div>
      </div>

      <div class="bg-white rounded-3xl border border-gray-200 shadow-sm overflow-hidden text-sm">
        <div class="p-6 border-b border-gray-100 bg-gray-50/50 flex items-center justify-between">
          <div class="flex items-center gap-3">
            <div class="w-2 h-8 bg-red-500 rounded-full"></div>
            <h2 class="font-black text-[#27138B] uppercase tracking-tight">Restricted Accounts</h2>
          </div>

          <a href="${pageContext.request.contextPath}/adminDashboard" class="bg-[#27138B] hover:bg-[#1e0e6b] text-white px-6 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-widest transition-all shadow-md flex items-center gap-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
            Back to Dashboard
          </a>
        </div>

        <div class="overflow-x-auto">
          <table class="w-full text-left border-collapse">
            <thead>
              <tr class="bg-white">
                <th class="px-6 py-4 text-[10px] font-black text-gray-400 uppercase tracking-widest border-b border-gray-100">Banned User</th>
                <th class="px-6 py-4 text-[10px] font-black text-gray-400 uppercase tracking-widest border-b border-gray-100 text-center">Total Posts</th>
                <th class="px-6 py-4 text-[10px] font-black text-gray-400 uppercase tracking-widest border-b border-gray-100 text-center">Total Answers</th>
                <th class="px-6 py-4 text-[10px] font-black text-gray-400 uppercase tracking-widest border-b border-gray-100 text-right">Account Actions</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-50">
              <c:forEach var="user" items="${bannedUsers}">
                <tr class="hover:bg-red-50/30 transition-colors group">
                  <td class="px-6 py-5">
                    <div class="flex items-center gap-3">
                      <div class="relative">
                        <img src="${user.getProfilePicUrl()}" alt="Avatar" class="w-10 h-10 rounded-full border border-gray-100 grayscale">
                        <div class="absolute -bottom-1 -right-1 w-4 h-4 bg-red-500 rounded-full border-2 border-white flex items-center justify-center">
                          <div class="w-1.5 h-[2px] bg-white"></div>
                        </div>
                      </div>
                      <div>
                        <p class="font-bold text-sm text-[#27138B]">${user.getName()}</p>
                        <p class="text-[10px] text-gray-400 font-medium">${user.getEmail()}</p>
                      </div>
                    </div>
                  </td>
                  <td class="px-6 py-5 text-center">
                    <span class="inline-block px-3 py-1 bg-gray-100 rounded-full text-xs font-bold text-gray-400">${user.getQuestionCount()}</span>
                  </td>
                  <td class="px-6 py-5 text-center">
                    <span class="inline-block px-3 py-1 bg-gray-100 rounded-full text-xs font-bold text-gray-400">${user.getAnswerCount()}</span>
                  </td>
                  <td class="px-6 py-5">
                    <div class="flex justify-end gap-3">
                      <button onclick="UnbanConfirmation('${user.getId()}')" class="bg-emerald-50 hover:bg-emerald-600 text-emerald-600 hover:text-white border border-emerald-100 px-4 py-2 rounded-xl text-[10px] font-black uppercase tracking-widest transition-all cursor-pointer">
                        Restore User
                      </button>
                      <button onclick="DeleteConfirmation('${user.getId()}')" class="bg-red-50 hover:bg-red-600 text-red-600 hover:text-white border border-red-100 px-4 py-2 rounded-xl text-[10px] font-black uppercase tracking-widest transition-all cursor-pointer">
                        Delete Permanent
                      </button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <div class="p-6 bg-gray-50/50 border-t border-gray-100">
          <p class="text-xs font-bold text-gray-400 uppercase tracking-widest">End of restricted list • Total ${dashboardData.getTotalBannedUsers()} Banned</p>
        </div>
      </div>
    </main>
    <script>
      function UnbanConfirmation(userId) {
        Swal.fire({
          title: 'Are you sure?',
          text: "This user will be unbanned and will be able to access their account.",
          icon: 'warning',
          buttonsStyling: false,
          confirmButtonText: "Yes",
          cancelButtonText: "No",
          allowOutsideClick: false,
          allowEscapeKey: false,
          allowEnterKey: false,
          showCloseButton: false,
          showCancelButton: true,
          customClass: {
            confirmButton: "w-32 mr-4 cursor-pointer py-3 rounded-lg transition-colors shadow-md bg-[#27138B] hover:bg-[#1e0e6b] text-white font-semibold",
            cancelButton: "w-32 ml-4 cursor-pointer py-3 rounded-lg transition-colors shadow-md bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold"
          }
        }).then((result) => {
          if (result.isConfirmed) {
            window.location.href = '${pageContext.request.contextPath}/unbanUser/' + userId;
          }
        });
      }

      function DeleteConfirmation(userId) {
        Swal.fire({
          title: 'Are you sure?',
          text: "This user will be deleted and all their data will be permanently removed.",
          icon: 'warning',
          buttonsStyling: false,
          confirmButtonText: "Yes",
          cancelButtonText: "No",
          allowOutsideClick: false,
          allowEscapeKey: false,
          allowEnterKey: false,
          showCloseButton: false,
          showCancelButton: true,
          customClass: {
            confirmButton: "w-32 mr-4 cursor-pointer py-3 rounded-lg transition-colors shadow-md bg-[#27138B] hover:bg-[#1e0e6b] text-white font-semibold",
            cancelButton: "w-32 ml-4 cursor-pointer py-3 rounded-lg transition-colors shadow-md bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold"
          }
        }).then((result) => {
          if (result.isConfirmed) {
            window.location.href = '${pageContext.request.contextPath}/deleteUser/' + userId;
          }
        });
      }

      function FailedBan() {
        Swal.fire({
          title: 'Failed to Ban User',
          text: "There was an error while banning the user. Please try again.",
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

      const status = "${sessionScope.status}";

      switch (status) {
        case "FAILED":
        {
          FailedBan();
          break;
        }
      }
    </script>
    <c:remove var="status" scope="session" />
  </body>
</html>
