/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author Xavy PC
 */
@Embeddable
public class TbusuariosentidadPK implements Serializable {

    @Basic(optional = false)
    @Column(name = "identidad")
    private int identidad;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "cedulau")
    private String cedulau;
    @Basic(optional = false)
    @NotNull
    @Column(name = "idrol")
    private int idrol;

    public TbusuariosentidadPK() {
    }

    public TbusuariosentidadPK(int identidad, String cedulau, int idrol) {
        this.identidad = identidad;
        this.cedulau = cedulau;
        this.idrol = idrol;
    }

    public int getIdentidad() {
        return identidad;
    }

    public void setIdentidad(int identidad) {
        this.identidad = identidad;
    }

    public String getCedulau() {
        return cedulau;
    }

    public void setCedulau(String cedulau) {
        this.cedulau = cedulau;
    }

    public int getIdrol() {
        return idrol;
    }

    public void setIdrol(int idrol) {
        this.idrol = idrol;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) identidad;
        hash += (cedulau != null ? cedulau.hashCode() : 0);
        hash += (int) idrol;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TbusuariosentidadPK)) {
            return false;
        }
        TbusuariosentidadPK other = (TbusuariosentidadPK) object;
        if (this.identidad != other.identidad) {
            return false;
        }
        if ((this.cedulau == null && other.cedulau != null) || (this.cedulau != null && !this.cedulau.equals(other.cedulau))) {
            return false;
        }
        if (this.idrol != other.idrol) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.TbusuariosentidadPK[ identidad=" + identidad + ", cedulau=" + cedulau + ", idrol=" + idrol + " ]";
    }
    
}
