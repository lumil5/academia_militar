package org.logistica.bean.entity;

import java.sql.Date;

import java.io.Serializable;

public class Matricula implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idMatricula;
    private Alumno alumno;
    private Curso curso;
    private Date fecha;
    private String estado;

    public int getIdMatricula() { return idMatricula; }
    public void setIdMatricula(int idMatricula) { this.idMatricula = idMatricula; }

    public Alumno getAlumno() { return alumno; }
    public void setAlumno(Alumno alumno) { this.alumno = alumno; }

    public Curso getCurso() { return curso; }
    public void setCurso(Curso curso) { this.curso = curso; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}