package org.logistica.dao.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.logistica.bean.entity.Docente;
import org.logistica.dao.interfaces.DocenteDAO;
import org.logistica.util.ConectaDB;

public class PostgresDocenteDAO implements DocenteDAO {

    @Override
    public List<Docente> listar() {
        List<Docente> lista = new ArrayList<>();

        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "SELECT * FROM docente";
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Docente d = new Docente();
                d.setIdDocente(rs.getInt("id_docente"));
                d.setNombres(rs.getString("nombres"));
                d.setApellidos(rs.getString("apellidos"));
                d.setDni(rs.getString("dni"));
                d.setEspecialidad(rs.getString("especialidad"));
                d.setCelular(rs.getString("celular"));
                d.setEstado(rs.getString("estado"));
                lista.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public void registrar(Docente d) {
        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "INSERT INTO docente(nombres, apellidos, dni, especialidad, celular, estado) VALUES (?,?,?,?,?,?)";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, d.getNombres());
            ps.setString(2, d.getApellidos());
            ps.setString(3, d.getDni());
            ps.setString(4, d.getEspecialidad());
            ps.setString(5, d.getCelular());
            ps.setString(6, d.getEstado());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void actualizar(Docente d) {
        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "UPDATE docente SET nombres=?, apellidos=?, dni=?, especialidad=?, celular=?, estado=? WHERE id_docente=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, d.getNombres());
            ps.setString(2, d.getApellidos());
            ps.setString(3, d.getDni());
            ps.setString(4, d.getEspecialidad());
            ps.setString(5, d.getCelular());
            ps.setString(6, d.getEstado());
            ps.setInt(7, d.getIdDocente());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void eliminar(int id) {
        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "DELETE FROM docente WHERE id_docente=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Docente buscar(int id) {
        Docente d = null;
        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "SELECT * FROM docente WHERE id_docente=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                d = new Docente();
                d.setIdDocente(rs.getInt("id_docente"));
                d.setNombres(rs.getString("nombres"));
                d.setApellidos(rs.getString("apellidos"));
                d.setDni(rs.getString("dni"));
                d.setEspecialidad(rs.getString("especialidad"));
                d.setCelular(rs.getString("celular"));
                d.setEstado(rs.getString("estado"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }
}
