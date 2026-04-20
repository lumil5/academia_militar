<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gestión de Cadetes | Intranet</title>

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
	--rojo: #dc3545;
	--gris-bg: #f3f5f9;
	--texto: #1f2937;
	--blanco: #ffffff;
	--sombra: 0 10px 28px rgba(0,0,0,0.08);
	--radio: 18px;
}

body {
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

    background: url("img/militar2.jpg");
    background-size: cover;
    background-position: center;
    background-attachment: fixed;

    color: var(--texto);
}

.page-wrap {
	max-width: 1180px;
	margin: 40px auto;
	padding: 0 16px;
}

.main-card {
	background: rgba(255,255,255,0.92);
	backdrop-filter: blur(3px);
	border-radius: 22px;
	box-shadow: var(--sombra);
	overflow: hidden;
}

.card-header-custom {
	background: linear-gradient(135deg, var(--azul), var(--azul-oscuro));
	color: white;
	padding: 22px 26px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 15px;
}

.header-title {
	display: flex;
	align-items: center;
	gap: 14px;
}

.header-title i {
	font-size: 34px;
}

.header-title h1 {
	margin: 0;
	font-size: 28px;
	font-weight: 800;
}

.header-title p {
	margin: 3px 0 0;
	font-size: 14px;
	opacity: 0.92;
}

.btn-nuevo {
	background: #2f9e44;
	color: white;
	border: none;
	border-radius: 12px;
	padding: 12px 22px;
	font-weight: 700;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 10px;
	transition: 0.25s ease;
	box-shadow: 0 8px 20px rgba(47,158,68,0.25);
}

.btn-nuevo:hover {
	background: #27863a;
	color: white;
	transform: translateY(-2px);
}

.card-body-custom {
	padding: 24px 26px 18px;
}

.info-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 12px;
	margin-bottom: 18px;
}

.info-bar .result-count {
	font-weight: 700;
	color: #4b5563;
}

.search-box {
	max-width: 320px;
	width: 100%;
}

.search-box input {
	border-radius: 12px;
	padding: 10px 14px;
	border: 1px solid #d1d5db;
	box-shadow: none;
}

.table-wrap {
	border-radius: 16px;
	overflow: hidden;
	background: white;
	border: 1px solid #e5e7eb;
}

.table-modern {
	margin: 0;
}

.table-modern thead th {
	background: #0f172a;
	color: white;
	padding: 14px 12px;
	border: none;
	font-size: 14px;
	font-weight: 700;
	vertical-align: middle;
}

.table-modern tbody td {
	padding: 14px 12px;
	vertical-align: middle;
	border-color: #e5e7eb;
	font-size: 14px;
}

.table-modern tbody tr:hover {
	background: #f8fafc;
}

.dni-link {
	font-weight: 800;
	color: #2563eb;
	text-decoration: none;
}

.dni-link:hover {
	text-decoration: underline;
}

.badge-age {
	background: #eef2f7;
	color: #374151;
	padding: 6px 10px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 700;
	display: inline-block;
}

.badge-estado {
	padding: 6px 12px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 800;
	display: inline-block;
}

.estado-activo {
	background: #d1fae5;
	color: #065f46;
}

.estado-inactivo {
	background: #fee2e2;
	color: #991b1b;
}

.estado-default {
	background: #e5e7eb;
	color: #374151;
}

.empty-text {
	color: #9ca3af;
	font-style: italic;
}

.actions {
	display: flex;
	gap: 8px;
}

.btn-icon {
	width: 38px;
	height: 38px;
	border-radius: 10px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	text-decoration: none;
	font-size: 15px;
	font-weight: 700;
	transition: 0.2s ease;
}

.btn-edit {
	background: #fff7db;
	color: #b7791f;
	border: 1px solid #f6d365;
}

.btn-edit:hover {
	background: #ffe9a8;
	color: #8a5b12;
}

.btn-delete {
	background: #ffe2e5;
	color: #c62839;
	border: 1px solid #f5a3ad;
}

.btn-delete:hover {
	background: #ffcbd1;
	color: #a61b2a;
}

.footer-actions {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 12px;
	margin-top: 18px;
}

