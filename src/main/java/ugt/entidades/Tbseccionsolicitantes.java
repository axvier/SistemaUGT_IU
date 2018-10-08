/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
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
    @NamedQuery(name = "Tbseccionsolicitantes.findAll", query = "SELECT t FROM Tbseccionsolicitantes t")
    , @NamedQuery(name = "Tbseccionsolicitantes.findByIdsolicitante", query = "SELECT t FROM Tbseccionsolicitantes t WHERE t.idsolicitante = :idsolicitante")
    , @NamedQuery(name = "Tbseccionsolicitantes.findByExtension", query = "SELECT t FROM Tbseccionsolicitantes t WHERE t.extension = :extension")})
public class Tbseccionsolicitantes implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idsolicitante")
    private Integer idsolicitante;
    @Size(max = 25)
    @Column(name = "extension")
    private String extension;
    @JoinColumn(name = "solicitud", referencedColumnName = "numero")
    @ManyToOne
    private Tbsolicitudes solicitud;
    @JoinColumn(name = "cedulau", referencedColumnName = "cedula")
    @ManyToOne(optional = false)
    private Tbusuarios cedulau;

    public Tbseccionsolicitantes() {
    }

    public Tbseccionsolicitantes(Integer idsolicitante) {
        this.idsolicitante = idsolicitante;
    }

    public Integer getIdsolicitante() {
        return idsolicitante;
    }

    public void setIdsolicitante(Integer idsolicitante) {
        this.idsolicitante = idsolicitante;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public Tbsolicitudes getSolicitud() {
        return solicitud;
    }

    public void setSolicitud(Tbsolicitudes solicitud) {
        this.solicitud = solicitud;
    }

    public Tbusuarios getCedulau() {
        return cedulau;
    }

    public void setCedulau(Tbusuarios cedulau) {
        this.cedulau = cedulau;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idsolicitante != null ? idsolicitante.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbseccionsolicitantes)) {
            return false;
        }
        Tbseccionsolicitantes other = (Tbseccionsolicitantes) object;
        if ((this.idsolicitante == null && other.idsolicitante != null) || (this.idsolicitante != null && !this.idsolicitante.equals(other.idsolicitante))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbseccionsolicitantes[ idsolicitante=" + idsolicitante + " ]";
    }
    
}
