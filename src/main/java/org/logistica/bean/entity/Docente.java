package org.logistica.bean.entity;

import java.io.Serializable;

public class Docente implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idDocente;
    private String nombres;
    private String apellidos;
    private String dni;
    private String especialidad;
    private String celular;
    private String estado;

    public Docente() {}

    public Docente(int idDocente, String nombres, String apellidos, String dni, String especialidad, String celular, String estado) {
        this.idDocente = idDocente;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.dni = dni;
        this.especialidad = especialidad;
        this.celular = celular;
        this.estado = estado;
    }

    public int getIdDocente() { return idDocente; }
    public void setIdDocente(int idDocente) { this.idDocente = idDocente; }

    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }

    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }

    public String getDni() { return dni; }
    public void setDni(String dni) { this.dni = dni; }

    public String getEspecialidad() { return especialidad; }
    public void setEspecialidad(String especialidad) { this.especialidad = especialidad; }

    public String getCelular() { return celular; }
    public void setCelular(String celular) { this.celular = celular; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}