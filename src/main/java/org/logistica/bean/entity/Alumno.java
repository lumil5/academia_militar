package org.logistica.bean.entity;

import java.io.Serializable;

public class Alumno implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idAlumno;
    private String nombres;
    private String apellidos;
    private String dni;
    private int edad;
    private String celular;
    private String estado;

    public Alumno() {}

    public Alumno(int idAlumno, String nombres, String apellidos, String dni, int edad, String celular, String estado) {
        this.idAlumno = idAlumno;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.dni = dni;
        this.edad = edad;
        this.celular = celular;
        this.estado = estado;
    }

    public int getIdAlumno() { return idAlumno; }
    public void setIdAlumno(int idAlumno) { this.idAlumno = idAlumno; }

    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }

    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }

    public String getDni() { return dni; }
    public void setDni(String dni) { this.dni = dni; }

    public int getEdad() { return edad; }
    public void setEdad(int edad) { this.edad = edad; }

    public String getCelular() { return celular; }
    public void setCelular(String celular) { this.celular = celular; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}