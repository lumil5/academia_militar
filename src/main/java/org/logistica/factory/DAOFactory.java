package org.logistica.factory;

import org.logistica.dao.interfaces.UsuarioDAO;
import org.logistica.dao.interfaces.AlumnoDAO;
import org.logistica.dao.interfaces.ConsultaDAO;
import org.logistica.dao.interfaces.CursoDAO;
import org.logistica.dao.interfaces.DocenteDAO;
import org.logistica.dao.interfaces.MatriculaDAO;
import org.logistica.dao.interfaces.RetiroDAO;
import org.logistica.dao.implement.PostgresUsuarioDAO;
import org.logistica.dao.implement.PostgresAlumnoDAO;
import org.logistica.dao.implement.PostgresConsultaDAO;
import org.logistica.dao.implement.PostgresCursoDAO;
import org.logistica.dao.implement.PostgresDocenteDAO;
import org.logistica.dao.implement.PostgresMatriculaDAO;
import org.logistica.dao.implement.PostgresRetiroDAO;

public class DAOFactory {

    public static UsuarioDAO getUsuarioDAO() {
        return new PostgresUsuarioDAO();
    }

    public static AlumnoDAO getAlumnoDAO() {
        return new PostgresAlumnoDAO();
    }

    public static CursoDAO getCursoDAO() {
        return new PostgresCursoDAO();
    }

    public static MatriculaDAO getMatriculaDAO() {
        return new PostgresMatriculaDAO();
    }

    public static RetiroDAO getRetiroDAO() {
        return new PostgresRetiroDAO();
    }

    public static ConsultaDAO getConsultaDAO() {
        return new PostgresConsultaDAO();
    }

    public static DocenteDAO getDocenteDAO() {
        return new PostgresDocenteDAO();
    }
}
