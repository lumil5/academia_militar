package org.logistica.dao.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.logistica.bean.entity.Alumno;
import org.logistica.dao.interfaces.AlumnoDAO;
import org.logistica.util.ConectaDB;

public class PostgresAlumnoDAO implements AlumnoDAO {

    @Override
    public List<Alumno> listar() {
        List<Alumno> lista = new ArrayList<>();

        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "SELECT * FROM alumno";

            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Alumno a = new Alumno();
                a.setIdAlumno(rs.getInt("id_alumno"));
                a.setNombres(rs.getString("nombres"));
                a.setApellidos(rs.getString("apellidos"));
                a.setDni(rs.getString("dni"));
                a.setEdad(rs.getInt("edad"));
                a.setCelular(rs.getString("celular"));
                a.setEstado(rs.getString("estado"));

                lista.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    @Override
    public void registrar(Alumno a) {
        try {
            Connection cn = ConectaDB.getConexion();

            String sql = "INSERT INTO alumno(nombres, apellidos, dni, edad, celular, estado) VALUES (?,?,?,?,?,?)";
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, a.getNombres());
            ps.setString(2, a.getApellidos());
            ps.setString(3, a.getDni());
            ps.setInt(4, a.getEdad());
            ps.setString(5, a.getCelular());
            ps.setString(6, a.getEstado());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void actualizar(Alumno a) {
        try {
            Connection cn = ConectaDB.getConexion();

            String sql = "UPDATE alumno SET nombres=?, apellidos=?, dni=?, edad=?, celular=?, estado=? WHERE id_alumno=?";
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, a.getNombres());
            ps.setString(2, a.getApellidos());
            ps.setString(3, a.getDni());
            ps.setInt(4, a.getEdad());
            ps.setString(5, a.getCelular());
            ps.setString(6, a.getEstado());
            ps.setInt(7, a.getIdAlumno());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void eliminar(int id) {
        try {
            Connection cn = ConectaDB.getConexion();

            String sql = "DELETE FROM alumno WHERE id_alumno=?";
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Alumno buscar(int id) {
        Alumno a = null;

        try {
            Connection cn = ConectaDB.getConexion();

            String sql = "SELECT * FROM alumno WHERE id_alumno=?";
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                a = new Alumno();
                a.setIdAlumno(rs.getInt("id_alumno"));
                a.setNombres(rs.getString("nombres"));
                a.setApellidos(rs.getString("apellidos"));
                a.setDni(rs.getString("dni"));
                a.setEdad(rs.getInt("edad"));
                a.setCelular(rs.getString("celular"));
                a.setEstado(rs.getString("estado"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return a;
    }
}
