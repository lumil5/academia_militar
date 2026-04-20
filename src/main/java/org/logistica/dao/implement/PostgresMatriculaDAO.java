package org.logistica.dao.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.logistica.bean.entity.Alumno;
import org.logistica.bean.entity.Curso;
import org.logistica.bean.entity.Matricula;
import org.logistica.dao.interfaces.MatriculaDAO;
import org.logistica.util.ConectaDB;

public class PostgresMatriculaDAO implements MatriculaDAO {

    @Override
    public List<Matricula> listar() {

        List<Matricula> lista = new ArrayList<>();

        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "SELECT * FROM matricula";
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Matricula m = new Matricula();
                m.setIdMatricula(rs.getInt("id_matricula"));
                Alumno alumno = new Alumno();
                alumno.setIdAlumno(rs.getInt("id_alumno"));
                m.setAlumno(alumno);
                Curso curso = new Curso();
                curso.setIdCurso(rs.getInt("id_curso"));
                m.setCurso(curso);
                m.setFecha(rs.getDate("fecha"));
                m.setEstado(rs.getString("estado"));
                lista.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    @Override
    public void registrar(Matricula m) {

        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "INSERT INTO matricula(id_alumno,id_curso,fecha,estado) VALUES(?,?,?,?)";

            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setInt(1, m.getAlumno().getIdAlumno());
            ps.setInt(2, m.getCurso().getIdCurso());
            ps.setDate(3, m.getFecha());
            ps.setString(4, m.getEstado());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void eliminar(int id) {
        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "DELETE FROM matricula WHERE id_matricula=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}