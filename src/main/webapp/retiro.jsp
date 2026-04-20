<%@ page import="java.util.List, org.logistica.bean.entity.Retiro"%>

<!DOCTYPE html>
<html>
<head>
    <title>Mantenimiento de Retiros</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .header {
            background: #1e88a8;
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: bold;
        }

        .box {
            border: 2px solid #1e88a8;
            padding: 20px;
        }

        .btn-add { background: #2e7d32; color: white; }
        .btn-del { background: #d32f2f; color: white; }
        .btn-clear { background: #6c757d; color: white; }

        table thead {
            background: #212529;
            color: white;
        }
    </style>
</head>

<body>

<div class="container mt-4">

    <!-- 🔵 TITULO -->
    <div class="header">
        Mantenimiento de Retiros
    </div>

    <!-- 🟦 FORM -->
    <div class="row mt-3">
        <form action="RetiroServlet" method="post" class="row g-0">
        <div class="col-md-8 box">

            <div class="row mb-3">
                <div class="col-md-4">N° Matrícula:</div>
                <div class="col-md-8">
                    <input type="text" name="txtMatricula" class="form-control" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">Fecha:</div>
                <div class="col-md-8">
                    <input type="date" name="txtFecha" class="form-control" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">Hora:</div>
                <div class="col-md-8">
                    <input type="time" name="txtHora" class="form-control" required>
                </div>
            </div>

        </div>

        <!-- 🔘 BOTONES -->
        <div class="col-md-4 box text-center">

                <button type="submit" class="btn btn-add w-100 mb-2">
                    Registrar Retiro
                </button>

                <button type="reset" class="btn btn-clear w-100">
                    Limpiar
                </button>

        </div>
        </form>

    </div>

    <!-- 📊 TABLA -->
    <div class="mt-4 box">

        <table class="table table-bordered table-hover">

            <thead>
                <tr>
                    <th>ID</th>
                    <th>Matricula</th>
                    <th>Fecha</th>
                    <th>Hora</th>
                </tr>
            </thead>

            <tbody>

            <%
            List<Retiro> lista = (List<Retiro>) request.getAttribute("listaRetiros");

            if (lista != null) {
                for (Retiro r : lista) {
            %>

                <tr>
                    <td><%=r.getIdRetiro()%></td>
                    <td><%=r.getMatricula() != null ? r.getMatricula().getIdMatricula() : ""%></td>
                    <td><%=r.getFecha()%></td>
                    <td><%=r.getHora()%></td>
                </tr>

            <%
                }
            }
            %>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>