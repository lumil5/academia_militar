package org.logistica.dao.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.logistica.bean.entity.Matricula;
import org.logistica.bean.entity.Retiro;
import org.logistica.dao.interfaces.RetiroDAO;
import org.logistica.util.ConectaDB;

public class PostgresRetiroDAO implements RetiroDAO {

    @Override
    public List<Retiro> listar() {

        List<Retiro> lista = new ArrayList<>();

        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "SELECT * FROM retiro";
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Retiro r = new Retiro();
                r.setIdRetiro(rs.getInt("id_retiro"));
                Matricula matricula = new Matricula();
                matricula.setIdMatricula(rs.getInt("id_matricula"));
                r.setMatricula(matricula);
                r.setFecha(rs.getDate("fecha"));
                r.setHora(rs.getTime("hora"));
                lista.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    @Override
    public int registrar(Retiro r) {

        int res = 0;

        try {
            Connection cn = ConectaDB.getConexion();
            String sql = "INSERT INTO retiro(id_matricula, fecha, hora) VALUES(?,?,?)";
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setInt(1, r.getMatricula().getIdMatricula());
            ps.setDate(2, r.getFecha());
            ps.setTime(3, r.getHora());

            res = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return res;
    }
}
