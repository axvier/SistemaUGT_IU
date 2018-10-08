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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
    @NamedQuery(name = "Tbseccionviajes.findAll", query = "SELECT t FROM Tbseccionviajes t")
    , @NamedQuery(name = "Tbseccionviajes.findByIdviaje", query = "SELECT t FROM Tbseccionviajes t WHERE t.idviaje = :idviaje")
    , @NamedQuery(name = "Tbseccionviajes.findByOrigen", query = "SELECT t FROM Tbseccionviajes t WHERE t.origen = :origen")
    , @NamedQuery(name = "Tbseccionviajes.findByDestino", query = "SELECT t FROM Tbseccionviajes t WHERE t.destino = :destino")
    , @NamedQuery(name = "Tbseccionviajes.findByFechasalida", query = "SELECT t FROM Tbseccionviajes t WHERE t.fechasalida = :fechasalida")
    , @NamedQuery(name = "Tbseccionviajes.findByFecharetorno", query = "SELECT t FROM Tbseccionviajes t WHERE t.fecharetorno = :fecharetorno")
    , @NamedQuery(name = "Tbseccionviajes.findByTelefono", query = "SELECT t FROM Tbseccionviajes t WHERE t.telefono = :telefono")})
public class Tbseccionviajes implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idviaje")
    private Integer idviaje;
    @Size(max = 2147483647)
    @Column(name = "origen")
    private String origen;
    @Size(max = 2147483647)
    @Column(name = "destino")
    private String destino;
    @Column(name = "fechasalida")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechasalida;
    @Column(name = "fecharetorno")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecharetorno;
    @Size(max = 15)
    @Column(name = "telefono")
    private String telefono;
    @JoinColumn(name = "solicitud", referencedColumnName = "numero")
    @ManyToOne(optional = false)
    private Tbsolicitudes solicitud;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idviaje")
    private Collection<Tbpasajeros> tbpasajerosCollection;

    public Tbseccionviajes() {
    }

    public Tbseccionviajes(Integer idviaje) {
        this.idviaje = idviaje;
    }

    public Integer getIdviaje() {
        return idviaje;
    }

    public void setIdviaje(Integer idviaje) {
        this.idviaje = idviaje;
    }

    public String getOrigen() {
        return origen;
    }

    public void setOrigen(String origen) {
        this.origen = origen;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public Date getFechasalida() {
        return fechasalida;
    }

    public void setFechasalida(Date fechasalida) {
        this.fechasalida = fechasalida;
    }

    public Date getFecharetorno() {
        return fecharetorno;
    }

    public void setFecharetorno(Date fecharetorno) {
        this.fecharetorno = fecharetorno;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Tbsolicitudes getSolicitud() {
        return solicitud;
    }

    public void setSolicitud(Tbsolicitudes solicitud) {
        this.solicitud = solicitud;
    }

    @XmlTransient
    public Collection<Tbpasajeros> getTbpasajerosCollection() {
        return tbpasajerosCollection;
    }

    public void setTbpasajerosCollection(Collection<Tbpasajeros> tbpasajerosCollection) {
        this.tbpasajerosCollection = tbpasajerosCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idviaje != null ? idviaje.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbseccionviajes)) {
            return false;
        }
        Tbseccionviajes other = (Tbseccionviajes) object;
        if ((this.idviaje == null && other.idviaje != null) || (this.idviaje != null && !this.idviaje.equals(other.idviaje))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbseccionviajes[ idviaje=" + idviaje + " ]";
    }
    
}
