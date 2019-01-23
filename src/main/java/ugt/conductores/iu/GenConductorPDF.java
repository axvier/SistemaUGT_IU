/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.conductores.iu;

import java.util.ArrayList;
import java.util.List;
import ugt.reportes.ConductorRepNomina;

/**
 *
 * @author Xavy PC
 */
public class GenConductorPDF {
    private List<ConductorRepNomina> listaConductor = new ArrayList<>();

    public List<ConductorRepNomina> getListaConductor() {
        return listaConductor;
    }

    public void setListaConductor(List<ConductorRepNomina> listaConductor) {
        this.listaConductor = listaConductor;
    }
    
    
}
