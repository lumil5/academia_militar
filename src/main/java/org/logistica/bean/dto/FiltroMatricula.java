package org.logistica.bean.dto;

import java.io.Serializable;
import java.sql.Date;

/**
 * Criterios de filtro para consultas de matrículas.
 */
public class FiltroMatricula implements Serializable {

    private static final long serialVersionUID = 1L;

    private String dni = "";
    private String textoAlumno = "";
    private int idCurso;
    private String estado = "";
    private Date fechaDesde;
    private Date fechaHasta;

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni != null ? dni : "";
    }

    public String getTextoAlumno() {
        return textoAlumno;
    }

    public void setTextoAlumno(String textoAlumno) {
        this.textoAlumno = textoAlumno != null ? textoAlumno : "";
    }

    public int getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado != null ? estado : "";
    }

    public Date getFechaDesde() {
        return fechaDesde;
    }

    public void setFechaDesde(Date fechaDesde) {
        this.fechaDesde = fechaDesde;
    }

    public Date getFechaHasta() {
        return fechaHasta;
    }

    public void setFechaHasta(Date fechaHasta) {
        this.fechaHasta = fechaHasta;
    }

    /** Valor para inputs type="date" en la vista (yyyy-MM-dd). */
    public String getFechaDesdeInput() {
        return fechaDesde != null ? fechaDesde.toString() : "";
    }

    public String getFechaHastaInput() {
        return fechaHasta != null ? fechaHasta.toString() : "";
    }
}
