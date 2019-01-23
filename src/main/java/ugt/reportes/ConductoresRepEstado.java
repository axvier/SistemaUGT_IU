package ugt.reportes;

/**
 *
 * @author Xavy PC
 */
public class ConductoresRepEstado {

    private int disponibles;
    private int ocupados;
    private int indispuestos;
    private int jubilados;

    public int getDisponibles() {
        return disponibles;
    }

    public void setDisponibles(int disponibles) {
        this.disponibles = disponibles;
    }

    public int getOcupados() {
        return ocupados;
    }

    public void setOcupados(int ocupados) {
        this.ocupados = ocupados;
    }

    public int getIndispuestos() {
        return indispuestos;
    }

    public void setIndispuestos(int indispuestos) {
        this.indispuestos = indispuestos;
    }

    public int getJubilados() {
        return jubilados;
    }

    public void setJubilados(int jubilados) {
        this.jubilados = jubilados;
    }

    public ConductoresRepEstado() {
        this.disponibles = 0;
        this.indispuestos = 0;
        this.jubilados = 0;
        this.ocupados = 0;
    }
}
