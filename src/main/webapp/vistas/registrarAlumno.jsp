<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registrar Cadete</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
	margin: 0;
	font-family: 'Segoe UI', sans-serif;
	background:
		linear-gradient(rgba(255,255,255,0.55), rgba(255,255,255,0.55)),
		url("../img/militar3.jpg");
	background-size: cover;
	background-position: center;
	background-attachment: fixed;
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 25px;
}

.card-form {
	width: 100%;
	max-width: 560px;
	background: rgba(255,255,255,0.95);
	border-radius: 22px;
	box-shadow: 0 12px 30px rgba(0,0,0,0.12);
	padding: 30px;
}

.header-box {
	text-align: center;
	margin-bottom: 24px;
}

.header-box i {
	font-size: 42px;
	color: #1f2c8c;
	margin-bottom: 10px;
}

.header-box h2 {
	margin: 0;
	font-size: 24px;
	font-weight: 800;
	color: #1f2937;
}

.header-box p {
	margin: 6px 0 0;
	color: #6b7280;
	font-size: 14px;
}

.form-label {
	font-weight: 700;
	color: #1f2937;
	margin-bottom: 6px;
}

.form-control, .form-select {
	border-radius: 12px;
	padding: 11px 14px;
	border: 1px solid #d1d5db;
}

.form-control:focus, .form-select:focus {
	border-color: #1f2c8c;
	box-shadow: 0 0 0 0.2rem rgba(31,44,140,0.15);
}

.btn-militar {
	background: #198754;
	color: white;
	font-weight: 700;
	border: none;
	border-radius: 12px;
	padding: 10px 22px;
}

.btn-militar:hover {
	background: #157347;
	color: white;
}

.btn-volver {
	background: #6b7280;
	color: white;
	font-weight: 700;
	border: none;
	border-radius: 12px;
	padding: 10px 22px;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.btn-volver:hover {
	background: #4b5563;
	color: white;
}

.actions {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 22px;
}

@media (max-width: 576px) {
	.card-form {
		padding: 22px;
	}

	.actions {
		flex-direction: column;
		gap: 12px;
	}

	.actions a,
	.actions button {
		width: 100%;
		justify-content: center;
	}
}
</style>
</head>
<body>

	<div class="card-form">

		<div class="header-box">
			<i class="fa-solid fa-user-plus"></i>
			<h2>Registrar Cadete</h2>
			<p>Complete los datos del nuevo alumno</p>
		</div>

		<form action="<%=request.getContextPath()%>/AlumnoServlet" method="post">
			<input type="hidden" name="accion" value="guardar">

			<div class="mb-3">
				<label class="form-label">DNI</label>
				<input type="text" name="txtDni" class="form-control" required>
			</div>

			<div class="mb-3">
				<label class="form-label">Nombres</label>
				<input type="text" name="txtNombres" class="form-control" required>
			</div>

			<div class="mb-3">
				<label class="form-label">Apellidos</label>
				<input type="text" name="txtApellidos" class="form-control" required>
			</div>

			<div class="mb-3">
				<label class="form-label">Edad</label>
				<input type="number" name="txtEdad" class="form-control" required>
			</div>

			<div class="mb-3">
				<label class="form-label">Celular</label>
				<input type="text" name="txtCelular" class="form-control">
			</div>

			<div class="mb-3">
				<label class="form-label">Estado</label>
				<select name="txtEstado" class="form-select">
					<option value="ACTIVO">ACTIVO</option>
					<option value="INACTIVO">INACTIVO</option>
				</select>
			</div>

			<div class="actions">
				<a href="<%=request.getContextPath()%>/AlumnoServlet" class="btn-volver">
					<i class="fa-solid fa-arrow-left"></i>
					Volver
				</a>

				<button type="submit" class="btn btn-militar">
					<i class="fa-solid fa-floppy-disk me-1"></i>
					Guardar
				</button>
			</div>
		</form>

	</div>

</body>
</html>