package org.logistica.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.util.Collections;
import java.util.List;

import org.logistica.bean.dto.FiltroMatricula;
import org.logistica.bean.dto.MatriculaConsultaDTO;
import org.logistica.bean.entity.Curso;
import org.logistica.dao.interfaces.ConsultaDAO;
import org.logistica.dao.interfaces.CursoDAO;
import org.logistica.factory.DAOFactory;
import org.logistica.util.MatriculaExcelExport;
import org.logistica.util.MatriculaPdfExport;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ConsultaServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;
    private static final int EXPORT_MAX_ROWS = 50_000;

    private final ConsultaDAO consultaDAO = DAOFactory.getConsultaDAO();
    private final CursoDAO cursoDAO = DAOFactory.getCursoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            FiltroMatricula filtro = construirFiltro(request);
            String export = request.getParameter("export");

            if ("pdf".equalsIgnoreCase(export)) {
                exportarPdf(response, filtro);
                return;
            }
            if ("excel".equalsIgnoreCase(export) || "xlsx".equalsIgnoreCase(export)) {
                exportarExcel(response, filtro);
                return;
            }

            int page = parseInt(request.getParameter("page"), 1);
            if (page < 1) {
                page = 1;
            }

            long total = consultaDAO.contarMatriculas(filtro);
            int totalPages = (int) Math.ceil(total / (double) PAGE_SIZE);
            if (totalPages < 1) {
                totalPages = 1;
            }
            if (page > totalPages && total > 0) {
                page = totalPages;
            }

            int offset = (page - 1) * PAGE_SIZE;
            List<MatriculaConsultaDTO> lista = consultaDAO.consultarMatriculas(filtro, offset, PAGE_SIZE);
            if (lista == null) {
                lista = Collections.emptyList();
            }
            List<Curso> cursos = cursoDAO.listar();
            if (cursos == null) {
                cursos = Collections.emptyList();
            }

            request.setAttribute("listaMatriculas", lista);
            request.setAttribute("totalRegistros", total);
            request.setAttribute("paginaActual", page);
            request.setAttribute("totalPaginas", totalPages);
            request.setAttribute("tamPagina", PAGE_SIZE);
            request.setAttribute("filtro", filtro);
            request.setAttribute("filtroQuery", construirCadenaConsulta(filtro));
            request.setAttribute("listaCursos", cursos);

            request.getRequestDispatcher("consulta.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar la consulta.");
        }
    }

    private void exportarPdf(HttpServletResponse response, FiltroMatricula filtro) throws Exception {
        List<MatriculaConsultaDTO> datos = consultaDAO.consultarMatriculas(filtro, 0, EXPORT_MAX_ROWS);
        byte[] bytes = MatriculaPdfExport.generar(datos,
                "Reporte de matrículas — " + datos.size() + " registro(s)");
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"reporte_matriculas.pdf\"");
        response.setContentLength(bytes.length);
        try (OutputStream os = response.getOutputStream()) {
            os.write(bytes);
        }
    }

    private void exportarExcel(HttpServletResponse response, FiltroMatricula filtro) throws Exception {
        List<MatriculaConsultaDTO> datos = consultaDAO.consultarMatriculas(filtro, 0, EXPORT_MAX_ROWS);
        byte[] bytes = MatriculaExcelExport.generar(datos);
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"reporte_matriculas.xlsx\"");
        response.setContentLength(bytes.length);
        try (OutputStream os = response.getOutputStream()) {
            os.write(bytes);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private static FiltroMatricula construirFiltro(HttpServletRequest request) {
        FiltroMatricula f = new FiltroMatricula();
        String dni = request.getParameter("dni");
        f.setDni(dni != null ? dni.trim() : "");

        String texto = request.getParameter("textoAlumno");
        f.setTextoAlumno(texto != null ? texto.trim() : "");

        f.setIdCurso(parseInt(request.getParameter("idCurso"), 0));

        String estado = request.getParameter("estado");
        f.setEstado(estado != null ? estado.trim() : "");

        String fd = request.getParameter("fechaDesde");
        if (fd != null && !fd.isBlank()) {
            try {
                f.setFechaDesde(Date.valueOf(fd.trim()));
            } catch (IllegalArgumentException ignored) {
            }
        }
        String fh = request.getParameter("fechaHasta");
        if (fh != null && !fh.isBlank()) {
            try {
                f.setFechaHasta(Date.valueOf(fh.trim()));
            } catch (IllegalArgumentException ignored) {
            }
        }
        return f;
    }

    private static int parseInt(String s, int def) {
        if (s == null || s.isBlank()) {
            return def;
        }
        try {
            return Integer.parseInt(s.trim());
        } catch (NumberFormatException e) {
            return def;
        }
    }

    private static String construirCadenaConsulta(FiltroMatricula f) {
        try {
            String enc = StandardCharsets.UTF_8.name();
            StringBuilder sb = new StringBuilder();
            agregarParam(sb, "dni", f.getDni(), enc);
            agregarParam(sb, "textoAlumno", f.getTextoAlumno(), enc);
            if (f.getIdCurso() > 0) {
                if (!sb.isEmpty()) {
                    sb.append('&');
                }
                sb.append("idCurso=").append(f.getIdCurso());
            }
            agregarParam(sb, "estado", f.getEstado(), enc);
            if (f.getFechaDesde() != null) {
                if (!sb.isEmpty()) {
                    sb.append('&');
                }
                sb.append("fechaDesde=").append(URLEncoder.encode(f.getFechaDesde().toString(), enc));
            }
            if (f.getFechaHasta() != null) {
                if (!sb.isEmpty()) {
                    sb.append('&');
                }
                sb.append("fechaHasta=").append(URLEncoder.encode(f.getFechaHasta().toString(), enc));
            }
            return sb.toString();
        } catch (Exception e) {
            return "";
        }
    }

    private static void agregarParam(StringBuilder sb, String nombre, String valor, String enc) throws Exception {
        if (valor == null || valor.isEmpty()) {
            return;
        }
        if (!sb.isEmpty()) {
            sb.append('&');
        }
        sb.append(nombre).append('=').append(URLEncoder.encode(valor, enc));
    }
}
