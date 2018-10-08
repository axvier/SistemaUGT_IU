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
    @NamedQuery(name = "Tbvehiculos.findAll", query = "SELECT t FROM Tbvehiculos t")
    , @NamedQuery(name = "Tbvehiculos.findByPlaca", query = "SELECT t FROM Tbvehiculos t WHERE t.placa = :placa")
    , @NamedQuery(name = "Tbvehiculos.findByDisco", query = "SELECT t FROM Tbvehiculos t WHERE t.disco = :disco")
    , @NamedQuery(name = "Tbvehiculos.findByColor", query = "SELECT t FROM Tbvehiculos t WHERE t.color = :color")
    , @NamedQuery(name = "Tbvehiculos.findByAnio", query = "SELECT t FROM Tbvehiculos t WHERE t.anio = :anio")
    , @NamedQuery(name = "Tbvehiculos.findByDescripcion", query = "SELECT t FROM Tbvehiculos t WHERE t.descripcion = :descripcion")
    , @NamedQuery(name = "Tbvehiculos.findByEstado", query = "SELECT t FROM Tbvehiculos t WHERE t.estado = :estado")
    , @NamedQuery(name = "Tbvehiculos.findByMarca", query = "SELECT t FROM Tbvehiculos t WHERE t.marca = :marca")
    , @NamedQuery(name = "Tbvehiculos.findByModelo", query = "SELECT t FROM Tbvehiculos t WHERE t.modelo = :modelo")})
public class Tbvehiculos implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "placa")
    private String placa;
    @Basic(optional = false)
    @NotNull
    @Column(name = "disco")
    private int disco;
    @Size(max = 2147483647)
    @Column(name = "color")
    private String color;
    @Column(name = "anio")
    private Integer anio;
    @Size(max = 2147483647)
    @Column(name = "descripcion")
    private String descripcion;
    @Size(max = 20)
    @Column(name = "estado")
    private String estado;
    @Size(max = 2147483647)
    @Column(name = "marca")
    private String marca;
    @Size(max = 2147483647)
    @Column(name = "modelo")
    private String modelo;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbvehiculos")
    private Collection<Tbvehiculosdependencias> tbvehiculosdependenciasCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "matricula")
    private Collection<Tbdisponibilidadvc> tbdisponibilidadvcCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "matricula")
    private Collection<Tbrevisionesmecanicas> tbrevisionesmecanicasCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbvehiculos")
    private Collection<Tbvehiculosconductores> tbvehiculosconductoresCollection;
    @JoinColumn(name = "idgrupo", referencedColumnName = "idgrupo")
    @ManyToOne(optional = false)
    private Tbgrupovehiculos idgrupo;

    public Tbvehiculos() {
    }

    public Tbvehiculos(String placa) {
        this.placa = placa;
    }

    public Tbvehiculos(String placa, int disco) {
        this.placa = placa;
        this.disco = disco;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public int getDisco() {
        return disco;
    }

    public void setDisco(int disco) {
        this.disco = disco;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Integer getAnio() {
        return anio;
    }

    public void setAnio(Integer anio) {
        this.anio = anio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    @XmlTransient
    public Collection<Tbvehiculosdependencias> getTbvehiculosdependenciasCollection() {
        return tbvehiculosdependenciasCollection;
    }

    public void setTbvehiculosdependenciasCollection(Collection<Tbvehiculosdependencias> tbvehiculosdependenciasCollection) {
        this.tbvehiculosdependenciasCollection = tbvehiculosdependenciasCollection;
    }

    @XmlTransient
    public Collection<Tbdisponibilidadvc> getTbdisponibilidadvcCollection() {
        return tbdisponibilidadvcCollection;
    }

    public void setTbdisponibilidadvcCollection(Collection<Tbdisponibilidadvc> tbdisponibilidadvcCollection) {
        this.tbdisponibilidadvcCollection = tbdisponibilidadvcCollection;
    }

    @XmlTransient
    public Collection<Tbrevisionesmecanicas> getTbrevisionesmecanicasCollection() {
        return tbrevisionesmecanicasCollection;
    }

    public void setTbrevisionesmecanicasCollection(Collection<Tbrevisionesmecanicas> tbrevisionesmecanicasCollection) {
        this.tbrevisionesmecanicasCollection = tbrevisionesmecanicasCollection;
    }

    @XmlTransient
    public Collection<Tbvehiculosconductores> getTbvehiculosconductoresCollection() {
        return tbvehiculosconductoresCollection;
    }

    public void setTbvehiculosconductoresCollection(Collection<Tbvehiculosconductores> tbvehiculosconductoresCollection) {
        this.tbvehiculosconductoresCollection = tbvehiculosconductoresCollection;
    }

    public Tbgrupovehiculos getIdgrupo() {
        return idgrupo;
    }

    public void setIdgrupo(Tbgrupovehiculos idgrupo) {
        this.idgrupo = idgrupo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (placa != null ? placa.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tbvehiculos)) {
            return false;
        }
        Tbvehiculos other = (Tbvehiculos) object;
        if ((this.placa == null && other.placa != null) || (this.placa != null && !this.placa.equals(other.placa))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ugt.entidades.Tbvehiculos[ placa=" + placa + " ]";
    }
    
}
