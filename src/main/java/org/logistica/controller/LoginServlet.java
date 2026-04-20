package org.logistica.controller;

import java.io.IOException;

import org.logistica.bean.entity.Usuario;
import org.logistica.dao.interfaces.UsuarioDAO;
import org.logistica.factory.DAOFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 🔥 RECIBE DATOS
		String username = request.getParameter("txtUsuario");
		String pass = request.getParameter("txtPassword");

		System.out.println("Usuario: " + username);
		System.out.println("Pass: " + pass);

		// 🔥 DAO
		UsuarioDAO dao = DAOFactory.getUsuarioDAO();
		Usuario user = dao.login(username, pass);

		// 🔥 VALIDACIÓN
		if (user != null) {

			HttpSession session = request.getSession();
			session.setAttribute("usuario", user.getUsername());
			session.setAttribute("rol", user.getRol());

			response.sendRedirect("vistas/dashboard.jsp");

		} else {

			request.setAttribute("mensaje", "Credenciales incorrectas");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}