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
<title>Mantenimiento de Cursos</title>

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
	--amarillo: #ffc107;
	--rojo: #dc3545;
	--gris: #6c757d;
	--texto: #1f2937;
	--sombra: 0 10px 28px rgba(0,0,0,0.08);
	--radio: 20px;
}

body {
	margin: 0;
	font-family: 'Segoe UI', sans-serif;
	background: url("img/militar4.jpg") no-repeat center center;
	background-size: cover;
	background-attachment: fixed;
	position: relative;
}

body::before {
	content: "";
	position: fixed;
	inset: 0;
	background: rgba(255,255,255,0.30);
	z-index: -1;
}

.page-wrap {
	max-width: 100%;
	margin: 0;
	padding: 16px;
}

.main-card {
	background: rgba(255,255,255,0.94);
	border-radius: 24px;
	box-shadow: var(--sombra);
	overflow: hidden;
}

.card-header-custom {
	background: linear-gradient(135deg, #1ca3ba, #178da2);
	color: white;
	padding: 22px 28px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 14px;
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
	font-size: 30px;
	font-weight: 800;
}

.header-title p {
	margin: 4px 0 0;
	font-size: 14px;
	opacity: .95;
}

.card-body-custom {
	padding: 24px 28px;
}

.form-panel {
	background: rgba(255,255,255,0.96);
	border: 1px solid #dbe4ee;
	border-radius: 18px;
	padding: 22px;
	margin-bottom: 24px;
}

.form-label {
	font-weight: 700;
	color: #334155;
	margin-bottom: 6px;
}

.form-control, .form-select {
	border-radius: 12px;
	padding: 10px 14px;
	border: 1px solid #d1d5db;
}

.form-control:focus, .form-select:focus {
	border-color: #178da2;
	box-shadow: 0 0 0 0.2rem rgba(23,141,162,0.15);
}

.btn-block-custom {
	width: 100%;
	border: none;
	border-radius: 12px;
	padding: 12px;
	font-weight: 700;
	color: white;
	margin-bottom: 10px;
	transition: .2s ease;
}

.btn-block-custom:hover {
	transform: translateY(-1px);
	color: white;
}

.btn-add { background: var(--verde); }
.btn-add:hover { background: #157347; }

.btn-edit { background: var(--amarillo); color: #212529; }
.btn-edit:hover { background: #e0a800; color: #212529; }

.btn-delete { background: var(--rojo); }
.btn-delete:hover { background: #bb2d3b; }

.btn-clear { background: var(--gris); }
.btn-clear:hover { background: #5c636a; }

.table-wrap {
	border-radius: 18px;
	overflow: hidden;
	border: 1px solid #dbe4ee;
	background: white;
}

.table-modern {
	margin: 0;
}

.table-modern thead th {
	background: #111827;
	color: white;
	border: none;
	padding: 14px 12px;
	font-size: 14px;
	font-weight: 700;
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

.table-modern tbody tr.selected-row {
	background: #e0f2fe !important;
}

.badge-ciclo {
	background: #e0f2fe;
	color: #075985;
	padding: 6px 12px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 700;
	display: inline-block;
}

.badge-number {
	background: #eef2f7;
	color: #374151;
	padding: 6px 10px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 700;
	display: inline-block;
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

.note-text {
	font-size: 13px;
	color: #6b7280;
}

@media (max-width: 768px) {
	.card-header-custom,
	.footer-actions {
		flex-direction: column;
		align-items: stretch;
	}

	.header-title h1 {
		font-size: 24px;
	}
}
</style>
</head>
<body>

	<div class="page-wrap">
		<div class="main-card">

			<div class="card-header-custom">
				<div class="header-title">
					<i class="fa-solid fa-book-open-reader"></i>
					<div>
						<h1>Gestión de Cursos</h1>
						<p>Administra el catálogo académico del sistema</p>
					</div>
				</div>
			</div>

			<div class="card-body-custom">

				<c:if test="${not empty mensaje}">
					<div class="alert alert-warning">${mensaje}</div>
				</c:if>

				<div class="form-panel">
					<form action="${ctx}/CursoServlet" method="post" id="formCurso">
						<input type="hidden" name="txtIdCurso" id="txtIdCurso">

						<div class="row g-3">
							<div class="col-md-8">
								<div class="row g-3">
									<div class="col-md-6">
										<label class="form-label">Código</label>
										<input type="text" name="txtCodigo" id="txtCodigo" class="form-control">
									</div>

									<div class="col-md-6">
										<label class="form-label">Nombre</label>
										<input type="text" name="txtNombre" id="txtNombre" class="form-control">
									</div>

									<div class="col-md-4">
										<label class="form-label">Ciclo</label>
										<select name="txtCiclo" id="txtCiclo" class="form-select">
											<option value="Primero">Primero</option>
											<option value="Segundo">Segundo</option>
											<option value="Tercero">Tercero</option>
											<option value="Cuarto">Cuarto</option>
											<option value="Quinto">Quinto</option>
											<option value="Sexto">Sexto</option>
										</select>
									</div>

									<div class="col-md-4">
										<label class="form-label">Créditos</label>
										<input type="number" name="txtCreditos" id="txtCreditos" class="form-control">
									</div>

									<div class="col-md-4">
										<label class="form-label">Horas</label>
										<input type="number" name="txtHoras" id="txtHoras" class="form-control">
									</div>
									<div class="col-md-4">
										<label class="form-label">ID Docente</label>
										<input type="number" name="txtIdDocente" id="txtIdDocente" class="form-control">
									</div>
									<div class="col-md-4">
										<label class="form-label">ID Salón</label>
										<input type="number" name="txtIdSalon" id="txtIdSalon" class="form-control">
									</div>
								</div>
							</div>

							<div class="col-md-4">
								<button type="submit" name="accion" value="adicionar" class="btn-block-custom btn-add">
									<i class="fa-solid fa-plus me-1"></i> Adicionar
								</button>

								<button type="submit" name="accion" value="modificar" class="btn-block-custom btn-edit">
									<i class="fa-solid fa-pen me-1"></i> Modificar
								</button>

								<button type="button" class="btn-block-custom btn-delete" id="btnAbrirModalEliminarCurso">
									<i class="fa-solid fa-trash me-1"></i> Eliminar
								</button>

								<button type="reset" class="btn-block-custom btn-clear" onclick="limpiarSeleccion();">
									<i class="fa-solid fa-broom me-1"></i> Limpiar
								</button>
							</div>
						</div>
					</form>
				</div>

				<div class="table-wrap">
					<div class="table-responsive">
						<table class="table table-modern align-middle">
							<thead>
								<tr>
									<th>ID</th>
									<th>Nombre</th>
									<th>Ciclo</th>
									<th>Créditos</th>
									<th>Horas</th>
									<th>ID Docente</th>
									<th>ID Salón</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty listaCursos}">
								<tr>
									<td colspan="7" class="text-center py-4 text-muted">
										No hay cursos registrados.
									</td>
								</tr>
								</c:if>
								<c:forEach var="c" items="${listaCursos}">
								<tr onclick="seleccionarCurso(this)" style="cursor:pointer;"
									data-id="${c.idCurso}"
									data-nombre="${fn:escapeXml(c.nombre)}"
									data-ciclo="${fn:escapeXml(c.ciclo)}"
									data-creditos="${c.creditos}"
									data-horas="${c.horas}"
									data-docente="${c.docente != null ? c.docente.idDocente : ''}"
									data-salon="${c.salon != null ? c.salon.idSalon : ''}">
									<td>${c.idCurso}</td>
									<td><c:out value="${c.nombre}" /></td>
									<td><span class="badge-ciclo"><c:out value="${c.ciclo}" /></span></td>
									<td><span class="badge-number">${c.creditos}</span></td>
									<td><span class="badge-number">${c.horas}</span></td>
									<td><span class="badge-number">${c.docente != null ? c.docente.idDocente : ''}</span></td>
									<td><span class="badge-number">${c.salon != null ? c.salon.idSalon : ''}</span></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<div class="footer-actions">
					<a href="${ctx}/vistas/inicioDashboard.jsp" class="btn-volver">
						<i class="fa-solid fa-arrow-left"></i>
						Volver al Panel
					</a>

					<div class="note-text">
						Primero selecciona una fila para modificar o eliminar.
					</div>
				</div>

			</div>
		</div>
	</div>

	<div class="modal fade" id="modalEliminarCurso" tabindex="-1" aria-labelledby="modalEliminarCursoLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border-0 shadow">
				<div class="modal-header bg-danger text-white">
					<h5 class="modal-title" id="modalEliminarCursoLabel">
						<i class="fa-solid fa-triangle-exclamation me-2"></i>Confirmar eliminación
					</h5>
					<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
				</div>
				<div class="modal-body">
					<p class="mb-2">Esta acción eliminará el curso seleccionado.</p>
					<div class="alert alert-danger d-flex align-items-center py-2 mb-2" role="alert">
						<i class="fa-solid fa-circle-exclamation me-2"></i>
						<small class="mb-0">Esta acción no se puede deshacer.</small>
					</div>
					<p class="mb-2"><strong>Curso:</strong> <span id="nombreCursoEliminar">-</span></p>
					<label for="confirmacionEliminarCurso" class="form-label small mb-1">
						Escribe <strong>ELIMINAR</strong> para confirmar:
					</label>
					<input type="text"
						   class="form-control"
						   id="confirmacionEliminarCurso"
						   autocomplete="off"
						   placeholder="ELIMINAR">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
					<form action="${ctx}/CursoServlet" method="post" class="d-inline">
						<input type="hidden" name="accion" value="eliminar">
						<input type="hidden" name="txtIdCurso" id="idCursoEliminar">
						<button type="submit" class="btn btn-danger" id="btnConfirmarEliminarCurso" disabled>
							<i class="fa-solid fa-trash me-1"></i>Eliminar
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		function seleccionarCurso(row) {
			document.getElementById("txtIdCurso").value = row.dataset.id || "";
			document.getElementById("txtNombre").value = row.dataset.nombre || "";
			document.getElementById("txtCiclo").value = row.dataset.ciclo || "Primero";
			document.getElementById("txtCreditos").value = row.dataset.creditos || "";
			document.getElementById("txtHoras").value = row.dataset.horas || "";
			document.getElementById("txtIdDocente").value = row.dataset.docente || "";
			document.getElementById("txtIdSalon").value = row.dataset.salon || "";

			document.querySelectorAll(".table-modern tbody tr").forEach(tr => tr.classList.remove("selected-row"));
			row.classList.add("selected-row");
		}

		function limpiarSeleccion() {
			document.getElementById("txtIdCurso").value = "";
			document.getElementById("txtIdDocente").value = "";
			document.getElementById("txtIdSalon").value = "";
			document.querySelectorAll(".table-modern tbody tr").forEach(tr => tr.classList.remove("selected-row"));
		}

		const modalEliminarCursoElement = document.getElementById("modalEliminarCurso");
		const btnAbrirModalEliminarCurso = document.getElementById("btnAbrirModalEliminarCurso");
		const idCursoEliminarInput = document.getElementById("idCursoEliminar");
		const nombreCursoEliminarSpan = document.getElementById("nombreCursoEliminar");
		const confirmacionEliminarCursoInput = document.getElementById("confirmacionEliminarCurso");
		const btnConfirmarEliminarCurso = document.getElementById("btnConfirmarEliminarCurso");

		if (modalEliminarCursoElement && btnAbrirModalEliminarCurso) {
			const modalEliminarCurso = new bootstrap.Modal(modalEliminarCursoElement);
			const actualizarEstadoBotonEliminarCurso = () => {
				const valor = (confirmacionEliminarCursoInput.value || "").trim().toUpperCase();
				btnConfirmarEliminarCurso.disabled = valor !== "ELIMINAR";
			};

			btnAbrirModalEliminarCurso.addEventListener("click", () => {
				const id = document.getElementById("txtIdCurso").value;
				const nombre = document.getElementById("txtNombre").value;
				if (!id) {
					alert("Primero selecciona un curso de la tabla.");
					return;
				}
				idCursoEliminarInput.value = id;
				nombreCursoEliminarSpan.textContent = nombre || "-";
				confirmacionEliminarCursoInput.value = "";
				btnConfirmarEliminarCurso.disabled = true;
				modalEliminarCurso.show();
				confirmacionEliminarCursoInput.focus();
			});

			confirmacionEliminarCursoInput.addEventListener("input", actualizarEstadoBotonEliminarCurso);
			modalEliminarCursoElement.addEventListener("hidden.bs.modal", () => {
				confirmacionEliminarCursoInput.value = "";
				btnConfirmarEliminarCurso.disabled = true;
			});
		}
	</script>

</body>
</html>