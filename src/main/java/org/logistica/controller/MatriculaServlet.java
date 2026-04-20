package org.logistica.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import org.logistica.bean.entity.Alumno;
import org.logistica.bean.entity.Curso;
import org.logistica.bean.entity.Matricula;
import org.logistica.dao.interfaces.MatriculaDAO;
import org.logistica.factory.DAOFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/MatriculaServlet")
public class MatriculaServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");

        MatriculaDAO dao = DAOFactory.getMatriculaDAO();
        List<Matricula> lista = dao.listar();

        request.setAttribute("listaMatriculas", lista);
        request.getRequestDispatcher("matricula.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int alumno = Integer.parseInt(request.getParameter("txtAlumno"));
        int curso = Integer.parseInt(request.getParameter("txtCurso"));
        Date fecha = Date.valueOf(request.getParameter("txtFecha"));
        String estado = request.getParameter("txtEstado");

        Alumno alumnoObj = new Alumno();
        alumnoObj.setIdAlumno(alumno);
        Curso cursoObj = new Curso();
        cursoObj.setIdCurso(curso);

        Matricula m = new Matricula();
        m.setAlumno(alumnoObj);
        m.setCurso(cursoObj);
        m.setFecha(fecha);
        m.setEstado(estado);

        MatriculaDAO dao = DAOFactory.getMatriculaDAO();
        dao.registrar(m);

        response.sendRedirect("MatriculaServlet");
    }
}