package ugt.reportes;

import ugt.entidades.Tbconductores;
import ugt.entidades.Tblicencias;

/**
 *
 * @author Xavy PC
 */
public class ConductorRepNomina {

    private Tbconductores conductor;
    private Tblicencias licencia;

    public Tbconductores getConductor() {
        return conductor;
    }

    public void setConductor(Tbconductores conductor) {
        this.conductor = conductor;
    }

    public Tblicencias getLicencia() {
        return licencia;
    }

    public void setLicencia(Tblicencias licencia) {
        this.licencia = licencia;
    }

}
