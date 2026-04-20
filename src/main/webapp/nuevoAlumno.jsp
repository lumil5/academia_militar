<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Nuevo Cadete</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h3>Registro de Nuevo Cadete</h3>
            </div>
            <div class="card-body">
                <form action="AlumnoServlet" method="POST">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">DNI</label>
                            <input type="number" name="txtDni" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Nombre Completo</label>
                            <input type="text" name="txtNombre" class="form-control" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Género</label>
                            <select name="txtGenero" class="form-control">
                                <option value="MASCULINO">Masculino</option>
                                <option value="FEMENINO">Femenino</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Teléfono</label>
                            <input type="text" name="txtTelefono" class="form-control">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Edad</label>
                            <input type="number" name="txtEdad" class="form-control">
                        </div>
                    </div>
                    <div class="mt-4">
                        <button type="submit" class="btn btn-success">Guardar Cadete</button>
                        <a href="AlumnoServlet" class="btn btn-secondary">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>