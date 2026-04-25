<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Inicio</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-light">

<div class="container-fluid py-3">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
        <h2 class="h4 mb-0">Inicio</h2>
        <span class="text-muted small">Panel general del sistema</span>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="fa-solid fa-chart-line text-primary"></i>
                        <h6 class="mb-0 text-secondary">Promedio Académico</h6>
                    </div>
                    <h3 class="mb-0">8.5 <small class="text-muted fs-6">/ 10</small></h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="fa-solid fa-person-military-pointing text-success"></i>
                        <h6 class="mb-0 text-secondary">Asistencia Táctica</h6>
                    </div>
                    <h3 class="mb-0">98%</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="fa-solid fa-award text-warning"></i>
                        <h6 class="mb-0 text-secondary">Méritos Acumulados</h6>
                    </div>
                    <h3 class="mb-0">12</h3>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm border-0 mb-3">
        <div class="card-header bg-white">
            <strong>Próximos Entrenamientos</strong>
        </div>
        <div class="table-responsive">
            <table class="table table-striped table-hover mb-0 align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Fecha</th>
                        <th>Actividad</th>
                        <th>Instructor</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>09/04/2026</td>
                        <td>Práctica de Tiro con Fusil</td>
                        <td>Sgt. Mendoza</td>
                        <td><span class="badge text-bg-warning">Pendiente</span></td>
                    </tr>
                    <tr>
                        <td>12/04/2026</td>
                        <td>Entrenamiento de Resistencia Física</td>
                        <td>Tte. Rojas</td>
                        <td><span class="badge text-bg-primary">En Proceso</span></td>
                    </tr>
                    <tr>
                        <td>15/04/2026</td>
                        <td>Simulación de Campo Táctico</td>
                        <td>Cap. Herrera</td>
                        <td><span class="badge text-bg-success">Programado</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-header bg-white">
            <strong>Accesos Rápidos</strong>
        </div>
        <div class="card-body">
            <div class="d-flex flex-wrap gap-2">
                <a href="${ctx}/AlumnoServlet" class="btn btn-outline-primary btn-sm"><i class="fa-solid fa-user-graduate me-1"></i>Alumnos</a>
                <a href="${ctx}/DocenteServlet" class="btn btn-outline-warning btn-sm"><i class="fa-solid fa-chalkboard-user me-1"></i>Docentes</a>
                <a href="${ctx}/MatriculaServlet" class="btn btn-outline-success btn-sm"><i class="fa-solid fa-clipboard-list me-1"></i>Matrícula</a>
                <a href="${ctx}/ConsultaServlet" class="btn btn-outline-dark btn-sm"><i class="fa-solid fa-magnifying-glass me-1"></i>Consultas</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
