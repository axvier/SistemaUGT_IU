/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
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
    @NamedQuery(name = "Tbtipoentidad.findAll", query = "SELECT t FROM Tbtipoentidad t")
    , @NamedQuery(name = "Tbtipoentidad.findByIdtipo", query = "SELECT t FROM Tbtipoentidad t WHERE t.idtipo = :idtipo")
    , @NamedQuery(name = "Tbtipoentidad.findByDescripcion", query = "SELECT t FROM Tbtipoentidad t WHERE t.descripcion = :descripcion")})
public class Tbtipoentidad implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idtipo")
    private Integer idtipo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(mappedBy = "gerarquia")
    private Collection<Tbroles> tbrolesCollection;
    @OneToMany(mappedBy = "idtipo")
    private Collection<Tbentidad> tbentidadCollection;

    public Tbtipoentidad() {
    }

    public Tbtipoentidad(Integer idtipo) {
        this.idtipo = idtipo;
    }

    public Tbtipoentidad(Integer idtipo, String descripcion) {
        this.idtipo = idtipo;
        this.descripcion = descripcion;
    }

    public Integer getIdtipo() {
        return idtipo;
    }

    public void setIdtipo(Integer idtipo) {
        this.idtipo = idtipo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public Collection<Tbroles> getTbrolesCollection() {
        return tbrolesCollection;
    }

    public void setTbrolesCollection(Collection<Tbroles> tbrolesCollection) {
        this.tbrolesCollection = tbrolesCollection;
    }

    @XmlTransient
    public Collection<Tbentidad> getTbentidadCollection() {
        return tbentidadCollection;
    }

    public void setTbentidadCollection(Collection<Tbentidad> tbentidadCollection) {
        this.tbentidadCollection = tbentidadCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtipo != null ? idtipo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbtipoentidad)) {
            return false;
        }
        Tbtipoentidad other = (Tbtipoentidad) object;
        if ((this.idtipo == null && other.idtipo != null) || (this.idtipo != null && !this.idtipo.equals(other.idtipo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbtipoentidad[ idtipo=" + idtipo + " ]";
    }
    
}
