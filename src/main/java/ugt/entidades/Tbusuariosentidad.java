/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Xavy PC
 */
@Entity
@Table(schema = "esquemaugt")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tbusuariosentidad.findAll", query = "SELECT t FROM Tbusuariosentidad t")
    , @NamedQuery(name = "Tbusuariosentidad.findByIdentidad", query = "SELECT t FROM Tbusuariosentidad t WHERE t.tbusuariosentidadPK.identidad = :identidad")
    , @NamedQuery(name = "Tbusuariosentidad.findByCedulau", query = "SELECT t FROM Tbusuariosentidad t WHERE t.tbusuariosentidadPK.cedulau = :cedulau")
    , @NamedQuery(name = "Tbusuariosentidad.findByIdrol", query = "SELECT t FROM Tbusuariosentidad t WHERE t.tbusuariosentidadPK.idrol = :idrol")
    , @NamedQuery(name = "Tbusuariosentidad.findByFechainicio", query = "SELECT t FROM Tbusuariosentidad t WHERE t.fechainicio = :fechainicio")
    , @NamedQuery(name = "Tbusuariosentidad.findByFechafin", query = "SELECT t FROM Tbusuariosentidad t WHERE t.fechafin = :fechafin")})
public class Tbusuariosentidad implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected TbusuariosentidadPK tbusuariosentidadPK;
    @Column(name = "fechainicio")
    @Temporal(TemporalType.DATE)
    private Date fechainicio;
    @Column(name = "fechafin")
    @Temporal(TemporalType.DATE)
    private Date fechafin;
    @JoinColumn(name = "identidad", referencedColumnName = "identidad", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Tbentidad tbentidad;
    @JoinColumn(name = "idrol", referencedColumnName = "idrol", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Tbroles tbroles;
    @JoinColumn(name = "cedulau", referencedColumnName = "cedula", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Tbusuarios tbusuarios;

    public Tbusuariosentidad() {
    }

    public Tbusuariosentidad(TbusuariosentidadPK tbusuariosentidadPK) {
        this.tbusuariosentidadPK = tbusuariosentidadPK;
    }

    public Tbusuariosentidad(int identidad, String cedulau, int idrol) {
        this.tbusuariosentidadPK = new TbusuariosentidadPK(identidad, cedulau, idrol);
    }

    public TbusuariosentidadPK getTbusuariosentidadPK() {
        return tbusuariosentidadPK;
    }

    public void setTbusuariosentidadPK(TbusuariosentidadPK tbusuariosentidadPK) {
        this.tbusuariosentidadPK = tbusuariosentidadPK;
    }

    public Date getFechainicio() {
        return fechainicio;
    }

    public void setFechainicio(Date fechainicio) {
        this.fechainicio = fechainicio;
    }

    public Date getFechafin() {
        return fechafin;
    }

    public void setFechafin(Date fechafin) {
        this.fechafin = fechafin;
    }

    public Tbentidad getTbentidad() {
        return tbentidad;
    }

    public void setTbentidad(Tbentidad tbentidad) {
        this.tbentidad = tbentidad;
    }

    public Tbroles getTbroles() {
        return tbroles;
    }

    public void setTbroles(Tbroles tbroles) {
        this.tbroles = tbroles;
    }

    public Tbusuarios getTbusuarios() {
        return tbusuarios;
    }

    public void setTbusuarios(Tbusuarios tbusuarios) {
        this.tbusuarios = tbusuarios;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (tbusuariosentidadPK != null ? tbusuariosentidadPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbusuariosentidad)) {
            return false;
        }
        Tbusuariosentidad other = (Tbusuariosentidad) object;
        if ((this.tbusuariosentidadPK == null && other.tbusuariosentidadPK != null) || (this.tbusuariosentidadPK != null && !this.tbusuariosentidadPK.equals(other.tbusuariosentidadPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbusuariosentidad[ tbusuariosentidadPK=" + tbusuariosentidadPK + " ]";
    }
    
}
