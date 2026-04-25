package org.logistica.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.logistica.bean.entity.Docente;
import org.logistica.dao.interfaces.DocenteDAO;
import org.logistica.factory.DAOFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DocenteServlet")
public class DocenteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final DocenteDAO dao = DAOFactory.getDocenteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = trimToEmpty(request.getParameter("accion"));
        if ("editar".equals(accion)) {
            int id = parseInt(request.getParameter("id"), -1);
            if (id <= 0) {
                request.setAttribute("mensaje", "ID de docente no válido para editar.");
                cargarListado(request, response);
                return;
            }
            Docente docente = dao.buscar(id);
            if (docente == null) {
                request.setAttribute("mensaje", "No se encontró el docente solicitado.");
                cargarListado(request, response);
                return;
            }
            request.setAttribute("docenteEditar", docente);
            request.setAttribute("abrirModalEditar", true);
            cargarListado(request, response);
            return;
        }

        cargarListado(request, response);
    }

    private void cargarListado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String buscar = trimToEmpty(request.getParameter("buscar"));
        int paginaActual = parseInt(request.getParameter("page"), 1);
        final int tamPagina = 10;
        if (paginaActual < 1) {
            paginaActual = 1;
        }

        List<Docente> lista = dao.listar();
        if (lista == null) {
            lista = Collections.emptyList();
        }
        if (!buscar.isEmpty()) {
            final String criterio = buscar.toLowerCase();
            lista = lista.stream()
                    .filter(d -> contiene(d.getNombres(), criterio)
                            || contiene(d.getApellidos(), criterio)
                            || contiene(d.getDni(), criterio)
                            || contiene(d.getEspecialidad(), criterio)
                            || contiene(d.getEstado(), criterio))
                    .collect(Collectors.toList());
        }

        int totalRegistros = lista.size();
        int totalPaginas = totalRegistros == 0 ? 1 : (int) Math.ceil((double) totalRegistros / tamPagina);
        if (paginaActual > totalPaginas) {
            paginaActual = totalPaginas;
        }

        int desde = (paginaActual - 1) * tamPagina;
        int hasta = Math.min(desde + tamPagina, totalRegistros);
        List<Docente> paginaLista = totalRegistros == 0 ? Collections.emptyList() : lista.subList(desde, hasta);

        String filtroQuery = buscar.isEmpty() ? ""
                : "buscar=" + URLEncoder.encode(buscar, StandardCharsets.UTF_8);

        request.setAttribute("buscar", buscar);
        request.setAttribute("filtroQuery", filtroQuery);
        request.setAttribute("paginaActual", paginaActual);
        request.setAttribute("tamPagina", tamPagina);
        request.setAttribute("totalRegistros", totalRegistros);
        request.setAttribute("totalPaginas", totalPaginas);
        request.setAttribute("listaDocentes", paginaLista);
        request.getRequestDispatcher("mantDocentes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = trimToEmpty(request.getParameter("accion"));

        String idStr = request.getParameter("txtIdDocente");
        String nombres = trimToEmpty(request.getParameter("txtNombres"));
        String apellidos = trimToEmpty(request.getParameter("txtApellidos"));
        String dni = trimToEmpty(request.getParameter("txtDni"));
        String especialidad = trimToEmpty(request.getParameter("txtEspecialidad"));
        String celular = trimToEmpty(request.getParameter("txtCelular"));
        String estado = trimToEmpty(request.getParameter("txtEstado"));

        if ("adicionar".equals(accion)) {
            if (!validarCamposBase(nombres, apellidos, dni, especialidad, request, response, "Complete todos los campos obligatorios para adicionar.")) {
                return;
            }
            Docente d = new Docente();
            d.setNombres(nombres);
            d.setApellidos(apellidos);
            d.setDni(dni);
            d.setEspecialidad(especialidad);
            d.setCelular(celular);
            d.setEstado(estado.isEmpty() ? "ACTIVO" : estado);
            dao.registrar(d);
            response.sendRedirect("DocenteServlet");
            return;
        }

        if ("modificar".equals(accion)) {
            int id = parseInt(idStr, -1);
            if (id <= 0) {
                request.setAttribute("mensaje", "Seleccione un docente de la tabla para modificar.");
                doGet(request, response);
                return;
            }
            if (!validarCamposBase(nombres, apellidos, dni, especialidad, request, response, "Complete todos los campos obligatorios para modificar.")) {
                return;
            }
            Docente d = new Docente();
            d.setIdDocente(id);
            d.setNombres(nombres);
            d.setApellidos(apellidos);
            d.setDni(dni);
            d.setEspecialidad(especialidad);
            d.setCelular(celular);
            d.setEstado(estado.isEmpty() ? "ACTIVO" : estado);
            dao.actualizar(d);
            response.sendRedirect("DocenteServlet");
            return;
        }

        if ("eliminar".equals(accion)) {
            int id = parseInt(idStr, -1);
            if (id <= 0) {
                request.setAttribute("mensaje", "Seleccione un docente de la tabla para eliminar.");
                doGet(request, response);
                return;
            }
            dao.eliminar(id);
            response.sendRedirect("DocenteServlet");
            return;
        }

        doGet(request, response);
    }

    private boolean validarCamposBase(String nombres, String apellidos, String dni, String especialidad,
            HttpServletRequest request, HttpServletResponse response, String mensaje)
            throws ServletException, IOException {
        if (nombres.isEmpty() || apellidos.isEmpty() || dni.isEmpty() || especialidad.isEmpty()) {
            request.setAttribute("mensaje", mensaje);
            doGet(request, response);
            return false;
        }
        return true;
    }

    private static int parseInt(String value, int fallback) {
        if (value == null || value.isBlank()) {
            return fallback;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return fallback;
        }
    }

    private static String trimToEmpty(String value) {
        return value == null ? "" : value.trim();
    }

    private static boolean contiene(String valor, String criterio) {
        return valor != null && valor.toLowerCase().contains(criterio);
    }
}
