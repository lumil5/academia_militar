package org.logistica.dao.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.logistica.bean.entity.Curso;
import org.logistica.bean.entity.Docente;
import org.logistica.bean.entity.Salon;
import org.logistica.dao.interfaces.CursoDAO;
import org.logistica.util.ConectaDB;

public class PostgresCursoDAO implements CursoDAO {

    @Override
    public List<Curso> listar() {

        List<Curso> lista = new ArrayList<>();

        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "SELECT * FROM curso";
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Curso c = new Curso();
                c.setIdCurso(rs.getInt("id_curso"));
                c.setNombre(rs.getString("nombre"));
                c.setCiclo(rs.getString("ciclo"));
                c.setCreditos(rs.getInt("creditos"));
                c.setHoras(rs.getInt("horas"));
                Docente docente = new Docente();
                docente.setIdDocente(rs.getInt("id_docente"));
                c.setDocente(docente);
                Salon salon = new Salon();
                salon.setIdSalon(rs.getInt("id_salon"));
                c.setSalon(salon);
                lista.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    @Override
    public void registrar(Curso c) {
        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "INSERT INTO curso(nombre,ciclo,creditos,horas,id_docente,id_salon) VALUES(?,?,?,?,?,?)";
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, c.getNombre());
            ps.setString(2, c.getCiclo());
            ps.setInt(3, c.getCreditos());
            ps.setInt(4, c.getHoras());
            ps.setInt(5, c.getDocente().getIdDocente());
            ps.setInt(6, c.getSalon().getIdSalon());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void eliminar(int id) {
        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "DELETE FROM curso WHERE id_curso=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void actualizar(Curso c) {
        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "UPDATE curso SET nombre=?, ciclo=?, creditos=?, horas=?, id_docente=?, id_salon=? WHERE id_curso=?";
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, c.getNombre());
            ps.setString(2, c.getCiclo());
            ps.setInt(3, c.getCreditos());
            ps.setInt(4, c.getHoras());
            ps.setInt(5, c.getDocente().getIdDocente());
            ps.setInt(6, c.getSalon().getIdSalon());
            ps.setInt(7, c.getIdCurso());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Curso buscar(int id) {
        Curso c = null;

        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "SELECT * FROM curso WHERE id_curso=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                c = new Curso();
                c.setIdCurso(rs.getInt("id_curso"));
                c.setNombre(rs.getString("nombre"));
                c.setCiclo(rs.getString("ciclo"));
                c.setCreditos(rs.getInt("creditos"));
                c.setHoras(rs.getInt("horas"));
                Docente docente = new Docente();
                docente.setIdDocente(rs.getInt("id_docente"));
                c.setDocente(docente);
                Salon salon = new Salon();
                salon.setIdSalon(rs.getInt("id_salon"));
                c.setSalon(salon);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }
}