package org.logistica.dao.interfaces;

import java.util.List;
import org.logistica.bean.entity.Alumno;

public interface AlumnoDAO {

    List<Alumno> listar();
    void registrar(Alumno a);
    void actualizar(Alumno a);
    void eliminar(int id);
    Alumno buscar(int id);
}
