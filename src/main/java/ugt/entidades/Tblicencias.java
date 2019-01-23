/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Xavy PC
 */
@Entity
@Table(schema = "esquemaugt")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tblicencias.findAll", query = "SELECT t FROM Tblicencias t")
    , @NamedQuery(name = "Tblicencias.findByTipo", query = "SELECT t FROM Tblicencias t WHERE t.tipo = :tipo")
    , @NamedQuery(name = "Tblicencias.findByFechaexpedicion", query = "SELECT t FROM Tblicencias t WHERE t.fechaexpedicion = :fechaexpedicion")
    , @NamedQuery(name = "Tblicencias.findByFechaexpiracion", query = "SELECT t FROM Tblicencias t WHERE t.fechaexpiracion = :fechaexpiracion")
    , @NamedQuery(name = "Tblicencias.findByPuntos", query = "SELECT t FROM Tblicencias t WHERE t.puntos = :puntos")
    , @NamedQuery(name = "Tblicencias.findByIdlicencia", query = "SELECT t FROM Tblicencias t WHERE t.idlicencia = :idlicencia")})
public class Tblicencias implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @NotNull
    @Column(name = "tipo")
    private Character tipo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fechaexpedicion")
    @Temporal(TemporalType.DATE)
    private Date fechaexpedicion;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fechaexpiracion")
    @Temporal(TemporalType.DATE)
    private Date fechaexpiracion;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idlicencia")
    private Integer idlicencia;
    @JoinColumn(name = "cedulac", referencedColumnName = "cedula")
    @ManyToOne(optional = false)
    private Tbconductores cedulac;
    @Basic(optional = false)
    @Column(name = "puntos")
    private Integer puntos;

    public Tblicencias() {
    }

    public Tblicencias(Integer idlicencia) {
        this.idlicencia = idlicencia;
    }

    public Tblicencias(Integer idlicencia, Character tipo, Date fechaexpedicion, Date fechaexpiracion) {
        this.idlicencia = idlicencia;
        this.tipo = tipo;
        this.fechaexpedicion = fechaexpedicion;
        this.fechaexpiracion = fechaexpiracion;
    }

    public Character getTipo() {
        return tipo;
    }

    public void setTipo(Character tipo) {
        this.tipo = tipo;
    }

    public Date getFechaexpedicion() {
        return fechaexpedicion;
    }

    public void setFechaexpedicion(Date fechaexpedicion) {
        this.fechaexpedicion = fechaexpedicion;
    }

    public Date getFechaexpiracion() {
        return fechaexpiracion;
    }

    public void setFechaexpiracion(Date fechaexpiracion) {
        this.fechaexpiracion = fechaexpiracion;
    }

    public Integer getIdlicencia() {
        return idlicencia;
    }

    public void setIdlicencia(Integer idlicencia) {
        this.idlicencia = idlicencia;
    }

    public Tbconductores getCedulac() {
        return cedulac;
    }

    public void setCedulac(Tbconductores cedulac) {
        this.cedulac = cedulac;
    }

    public Integer getPuntos() {
        return puntos;
    }

    public void setPuntos(Integer puntos) {
        this.puntos = puntos;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idlicencia != null ? idlicencia.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tblicencias)) {
            return false;
        }
        Tblicencias other = (Tblicencias) object;
        if ((this.idlicencia == null && other.idlicencia != null) || (this.idlicencia != null && !this.idlicencia.equals(other.idlicencia))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tblicencias[ idlicencia=" + idlicencia + " ]";
    }
    
}
