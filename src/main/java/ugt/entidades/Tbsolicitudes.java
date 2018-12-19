/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Xavy PC
 */
@Entity
@Table(schema = "esquemaugt")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tbsolicitudes.findAll", query = "SELECT t FROM Tbsolicitudes t")
    , @NamedQuery(name = "Tbsolicitudes.findByEstado", query = "SELECT t FROM Tbsolicitudes t WHERE t.estado = :estado")
    , @NamedQuery(name = "Tbsolicitudes.findByFecha", query = "SELECT t FROM Tbsolicitudes t WHERE t.fecha = :fecha")
    , @NamedQuery(name = "Tbsolicitudes.findByObservacion", query = "SELECT t FROM Tbsolicitudes t WHERE t.observacion = :observacion")
    , @NamedQuery(name = "Tbsolicitudes.findByIdpdf", query = "SELECT t FROM Tbsolicitudes t WHERE t.idpdf = :idpdf")
    , @NamedQuery(name = "Tbsolicitudes.findByNumero", query = "SELECT t FROM Tbsolicitudes t WHERE t.numero = :numero")})
public class Tbsolicitudes implements Serializable {

    private static final long serialVersionUID = 1L;
    @Size(max = 20)
    @Column(name = "estado")
    private String estado;
    @Column(name = "fecha")
    @Temporal(TemporalType.DATE)
    private Date fecha;
    @Size(max = 2147483647)
    @Column(name = "observacion")
    private String observacion;
    @Column(name = "idpdf")
    private Integer idpdf;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "numero")
    private Integer numero;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "solicitud")
    private Collection<Tbseccionviajes> tbseccionviajesCollection;
    @OneToMany(mappedBy = "solicitud")
    private Collection<Tbseccionsolicitantes> tbseccionsolicitantesCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "solicitud")
    private Collection<Tbseccionmotivo> tbseccionmotivoCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "solicitud")
    private Collection<Tbordenesmovilizaciones> tbordenesmovilizacionesCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "solicitud")
    private Collection<Tbdisponibilidadvc> tbdisponibilidadvcCollection;

    public Tbsolicitudes() {
    }

    public Tbsolicitudes(Integer numero) {
        this.numero = numero;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public Integer getNumero() {
        return numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    @XmlTransient
    public Collection<Tbseccionviajes> getTbseccionviajesCollection() {
        return tbseccionviajesCollection;
    }

    public void setTbseccionviajesCollection(Collection<Tbseccionviajes> tbseccionviajesCollection) {
        this.tbseccionviajesCollection = tbseccionviajesCollection;
    }

    @XmlTransient
    public Collection<Tbseccionsolicitantes> getTbseccionsolicitantesCollection() {
        return tbseccionsolicitantesCollection;
    }

    public void setTbseccionsolicitantesCollection(Collection<Tbseccionsolicitantes> tbseccionsolicitantesCollection) {
        this.tbseccionsolicitantesCollection = tbseccionsolicitantesCollection;
    }

    @XmlTransient
    public Collection<Tbseccionmotivo> getTbseccionmotivoCollection() {
        return tbseccionmotivoCollection;
    }

    public void setTbseccionmotivoCollection(Collection<Tbseccionmotivo> tbseccionmotivoCollection) {
        this.tbseccionmotivoCollection = tbseccionmotivoCollection;
    }

    @XmlTransient
    public Collection<Tbordenesmovilizaciones> getTbordenesmovilizacionesCollection() {
        return tbordenesmovilizacionesCollection;
    }

    public void setTbordenesmovilizacionesCollection(Collection<Tbordenesmovilizaciones> tbordenesmovilizacionesCollection) {
        this.tbordenesmovilizacionesCollection = tbordenesmovilizacionesCollection;
    }

    @XmlTransient
    public Collection<Tbdisponibilidadvc> getTbdisponibilidadvcCollection() {
        return tbdisponibilidadvcCollection;
    }

    public void setTbdisponibilidadvcCollection(Collection<Tbdisponibilidadvc> tbdisponibilidadvcCollection) {
        this.tbdisponibilidadvcCollection = tbdisponibilidadvcCollection;
    }

    public Integer getIdpdf() {
        return idpdf;
    }

    public void setIdpdf(Integer idpdf) {
        this.idpdf = idpdf;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (numero != null ? numero.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbsolicitudes)) {
            return false;
        }
        Tbsolicitudes other = (Tbsolicitudes) object;
        if ((this.numero == null && other.numero != null) || (this.numero != null && !this.numero.equals(other.numero))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbsolicitudes[ numero=" + numero + " ]";
    }
    
}
