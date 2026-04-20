<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mantenimiento de Docentes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-light">

<div class="container py-4">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <div>
                <h5 class="mb-0"><i class="fa-solid fa-chalkboard-user me-2"></i>Mantenimiento de Docentes</h5>
                <small>Administra los docentes del sistema</small>
            </div>
            <a href="${ctx}/vistas/dashboard.jsp" class="btn btn-outline-light btn-sm">
                <i class="fa-solid fa-arrow-left me-1"></i>Volver al panel
            </a>
        </div>

        <div class="card-body">
            <c:if test="${not empty mensaje}">
                <div class="alert alert-warning">${mensaje}</div>
            </c:if>

            <form action="${ctx}/DocenteServlet" method="post" class="border rounded p-3 mb-3 bg-white">
                <input type="hidden" id="txtIdDocente" name="txtIdDocente">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Nombres</label>
                        <input type="text" class="form-control" id="txtNombres" name="txtNombres" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Apellidos</label>
                        <input type="text" class="form-control" id="txtApellidos" name="txtApellidos" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">DNI</label>
                        <input type="text" class="form-control" id="txtDni" name="txtDni" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Especialidad</label>
                        <input type="text" class="form-control" id="txtEspecialidad" name="txtEspecialidad" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Celular</label>
                        <input type="text" class="form-control" id="txtCelular" name="txtCelular">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Estado</label>
                        <select class="form-select" id="txtEstado" name="txtEstado">
                            <option value="ACTIVO">ACTIVO</option>
                            <option value="INACTIVO">INACTIVO</option>
                        </select>
                    </div>
                </div>
                <div class="d-flex gap-2 mt-3 flex-wrap">
                    <button type="submit" class="btn btn-success" name="accion" value="adicionar">
                        <i class="fa-solid fa-plus me-1"></i>Adicionar
                    </button>
                    <button type="submit" class="btn btn-warning" name="accion" value="modificar">
                        <i class="fa-solid fa-pen me-1"></i>Modificar
                    </button>
                    <button type="submit" class="btn btn-danger" name="accion" value="eliminar" onclick="return validarEliminar();">
                        <i class="fa-solid fa-trash me-1"></i>Eliminar
                    </button>
                    <button type="reset" class="btn btn-secondary" onclick="limpiarSeleccion();">
                        <i class="fa-solid fa-broom me-1"></i>Limpiar
                    </button>
                </div>
            </form>

            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>DNI</th>
                            <th>Especialidad</th>
                            <th>Celular</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty listaDocentes}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-3">No hay docentes registrados.</td>
                            </tr>
                        </c:if>
                        <c:forEach var="d" items="${listaDocentes}">
                            <tr onclick="seleccionarDocente(this)" style="cursor:pointer;"
                                data-id="${d.idDocente}"
                                data-nombres="${fn:escapeXml(d.nombres)}"
                                data-apellidos="${fn:escapeXml(d.apellidos)}"
                                data-dni="${fn:escapeXml(d.dni)}"
                                data-especialidad="${fn:escapeXml(d.especialidad)}"
                                data-celular="${fn:escapeXml(d.celular)}"
                                data-estado="${fn:escapeXml(d.estado)}">
                                <td>${d.idDocente}</td>
                                <td><c:out value="${d.nombres}" /></td>
                                <td><c:out value="${d.apellidos}" /></td>
                                <td><c:out value="${d.dni}" /></td>
                                <td><c:out value="${d.especialidad}" /></td>
                                <td><c:out value="${empty d.celular ? '-' : d.celular}" /></td>
                                <td>
                                    <span class="badge ${fn:toUpperCase(d.estado) == 'ACTIVO' ? 'text-bg-success' : 'text-bg-danger'}">
                                        <c:out value="${empty d.estado ? 'SIN ESTADO' : d.estado}" />
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
function seleccionarDocente(row) {
    document.getElementById("txtIdDocente").value = row.dataset.id || "";
    document.getElementById("txtNombres").value = row.dataset.nombres || "";
    document.getElementById("txtApellidos").value = row.dataset.apellidos || "";
    document.getElementById("txtDni").value = row.dataset.dni || "";
    document.getElementById("txtEspecialidad").value = row.dataset.especialidad || "";
    document.getElementById("txtCelular").value = row.dataset.celular || "";
    document.getElementById("txtEstado").value = row.dataset.estado || "ACTIVO";

    document.querySelectorAll("tbody tr").forEach((tr) => tr.classList.remove("table-primary"));
    row.classList.add("table-primary");
}

function validarEliminar() {
    const id = document.getElementById("txtIdDocente").value;
    if (!id) {
        alert("Primero selecciona un docente de la tabla.");
        return false;
    }
    return confirm("¿Seguro que deseas eliminar este docente?");
}

function limpiarSeleccion() {
    document.getElementById("txtIdDocente").value = "";
    document.getElementById("txtEstado").value = "ACTIVO";
    document.querySelectorAll("tbody tr").forEach((tr) => tr.classList.remove("table-primary"));
}
</script>

</body>
</html>
