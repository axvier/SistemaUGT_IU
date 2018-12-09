/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
import java.util.Collection;
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
    @NamedQuery(name = "Tbopciones.findAll", query = "SELECT t FROM Tbopciones t")
    , @NamedQuery(name = "Tbopciones.findByIdopcion", query = "SELECT t FROM Tbopciones t WHERE t.idopcion = :idopcion")
    , @NamedQuery(name = "Tbopciones.findByDescripcion", query = "SELECT t FROM Tbopciones t WHERE t.descripcion = :descripcion")
    , @NamedQuery(name = "Tbopciones.findByAccion", query = "SELECT t FROM Tbopciones t WHERE t.accion = :accion")
    , @NamedQuery(name = "Tbopciones.findByEstado", query = "SELECT t FROM Tbopciones t WHERE t.estado = :estado")})
public class Tbopciones implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idopcion")
    private Integer idopcion;
    @Size(max = 2147483647)
    @Column(name = "descripcion")
    private String descripcion;
    @Size(max = 2147483647)
    @Column(name = "accion")
    private String accion;
    @Size(max = 20)
    @Column(name = "estado")
    private String estado;
    @OneToMany(mappedBy = "idpadre")
    private Collection<Tbopciones> tbopcionesCollection;
    @JoinColumn(name = "idpadre", referencedColumnName = "idopcion")
    @ManyToOne
    private Tbopciones idpadre;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idopcion")
    private Collection<Tbrolesopciones> tbrolesopcionesCollection;

    public Tbopciones() {
    }

    public Tbopciones(Integer idopcion) {
        this.idopcion = idopcion;
    }

    public Integer getIdopcion() {
        return idopcion;
    }

    public void setIdopcion(Integer idopcion) {
        this.idopcion = idopcion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.accion = accion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

     @XmlTransient
    public Collection<Tbopciones> getTbopcionesCollection() {
        return tbopcionesCollection;
    }

    public void setTbopcionesCollection(Collection<Tbopciones> tbentidadCollection) {
        this.tbopcionesCollection = tbentidadCollection;
    }

    public Tbopciones getIdpadre() {
        return idpadre;
    }

    public void setIdpadre(Tbopciones idpadre) {
        this.idpadre = idpadre;
    }

    @XmlTransient
    public Collection<Tbrolesopciones> getTbrolesopcionesCollection() {
        return tbrolesopcionesCollection;
    }

    public void setTbrolesopcionesCollection(Collection<Tbrolesopciones> tbrolesopcionesCollection) {
        this.tbrolesopcionesCollection = tbrolesopcionesCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idopcion != null ? idopcion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbopciones)) {
            return false;
        }
        Tbopciones other = (Tbopciones) object;
        if ((this.idopcion == null && other.idopcion != null) || (this.idopcion != null && !this.idopcion.equals(other.idopcion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbopciones[ idopcion=" + idopcion + " ]";
    }
    
}
