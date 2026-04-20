package org.logistica.bean.dto;

import java.io.Serializable;
import java.sql.Date;

/**
 * Fila enriquecida para consultas y exportación (matrícula + alumno + curso).
 */
public class MatriculaConsultaDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private int idMatricula;
    private Date fechaMatricula;
    private String estadoMatricula;

    private int idAlumno;
    private String dniAlumno;
    private String nombresAlumno;
    private String apellidosAlumno;

    private int idCurso;
    private String nombreCurso;
    private String cicloCurso;

    public int getIdMatricula() {
        return idMatricula;
    }

    public void setIdMatricula(int idMatricula) {
        this.idMatricula = idMatricula;
    }

    public Date getFechaMatricula() {
        return fechaMatricula;
    }

    public void setFechaMatricula(Date fechaMatricula) {
        this.fechaMatricula = fechaMatricula;
    }

    public String getEstadoMatricula() {
        return estadoMatricula;
    }

    public void setEstadoMatricula(String estadoMatricula) {
        this.estadoMatricula = estadoMatricula;
    }

    public int getIdAlumno() {
        return idAlumno;
    }

    public void setIdAlumno(int idAlumno) {
        this.idAlumno = idAlumno;
    }

    public String getDniAlumno() {
        return dniAlumno;
    }

    public void setDniAlumno(String dniAlumno) {
        this.dniAlumno = dniAlumno;
    }

    public String getNombresAlumno() {
        return nombresAlumno;
    }

    public void setNombresAlumno(String nombresAlumno) {
        this.nombresAlumno = nombresAlumno;
    }

    public String getApellidosAlumno() {
        return apellidosAlumno;
    }

    public void setApellidosAlumno(String apellidosAlumno) {
        this.apellidosAlumno = apellidosAlumno;
    }

    public int getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
    }

    public String getNombreCurso() {
        return nombreCurso;
    }

    public void setNombreCurso(String nombreCurso) {
        this.nombreCurso = nombreCurso;
    }

    public String getCicloCurso() {
        return cicloCurso;
    }

    public void setCicloCurso(String cicloCurso) {
        this.cicloCurso = cicloCurso;
    }

    public String getNombreCompletoAlumno() {
        String n = nombresAlumno != null ? nombresAlumno : "";
        String a = apellidosAlumno != null ? apellidosAlumno : "";
        return (n + " " + a).trim();
    }
}
