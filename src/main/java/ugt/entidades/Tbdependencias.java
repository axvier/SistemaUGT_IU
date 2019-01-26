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
    @NamedQuery(name = "Tbdependencias.findAll", query = "SELECT t FROM Tbdependencias t")
    , @NamedQuery(name = "Tbdependencias.findByIddependencia", query = "SELECT t FROM Tbdependencias t WHERE t.iddependencia = :iddependencia")
    , @NamedQuery(name = "Tbdependencias.findByNombre", query = "SELECT t FROM Tbdependencias t WHERE t.nombre = :nombre")
    , @NamedQuery(name = "Tbdependencias.findByCodigo", query = "SELECT t FROM Tbdependencias t WHERE t.codigo = :codigo")})
public class Tbdependencias implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "iddependencia")
    private Integer iddependencia;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "codigo")
    private String codigo;
//    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbdependencias")
//    private Collection<Tbvehiculosdependencias> tbvehiculosdependenciasCollection;

    public Tbdependencias() {
    }

    public Tbdependencias(Integer iddependencia) {
        this.iddependencia = iddependencia;
    }

    public Tbdependencias(Integer iddependencia, String nombre, String codigo) {
        this.iddependencia = iddependencia;
        this.nombre = nombre;
        this.codigo = codigo;
    }

    public Integer getIddependencia() {
        return iddependencia;
    }

    public void setIddependencia(Integer iddependencia) {
        this.iddependencia = iddependencia;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

//    @XmlTransient
//    public Collection<Tbvehiculosdependencias> getTbvehiculosdependenciasCollection() {
//        return tbvehiculosdependenciasCollection;
//    }
//
//    public void setTbvehiculosdependenciasCollection(Collection<Tbvehiculosdependencias> tbvehiculosdependenciasCollection) {
//        this.tbvehiculosdependenciasCollection = tbvehiculosdependenciasCollection;
//    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iddependencia != null ? iddependencia.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbdependencias)) {
            return false;
        }
        Tbdependencias other = (Tbdependencias) object;
        if ((this.iddependencia == null && other.iddependencia != null) || (this.iddependencia != null && !this.iddependencia.equals(other.iddependencia))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbdependencias[ iddependencia=" + iddependencia + " ]";
    }
    
}
