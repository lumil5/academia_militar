package org.logistica.dao.interfaces;

import java.util.List;
import org.logistica.bean.entity.Matricula;

public interface MatriculaDAO {

    List<Matricula> listar();
    void registrar(Matricula m);
    void eliminar(int id);
}