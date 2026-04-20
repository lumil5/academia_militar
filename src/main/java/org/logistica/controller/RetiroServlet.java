package org.logistica.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import org.logistica.bean.entity.Matricula;
import org.logistica.bean.entity.Retiro;
import org.logistica.dao.interfaces.RetiroDAO;
import org.logistica.factory.DAOFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RetiroServlet")
public class RetiroServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RetiroDAO dao = DAOFactory.getRetiroDAO();
        List<Retiro> lista = dao.listar();

        request.setAttribute("listaRetiros", lista);
        request.getRequestDispatcher("retiro.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idMatricula = Integer.parseInt(request.getParameter("txtMatricula"));

        Date fecha = Date.valueOf(request.getParameter("txtFecha"));
        Time hora = Time.valueOf(request.getParameter("txtHora"));

        Matricula matricula = new Matricula();
        matricula.setIdMatricula(idMatricula);

        Retiro r = new Retiro();
        r.setMatricula(matricula);
        r.setFecha(fecha);
        r.setHora(hora);

        RetiroDAO dao = DAOFactory.getRetiroDAO();
        dao.registrar(r);

        response.sendRedirect("RetiroServlet");
    }
}