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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
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
    @NamedQuery(name = "Tbdisponibilidadvc.findAll", query = "SELECT t FROM Tbdisponibilidadvc t")
    , @NamedQuery(name = "Tbdisponibilidadvc.findByIddisponibilidad", query = "SELECT t FROM Tbdisponibilidadvc t WHERE t.iddisponibilidad = :iddisponibilidad")
    , @NamedQuery(name = "Tbdisponibilidadvc.findByEstado", query = "SELECT t FROM Tbdisponibilidadvc t WHERE t.estado = :estado")})
public class Tbdisponibilidadvc implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "iddisponibilidad")
    private Integer iddisponibilidad;
    @Size(max = 20)
    @Column(name = "estado")
    private String estado;
    @JoinColumn(name = "cedula_cond", referencedColumnName = "cedula")
    @ManyToOne(optional = false)
    private Tbconductores cedulaCond;
    @JoinColumn(name = "solicitud", referencedColumnName = "numero")
    @ManyToOne(optional = false)
    private Tbsolicitudes solicitud;
    @JoinColumn(name = "matricula", referencedColumnName = "placa")
    @ManyToOne(optional = false)
    private Tbvehiculos matricula;

    public Tbdisponibilidadvc() {
    }

    public Tbdisponibilidadvc(Integer iddisponibilidad) {
        this.iddisponibilidad = iddisponibilidad;
    }

    public Integer getIddisponibilidad() {
        return iddisponibilidad;
    }

    public void setIddisponibilidad(Integer iddisponibilidad) {
        this.iddisponibilidad = iddisponibilidad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Tbconductores getCedulaCond() {
        return cedulaCond;
    }

    public void setCedulaCond(Tbconductores cedulaCond) {
        this.cedulaCond = cedulaCond;
    }

    public Tbsolicitudes getSolicitud() {
        return solicitud;
    }

    public void setSolicitud(Tbsolicitudes solicitud) {
        this.solicitud = solicitud;
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
        hash += (iddisponibilidad != null ? iddisponibilidad.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbdisponibilidadvc)) {
            return false;
        }
        Tbdisponibilidadvc other = (Tbdisponibilidadvc) object;
        if ((this.iddisponibilidad == null && other.iddisponibilidad != null) || (this.iddisponibilidad != null && !this.iddisponibilidad.equals(other.iddisponibilidad))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbdisponibilidadvc[ iddisponibilidad=" + iddisponibilidad + " ]";
    }
    
}
