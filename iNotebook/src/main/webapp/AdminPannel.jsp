<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" type="text/css" href="css/AdminPannelcss.css">
         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
     
    <title>iNotebook Admin Panel</title>
   
</head>
<body>
    <div class="container" style="max-width: 1609px;">
    
        <!-- Sidebar -->
        <nav class="sidebar">
            <h2>iNotebook Admin</h2>
            <ul>
                <li><a href="#dashboard">Dashboard</a></li>
                <li><a href="#users">User Management</a></li>
                <li><a href="#tasks">Task Management</a></li>
                <li><a href="#notes">Notes Management</a></li>
               
                
            </ul>
        </nav>
        
        <!-- Main Content -->
        <div class="main-content">
            <header>
                <h1>Admin Dashboard</h1>
                
                
            </header>

            <!-- Dashboard Overview -->
            <section id="dashboard" class="dashboard-cards">
                <div class="card">Total Users: 1</div>
                <div class="card">Total Notes: 3</div>
                <div class="card">Total Tasks: 10</div>
                <div class="card">Total Notebooks: 5</div>
            </section>

        <!-- User Management -->
<section id="users">
    <h2>User Management</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Map<String, String>> users = (List<Map<String, String>>) request.getAttribute("users");
                if (users != null) {
                    for (Map<String, String> user : users) {
                        String name = user.get("name");
                        String email = user.get("email");
            %>
            <tr>
                <td><%= name %></td>
                <td><%= email %></td>
                <td>
                    <form action="DeleteUserServlet" method="post" style="display:inline;">
                        <input type="hidden" name="email" value="<%= email %>">
                        <button class="btn btn-danger">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</section>

<!-- Task Management -->
<section id="tasks">
    <h2>Task Management</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Task Name</th>
                <th>Creation Time</th>
                <th>Timer (Due Date)</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Map<String, String>> tasks = (List<Map<String, String>>) request.getAttribute("tasks");
                if (tasks != null) {
                    for (Map<String, String> task : tasks) {
            %>
            <tr>
                <td><%= task.get("task_name") %></td>
                <td><%= task.get("created_at") %></td>
                <td><%= task.get("due_date") %></td>
                <td>
                    <form action="DeleteTaskServlet" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= task.get("id") %>">
                        <button class="btn btn-danger">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</section>



<!-- Notes Management -->
<section id="notes">
    <h2>Notes Management</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Title</th>
                <th>Content</th>
                <th>File Path</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Map<String, String>> notes = (List<Map<String, String>>) request.getAttribute("notes");
                if (notes != null) {
                    for (Map<String, String> note : notes) {
            %>
            <tr>
                <td><%= note.get("title") %></td>
                <td><%= note.get("content") %></td>
                <td>
                    <% if (note.get("file_path") != null) { %>
                        <a href="DownloadNoteFileServlet?noteId=<%= note.get("id") %>">Download</a>
                    <% } else { %>
                        N/A
                    <% } %>
                </td>
                <td><%= note.get("created_at") %></td>
                <td>
                    <form action="DeleteNoteServlet" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= note.get("id") %>">
                       <button class="btn btn-danger">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</section>


<!-- Notebook Management -->
<section id="notebooks">
    <h2>Notebook Management</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Name</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Map<String, String>> notebooks = (List<Map<String, String>>) request.getAttribute("notebooks");
                if (notebooks != null) {
                    for (Map<String, String> notebook : notebooks) {
            %>
            <tr>
                <td><%= notebook.get("name") %></td>
                <td><%= notebook.get("created_at") %></td>
                <td>
                    <form action="DeleteNotebookServlet" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= notebook.get("id") %>">
                       <button class="btn btn-danger">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</section>
        </div>
    </div>
</body>
</html>
