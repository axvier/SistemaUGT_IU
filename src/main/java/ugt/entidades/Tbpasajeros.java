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
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
    @NamedQuery(name = "Tbpasajeros.findAll", query = "SELECT t FROM Tbpasajeros t")
    , @NamedQuery(name = "Tbpasajeros.findByCedula", query = "SELECT t FROM Tbpasajeros t WHERE t.cedula = :cedula")
    , @NamedQuery(name = "Tbpasajeros.findByNombres", query = "SELECT t FROM Tbpasajeros t WHERE t.nombres = :nombres")
    , @NamedQuery(name = "Tbpasajeros.findByApellidos", query = "SELECT t FROM Tbpasajeros t WHERE t.apellidos = :apellidos")
    , @NamedQuery(name = "Tbpasajeros.findByEntidad", query = "SELECT t FROM Tbpasajeros t WHERE t.entidad = :entidad")
    , @NamedQuery(name = "Tbpasajeros.findByDescripcion", query = "SELECT t FROM Tbpasajeros t WHERE t.descripcion = :descripcion")})
public class Tbpasajeros implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "cedula")
    private String cedula;
    @Size(max = 2147483647)
    @Column(name = "nombres")
    private String nombres;
    @Size(max = 2147483647)
    @Column(name = "apellidos")
    private String apellidos;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "entidad")
    private String entidad;
    @Size(max = 2147483647)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbpasajeros")
    private Collection<Tbviajepasajero> tbviajepasajeroCollection;

    public Tbpasajeros() {
    }

    public Tbpasajeros(String cedula) {
        this.cedula = cedula;
    }

    public Tbpasajeros(String cedula, String entidad) {
        this.cedula = cedula;
        this.entidad = entidad;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getEntidad() {
        return entidad;
    }

    public void setEntidad(String entidad) {
        this.entidad = entidad;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public Collection<Tbviajepasajero> getTbviajepasajeroCollection() {
        return tbviajepasajeroCollection;
    }

    public void setTbviajepasajeroCollection(Collection<Tbviajepasajero> tbviajepasajeroCollection) {
        this.tbviajepasajeroCollection = tbviajepasajeroCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (cedula != null ? cedula.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbpasajeros)) {
            return false;
        }
        Tbpasajeros other = (Tbpasajeros) object;
        if ((this.cedula == null && other.cedula != null) || (this.cedula != null && !this.cedula.equals(other.cedula))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbpasajeros[ cedula=" + cedula + " ]";
    }
    
}
