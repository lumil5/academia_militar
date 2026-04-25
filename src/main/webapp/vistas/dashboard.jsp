<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session.getAttribute("usuario") == null) {
	response.sendRedirect("../login.jsp");
	return;
}
String userLogueado = (String) session.getAttribute("usuario");
String rolLogueado = (String) session.getAttribute("rol");
if (rolLogueado == null)
	rolLogueado = "SIN ROL";
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Panel de Control | Academia</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root {
	--azul: #1f2c8c;
	--azul-oscuro: #16206a;
	--verde: #198754;
	--dorado: #ffc107;
	--gris-bg: #f4f6fb;
	--texto: #1f2937;
	--blanco: #ffffff;
	--sombra: 0 8px 22px rgba(0,0,0,0.08);
	--radio: 16px;
}

* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background:
		linear-gradient(rgba(255,255,255,0.55), rgba(255,255,255,0.55)),
		url("../img/militar1.jpg");
	background-size: cover;
	background-position: center;
	background-attachment: fixed;
	color: var(--texto);
}

.layout {
	display: flex;
	min-height: 100vh;
}

/* SIDEBAR */
.sidebar {
	width: 250px;
	background: linear-gradient(180deg, var(--azul), var(--azul-oscuro));
	color: white;
	padding: 20px 14px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	box-shadow: var(--sombra);
}

.brand {
	font-size: 21px;
	font-weight: 800;
	text-align: center;
	margin-bottom: 18px;
	letter-spacing: 1px;
}

.profile-box {
	background: rgba(255,255,255,0.08);
	border: 1px solid rgba(255,255,255,0.10);
	border-radius: 18px;
	padding: 18px 12px;
	text-align: center;
	margin-bottom: 18px;
}

.profile-box i {
	font-size: 46px;
	margin-bottom: 10px;
	color: #fff;
}

.profile-box h5 {
	margin: 0;
	font-weight: 700;
	font-size: 16px;
}

.profile-box p {
	margin: 6px 0 8px;
	font-size: 16px;
	font-weight: 500;
}

.role-badge {
	display: inline-block;
	background: var(--dorado);
	color: #111;
	font-weight: 700;
	font-size: 12px;
	padding: 5px 11px;
	border-radius: 30px;
}

.menu {
	list-style: none;
	padding: 0;
	margin: 0;
}

.menu li {
	margin-bottom: 6px;
}

.menu a {
	display: flex;
	align-items: center;
	gap: 11px;
	text-decoration: none;
	color: white;
	padding: 11px 13px;
	border-radius: 12px;
	transition: 0.25s ease;
	font-weight: 500;
	font-size: 15px;
}

.menu a:hover, .menu a.active {
	background: rgba(255,255,255,0.12);
	transform: translateX(4px);
}

.menu i {
	width: 18px;
	text-align: center;
	font-size: 15px;
}

.logout a {
	color: var(--dorado);
	font-weight: 700;
}

/* MAIN */
.main-content {
	flex: 1;
	padding: 18px;
}

.topbar {
	background: rgba(255,255,255,0.88);
	backdrop-filter: blur(3px);
	border-radius: var(--radio);
	padding: 14px 18px;
	box-shadow: var(--sombra);
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 18px;
	flex-wrap: wrap;
	gap: 10px;
}

.topbar h1 {
	margin: 0;
	font-size: 28px;
	font-weight: 800;
	color: #111827;
}

.topbar .date-box {
	color: #6b7280;
	font-weight: 500;
	font-size: 14px;
}

/* STATS */
.stats-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 16px;
	margin-bottom: 18px;
}

.stat-card {
	background: rgba(255,255,255,0.9);
	backdrop-filter: blur(2px);
	border-radius: var(--radio);
	padding: 16px 18px;
	box-shadow: var(--sombra);
	position: relative;
	overflow: hidden;
	min-height: 115px;
}

.stat-card::before {
	content: "";
	position: absolute;
	left: 0;
	top: 0;
	width: 5px;
	height: 100%;
	background: var(--verde);
}

.stat-card .icon {
	font-size: 22px;
	color: var(--azul);
	margin-bottom: 8px;
}

.stat-card h6 {
	margin: 0;
	font-size: 14px;
	color: #6b7280;
	font-weight: 600;
}

.stat-card h2 {
	margin: 8px 0 0;
	font-size: 28px;
	font-weight: 800;
	color: #111827;
}

