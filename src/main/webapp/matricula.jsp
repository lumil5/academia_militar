<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, org.logistica.bean.entity.Matricula"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registro de Matrículas</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
  body{
    background: url('img/militar3.jpg') no-repeat center center fixed;
    background-size: cover;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* capa oscura encima de la imagen */
body::before{
    content: "";
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5); /* oscuridad */
    z-index: -1;
}

    .main-container{
        max-width: 1150px;
        margin: 30px auto;
    }

    .titulo{
        background: linear-gradient(90deg, #17a2b8, #138496);
        color: white;
        padding: 18px;
        text-align: center;
        font-size: 30px;
        font-weight: bold;
        border-radius: 12px 12px 0 0;
        box-shadow: 0 4px 12px rgba(0,0,0,0.12);
    }

    .box{
    border: 2px solid #17a2b8;
    padding: 25px;
    margin-bottom: 18px;
    background: rgba(255,255,255,0.95); /* semi transparente */
    backdrop-filter: blur(5px);
    box-shadow: 0 4px 14px rgba(0,0,0,0.3);
}

    .box:first-of-type{
        border-radius: 0 0 12px 12px;
    }

    .form-label-custom{
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 8px;
    }

    .form-control{
        border-radius: 10px;
        height: 45px;
        border: 1px solid #ced4da;
        box-shadow: none !important;
    }

    .form-control:focus{
        border-color: #17a2b8;
        box-shadow: 0 0 0 0.15rem rgba(23,162,184,.20) !important;
    }

    .btn-sys{
        width: 100%;
        font-weight: bold;
        padding: 12px;
        border-radius: 10px;
        border: none;
        transition: 0.3s ease;
    }

    .btn-sys:hover{
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    }

    .btn-info-custom{
        background: linear-gradient(90deg, #20c997, #17a2b8);
        color: white;
    }

    .btn-warning-custom{
        background: linear-gradient(90deg, #ffc107, #ffb300);
        color: #212529;
    }

    .btn-danger-custom{
        background: linear-gradient(90deg, #dc3545, #c82333);
        color: white;
    }

    .btn-secondary-custom{
        background: linear-gradient(90deg, #6c757d, #5a6268);
        color: white;
    }

    .btn-search{
        height: 45px;
        border-radius: 10px;
        font-weight: bold;
    }

    .table-container{
        overflow-x: auto;
    }

    .table{
        margin-bottom: 0;
        border-radius: 10px;
        overflow: hidden;
    }

    .table thead th{
        background: #1f2937 !important;
        color: white !important;
        text-align: center;
        vertical-align: middle;
        padding: 14px;
        font-size: 15px;
    }

    .table tbody td{
        text-align: center;
        vertical-align: middle;
        padding: 12px;
    }

    .table tbody tr:hover{
        background-color: #eef9fc;
    }

    .sin-registros{
        text-align: center;
        font-weight: 600;
        color: #6c757d;
        padding: 20px !important;
    }

    @media (max-width: 768px){
        .titulo{
    background: rgba(23,162,184,0.9);
    color: white;
    padding: 18px;
    text-align: center;
    font-size: 28px;
    font-weight: bold;
    border-radius: 10px;
     }
    }
</style>
</head>

<body>

<div class="container main-container">

    <div class="titulo">
        Registro y Gestión de Matrículas
    </div>

    <!-- FORMULARIO -->
    <form action="../MatriculaServlet" method="post">

        <div class="box">

            <div class="row g-4 mb-2">

                <div class="col-md-4">
                    <label class="form-label-custom">N° Matrícula:</label>
                    <input type="text" class="form-control" placeholder="Autogenerado" disabled>
                </div>

                <div class="col-md-2 d-flex align-items-end">
                    <button type="button" class="btn btn-secondary btn-search w-100" disabled>Buscar</button>
                </div>

                <div class="col-md-3">
                    <label class="form-label-custom">Fecha:</label>
                    <input type="date" name="txtFecha" class="form-control" required>
                </div>

                <div class="col-md-3">
                    <label class="form-label-custom">Estado:</label>
                    <select name="txtEstado" class="form-control" required>
                        <option value="ACTIVO">ACTIVO</option>
                        <option value="INACTIVO">INACTIVO</option>
                    </select>
                </div>

            </div>

            <div class="row g-4">

                <div class="col-md-6">
                    <label class="form-label-custom">Código del Alumno:</label>
                    <input type="number" name="txtAlumno" class="form-control" placeholder="Ingrese código del alumno" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label-custom">Código del Curso:</label>
                    <input type="number" name="txtCurso" class="form-control" placeholder="Ingrese código del curso" required>
                </div>

            </div>

        </div>

        <!-- BOTONES -->
        <div class="box">
            <div class="row g-3">

                <div class="col-md-3">
                    <button type="submit" class="btn btn-sys btn-info-custom">Registrar Nueva</button>
                </div>

                <div class="col-md-3">
                    <button type="button" class="btn btn-sys btn-warning-custom">Modificar Curso</button>
                </div>

                <div class="col-md-3">
                    <button type="button" class="btn btn-sys btn-danger-custom">Cancelar Matrícula</button>
                </div>

                <div class="col-md-3">
                    <button type="reset" class="btn btn-sys btn-secondary-custom">Limpiar</button>
                </div>

            </div>
        </div>

    </form>

    <!-- TABLA -->
    <div class="box">
        <div class="table-container">
            <table class="table table-bordered table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Alumno</th>
                        <th>Curso</th>
                        <th>Fecha</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>

                <%
                List<Matricula> lista = (List<Matricula>) request.getAttribute("listaMatriculas");

                if (lista != null && !lista.isEmpty()) {
                    for (Matricula m : lista) {
                %>

                    <tr>
                        <td><%= m.getIdMatricula() %></td>
                        <td><%= m.getAlumno() != null ? m.getAlumno().getIdAlumno() : "" %></td>
                        <td><%= m.getCurso() != null ? m.getCurso().getIdCurso() : "" %></td>
                        <td><%= m.getFecha() %></td>
                        <td><%= m.getEstado() %></td>
                    </tr>

                <%
                    }
                } else {
                %>
                    <tr>
                        <td colspan="5" class="sin-registros">No hay matrículas registradas.</td>
                    </tr>
                <%
                }
                %>

                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>