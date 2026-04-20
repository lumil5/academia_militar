package org.logistica.dao.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.logistica.bean.entity.Usuario;
import org.logistica.dao.interfaces.UsuarioDAO;
import org.logistica.util.ConectaDB;

public class PostgresUsuarioDAO implements UsuarioDAO {

    @Override
    public Usuario login(String username, String password) {

        Usuario u = null;

        try {
            Connection cn = ConectaDB.getConexion();

            String sql = "SELECT * FROM usuario WHERE username=? AND password=?";
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setRol(rs.getString("rol"));
            }

            rs.close();
            ps.close();
            cn.close();

        } catch (Exception e) {
            System.out.println("❌ Error en login");
            e.printStackTrace();
        }

        return u;
    }
}