<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="sepBase" value="${empty filtroQuery ? '?' : '?'.concat(filtroQuery).concat('&')}" />
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Consulta de matrículas</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-4">

    <div class="row mb-3">
        <div class="col">
            <h1 class="h3 mb-1">Consulta de matrículas</h1>
            <p class="text-secondary mb-0">Filtros, listado paginado y exportación de reportes.</p>
        </div>
        <div class="col-auto d-flex align-items-center gap-2 flex-wrap">
            <a class="btn btn-outline-secondary btn-sm" href="${ctx}/vistas/dashboard.jsp">Volver al panel</a>
        </div>
    </div>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <span class="fw-semibold">Criterios de búsqueda</span>
        </div>
        <div class="card-body">
            <form method="get" action="${ctx}/ConsultaServlet" class="row g-3" >
                <input type="hidden" name="page" value="1">
                <div class="col-md-3">
                    <label class="form-label small mb-0" for="dni">DNI alumno</label>
                    <input type="text" class="form-control form-control-sm" id="dni" name="dni"
                        value="${fn:escapeXml(filtro.dni)}"
                        placeholder="Coincide parcialmente" autocomplete="off">
                </div>
                <div class="col-md-3">
                    <label class="form-label small mb-0" for="textoAlumno">Nombre / apellido</label>
                    <input type="text" class="form-control form-control-sm" id="textoAlumno" name="textoAlumno"
                        value="${fn:escapeXml(filtro.textoAlumno)}"
                        placeholder="Buscar en nombres o apellidos" autocomplete="off">
                </div>
                <div class="col-md-2">
                    <label class="form-label small mb-0" for="idCurso">Curso</label>
                    <select class="form-select form-select-sm" id="idCurso" name="idCurso">
                        <option value="0" ${filtro.idCurso == 0 ? 'selected' : ''}>Todos</option>
                        <c:forEach var="c" items="${listaCursos}">
                        <option value="${c.idCurso}" ${filtro.idCurso == c.idCurso ? 'selected' : ''}>
                            <c:choose>
                                <c:when test="${not empty c.nombre}">
                                    <c:out value="${c.nombre}" />
                                </c:when>
                                <c:otherwise>ID ${c.idCurso}</c:otherwise>
                            </c:choose>
                        </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label small mb-0" for="estado">Estado matrícula</label>
                    <select class="form-select form-select-sm" id="estado" name="estado">
                        <option value="" ${empty filtro.estado ? 'selected' : ''}>Todos</option>
                        <option value="ACTIVO" ${filtro.estado == 'ACTIVO' ? 'selected' : ''}>ACTIVO</option>
                        <option value="INACTIVO" ${filtro.estado == 'INACTIVO' ? 'selected' : ''}>INACTIVO</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label small mb-0" for="fechaDesde">Fecha desde</label>
                    <input type="date" class="form-control form-control-sm" id="fechaDesde" name="fechaDesde"
                        value="${filtro.fechaDesdeInput}">
                </div>
                <div class="col-md-2">
                    <label class="form-label small mb-0" for="fechaHasta">Fecha hasta</label>
                    <input type="date" class="form-control form-control-sm" id="fechaHasta" name="fechaHasta"
                        value="${filtro.fechaHastaInput}">
                </div>
                <div class="col-12 d-flex flex-wrap gap-2 pt-2">
                    <button type="submit" class="btn btn-primary btn-sm">Buscar</button>
                    <a class="btn btn-outline-secondary btn-sm" href="${ctx}/ConsultaServlet">Limpiar filtros</a>
                    <a class="btn btn-danger btn-sm" href="${ctx}/ConsultaServlet${sepBase}export=pdf">Exportar PDF</a>
                    <a class="btn btn-success btn-sm" href="${ctx}/ConsultaServlet${sepBase}export=excel">Exportar Excel</a>
                </div>
            </form>
        </div>
    </div>

    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-2">
        <p class="mb-0 small text-secondary">
            Mostrando ${fn:length(listaMatriculas)} de ${totalRegistros} registro(s)
            <c:if test="${totalRegistros > 0}">
                — página ${paginaActual} de ${totalPaginas} (${tamPagina} por página)
            </c:if>
        </p>
    </div>

    <div class="card shadow-sm">
        <div class="table-responsive">
            <table class="table table-striped table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Fecha</th>
                        <th scope="col">Alumno</th>
                        <th scope="col">DNI</th>
                        <th scope="col">Curso</th>
                        <th scope="col">Ciclo</th>
                        <th scope="col">Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty listaMatriculas}">
                    <tr>
                        <td colspan="7" class="text-center text-secondary py-4">No hay resultados para los criterios seleccionados.</td>
                    </tr>
                    </c:if>
                    <c:forEach var="m" items="${listaMatriculas}">
                    <c:set var="nom" value="${empty m.nombreCompletoAlumno ? '—' : m.nombreCompletoAlumno}" />
                    <c:set var="est" value="${empty m.estadoMatricula ? '' : m.estadoMatricula}" />
                    <c:set var="estUpper" value="${fn:toUpperCase(est)}" />
                    <c:set var="badgeClass" value="${estUpper == 'ACTIVO' ? 'bg-success' : (estUpper == 'INACTIVO' ? 'bg-danger' : 'bg-secondary')}" />
                    <tr>
                        <td>${m.idMatricula}</td>
                        <td>${empty m.fechaMatricula ? '—' : m.fechaMatricula}</td>
                        <td><c:out value="${nom}" /></td>
                        <td><c:out value="${empty m.dniAlumno ? '—' : m.dniAlumno}" /></td>
                        <td><c:out value="${empty m.nombreCurso ? '—' : m.nombreCurso}" /></td>
                        <td><c:out value="${empty m.cicloCurso ? '—' : m.cicloCurso}" /></td>
                        <td><span class="badge ${badgeClass}">${empty est ? '—' : est}</span></td>
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
                <a class="page-link" href="${ctx}/ConsultaServlet${sepBase}page=${paginaActual - 1}">Anterior</a>
            </li>
            </c:when>
            <c:otherwise>
            <li class="page-item disabled"><span class="page-link">Anterior</span></li>
            </c:otherwise>
            </c:choose>

            <c:if test="${ini > 1}">
            <li class="page-item"><a class="page-link" href="${ctx}/ConsultaServlet${sepBase}page=1">1</a></li>
            <c:if test="${ini > 2}"><li class="page-item disabled"><span class="page-link">…</span></li></c:if>
            </c:if>

            <c:forEach var="p" begin="${ini}" end="${fin}">
            <li class="page-item ${p == paginaActual ? 'active' : ''}">
                <c:choose>
                <c:when test="${p != paginaActual}">
                <a class="page-link" href="${ctx}/ConsultaServlet${sepBase}page=${p}">${p}</a>
                </c:when>
                <c:otherwise>
                <span class="page-link">${p}</span>
                </c:otherwise>
                </c:choose>
            </li>
            </c:forEach>

            <c:if test="${fin < totalPaginas}">
            <c:if test="${fin < totalPaginas - 1}">
            <li class="page-item disabled"><span class="page-link">…</span></li>
            </c:if>
            <li class="page-item"><a class="page-link" href="${ctx}/ConsultaServlet${sepBase}page=${totalPaginas}">${totalPaginas}</a></li>
            </c:if>

            <c:choose>
            <c:when test="${paginaActual < totalPaginas}">
            <li class="page-item">
                <a class="page-link" href="${ctx}/ConsultaServlet${sepBase}page=${paginaActual + 1}">Siguiente</a>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
