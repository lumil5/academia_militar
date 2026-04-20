package org.logistica.dao.interfaces;

import java.util.List;
import org.logistica.bean.entity.Curso;

public interface CursoDAO {

    List<Curso> listar();
    void registrar(Curso c);
    void actualizar(Curso c);
    void eliminar(int id);
    Curso buscar(int id);
}
