/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Xavy PC
 */
@Entity
@Table(schema = "esquemaugt")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tbvehiculosdependencias.findAll", query = "SELECT t FROM Tbvehiculosdependencias t")
    , @NamedQuery(name = "Tbvehiculosdependencias.findByIddependencia", query = "SELECT t FROM Tbvehiculosdependencias t WHERE t.tbvehiculosdependenciasPK.iddependencia = :iddependencia")
    , @NamedQuery(name = "Tbvehiculosdependencias.findByMatricula", query = "SELECT t FROM Tbvehiculosdependencias t WHERE t.tbvehiculosdependenciasPK.matricula = :matricula")
    , @NamedQuery(name = "Tbvehiculosdependencias.findByFechainicio", query = "SELECT t FROM Tbvehiculosdependencias t WHERE t.tbvehiculosdependenciasPK.fechainicio = :fechainicio")
    , @NamedQuery(name = "Tbvehiculosdependencias.findByFechafin", query = "SELECT t FROM Tbvehiculosdependencias t WHERE t.fechafin = :fechafin")})
public class Tbvehiculosdependencias implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected TbvehiculosdependenciasPK tbvehiculosdependenciasPK;
    @Column(name = "fechafin")
    @Temporal(TemporalType.DATE)
    private Date fechafin;
    @JoinColumn(name = "iddependencia", referencedColumnName = "identidad", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Tbentidad tbentidad;
    @JoinColumn(name = "matricula", referencedColumnName = "placa", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Tbvehiculos tbvehiculos;

    public Tbvehiculosdependencias() {
    }

    public Tbvehiculosdependencias(TbvehiculosdependenciasPK tbvehiculosdependenciasPK) {
        this.tbvehiculosdependenciasPK = tbvehiculosdependenciasPK;
    }

    public Tbvehiculosdependencias(int iddependencia, String matricula, Date fechainicio) {
        this.tbvehiculosdependenciasPK = new TbvehiculosdependenciasPK(iddependencia, matricula, fechainicio);
    }

    public TbvehiculosdependenciasPK getTbvehiculosdependenciasPK() {
        return tbvehiculosdependenciasPK;
    }

    public void setTbvehiculosdependenciasPK(TbvehiculosdependenciasPK tbvehiculosdependenciasPK) {
        this.tbvehiculosdependenciasPK = tbvehiculosdependenciasPK;
    }

    public Date getFechafin() {
        return fechafin;
    }

    public void setFechafin(Date fechafin) {
        this.fechafin = fechafin;
    }

    public Tbentidad getTbdependencias() {
        return tbentidad;
    }

    public void setTbdependencias(Tbentidad tbdependencias) {
        this.tbentidad = tbdependencias;
    }

    public Tbvehiculos getTbvehiculos() {
        return tbvehiculos;
    }

    public void setTbvehiculos(Tbvehiculos tbvehiculos) {
        this.tbvehiculos = tbvehiculos;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (tbvehiculosdependenciasPK != null ? tbvehiculosdependenciasPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbvehiculosdependencias)) {
            return false;
        }
        Tbvehiculosdependencias other = (Tbvehiculosdependencias) object;
        if ((this.tbvehiculosdependenciasPK == null && other.tbvehiculosdependenciasPK != null) || (this.tbvehiculosdependenciasPK != null && !this.tbvehiculosdependenciasPK.equals(other.tbvehiculosdependenciasPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbvehiculosdependencias[ tbvehiculosdependenciasPK=" + tbvehiculosdependenciasPK + " ]";
    }
    
}
