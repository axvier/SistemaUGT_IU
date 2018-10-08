/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbvehiculos;

/**
 *
 * @author Evelyn
 */
public class VehiculosL {
    private List<Tbvehiculos> vehiculo=new ArrayList<>();

    /**
     * @return the vehiculo
     */
    public List<Tbvehiculos> getVehiculo() {
        return vehiculo;
    }

    /**
     * @param vehiculo the vehiculo to set
     */
    public void setVehiculo(List<Tbvehiculos> vehiculo) {
        this.vehiculo = vehiculo;
    }
    
    
}
