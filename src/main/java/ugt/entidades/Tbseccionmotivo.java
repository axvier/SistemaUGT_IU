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
import javax.validation.constraints.NotNull;
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
    @NamedQuery(name = "Tbseccionmotivo.findAll", query = "SELECT t FROM Tbseccionmotivo t")
    , @NamedQuery(name = "Tbseccionmotivo.findByIdmotivo", query = "SELECT t FROM Tbseccionmotivo t WHERE t.idmotivo = :idmotivo")
    , @NamedQuery(name = "Tbseccionmotivo.findByDescripcion", query = "SELECT t FROM Tbseccionmotivo t WHERE t.descripcion = :descripcion")})
public class Tbseccionmotivo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idmotivo")
    private Integer idmotivo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "descripcion")
    private String descripcion;
    @JoinColumn(name = "solicitud", referencedColumnName = "numero")
    @ManyToOne(optional = false)
    private Tbsolicitudes solicitud;

    public Tbseccionmotivo() {
    }

    public Tbseccionmotivo(Integer idmotivo) {
        this.idmotivo = idmotivo;
    }

    public Tbseccionmotivo(Integer idmotivo, String descripcion) {
        this.idmotivo = idmotivo;
        this.descripcion = descripcion;
    }

    public Integer getIdmotivo() {
        return idmotivo;
    }

    public void setIdmotivo(Integer idmotivo) {
        this.idmotivo = idmotivo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Tbsolicitudes getSolicitud() {
        return solicitud;
    }

    public void setSolicitud(Tbsolicitudes solicitud) {
        this.solicitud = solicitud;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idmotivo != null ? idmotivo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbseccionmotivo)) {
            return false;
        }
        Tbseccionmotivo other = (Tbseccionmotivo) object;
        if ((this.idmotivo == null && other.idmotivo != null) || (this.idmotivo != null && !this.idmotivo.equals(other.idmotivo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbseccionmotivo[ idmotivo=" + idmotivo + " ]";
    }
    
}
