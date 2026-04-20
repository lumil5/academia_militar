package org.logistica.bean.entity;

import java.sql.Date;
import java.sql.Time;

import java.io.Serializable;

public class Retiro implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idRetiro;
    private Matricula matricula;
    private Date fecha;
    private Time hora;

    public Retiro() {}

    public int getIdRetiro() { return idRetiro; }
    public void setIdRetiro(int idRetiro) { this.idRetiro = idRetiro; }

    public Matricula getMatricula() { return matricula; }
    public void setMatricula(Matricula matricula) { this.matricula = matricula; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public Time getHora() { return hora; }
    public void setHora(Time hora) { this.hora = hora; }
}