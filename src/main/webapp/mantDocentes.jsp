<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="sepBase" value="${empty filtroQuery ? '?' : '?'.concat(filtroQuery).concat('&')}" />
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

<div class="container-fluid py-4 px-3">
    <div class="card shadow-sm mb-3">
        <div style="background-color: #1f2c8c;" class="card-header text-white d-flex justify-content-between align-items-center flex-wrap gap-2 px-3 py-3">
            <div>
                <h1 class="h3 mb-1"><i class="fa-solid fa-chalkboard-user me-2"></i>Mantenimiento de Docentes</h1>
                <small>Administra los docentes del sistema</small>
            </div>
            <div class="d-flex align-items-center gap-2 flex-wrap">
                <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalRegistrarDocente">
                    <i class="fa-solid fa-user-plus me-1"></i>Nuevo registro
                </button>
            </div>
        </div>
   

        <c:if test="${not empty mensaje}">
            <div class="alert alert-warning">${mensaje}</div>
        </c:if>

    </div>

    <div class="card shadow-sm">
        <div class="card-header bg-white d-flex justify-content-between align-items-center flex-wrap gap-2">
            <h2 class="h6 mb-0 text-secondary">Listado de docentes</h2>
            <span class="small text-secondary">Mostrando ${fn:length(listaDocentes)} de ${totalRegistros} docente(s)
                <c:if test="${totalRegistros > 0}">
                    — página ${paginaActual} de ${totalPaginas} (${tamPagina} por página)
                </c:if>
            </span>
        </div>
        <div class="card-body border-bottom">
            <form action="${ctx}/DocenteServlet" method="get" class="row g-2 align-items-end">
                <div class="col-md-5">
                    <label for="txtBuscar" class="form-label small mb-1">Buscar docente</label>
                    <input type="text"
                           class="form-control form-control-sm"
                           id="txtBuscar"
                           name="buscar"
                           value="${fn:escapeXml(buscar)}"
                           placeholder="Nombres, apellidos, DNI, especialidad o estado">
                </div>
                <div class="col-auto d-flex gap-2">
                    <button type="submit" class="btn btn-primary btn-sm">
                        <i class="fa-solid fa-magnifying-glass me-1"></i>Buscar
                    </button>
                    <a href="${ctx}/DocenteServlet" class="btn btn-outline-secondary btn-sm">Limpiar</a>
                </div>
            </form>
        </div>
        <div class="table-responsive">
            <table class="table table-striped table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>DNI</th>
                        <th>Especialidad</th>
                        <th>Celular</th>
                        <th>Estado</th>
                        <th class="text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty listaDocentes}">
                        <tr>
                            <td colspan="8" class="text-center text-muted py-3">No hay docentes registrados.</td>
                        </tr>
                    </c:if>
                    <c:forEach var="d" items="${listaDocentes}">
                        <tr>
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
                            <td class="text-center">
                                <div class="d-inline-flex gap-1">
                                    <c:url var="urlEditarDocente" value="/DocenteServlet">
                                        <c:param name="accion" value="editar" />
                                        <c:param name="id" value="${d.idDocente}" />
                                        <c:param name="page" value="${paginaActual}" />
                                        <c:param name="buscar" value="${buscar}" />
                                    </c:url>
                                    <a href="${urlEditarDocente}"
                                       class="btn btn-warning btn-sm"
                                       title="Modificar">
                                        <i class="fa-solid fa-pen"></i>
                                    </a>
                                    <button type="button"
                                            class="btn btn-danger btn-sm btn-eliminar-docente"
                                            data-id="${d.idDocente}"
                                            data-nombre="${fn:escapeXml(d.nombres)} ${fn:escapeXml(d.apellidos)}"
                                            title="Eliminar">
                                            <i class="fa-solid fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <c:if test="${totalPaginas > 1}">
    <c:set var="ventana" value="4" />
    <c:set var="ini" value="${paginaActual - ventana < 1 ? 1 : paginaActual - ventana}" />
    <c:set var="fin" value="${paginaActual + ventana > totalPaginas ? totalPaginas : paginaActual + ventana}" />
    <nav class="mt-3" aria-label="Paginación">
        <ul class="pagination pagination-sm justify-content-center flex-wrap">
            <c:choose>
            <c:when test="${paginaActual > 1}">
            <li class="page-item">
                <a class="page-link" href="${ctx}/DocenteServlet${sepBase}page=${paginaActual - 1}">Anterior</a>
            </li>
            </c:when>
            <c:otherwise>
            <li class="page-item disabled"><span class="page-link">Anterior</span></li>
            </c:otherwise>
            </c:choose>

            <c:if test="${ini > 1}">
            <li class="page-item"><a class="page-link" href="${ctx}/DocenteServlet${sepBase}page=1">1</a></li>
            <c:if test="${ini > 2}"><li class="page-item disabled"><span class="page-link">...</span></li></c:if>
            </c:if>

            <c:forEach var="p" begin="${ini}" end="${fin}">
            <li class="page-item ${p == paginaActual ? 'active' : ''}">
                <c:choose>
                <c:when test="${p != paginaActual}">
                <a class="page-link" href="${ctx}/DocenteServlet${sepBase}page=${p}">${p}</a>
                </c:when>
                <c:otherwise>
                <span class="page-link">${p}</span>
                </c:otherwise>
                </c:choose>
            </li>
            </c:forEach>

            <c:if test="${fin < totalPaginas}">
            <c:if test="${fin < totalPaginas - 1}">
            <li class="page-item disabled"><span class="page-link">...</span></li>
            </c:if>
            <li class="page-item"><a class="page-link" href="${ctx}/DocenteServlet${sepBase}page=${totalPaginas}">${totalPaginas}</a></li>
            </c:if>

            <c:choose>
            <c:when test="${paginaActual < totalPaginas}">
            <li class="page-item">
                <a class="page-link" href="${ctx}/DocenteServlet${sepBase}page=${paginaActual + 1}">Siguiente</a>
            </li>
            </c:when>
            <c:otherwise>
            <li class="page-item disabled"><span class="page-link">Siguiente</span></li>
            </c:otherwise>
            </c:choose>
        </ul>
    </nav>
    </c:if>
