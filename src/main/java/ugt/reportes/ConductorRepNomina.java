package ugt.reportes;

import java.util.List;
import ugt.entidades.Tbconductores;
import ugt.entidades.Tblicencias;
import ugt.entidades.Tbvehiculosdependencias;

/**
 *
 * @author Xavy PC
 */
public class ConductorRepNomina {

    private Tbconductores conductor;
    private Tblicencias licencia;
    private List<Tbvehiculosdependencias> listavehiculo;

    public List<Tbvehiculosdependencias> getListavehiculo() {
        return listavehiculo;
    }

    public void setListavehiculo(List<Tbvehiculosdependencias> listavehiculo) {
        this.listavehiculo = listavehiculo;
    }

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
