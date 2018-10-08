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
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
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
    @NamedQuery(name = "Tbconductores.findAll", query = "SELECT t FROM Tbconductores t")
    , @NamedQuery(name = "Tbconductores.findByCedula", query = "SELECT t FROM Tbconductores t WHERE t.cedula = :cedula")
    , @NamedQuery(name = "Tbconductores.findByNombres", query = "SELECT t FROM Tbconductores t WHERE t.nombres = :nombres")
    , @NamedQuery(name = "Tbconductores.findByApellidos", query = "SELECT t FROM Tbconductores t WHERE t.apellidos = :apellidos")
    , @NamedQuery(name = "Tbconductores.findByFechanac", query = "SELECT t FROM Tbconductores t WHERE t.fechanac = :fechanac")
    , @NamedQuery(name = "Tbconductores.findByGenero", query = "SELECT t FROM Tbconductores t WHERE t.genero = :genero")
    , @NamedQuery(name = "Tbconductores.findByEstado", query = "SELECT t FROM Tbconductores t WHERE t.estado = :estado")})
public class Tbconductores implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "cedula")
    private String cedula;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "nombres")
    private String nombres;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "apellidos")
    private String apellidos;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fechanac")
    @Temporal(TemporalType.DATE)
    private Date fechanac;
    @Size(max = 10)
    @Column(name = "genero")
    private String genero;
    @Size(max = 2147483647)
    @Column(name = "estado")
    private String estado;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "cedulac")
    private Collection<Tblicencias> tblicenciasCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "cedulaCond")
    private Collection<Tbdisponibilidadvc> tbdisponibilidadvcCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbconductores")
    private Collection<Tbvehiculosconductores> tbvehiculosconductoresCollection;

    public Tbconductores() {
    }

    public Tbconductores(String cedula) {
        this.cedula = cedula;
    }

    public Tbconductores(String cedula, String nombres, String apellidos, Date fechanac) {
        this.cedula = cedula;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.fechanac = fechanac;
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

    public Date getFechanac() {
        return fechanac;
    }

    public void setFechanac(Date fechanac) {
        this.fechanac = fechanac;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    @XmlTransient
    public Collection<Tblicencias> getTblicenciasCollection() {
        return tblicenciasCollection;
    }

    public void setTblicenciasCollection(Collection<Tblicencias> tblicenciasCollection) {
        this.tblicenciasCollection = tblicenciasCollection;
    }

    @XmlTransient
    public Collection<Tbdisponibilidadvc> getTbdisponibilidadvcCollection() {
        return tbdisponibilidadvcCollection;
    }

    public void setTbdisponibilidadvcCollection(Collection<Tbdisponibilidadvc> tbdisponibilidadvcCollection) {
        this.tbdisponibilidadvcCollection = tbdisponibilidadvcCollection;
    }

    @XmlTransient
    public Collection<Tbvehiculosconductores> getTbvehiculosconductoresCollection() {
        return tbvehiculosconductoresCollection;
    }

    public void setTbvehiculosconductoresCollection(Collection<Tbvehiculosconductores> tbvehiculosconductoresCollection) {
        this.tbvehiculosconductoresCollection = tbvehiculosconductoresCollection;
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
        if (!(object instanceof Tbconductores)) {
            return false;
        }
        Tbconductores other = (Tbconductores) object;
        if ((this.cedula == null && other.cedula != null) || (this.cedula != null && !this.cedula.equals(other.cedula))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbconductores[ cedula=" + cedula + " ]";
    }
    
}
