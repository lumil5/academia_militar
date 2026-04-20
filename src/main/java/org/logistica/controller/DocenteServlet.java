package org.logistica.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

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
        List<Docente> lista = dao.listar();
        if (lista == null) {
            lista = Collections.emptyList();
        }
        request.setAttribute("listaDocentes", lista);
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
}
