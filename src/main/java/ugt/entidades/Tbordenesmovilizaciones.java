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
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
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
    @NamedQuery(name = "Tbordenesmovilizaciones.findAll", query = "SELECT t FROM Tbordenesmovilizaciones t")
    , @NamedQuery(name = "Tbordenesmovilizaciones.findByNumeroOrden", query = "SELECT t FROM Tbordenesmovilizaciones t WHERE t.numeroOrden = :numeroOrden")
    , @NamedQuery(name = "Tbordenesmovilizaciones.findByFechagenerar", query = "SELECT t FROM Tbordenesmovilizaciones t WHERE t.fechagenerar = :fechagenerar")
    , @NamedQuery(name = "Tbordenesmovilizaciones.findByIdpdf", query = "SELECT t FROM Tbordenesmovilizaciones t WHERE t.idpdf = :idpdf")
    , @NamedQuery(name = "Tbordenesmovilizaciones.findByKminicio", query = "SELECT t FROM Tbordenesmovilizaciones t WHERE t.kminicio = :kminicio")
    , @NamedQuery(name = "Tbordenesmovilizaciones.findByKmfin", query = "SELECT t FROM Tbordenesmovilizaciones t WHERE t.kmfin = :kmfin")})
public class Tbordenesmovilizaciones implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "numero_orden")
    private String numeroOrden;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fechagenerar")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechagenerar;
    @Column(name = "idpdf")
    private Integer idpdf;
    @Size(max = 50)
    @Column(name = "kminicio")
    private String kminicio;
    @Size(max = 50)
    @Column(name = "kmfin")
    private String kmfin;
    @JoinColumn(name = "solicitud", referencedColumnName = "numero")
    @ManyToOne(optional = false)
    private Tbsolicitudes solicitud;

    public Tbordenesmovilizaciones() {
    }

    public Tbordenesmovilizaciones(String numeroOrden) {
        this.numeroOrden = numeroOrden;
    }

    public Tbordenesmovilizaciones(String numeroOrden, Date fechagenerar) {
        this.numeroOrden = numeroOrden;
        this.fechagenerar = fechagenerar;
    }

    public String getNumeroOrden() {
        return numeroOrden;
    }

    public void setNumeroOrden(String numeroOrden) {
        this.numeroOrden = numeroOrden;
    }

    public Date getFechagenerar() {
        return fechagenerar;
    }

    public void setFechagenerar(Date fechagenerar) {
        this.fechagenerar = fechagenerar;
    }
    
    public Integer getIdpdf() {
        return idpdf;
    }

    public void setIdpdf(Integer idpdf) {
        this.idpdf = idpdf;
    }

    public String getKminicio() {
        return kminicio;
    }

    public void setKminicio(String kminicio) {
        this.kminicio = kminicio;
    }

    public String getKmfin() {
        return kmfin;
    }

    public void setKmfin(String kmfin) {
        this.kmfin = kmfin;
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
        hash += (numeroOrden != null ? numeroOrden.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbordenesmovilizaciones)) {
            return false;
        }
        Tbordenesmovilizaciones other = (Tbordenesmovilizaciones) object;
        if ((this.numeroOrden == null && other.numeroOrden != null) || (this.numeroOrden != null && !this.numeroOrden.equals(other.numeroOrden))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbordenesmovilizaciones[ numeroOrden=" + numeroOrden + " ]";
    }

}
