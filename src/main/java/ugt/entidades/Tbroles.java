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
    @NamedQuery(name = "Tbroles.findAll", query = "SELECT t FROM Tbroles t")
    , @NamedQuery(name = "Tbroles.findByIdrol", query = "SELECT t FROM Tbroles t WHERE t.idrol = :idrol")
    , @NamedQuery(name = "Tbroles.findByDescripcion", query = "SELECT t FROM Tbroles t WHERE t.descripcion = :descripcion")
    , @NamedQuery(name = "Tbroles.findByCharrol", query = "SELECT t FROM Tbroles t WHERE t.charrol = :charrol")
    , @NamedQuery(name = "Tbroles.findByEstado", query = "SELECT t FROM Tbroles t WHERE t.estado = :estado")})
public class Tbroles implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idrol")
    private Integer idrol;
    @Size(max = 2147483647)
    @Column(name = "descripcion")
    private String descripcion;
    @Size(max = 5)
    @Column(name = "charrol")
    private String charrol;
    @Size(max = 20)
    @Column(name = "estado")
    private String estado;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbroles")
    private Collection<Tbusuariosentidad> tbusuariosentidadCollection;
    @JoinColumn(name = "gerarquia", referencedColumnName = "idtipo")
    @ManyToOne
    private Tbtipoentidad gerarquia;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idrol")
    private Collection<Tbrolesopciones> tbrolesopcionesCollection;

    public Tbroles() {
    }

    public Tbroles(Integer idrol) {
        this.idrol = idrol;
    }

    public Integer getIdrol() {
        return idrol;
    }

    public void setIdrol(Integer idrol) {
        this.idrol = idrol;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getCharrol() {
        return charrol;
    }

    public void setCharrol(String charrol) {
        this.charrol = charrol;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    @XmlTransient
    public Collection<Tbusuariosentidad> getTbusuariosentidadCollection() {
        return tbusuariosentidadCollection;
    }

    public void setTbusuariosentidadCollection(Collection<Tbusuariosentidad> tbusuariosentidadCollection) {
        this.tbusuariosentidadCollection = tbusuariosentidadCollection;
    }

    public Tbtipoentidad getGerarquia() {
        return gerarquia;
    }

    public void setGerarquia(Tbtipoentidad gerarquia) {
        this.gerarquia = gerarquia;
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
        hash += (idrol != null ? idrol.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbroles)) {
            return false;
        }
        Tbroles other = (Tbroles) object;
        if ((this.idrol == null && other.idrol != null) || (this.idrol != null && !this.idrol.equals(other.idrol))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbroles[ idrol=" + idrol + " ]";
    }
    
}
