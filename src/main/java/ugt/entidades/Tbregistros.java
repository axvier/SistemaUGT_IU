/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
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
    @NamedQuery(name = "Tbregistros.findAll", query = "SELECT t FROM Tbregistros t")
    , @NamedQuery(name = "Tbregistros.findByIdregistro", query = "SELECT t FROM Tbregistros t WHERE t.idregistro = :idregistro")
    , @NamedQuery(name = "Tbregistros.findByIdtabla", query = "SELECT t FROM Tbregistros t WHERE t.idtabla = :idtabla")
    , @NamedQuery(name = "Tbregistros.findByTabla", query = "SELECT t FROM Tbregistros t WHERE t.tabla = :tabla")
    , @NamedQuery(name = "Tbregistros.findByFecha", query = "SELECT t FROM Tbregistros t WHERE t.fecha = :fecha")
    , @NamedQuery(name = "Tbregistros.findByResponsable", query = "SELECT t FROM Tbregistros t WHERE t.responsable = :responsable")
    , @NamedQuery(name = "Tbregistros.findDocOrderFechaAsc", query = "SELECT t FROM Tbregistros t WHERE t.idtabla = :idtabla AND t.tabla = :tabla ORDER BY t.fecha ASC")
    , @NamedQuery(name = "Tbregistros.findDocOrderFechaDesc", query = "SELECT t FROM Tbregistros t WHERE t.idtabla = :idtabla AND t.tabla = :tabla ORDER BY t.fecha DESC")
    , @NamedQuery(name = "Tbregistros.findByAccion", query = "SELECT t FROM Tbregistros t WHERE t.accion = :accion")})
public class Tbregistros implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idregistro")
    private Integer idregistro;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "idtabla")
    private String idtabla;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "tabla")
    private String tabla;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    @Size(max = 2147483647)
    @Column(name = "responsable")
    private String responsable;
    @Size(max = 100)
    @Column(name = "accion")
    private String accion;

    public Tbregistros() {
    }

    public Tbregistros(Integer idregistro) {
        this.idregistro = idregistro;
    }

    public Tbregistros(Integer idregistro, String idtabla, String tabla, Date fecha) {
        this.idregistro = idregistro;
        this.idtabla = idtabla;
        this.tabla = tabla;
        this.fecha = fecha;
    }

    public Integer getIdregistro() {
        return idregistro;
    }

    public void setIdregistro(Integer idregistro) {
        this.idregistro = idregistro;
    }

    public String getIdtabla() {
        return idtabla;
    }

    public void setIdtabla(String idtabla) {
        this.idtabla = idtabla;
    }

    public String getTabla() {
        return tabla;
    }

    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.accion = accion;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idregistro != null ? idregistro.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbregistros)) {
            return false;
        }
        Tbregistros other = (Tbregistros) object;
        if ((this.idregistro == null && other.idregistro != null) || (this.idregistro != null && !this.idregistro.equals(other.idregistro))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbregistros[ idregistro=" + idregistro + " ]";
    }
    
}