.btn-volver {
	background: #6b7280;
	color: white;
	border: none;
	border-radius: 12px;
	padding: 10px 18px;
	text-decoration: none;
	font-weight: 700;
	display: inline-flex;
	align-items: center;
	gap: 10px;
}

.btn-volver:hover {
	background: #4b5563;
	color: white;
}

.mini-note {
	font-size: 13px;
	color: #6b7280;
}

@media (max-width: 768px) {
	.card-header-custom,
	.info-bar,
	.footer-actions {
		flex-direction: column;
		align-items: stretch;
	}

	.header-title h1 {
		font-size: 22px;
	}

	.page-wrap {
		margin: 20px auto;
	}
}
</style>
</head>
<body>

	<div class="page-wrap">
		<div class="main-card">

			<div class="card-header-custom">
				<div class="header-title">
					<i class="fa-solid fa-user-graduate"></i>
					<div>
						<h1>Gestión de Cadetes</h1>
						<p>Listado oficial de alumnos registrados en el sistema</p>
					</div>
				</div>

				<a href="vistas/registrarAlumno.jsp" class="btn-nuevo">
					<i class="fa-solid fa-circle-plus"></i>
					Nuevo Registro
				</a>
			</div>

			<div class="card-body-custom">

				<div class="info-bar">
					<div class="result-count">
						<i class="fa-solid fa-list-ul me-1"></i>
						Total de registros: ${fn:length(listaAlumnos)}
					</div>

					<div class="search-box">
						<input type="text" class="form-control" placeholder="Buscar cadete...">
					</div>
				</div>

				<c:if test="${not empty mensaje}">
					<div class="alert alert-warning">${mensaje}</div>
				</c:if>

				<div class="table-wrap">
					<div class="table-responsive">
						<table class="table table-modern align-middle">
							<thead>
								<tr>
									<th>DNI</th>
									<th>Nombre</th>
									<th>Apellidos</th>
									<th>Celular</th>
									<th>Edad</th>
									<th>Estado</th>
									<th class="text-center">Acciones</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty listaAlumnos}">
								<tr>
									<td colspan="7" class="text-center py-4 empty-text">
										No hay cadetes registrados en este momento.
									</td>
								</tr>
								</c:if>
								<c:forEach var="a" items="${listaAlumnos}">
								<c:set var="estado" value="${empty a.estado ? 'Sin estado' : a.estado}" />
								<c:set var="estadoUpper" value="${fn:toUpperCase(estado)}" />
								<c:set var="claseEstado" value="${estadoUpper == 'ACTIVO' ? 'estado-activo' : (estadoUpper == 'INACTIVO' ? 'estado-inactivo' : 'estado-default')}" />
								<tr>
									<td>
										<a href="#" class="dni-link"><c:out value="${a.dni}" /></a>
									</td>
									<td><c:out value="${empty a.nombres ? '-' : a.nombres}" /></td>
									<td><c:out value="${empty a.apellidos ? '-' : a.apellidos}" /></td>
									<td><c:out value="${empty a.celular ? '-' : a.celular}" /></td>
									<td>
										<span class="badge-age">${a.edad} años</span>
									</td>
									<td>
										<span class="badge-estado ${claseEstado}">${estado}</span>
									</td>
									<td class="text-center">
										<div class="actions justify-content-center">
											<a href="${ctx}/AlumnoServlet?accion=editar&id=${a.idAlumno}" 
                                               class="btn btn-warning btn-sm">
                                                 <i class="fa fa-edit"></i>
                                               </a>
											<a href="${ctx}/AlumnoServlet?accion=eliminar&id=${a.idAlumno}"
											   class="btn-icon btn-delete"
											   title="Eliminar"
											   onclick="return confirm('¿Seguro que deseas eliminar este registro?')">
												<i class="fa-solid fa-trash"></i>
											</a>
										</div>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<div class="footer-actions">
					<a href="${ctx}/vistas/dashboard.jsp" class="btn-volver">
						<i class="fa-solid fa-arrow-left"></i>
						Volver al Panel
					</a>

					<div class="mini-note">
						Administra, consulta y actualiza la información de los cadetes.
					</div>
				</div>

			</div>
		</div>
	</div>

</body>
</html>