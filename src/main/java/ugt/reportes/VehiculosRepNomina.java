/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.reportes;

import java.util.List;
import ugt.entidades.Tbrevisionesmecanicas;
import ugt.entidades.Tbvehiculos;
import ugt.entidades.Tbvehiculosconductores;
import ugt.entidades.Tbvehiculosdependencias;

/**
 *
 * @author Xavy PC
 */
public class VehiculosRepNomina {
    private Tbvehiculos vehiculo;
    private List<Tbrevisionesmecanicas> revisiones;
    private Tbvehiculosconductores vehiculoConductor;
    private Tbvehiculosdependencias vehiculoDependencia;

    public Tbvehiculos getVehiculo() {
        return vehiculo;
    }

    public void setVehiculo(Tbvehiculos vehiculo) {
        this.vehiculo = vehiculo;
    }

    public List<Tbrevisionesmecanicas> getRevisiones() {
        return revisiones;
    }

    public void setRevisiones(List<Tbrevisionesmecanicas> revisiones) {
        this.revisiones = revisiones;
    }

    public Tbvehiculosconductores getVehiculoConductor() {
        return vehiculoConductor;
    }

    public void setVehiculoConductor(Tbvehiculosconductores vehiculoConductor) {
        this.vehiculoConductor = vehiculoConductor;
    }

    public Tbvehiculosdependencias getVehiculoDependencia() {
        return vehiculoDependencia;
    }

    public void setVehiculoDependencia(Tbvehiculosdependencias vehiculoDependencia) {
        this.vehiculoDependencia = vehiculoDependencia;
    }
    
    
}
