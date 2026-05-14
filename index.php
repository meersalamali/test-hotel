<?php
session_start();
$isLoggedIn = !empty($_SESSION['logged_in']);
?>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hotel Management System</title>
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@3.26.0/dist/tabler-icons.min.css">
<link rel="stylesheet" href="assets/style.css">
</head>
<body>

<!-- LOGIN SCREEN -->
<div id="login-screen" style="<?= $isLoggedIn ? 'display:none' : '' ?>">
  <div class="login-card">
    <div class="login-logo">
      <div class="login-logo-icon" id="login-logo-icon">🏨</div>
      <h1 id="login-hotel-name">Grand Luxe Hotel</h1>
      <p id="login-sub-text" data-i18n="login.sub">Management System — Admin Portal</p>
    </div>
    <div class="login-form">
      <div id="login-err" class="login-err" data-i18n="login.error">Invalid username or password.</div>
      <div class="form-group">
        <label data-i18n="login.username">Username</label>
        <input type="text" id="login-user" placeholder="admin" value="admin"/>
      </div>
      <div class="form-group">
        <label data-i18n="login.password">Password</label>
        <input type="password" id="login-pass" placeholder="••••••••" value="admin123"/>
      </div>
      <button class="btn btn-primary" style="width:100%;justify-content:center;padding:12px" onclick="doLogin()">
        <i class="ti ti-login"></i><span data-i18n="login.signIn"> Sign In</span>
      </button>
      <p style="text-align:center;color:var(--text3);font-size:11px;margin-top:12px" data-i18n="login.default">Default: admin / admin123</p>
    </div>
  </div>
</div>

<!-- MAIN APP -->
<div id="app" style="<?= $isLoggedIn ? '' : 'display:none' ?>">
  <!-- SIDEBAR -->
  <div id="sidebar">
    <div class="sidebar-logo">
      <div class="sidebar-logo-img" id="sb-logo">🏨</div>
      <div class="sidebar-name" id="sb-name">Grand Luxe Hotel</div>
      <div class="sidebar-sub" data-i18n="sidebar.sub">Management System</div>
    </div>
    <nav class="sidebar-nav">
      <div class="nav-section" data-i18n="nav.section.overview">Overview</div>
      <div class="nav-item active" onclick="showPage('dashboard',this)">
        <i class="ti ti-dashboard"></i><span data-i18n="nav.dashboard">Dashboard</span>
      </div>
      <div class="nav-section" data-i18n="nav.section.operations">Operations</div>
      <div class="nav-item" onclick="showPage('rooms',this)">
        <i class="ti ti-building"></i><span data-i18n="nav.rooms">Rooms</span>
      </div>
      <div class="nav-item" onclick="showPage('bookings',this)">
        <i class="ti ti-calendar-event"></i><span data-i18n="nav.bookings">Bookings</span>
      </div>
      <div class="nav-section" data-i18n="nav.section.finance">Finance</div>
      <div class="nav-item" onclick="showPage('income',this)">
        <i class="ti ti-trending-up"></i><span data-i18n="nav.income">Income</span>
      </div>
      <div class="nav-item" onclick="showPage('expenditure',this)">
        <i class="ti ti-trending-down"></i><span data-i18n="nav.expenditure">Expenditure</span>
      </div>
      <div class="nav-item" onclick="showPage('salary',this)">
        <i class="ti ti-wallet"></i><span data-i18n="nav.salary">Salary</span>
      </div>
      <div class="nav-section" data-i18n="nav.section.staff">Staff</div>
      <div class="nav-item" onclick="showPage('employees',this)">
        <i class="ti ti-users"></i><span data-i18n="nav.employees">Employees</span>
      </div>
      <div class="nav-section" data-i18n="nav.section.system">System</div>
      <div class="nav-item" onclick="showPage('settings',this)">
        <i class="ti ti-settings"></i><span data-i18n="nav.settings">Settings</span>
      </div>
    </nav>
    <div class="sidebar-footer">
      <div class="nav-item" style="color:rgba(255,255,255,.4)" onclick="doLogout()">
        <i class="ti ti-logout"></i><span data-i18n="nav.logout">Logout</span>
      </div>
    </div>
  </div>

  <div id="sidebar-backdrop" onclick="closeSidebar()"></div>

  <!-- MAIN CONTENT -->
  <div id="main">
    <div id="topbar">
      <div style="display:flex;align-items:center;gap:10px">
        <button class="hamburger-btn" id="hamburger-btn" onclick="toggleSidebar()">
          <i class="ti ti-menu-2"></i>
        </button>
        <div class="topbar-title" id="page-title">Dashboard</div>
      </div>
      <div class="topbar-right">
        <button class="topbar-btn" onclick="toggleDark()"><i class="ti ti-moon" id="dark-icon"></i></button>
        <span class="badge" data-i18n="topbar.role">Super Admin</span>
      </div>
    </div>
    <div id="content"></div>
  </div>
</div>

<!-- MODAL -->
<div class="overlay" id="modal-overlay" style="display:none" onclick="if(event.target===this)closeModal()">
  <div class="modal" id="modal-box">
    <div class="modal-head">
      <h3 id="modal-title">Modal</h3>
      <button class="btn btn-sm btn-outline" onclick="closeModal()"><i class="ti ti-x"></i></button>
    </div>
    <div class="modal-body" id="modal-body"></div>
  </div>
</div>

<script src="assets/dashboard.js"></script>
<script src="assets/app.js"></script>
</body>
</html>
