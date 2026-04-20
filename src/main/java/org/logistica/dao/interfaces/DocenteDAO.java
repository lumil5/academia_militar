package org.logistica.dao.interfaces;

import java.util.List;
import org.logistica.bean.entity.Docente;

public interface DocenteDAO {
    List<Docente> listar();
    void registrar(Docente d);
    void actualizar(Docente d);
    void eliminar(int id);
    Docente buscar(int id);
}
