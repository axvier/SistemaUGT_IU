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
    @NamedQuery(name = "Tbentidad.findAll", query = "SELECT t FROM Tbentidad t")
    , @NamedQuery(name = "Tbentidad.findByIdentidad", query = "SELECT t FROM Tbentidad t WHERE t.identidad = :identidad")
    , @NamedQuery(name = "Tbentidad.findByCodigoentidad", query = "SELECT t FROM Tbentidad t WHERE t.codigoentidad = :codigoentidad")
    , @NamedQuery(name = "Tbentidad.findByNombre", query = "SELECT t FROM Tbentidad t WHERE t.nombre = :nombre")})
public class Tbentidad implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "identidad")
    private Integer identidad;
    @Size(max = 50)
    @Column(name = "codigoentidad")
    private String codigoentidad;
    @Size(max = 2147483647)
    @Column(name = "nombre")
    private String nombre;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbentidad")
    private Collection<Tbusuariosentidad> tbusuariosentidadCollection;
    @OneToMany(mappedBy = "idpadre")
    private Collection<Tbentidad> tbentidadCollection;
    @JoinColumn(name = "idpadre", referencedColumnName = "identidad")
    @ManyToOne
    private Tbentidad idpadre;
    @JoinColumn(name = "idtipo", referencedColumnName = "idtipo")
    @ManyToOne
    private Tbtipoentidad idtipo;

    public Tbentidad() {
    }

    public Tbentidad(Integer identidad) {
        this.identidad = identidad;
    }

    public Integer getIdentidad() {
        return identidad;
    }

    public void setIdentidad(Integer identidad) {
        this.identidad = identidad;
    }

    public String getCodigoentidad() {
        return codigoentidad;
    }

    public void setCodigoentidad(String codigoentidad) {
        this.codigoentidad = codigoentidad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @XmlTransient
    public Collection<Tbusuariosentidad> getTbusuariosentidadCollection() {
        return tbusuariosentidadCollection;
    }

    public void setTbusuariosentidadCollection(Collection<Tbusuariosentidad> tbusuariosentidadCollection) {
        this.tbusuariosentidadCollection = tbusuariosentidadCollection;
    }

    @XmlTransient
    public Collection<Tbentidad> getTbentidadCollection() {
        return tbentidadCollection;
    }

    public void setTbentidadCollection(Collection<Tbentidad> tbentidadCollection) {
        this.tbentidadCollection = tbentidadCollection;
    }

    public Tbentidad getIdpadre() {
        return idpadre;
    }

    public void setIdpadre(Tbentidad idpadre) {
        this.idpadre = idpadre;
    }

    public Tbtipoentidad getIdtipo() {
        return idtipo;
    }

    public void setIdtipo(Tbtipoentidad idtipo) {
        this.idtipo = idtipo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (identidad != null ? identidad.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbentidad)) {
            return false;
        }
        Tbentidad other = (Tbentidad) object;
        if ((this.identidad == null && other.identidad != null) || (this.identidad != null && !this.identidad.equals(other.identidad))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbentidad[ identidad=" + identidad + " ]";
    }
    
}