/* CONTENT CARDS */
.content-card {
	background: rgba(255,255,255,0.88);
	backdrop-filter: blur(3px);
	border-radius: var(--radio);
	box-shadow: var(--sombra);
	padding: 18px;
	margin-bottom: 18px;
}

.section-title {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 14px;
	flex-wrap: wrap;
	gap: 8px;
}

.section-title h3 {
	margin: 0;
	font-size: 18px;
	font-weight: 800;
}

.section-title span {
	color: #6b7280;
	font-size: 13px;
}

/* TABLE */
.table-modern {
	margin: 0;
	overflow: hidden;
	border-radius: 12px;
}

.table-modern thead th {
	background: #111827;
	color: white;
	border: none;
	padding: 10px 12px;
	font-weight: 700;
	font-size: 14px;
}

.table-modern tbody td {
	padding: 10px 12px;
	vertical-align: middle;
	border-color: #e5e7eb;
	font-size: 14px;
}

.table-modern tbody tr:hover {
	background: rgba(249,250,251,0.9);
}

.badge-status {
	padding: 7px 12px;
	border-radius: 30px;
	font-size: 11px;
	font-weight: 700;
	display: inline-block;
}

.badge-pendiente {
	background: #fff3cd;
	color: #856404;
}

.badge-completado {
	background: #d1e7dd;
	color: #0f5132;
}

.badge-proceso {
	background: #cfe2ff;
	color: #084298;
}

/* EXTRA BOXES */
.quick-actions {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 16px;
}

.action-card {
	background: rgba(255,255,255,0.9);
	backdrop-filter: blur(2px);
	border-radius: var(--radio);
	padding: 18px 16px;
	box-shadow: var(--sombra);
	text-align: center;
	transition: 0.25s ease;
}

.action-card:hover {
	transform: translateY(-4px);
}

.action-card i {
	font-size: 28px;
	color: var(--azul);
	margin-bottom: 8px;
}

.action-card h5 {
	font-weight: 700;
	margin-bottom: 6px;
	font-size: 16px;
}

.action-card p {
	font-size: 13px;
	color: #6b7280;
	margin-bottom: 12px;
}

/* RESPONSIVE */
@media (max-width: 1100px) {
	.stats-grid,
	.quick-actions {
		grid-template-columns: 1fr;
	}
}

@media (max-width: 900px) {
	.layout {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
	}
	.main-content {
		padding: 14px;
	}
	.topbar h1 {
		font-size: 24px;
	}
}
</style>
</head>
<body>

	<div class="layout">

		<aside class="sidebar">
			<div>
				<div class="brand">COMANDO LINCE</div>

				<div class="profile-box">
					<i class="fa-solid fa-user-shield"></i>
					<h5>Bienvenido</h5>
					<p><%=userLogueado%></p>
					<span class="role-badge"><%=rolLogueado%></span>
				</div>

				<ul class="menu">
					<li><a href="inicioDashboard.jsp" target="framePrincipal" class="active"><i class="fa-solid fa-house"></i> Inicio</a></li>
					<li><a href="../AlumnoServlet" target="framePrincipal"><i class="fa-solid fa-user-graduate"></i> Mantenimiento Alumnos</a></li>
					<li><a href="../DocenteServlet" target="framePrincipal"><i class="fa-solid fa-chalkboard-user"></i> Mantenimiento Docentes</a></li>
					<li><a href="../CursoServlet" target="framePrincipal"><i class="fa-solid fa-book"></i> Mantenimiento Cursos</a></li>
					<li><a href="../MatriculaServlet" target="framePrincipal"><i class="fa-solid fa-clipboard-list"></i> Matrícula</a></li>
					<li><a href="../RetiroServlet" target="framePrincipal"><i class="fa-solid fa-person-walking-arrow-right"></i> Retiro de Curso</a></li>
					<li><a href="../ConsultaServlet" target="framePrincipal"><i class="fa-solid fa-magnifying-glass"></i> Consultas</a></li>
				</ul>
			</div>

			<div class="logout">
				<ul class="menu">
					<li><a href="<%=request.getContextPath()%>/LogoutServlet" class="btn btn-warning">  Salir </a></li>
				</ul>
			</div>
		</aside>

		<main class="main-content">

			<div class="content-card p-2">
				<iframe
					class="w-100 border rounded bg-white"
					name="framePrincipal"
					title="Contenido principal"
					src="inicioDashboard.jsp"
					height="900">
				</iframe>
			</div>

		</main>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>