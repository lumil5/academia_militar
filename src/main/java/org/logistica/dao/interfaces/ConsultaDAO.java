package org.logistica.dao.interfaces;

import java.util.List;

import org.logistica.bean.dto.FiltroMatricula;
import org.logistica.bean.dto.MatriculaConsultaDTO;

public interface ConsultaDAO {

    List<MatriculaConsultaDTO> consultarMatriculas(FiltroMatricula filtro, int offset, int limite);

    long contarMatriculas(FiltroMatricula filtro);
}
