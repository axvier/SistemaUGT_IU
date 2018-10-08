/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
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
    @NamedQuery(name = "Tbcomisiones.findAll", query = "SELECT t FROM Tbcomisiones t")
    , @NamedQuery(name = "Tbcomisiones.findByCedula", query = "SELECT t FROM Tbcomisiones t WHERE t.cedula = :cedula")
    , @NamedQuery(name = "Tbcomisiones.findByNombres", query = "SELECT t FROM Tbcomisiones t WHERE t.nombres = :nombres")
    , @NamedQuery(name = "Tbcomisiones.findByApellidos", query = "SELECT t FROM Tbcomisiones t WHERE t.apellidos = :apellidos")
    , @NamedQuery(name = "Tbcomisiones.findByEntidad", query = "SELECT t FROM Tbcomisiones t WHERE t.entidad = :entidad")
    , @NamedQuery(name = "Tbcomisiones.findByCargo", query = "SELECT t FROM Tbcomisiones t WHERE t.cargo = :cargo")})
public class Tbcomisiones implements Serializable {

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
    @Size(min = 1, max = 10)
    @Column(name = "entidad")
    private String entidad;
    @Size(max = 2147483647)
    @Column(name = "cargo")
    private String cargo;

    public Tbcomisiones() {
    }

    public Tbcomisiones(String cedula) {
        this.cedula = cedula;
    }

    public Tbcomisiones(String cedula, String entidad) {
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

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
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
        if (!(object instanceof Tbcomisiones)) {
            return false;
        }
        Tbcomisiones other = (Tbcomisiones) object;
        if ((this.cedula == null && other.cedula != null) || (this.cedula != null && !this.cedula.equals(other.cedula))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbcomisiones[ cedula=" + cedula + " ]";
    }
    
}
