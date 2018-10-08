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
    @NamedQuery(name = "Tbgrupovehiculos.findAll", query = "SELECT t FROM Tbgrupovehiculos t")
    , @NamedQuery(name = "Tbgrupovehiculos.findByIdgrupo", query = "SELECT t FROM Tbgrupovehiculos t WHERE t.idgrupo = :idgrupo")
    , @NamedQuery(name = "Tbgrupovehiculos.findByNombre", query = "SELECT t FROM Tbgrupovehiculos t WHERE t.nombre = :nombre")
    , @NamedQuery(name = "Tbgrupovehiculos.findByDetalle", query = "SELECT t FROM Tbgrupovehiculos t WHERE t.detalle = :detalle")})
public class Tbgrupovehiculos implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idgrupo")
    private Integer idgrupo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "nombre")
    private String nombre;
    @Size(max = 2147483647)
    @Column(name = "detalle")
    private String detalle;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idgrupo")
    private Collection<Tbvehiculos> tbvehiculosCollection;

    public Tbgrupovehiculos() {
    }

    public Tbgrupovehiculos(Integer idgrupo) {
        this.idgrupo = idgrupo;
    }

    public Tbgrupovehiculos(Integer idgrupo, String nombre) {
        this.idgrupo = idgrupo;
        this.nombre = nombre;
    }

    public Integer getIdgrupo() {
        return idgrupo;
    }

    public void setIdgrupo(Integer idgrupo) {
        this.idgrupo = idgrupo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDetalle() {
        return detalle;
    }

    public void setDetalle(String detalle) {
        this.detalle = detalle;
    }

    @XmlTransient
    public Collection<Tbvehiculos> getTbvehiculosCollection() {
        return tbvehiculosCollection;
    }

    public void setTbvehiculosCollection(Collection<Tbvehiculos> tbvehiculosCollection) {
        this.tbvehiculosCollection = tbvehiculosCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idgrupo != null ? idgrupo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbgrupovehiculos)) {
            return false;
        }
        Tbgrupovehiculos other = (Tbgrupovehiculos) object;
        if ((this.idgrupo == null && other.idgrupo != null) || (this.idgrupo != null && !this.idgrupo.equals(other.idgrupo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbgrupovehiculos[ idgrupo=" + idgrupo + " ]";
    }
    
}