</div>

<jsp:include page="/vistas/registrarDocente.jsp" />

<div class="modal fade" id="modalEditarDocente" tabindex="-1" aria-labelledby="modalEditarDocenteLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
            <div class="modal-header text-white border-0 py-3" style="background-color: #1f2c8c;">
                <h5 class="modal-title" id="modalEditarDocenteLabel">
                    <i class="fa-solid fa-pen-to-square me-2"></i>Modificar docente
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <form action="${ctx}/DocenteServlet" method="post">
                <input type="hidden" name="txtIdDocente" value="${docenteEditar.idDocente}">
                <div class="modal-body p-4">
                    <div class="alert alert-light border d-flex align-items-center gap-2 py-2 mb-4">
                        <i class="fa-solid fa-circle-info text-primary"></i>
                        <small class="mb-0">Actualiza los datos del docente seleccionado.</small>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold" for="editTxtNombres">Nombres</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" class="form-control" id="editTxtNombres" name="txtNombres" value="${docenteEditar.nombres}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold" for="editTxtApellidos">Apellidos</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-id-card"></i></span>
                                <input type="text" class="form-control" id="editTxtApellidos" name="txtApellidos" value="${docenteEditar.apellidos}" required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold" for="editTxtDni">DNI</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-regular fa-address-card"></i></span>
                                <input type="text" class="form-control" id="editTxtDni" name="txtDni" value="${docenteEditar.dni}" maxlength="8" required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold" for="editTxtEspecialidad">Especialidad</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-book-open-reader"></i></span>
                                <input type="text" class="form-control" id="editTxtEspecialidad" name="txtEspecialidad" value="${docenteEditar.especialidad}" required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold" for="editTxtCelular">Celular</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                                <input type="text" class="form-control" id="editTxtCelular" name="txtCelular" value="${docenteEditar.celular}" maxlength="9">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold" for="editTxtEstado">Estado</label>
                            <select class="form-select" id="editTxtEstado" name="txtEstado">
                                <option value="ACTIVO" ${docenteEditar.estado == 'ACTIVO' ? 'selected' : ''}>ACTIVO</option>
                                <option value="INACTIVO" ${docenteEditar.estado == 'INACTIVO' ? 'selected' : ''}>INACTIVO</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light border-0 px-4 py-3">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-warning px-4" name="accion" value="modificar">
                        <i class="fa-solid fa-floppy-disk me-1"></i>Guardar cambios
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<div class="modal fade" id="modalEliminarDocente" tabindex="-1" aria-labelledby="modalEliminarDocenteLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="modalEliminarDocenteLabel">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i>Confirmar eliminación
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                <p class="mb-2">Esta acción eliminará al docente seleccionado.</p>
                <div class="alert alert-danger d-flex align-items-center py-2 mb-2" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i>
                    <small class="mb-0">Esta acción no se puede deshacer.</small>
                </div>
                <p class="mb-2"><strong>Docente:</strong> <span id="nombreDocenteEliminar">-</span></p>
                <label for="confirmacionEliminarDocente" class="form-label small mb-1">
                    Escribe <strong>ELIMINAR</strong> para confirmar:
                </label>
                <input type="text"
                       class="form-control"
                       id="confirmacionEliminarDocente"
                       autocomplete="off"
                       placeholder="ELIMINAR">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <form action="${ctx}/DocenteServlet" method="post" class="d-inline">
                    <input type="hidden" name="txtIdDocente" id="idDocenteEliminar">
                    <button type="submit" class="btn btn-danger" name="accion" value="eliminar" id="btnConfirmarEliminarDocente" disabled>
                        <i class="fa-solid fa-trash me-1"></i>Eliminar
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
const modalEliminarDocenteElement = document.getElementById('modalEliminarDocente');
const idDocenteEliminarInput = document.getElementById('idDocenteEliminar');
const nombreDocenteEliminarSpan = document.getElementById('nombreDocenteEliminar');
const confirmacionEliminarDocenteInput = document.getElementById('confirmacionEliminarDocente');
const btnConfirmarEliminarDocente = document.getElementById('btnConfirmarEliminarDocente');

