package org.logistica.bean.entity;

import java.io.Serializable;

public class Salon implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idSalon;
    private String nombre;
    private int capacidad;
    private String ubicacion;
    private String estado;

    public Salon() {}

    public Salon(int idSalon, String nombre, int capacidad, String ubicacion, String estado) {
        this.idSalon = idSalon;
        this.nombre = nombre;
        this.capacidad = capacidad;
        this.ubicacion = ubicacion;
        this.estado = estado;
    }

    public int getIdSalon() { return idSalon; }
    public void setIdSalon(int idSalon) { this.idSalon = idSalon; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public int getCapacidad() { return capacidad; }
    public void setCapacidad(int capacidad) { this.capacidad = capacidad; }

    public String getUbicacion() { return ubicacion; }
    public void setUbicacion(String ubicacion) { this.ubicacion = ubicacion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
