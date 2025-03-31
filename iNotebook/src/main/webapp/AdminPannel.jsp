<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" type="text/css" href="css/AdminPannelcss.css">
    <title>iNotebook Admin Panel</title>
   
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <nav class="sidebar">
            <h2>iNotebook Admin</h2>
            <ul>
                <li><a href="#dashboard">Dashboard</a></li>
                <li><a href="#users">User Management</a></li>
                <li><a href="#tasks">Task Management</a></li>
                <li><a href="#notes">Notes Management</a></li>
                <li><a href="#">Reports</a></li>
                <li><a href="#">Logout</a></li>
            </ul>
        </nav>
        
        <!-- Main Content -->
        <div class="main-content">
            <header>
                <h1>Admin Dashboard</h1>
                <input type="text" placeholder="Search...">
                <img src="admin-profile.jpg" alt="Admin">
            </header>

            <!-- Dashboard Overview -->
            <section id="dashboard" class="dashboard-cards">
                <div class="card">Total Users: 150</div>
                <div class="card">Total Notes: 300</div>
                <div class="card">Total Tasks: 120</div>
            </section>

            <!-- User Management -->
            <section id="users">
                <h2>User Management</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>John Doe</td>
                            <td>john@example.com</td>
                            <td>
                                <button class="edit-btn">Edit</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Jane Smith</td>
                            <td>jane@example.com</td>
                            <td>
                                <button class="edit-btn">Edit</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Mike Johnson</td>
                            <td>mike@example.com</td>
                            <td>
                                <button class="edit-btn">Edit</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Emily Davis</td>
                            <td>emily@example.com</td>
                            <td>
                                <button class="edit-btn">Edit</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Chris Brown</td>
                            <td>chris@example.com</td>
                            <td>
                                <button class="edit-btn">Edit</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Chris Brown</td>
                            <td>chris@example.com</td>
                            <td>
                                <button class="edit-btn">Edit</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Chris Brown</td>
                            <td>chris@example.com</td>
                            <td>
                                <button class="edit-btn">Edit</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Chris Brown</td>
                            <td>chris@example.com</td>
                            <td>
                                <button class="edit-btn">Edit</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Chris Brown</td>
                            <td>chris@example.com</td>
                            <td>
                                <button class="edit-btn">Edit</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                             <tr>
                            <td>Chris Brown</td>
                            <td>chris@example.com</td>
                            <td>
                                <button class="edit-btn">Edit</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </section>

         <!-- Task Management -->
<section id="tasks">
    <h2>Task Management</h2>
    <table>
        <thead>
            <tr>
                <th>Creation Time</th>
                <th>Task Name</th>
                <th>Timer</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>2025-02-01 10:00 AM</td>
                <td>Finish React Project</td>
                <td>02:30:00</td>
                <td><span class="status not-completed">Not Completed</span></td>
                <td>
                    <button class="edit-btn">Edit</button>
                    <button class="delete-btn">Delete</button>
                </td>
            </tr>
            <tr>
                <td>2025-02-02 11:00 AM</td>
                <td>Meeting with Team</td>
                <td>01:00:00</td>
                <td><span class="status completed">Completed</span></td>
                <td>
                    <button class="edit-btn">Edit</button>
                    <button class="delete-btn">Delete</button>
                </td>
            </tr>
            <tr>
                <td>2025-02-03 09:30 AM</td>
                <td>Write Documentation</td>
                <td>03:45:00</td>
                <td><span class="status not-completed">Not Completed</span></td>
                <td>
                    <button class="edit-btn">Edit</button>
                    <button class="delete-btn">Delete</button>
                </td>
            </tr>
            <tr>
                <td>2025-02-04 02:00 PM</td>
                <td>Code Review</td>
                <td>02:15:00</td>
                <td><span class="status completed">Completed</span></td>
                <td>
                    <button class="edit-btn">Edit</button>
                    <button class="delete-btn">Delete</button>
                </td>
            </tr>
            <tr>
                <td>2025-02-05 08:00 AM</td>
                <td>Update Server</td>
                <td>01:30:00</td>
                <td><span class="status not-completed">Not Completed</span></td>
                <td>
                    <button class="edit-btn">Edit</button>
                    <button class="delete-btn">Delete</button>
                </td>
            </tr>
        </tbody>
    </table>
</section>

           <!-- Notes Management -->
<section id="notes">
    <h2>Notes Management</h2>
    <table>
        <thead>
            <tr>
                <th>Note Name</th>
                <th>Description</th>
                <th>Files/Images</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Project Ideas</td>
                <td>List of project ideas for 2025.</td>
                <td>
                    <img src="image1.jpg" alt="Image 1" class="note-img">
                    <a href="document1.pdf" class="note-file" download>document1.pdf</a>
                </td>
                <td>
                    <button class="edit-btn">Edit</button>
                    <button class="delete-btn">Delete</button>
                </td>
            </tr>
            <tr>
                <td>Meeting Notes</td>
                <td>Notes from the team meeting.</td>
                <td>
                    <img src="image2.jpg" alt="Image 2" class="note-img">
                    <a href="presentation.pptx" class="note-file" download>presentation.pptx</a>
                </td>
                <td>
                    <button class="edit-btn">Edit</button>
                    <button class="delete-btn">Delete</button>
                </td>
            </tr>
            <tr>
                <td>Learning Resources</td>
                <td>Links and resources for React learning.</td>
                <td>
                    <img src="image3.jpg" alt="Image 3" class="note-img">
                    <a href="ebook.pdf" class="note-file" download>ebook.pdf</a>
                </td>
                <td>
                    <button class="edit-btn">Edit</button>
                    <button class="delete-btn">Delete</button>
                </td>
            </tr>
            <tr>
                <td>Personal Notes</td>
                <td>My personal thoughts and reflections.</td>
                <td>
                    <img src="image4.jpg" alt="Image 4" class="note-img">
                </td>
                <td>
                    <button class="edit-btn">Edit</button>
                    <button class="delete-btn">Delete</button>
                </td>
            </tr>
            <tr>
                <td>Weekly Tasks</td>
                <td>Checklist for weekly tasks.</td>
                <td>
                    <a href="tasks.xlsx" class="note-file" download>tasks.xlsx</a>
                </td>
                <td>
                    <button class="edit-btn">Edit</button>
                    <button class="delete-btn">Delete</button>
                </td>
            </tr>
        </tbody>
    </table>
</section>

        </div>
    </div>
</body>
</html>
