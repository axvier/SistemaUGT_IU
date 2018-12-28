/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Xavy PC
 */
@Entity
@Table(schema = "esquemaugt")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tbviajepasajero.findAll", query = "SELECT t FROM Tbviajepasajero t")
    , @NamedQuery(name = "Tbviajepasajero.findByIdviaje", query = "SELECT t FROM Tbviajepasajero t WHERE t.tbviajepasajeroPK.idviaje = :idviaje")
    , @NamedQuery(name = "Tbviajepasajero.findByCedulap", query = "SELECT t FROM Tbviajepasajero t WHERE t.tbviajepasajeroPK.cedulap = :cedulap")
    , @NamedQuery(name = "Tbviajepasajero.findByTipo", query = "SELECT t FROM Tbviajepasajero t WHERE t.tipo = :tipo")})
public class Tbviajepasajero implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected TbviajepasajeroPK tbviajepasajeroPK;
    @Size(max = 15)
    @Column(name = "tipo")
    private String tipo;
    @JoinColumn(name = "cedulap", referencedColumnName = "cedula", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Tbpasajeros tbpasajeros;
    @JoinColumn(name = "idviaje", referencedColumnName = "idviaje", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Tbseccionviajes tbseccionviajes;

    public Tbviajepasajero() {
    }

    public Tbviajepasajero(TbviajepasajeroPK tbviajepasajeroPK) {
        this.tbviajepasajeroPK = tbviajepasajeroPK;
    }

    public Tbviajepasajero(int idviaje, String cedulap) {
        this.tbviajepasajeroPK = new TbviajepasajeroPK(idviaje, cedulap);
    }

    public TbviajepasajeroPK getTbviajepasajeroPK() {
        return tbviajepasajeroPK;
    }

    public void setTbviajepasajeroPK(TbviajepasajeroPK tbviajepasajeroPK) {
        this.tbviajepasajeroPK = tbviajepasajeroPK;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Tbpasajeros getTbpasajeros() {
        return tbpasajeros;
    }

    public void setTbpasajeros(Tbpasajeros tbpasajeros) {
        this.tbpasajeros = tbpasajeros;
    }

    public Tbseccionviajes getTbseccionviajes() {
        return tbseccionviajes;
    }

    public void setTbseccionviajes(Tbseccionviajes tbseccionviajes) {
        this.tbseccionviajes = tbseccionviajes;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (tbviajepasajeroPK != null ? tbviajepasajeroPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbviajepasajero)) {
            return false;
        }
        Tbviajepasajero other = (Tbviajepasajero) object;
        if ((this.tbviajepasajeroPK == null && other.tbviajepasajeroPK != null) || (this.tbviajepasajeroPK != null && !this.tbviajepasajeroPK.equals(other.tbviajepasajeroPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbviajepasajero[ tbviajepasajeroPK=" + tbviajepasajeroPK + " ]";
    }
    
}
