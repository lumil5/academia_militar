package org.logistica.bean.entity;

import java.io.Serializable;

public class Curso implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idCurso;
    private String nombre;
    private String ciclo;
    private int creditos;
    private int horas;
    private Docente docente;
    private Salon salon;

    public Curso() {}

    public int getIdCurso() { return idCurso; }
    public void setIdCurso(int idCurso) { this.idCurso = idCurso; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCiclo() { return ciclo; }
    public void setCiclo(String ciclo) { this.ciclo = ciclo; }

    public int getCreditos() { return creditos; }
    public void setCreditos(int creditos) { this.creditos = creditos; }

    public int getHoras() { return horas; }
    public void setHoras(int horas) { this.horas = horas; }

    public Docente getDocente() { return docente; }
    public void setDocente(Docente docente) { this.docente = docente; }

    public Salon getSalon() { return salon; }
    public void setSalon(Salon salon) { this.salon = salon; }

}