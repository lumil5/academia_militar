<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Acceso Militar | Intranet</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #121212;
	display: flex;
	align-items: center;
	height: 100vh;
}
.login-card {
	background: white;
	border-radius: 0;
	border-left: 5px solid #1a237e;
}
.btn-militar {
	background: #1a237e;
	color: white;
	border-radius: 0;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-4">
				<div class="card login-card p-4 shadow-lg">
					<div class="text-center mb-4">
						<h3 class="fw-bold">INTRANET MILITAR</h3>
						<p class="text-muted small">Ingrese sus credenciales</p>
					</div>

					<form action="LoginServlet" method="post">
						<div class="mb-3">
							<label class="form-label">Usuario</label>
							<input type="text" name="txtUsuario" class="form-control" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Contraseña</label>
							<input type="password" name="txtPassword" class="form-control" required>
						</div>

						<button type="submit" class="btn btn-militar w-100">
							AUTENTICAR
						</button>
					</form>

					<%
					if (request.getAttribute("mensaje") != null) {
					%>
					<div class="alert alert-danger mt-3">
						<%=request.getAttribute("mensaje")%>
					</div>
					<%
					}
					%>

					<div class="mt-3 text-center">
						<a href="index.jsp" class="text-decoration-none small">
							Volver al Portal Público
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>