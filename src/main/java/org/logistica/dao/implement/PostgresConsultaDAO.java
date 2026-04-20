package org.logistica.dao.implement;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.logistica.bean.dto.FiltroMatricula;
import org.logistica.bean.dto.MatriculaConsultaDTO;
import org.logistica.dao.interfaces.ConsultaDAO;
import org.logistica.util.ConectaDB;

public class PostgresConsultaDAO implements ConsultaDAO {

    private static final String BASE_FROM = """
            FROM matricula m
            INNER JOIN alumno a ON m.id_alumno = a.id_alumno
            INNER JOIN curso c ON m.id_curso = c.id_curso
            """;

    @Override
    public List<MatriculaConsultaDTO> consultarMatriculas(FiltroMatricula filtro, int offset, int limite) {

        List<MatriculaConsultaDTO> lista = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("""
                SELECT m.id_matricula, m.fecha, m.estado,
                       a.id_alumno, a.dni, a.nombres, a.apellidos,
                       c.id_curso, c.nombre, c.ciclo
                """);
        sql.append(BASE_FROM);
        sql.append(" WHERE 1=1 ");
        List<Object> params = new ArrayList<>();
        appendFiltros(sql, params, filtro);
        sql.append(" ORDER BY m.fecha DESC, m.id_matricula DESC ");
        sql.append(" LIMIT ? OFFSET ? ");
        params.add(Math.max(1, limite));
        params.add(Math.max(0, offset));

        try {
            Connection cn = ConectaDB.getConexion();
            PreparedStatement ps = cn.prepareStatement(sql.toString());
            bindParams(ps, params);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    @Override
    public long contarMatriculas(FiltroMatricula filtro) {

        StringBuilder sql = new StringBuilder("SELECT COUNT(*) ");
        sql.append(BASE_FROM);
        sql.append(" WHERE 1=1 ");
        List<Object> params = new ArrayList<>();
        appendFiltros(sql, params, filtro);

        try {
            Connection cn = ConectaDB.getConexion();
            PreparedStatement ps = cn.prepareStatement(sql.toString());
            bindParams(ps, params);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0L;
    }

    private void appendFiltros(StringBuilder sql, List<Object> params, FiltroMatricula f) {

        if (f.getDni() != null && !f.getDni().trim().isEmpty()) {
            sql.append(" AND a.dni ILIKE ? ");
            params.add("%" + f.getDni().trim() + "%");
        }

        if (f.getTextoAlumno() != null && !f.getTextoAlumno().trim().isEmpty()) {
            sql.append(" AND (a.nombres ILIKE ? OR a.apellidos ILIKE ? OR (a.nombres || ' ' || a.apellidos) ILIKE ?) ");
            String p = "%" + f.getTextoAlumno().trim() + "%";
            params.add(p);
            params.add(p);
            params.add(p);
        }

        if (f.getIdCurso() > 0) {
            sql.append(" AND c.id_curso = ? ");
            params.add(f.getIdCurso());
        }

        if (f.getEstado() != null && !f.getEstado().trim().isEmpty()) {
            sql.append(" AND m.estado = ? ");
            params.add(f.getEstado().trim());
        }

        if (f.getFechaDesde() != null) {
            sql.append(" AND m.fecha >= ? ");
            params.add(f.getFechaDesde());
        }

        if (f.getFechaHasta() != null) {
            sql.append(" AND m.fecha <= ? ");
            params.add(f.getFechaHasta());
        }
    }

    private void bindParams(PreparedStatement ps, List<Object> params) throws Exception {
        int i = 1;
        for (Object o : params) {
            if (o instanceof String s) {
                ps.setString(i++, s);
            } else if (o instanceof Integer n) {
                ps.setInt(i++, n);
            } else if (o instanceof Long l) {
                ps.setLong(i++, l);
            } else if (o instanceof Date d) {
                ps.setDate(i++, d);
            } else {
                ps.setObject(i++, o);
            }
        }
    }

    private static MatriculaConsultaDTO mapear(ResultSet rs) throws Exception {
        MatriculaConsultaDTO row = new MatriculaConsultaDTO();
        row.setIdMatricula(rs.getInt("id_matricula"));
        row.setFechaMatricula(rs.getDate("fecha"));
        row.setEstadoMatricula(rs.getString("estado"));
        row.setIdAlumno(rs.getInt("id_alumno"));
        row.setDniAlumno(rs.getString("dni"));
        row.setNombresAlumno(rs.getString("nombres"));
        row.setApellidosAlumno(rs.getString("apellidos"));
        row.setIdCurso(rs.getInt("id_curso"));
        row.setNombreCurso(rs.getString("nombre"));
        row.setCicloCurso(rs.getString("ciclo"));
        return row;
    }
}
