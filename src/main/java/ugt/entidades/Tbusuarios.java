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
    @NamedQuery(name = "Tbusuarios.findAll", query = "SELECT t FROM Tbusuarios t")
    , @NamedQuery(name = "Tbusuarios.findByCedula", query = "SELECT t FROM Tbusuarios t WHERE t.cedula = :cedula")
    , @NamedQuery(name = "Tbusuarios.findByNombres", query = "SELECT t FROM Tbusuarios t WHERE t.nombres = :nombres")
    , @NamedQuery(name = "Tbusuarios.findByApellidos", query = "SELECT t FROM Tbusuarios t WHERE t.apellidos = :apellidos")
    , @NamedQuery(name = "Tbusuarios.findByEmail", query = "SELECT t FROM Tbusuarios t WHERE t.email = :email")
    , @NamedQuery(name = "Tbusuarios.findByTipousuario", query = "SELECT t FROM Tbusuarios t WHERE t.tipousuario = :tipousuario")
    , @NamedQuery(name = "Tbusuarios.findByEstado", query = "SELECT t FROM Tbusuarios t WHERE t.estado = :estado")})
public class Tbusuarios implements Serializable {

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
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 2147483647)
    @Column(name = "email")
    private String email;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "tipousuario")
    private String tipousuario;
    @Size(max = 20)
    @Column(name = "estado")
    private String estado;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbusuarios")
    private Collection<Tbusuariosentidad> tbusuariosentidadCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "cedulau")
    private Collection<Tbseccionsolicitantes> tbseccionsolicitantesCollection;

    public Tbusuarios() {
    }

    public Tbusuarios(String cedula) {
        this.cedula = cedula;
    }

    public Tbusuarios(String cedula, String tipousuario) {
        this.cedula = cedula;
        this.tipousuario = tipousuario;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTipousuario() {
        return tipousuario;
    }

    public void setTipousuario(String tipousuario) {
        this.tipousuario = tipousuario;
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

    @XmlTransient
    public Collection<Tbseccionsolicitantes> getTbseccionsolicitantesCollection() {
        return tbseccionsolicitantesCollection;
    }

    public void setTbseccionsolicitantesCollection(Collection<Tbseccionsolicitantes> tbseccionsolicitantesCollection) {
        this.tbseccionsolicitantesCollection = tbseccionsolicitantesCollection;
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
        if (!(object instanceof Tbusuarios)) {
            return false;
        }
        Tbusuarios other = (Tbusuarios) object;
        if ((this.cedula == null && other.cedula != null) || (this.cedula != null && !this.cedula.equals(other.cedula))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbusuarios[ cedula=" + cedula + " ]";
    }
    
}
