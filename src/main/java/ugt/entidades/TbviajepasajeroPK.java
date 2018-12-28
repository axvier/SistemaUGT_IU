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
public class TbviajepasajeroPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "idviaje")
    private int idviaje;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "cedulap")
    private String cedulap;

    public TbviajepasajeroPK() {
    }

    public TbviajepasajeroPK(int idviaje, String cedulap) {
        this.idviaje = idviaje;
        this.cedulap = cedulap;
    }

    public int getIdviaje() {
        return idviaje;
    }

    public void setIdviaje(int idviaje) {
        this.idviaje = idviaje;
    }

    public String getCedulap() {
        return cedulap;
    }

    public void setCedulap(String cedulap) {
        this.cedulap = cedulap;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idviaje;
        hash += (cedulap != null ? cedulap.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TbviajepasajeroPK)) {
            return false;
        }
        TbviajepasajeroPK other = (TbviajepasajeroPK) object;
        if (this.idviaje != other.idviaje) {
            return false;
        }
        if ((this.cedulap == null && other.cedulap != null) || (this.cedulap != null && !this.cedulap.equals(other.cedulap))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.TbviajepasajeroPK[ idviaje=" + idviaje + ", cedulap=" + cedulap + " ]";
    }
    
}