if (modalEliminarDocenteElement) {
    const modalEliminarDocente = new bootstrap.Modal(modalEliminarDocenteElement);
    const actualizarEstadoBotonEliminar = () => {
        const valor = (confirmacionEliminarDocenteInput.value || '').trim().toUpperCase();
        btnConfirmarEliminarDocente.disabled = valor !== 'ELIMINAR';
    };

    document.querySelectorAll('.btn-eliminar-docente').forEach((btn) => {
        btn.addEventListener('click', () => {
            idDocenteEliminarInput.value = btn.dataset.id || '';
            nombreDocenteEliminarSpan.textContent = btn.dataset.nombre || '-';
            confirmacionEliminarDocenteInput.value = '';
            btnConfirmarEliminarDocente.disabled = true;
            modalEliminarDocente.show();
            confirmacionEliminarDocenteInput.focus();
        });
    });

    confirmacionEliminarDocenteInput.addEventListener('input', actualizarEstadoBotonEliminar);
    modalEliminarDocenteElement.addEventListener('hidden.bs.modal', () => {
        confirmacionEliminarDocenteInput.value = '';
        btnConfirmarEliminarDocente.disabled = true;
    });
}
</script>
<c:if test="${abrirModalEditar}">
<script>
const modalEditar = new bootstrap.Modal(document.getElementById('modalEditarDocente'));
modalEditar.show();
</script>
</c:if>

</body>
</html>
