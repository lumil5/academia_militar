<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${empty ctx}">
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
</c:if>

<div class="modal fade" id="modalRegistrarDocente" tabindex="-1" aria-labelledby="modalRegistrarDocenteLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
            <div class="modal-header text-white border-0 py-3" style="background-color: #1f2c8c;">
                <h5 class="modal-title" id="modalRegistrarDocenteLabel">
                    <i class="fa-solid fa-user-plus me-2"></i>Registrar docente
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <form action="${ctx}/DocenteServlet" method="post">
                <div class="modal-body p-4">
                    <div class="alert alert-light border d-flex align-items-center gap-2 py-2 mb-4">
                        <i class="fa-solid fa-circle-info text-primary"></i>
                        <small class="mb-0">Completa los datos del docente para registrarlo en el sistema.</small>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold" for="regTxtNombres">Nombres</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" class="form-control" id="regTxtNombres" name="txtNombres" placeholder="Ej. José Luis" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold" for="regTxtApellidos">Apellidos</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-id-card"></i></span>
                                <input type="text" class="form-control" id="regTxtApellidos" name="txtApellidos" placeholder="Ej. Pérez Gómez" required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold" for="regTxtDni">DNI</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-regular fa-address-card"></i></span>
                                <input type="text" class="form-control" id="regTxtDni" name="txtDni" required maxlength="8" placeholder="8 dígitos">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold" for="regTxtEspecialidad">Especialidad</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-book-open-reader"></i></span>
                                <input type="text" class="form-control" id="regTxtEspecialidad" name="txtEspecialidad" placeholder="Ej. Matemática" required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold" for="regTxtCelular">Celular</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                                <input type="text" class="form-control" id="regTxtCelular" name="txtCelular" maxlength="9" placeholder="Opcional">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold" for="regTxtEstado">Estado</label>
                            <select class="form-select" id="regTxtEstado" name="txtEstado">
                                <option value="ACTIVO" selected>ACTIVO</option>
                                <option value="INACTIVO">INACTIVO</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light border-0 px-4 py-3">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        Cancelar
                    </button>
                    <button type="submit" class="btn btn-success px-4" name="accion" value="adicionar">
                        <i class="fa-solid fa-plus me-1"></i>Guardar docente
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>