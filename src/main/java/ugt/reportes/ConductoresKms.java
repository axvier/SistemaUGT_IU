/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.reportes;

import java.util.List;
import ugt.entidades.Tbconductores;
import ugt.entidades.Tbordenesmovilizaciones;

/**
 *
 * @author Xavy PC
 */
public class ConductoresKms {
    private Tbconductores conductor;
    private List<Tbordenesmovilizaciones> ordenes;

    public Tbconductores getConductor() {
        return conductor;
    }

    public void setConductor(Tbconductores conductor) {
        this.conductor = conductor;
    }

    public List<Tbordenesmovilizaciones> getOrdenes() {
        return ordenes;
    }

    public void setOrdenes(List<Tbordenesmovilizaciones> ordenes) {
        this.ordenes = ordenes;
    }
    
}
