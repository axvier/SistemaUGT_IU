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
    @NamedQuery(name = "Tbvehiculosconductores.findAll", query = "SELECT t FROM Tbvehiculosconductores t")
    , @NamedQuery(name = "Tbvehiculosconductores.findByMatricula", query = "SELECT t FROM Tbvehiculosconductores t WHERE t.tbvehiculosconductoresPK.matricula = :matricula")
    , @NamedQuery(name = "Tbvehiculosconductores.findByCedula", query = "SELECT t FROM Tbvehiculosconductores t WHERE t.tbvehiculosconductoresPK.cedula = :cedula")
    , @NamedQuery(name = "Tbvehiculosconductores.findByFechainicio", query = "SELECT t FROM Tbvehiculosconductores t WHERE t.tbvehiculosconductoresPK.fechainicio = :fechainicio")
    , @NamedQuery(name = "Tbvehiculosconductores.findByFechafin", query = "SELECT t FROM Tbvehiculosconductores t WHERE t.fechafin = :fechafin")})
public class Tbvehiculosconductores implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected TbvehiculosconductoresPK tbvehiculosconductoresPK;
    @Column(name = "fechafin")
    @Temporal(TemporalType.DATE)
    private Date fechafin;
    @JoinColumn(name = "cedula", referencedColumnName = "cedula", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Tbconductores tbconductores;
    @JoinColumn(name = "matricula", referencedColumnName = "placa", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Tbvehiculos tbvehiculos;

    public Tbvehiculosconductores() {
    }

    public Tbvehiculosconductores(TbvehiculosconductoresPK tbvehiculosconductoresPK) {
        this.tbvehiculosconductoresPK = tbvehiculosconductoresPK;
    }

    public Tbvehiculosconductores(String matricula, String cedula, Date fechainicio) {
        this.tbvehiculosconductoresPK = new TbvehiculosconductoresPK(matricula, cedula, fechainicio);
    }

    public TbvehiculosconductoresPK getTbvehiculosconductoresPK() {
        return tbvehiculosconductoresPK;
    }

    public void setTbvehiculosconductoresPK(TbvehiculosconductoresPK tbvehiculosconductoresPK) {
        this.tbvehiculosconductoresPK = tbvehiculosconductoresPK;
    }

    public Date getFechafin() {
        return fechafin;
    }

    public void setFechafin(Date fechafin) {
        this.fechafin = fechafin;
    }

    public Tbconductores getTbconductores() {
        return tbconductores;
    }

    public void setTbconductores(Tbconductores tbconductores) {
        this.tbconductores = tbconductores;
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
        hash += (tbvehiculosconductoresPK != null ? tbvehiculosconductoresPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbvehiculosconductores)) {
            return false;
        }
        Tbvehiculosconductores other = (Tbvehiculosconductores) object;
        if ((this.tbvehiculosconductoresPK == null && other.tbvehiculosconductoresPK != null) || (this.tbvehiculosconductoresPK != null && !this.tbvehiculosconductoresPK.equals(other.tbvehiculosconductoresPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbvehiculosconductores[ tbvehiculosconductoresPK=" + tbvehiculosconductoresPK + " ]";
    }
    
}
