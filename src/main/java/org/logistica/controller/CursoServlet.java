package org.logistica.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import org.logistica.bean.entity.Curso;
import org.logistica.bean.entity.Docente;
import org.logistica.bean.entity.Salon;
import org.logistica.dao.interfaces.CursoDAO;
import org.logistica.factory.DAOFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CursoServlet")
public class CursoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final CursoDAO dao = DAOFactory.getCursoDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		List<Curso> lista = dao.listar();
		if (lista == null) {
			lista = Collections.emptyList();
		}

		request.setAttribute("listaCursos", lista);
		request.getRequestDispatcher("mantCursos.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String accion = request.getParameter("accion");

		String idStr = request.getParameter("txtIdCurso");
		String nombre = request.getParameter("txtNombre");
		String ciclo = request.getParameter("txtCiclo");
		String creditosStr = request.getParameter("txtCreditos");
		String horasStr = request.getParameter("txtHoras");
		String idDocenteStr = request.getParameter("txtIdDocente");
		String idSalonStr = request.getParameter("txtIdSalon");

		if ("adicionar".equals(accion)) {

			if (nombre == null || nombre.trim().isEmpty() ||
				ciclo == null || ciclo.trim().isEmpty() ||
				creditosStr == null || creditosStr.trim().isEmpty() ||
				horasStr == null || horasStr.trim().isEmpty() ||
				idDocenteStr == null || idDocenteStr.trim().isEmpty() ||
				idSalonStr == null || idSalonStr.trim().isEmpty()) {

				request.setAttribute("mensaje", "Complete todos los campos para adicionar.");
				doGet(request, response);
				return;
			}

			int creditos = parseInt(creditosStr, -1);
			int horas = parseInt(horasStr, -1);
			int idDocente = parseInt(idDocenteStr, -1);
			int idSalon = parseInt(idSalonStr, -1);
			if (creditos < 0 || horas < 0 || idDocente <= 0 || idSalon <= 0) {
				request.setAttribute("mensaje", "Creditos, horas, docente y salon deben ser valores validos.");
				doGet(request, response);
				return;
			}

			Curso c = new Curso();
			Docente docente = new Docente();
			Salon salon = new Salon();
			docente.setIdDocente(idDocente);
			salon.setIdSalon(idSalon);
			c.setNombre(nombre);
			c.setCiclo(ciclo);
			c.setCreditos(creditos);
			c.setHoras(horas);
			c.setDocente(docente);
			c.setSalon(salon);

			dao.registrar(c);
			response.sendRedirect("CursoServlet");
			return;
		}

		if ("modificar".equals(accion)) {

			if (idStr == null || idStr.trim().isEmpty()) {
				request.setAttribute("mensaje", "Seleccione un curso de la tabla para modificar.");
				doGet(request, response);
				return;
			}

			if (nombre == null || nombre.trim().isEmpty() ||
				ciclo == null || ciclo.trim().isEmpty() ||
				creditosStr == null || creditosStr.trim().isEmpty() ||
				horasStr == null || horasStr.trim().isEmpty() ||
				idDocenteStr == null || idDocenteStr.trim().isEmpty() ||
				idSalonStr == null || idSalonStr.trim().isEmpty()) {

				request.setAttribute("mensaje", "Complete todos los campos para modificar.");
				doGet(request, response);
				return;
			}

			int id = parseInt(idStr, -1);
			int creditos = parseInt(creditosStr, -1);
			int horas = parseInt(horasStr, -1);
			int idDocente = parseInt(idDocenteStr, -1);
			int idSalon = parseInt(idSalonStr, -1);
			if (id <= 0 || creditos < 0 || horas < 0 || idDocente <= 0 || idSalon <= 0) {
				request.setAttribute("mensaje", "Complete datos validos para modificar.");
				doGet(request, response);
				return;
			}

			Curso c = new Curso();
			Docente docente = new Docente();
			Salon salon = new Salon();
			docente.setIdDocente(idDocente);
			salon.setIdSalon(idSalon);
			c.setIdCurso(id);
			c.setNombre(nombre);
			c.setCiclo(ciclo);
			c.setCreditos(creditos);
			c.setHoras(horas);
			c.setDocente(docente);
			c.setSalon(salon);

			dao.actualizar(c);
			response.sendRedirect("CursoServlet");
			return;
		}

		if ("eliminar".equals(accion)) {

			if (idStr == null || idStr.trim().isEmpty()) {
				request.setAttribute("mensaje", "Seleccione un curso de la tabla para eliminar.");
				doGet(request, response);
				return;
			}

			int id = parseInt(idStr, -1);
			if (id <= 0) {
				request.setAttribute("mensaje", "Seleccione un curso valido para eliminar.");
				doGet(request, response);
				return;
			}
			dao.eliminar(id);
			response.sendRedirect("CursoServlet");
			return;
		}

		doGet(request, response);
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
}