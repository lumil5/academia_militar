package org.logistica.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import org.logistica.bean.entity.Alumno;
import org.logistica.dao.interfaces.AlumnoDAO;
import org.logistica.factory.DAOFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AlumnoServlet")
public class AlumnoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private AlumnoDAO dao = DAOFactory.getAlumnoDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String accion = request.getParameter("accion");

		if ("nuevo".equals(accion)) {
			request.getRequestDispatcher("vistas/registrarAlumno.jsp").forward(request, response);
			return;
		}

		if ("editar".equals(accion)) {
		    int id = parseInt(request.getParameter("id"), -1);
		    if (id <= 0) {
		    	request.setAttribute("mensaje", "Seleccione un alumno valido para editar.");
		    	cargarListado(request, response);
		    	return;
		    }

		    Alumno alumno = dao.buscar(id);
		    if (alumno == null) {
		    	request.setAttribute("mensaje", "No se encontro el alumno seleccionado.");
		    	cargarListado(request, response);
		    	return;
		    }

		    request.setAttribute("alumno", alumno);

		    request.getRequestDispatcher("vistas/editarAlumno.jsp").forward(request, response);
		    return;
		}

		if ("eliminar".equals(accion)) {
			int id = parseInt(request.getParameter("id"), -1);
			if (id <= 0) {
				request.setAttribute("mensaje", "Seleccione un alumno valido para eliminar.");
				cargarListado(request, response);
				return;
			}
			dao.eliminar(id);
			response.sendRedirect("AlumnoServlet");
			return;
		}

		cargarListado(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String accion = request.getParameter("accion");

		if ("guardar".equals(accion)) {
			String dni = trimToEmpty(request.getParameter("txtDni"));
			String nombres = trimToEmpty(request.getParameter("txtNombres"));
			String apellidos = trimToEmpty(request.getParameter("txtApellidos"));
			String edadStr = request.getParameter("txtEdad");
			String celular = trimToEmpty(request.getParameter("txtCelular"));
			String estado = trimToEmpty(request.getParameter("txtEstado"));

			if (dni.isEmpty() || nombres.isEmpty() || apellidos.isEmpty()) {
				request.setAttribute("error", "DNI, nombres y apellidos son obligatorios.");
				request.getRequestDispatcher("vistas/registrarAlumno.jsp").forward(request, response);
				return;
			}

			int edad = parseInt(edadStr, -1);
			if (edad < 0) {
				request.setAttribute("error", "La edad debe ser un numero valido.");
				request.getRequestDispatcher("vistas/registrarAlumno.jsp").forward(request, response);
				return;
			}

			Alumno a = new Alumno();
			a.setDni(dni);
			a.setNombres(nombres);
			a.setApellidos(apellidos);
			a.setEdad(edad);
			a.setCelular(celular);
			a.setEstado(estado.isEmpty() ? "ACTIVO" : estado);

			dao.registrar(a);
			response.sendRedirect("AlumnoServlet");
			return;
		}

		if ("actualizar".equals(accion)) {
			int id = parseInt(request.getParameter("txtIdAlumno"), -1);
			String dni = trimToEmpty(request.getParameter("txtDni"));
			String nombres = trimToEmpty(request.getParameter("txtNombres"));
			String apellidos = trimToEmpty(request.getParameter("txtApellidos"));
			String edadStr = request.getParameter("txtEdad");
			String celular = trimToEmpty(request.getParameter("txtCelular"));
			String estado = trimToEmpty(request.getParameter("txtEstado"));

			if (id <= 0 || dni.isEmpty() || nombres.isEmpty() || apellidos.isEmpty()) {
				request.setAttribute("mensaje", "Datos invalidos para actualizar alumno.");
				cargarListado(request, response);
				return;
			}
			int edad = parseInt(edadStr, -1);
			if (edad < 0) {
				request.setAttribute("mensaje", "La edad debe ser un numero valido.");
				cargarListado(request, response);
				return;
			}

			Alumno a = new Alumno();
			a.setIdAlumno(id);
			a.setDni(dni);
			a.setNombres(nombres);
			a.setApellidos(apellidos);
			a.setEdad(edad);
			a.setCelular(celular);
			a.setEstado(estado.isEmpty() ? "ACTIVO" : estado);

			dao.actualizar(a);
			response.sendRedirect("AlumnoServlet");
		}
	}

	private void cargarListado(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Alumno> lista = dao.listar();
		if (lista == null) {
			lista = Collections.emptyList();
		}
		request.setAttribute("listaAlumnos", lista);
		request.getRequestDispatcher("mantAlumnos.jsp").forward(request, response);
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