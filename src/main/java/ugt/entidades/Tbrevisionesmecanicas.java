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
    @NamedQuery(name = "Tbrevisionesmecanicas.findAll", query = "SELECT t FROM Tbrevisionesmecanicas t")
    , @NamedQuery(name = "Tbrevisionesmecanicas.findByIdrevision", query = "SELECT t FROM Tbrevisionesmecanicas t WHERE t.idrevision = :idrevision")
    , @NamedQuery(name = "Tbrevisionesmecanicas.findByDetalle", query = "SELECT t FROM Tbrevisionesmecanicas t WHERE t.detalle = :detalle")
    , @NamedQuery(name = "Tbrevisionesmecanicas.findByFecha", query = "SELECT t FROM Tbrevisionesmecanicas t WHERE t.fecha = :fecha")})
public class Tbrevisionesmecanicas implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idrevision")
    private Integer idrevision;
    @Size(max = 2147483647)
    @Column(name = "detalle")
    private String detalle;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha")
    @Temporal(TemporalType.DATE)
    private Date fecha;
    @JoinColumn(name = "matricula", referencedColumnName = "placa")
    @ManyToOne(optional = false)
    private Tbvehiculos matricula;

    public Tbrevisionesmecanicas() {
    }

    public Tbrevisionesmecanicas(Integer idrevision) {
        this.idrevision = idrevision;
    }

    public Tbrevisionesmecanicas(Integer idrevision, Date fecha) {
        this.idrevision = idrevision;
        this.fecha = fecha;
    }

    public Integer getIdrevision() {
        return idrevision;
    }

    public void setIdrevision(Integer idrevision) {
        this.idrevision = idrevision;
    }

    public String getDetalle() {
        return detalle;
    }

    public void setDetalle(String detalle) {
        this.detalle = detalle;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Tbvehiculos getMatricula() {
        return matricula;
    }

    public void setMatricula(Tbvehiculos matricula) {
        this.matricula = matricula;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idrevision != null ? idrevision.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbrevisionesmecanicas)) {
            return false;
        }
        Tbrevisionesmecanicas other = (Tbrevisionesmecanicas) object;
        if ((this.idrevision == null && other.idrevision != null) || (this.idrevision != null && !this.idrevision.equals(other.idrevision))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbrevisionesmecanicas[ idrevision=" + idrevision + " ]";
    }
    
}
