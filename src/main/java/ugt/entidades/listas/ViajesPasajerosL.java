package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbviajepasajero;

/**
 *
 * @author Xavy PC
 */
public class ViajesPasajerosL {

    private List<Tbviajepasajero> lista = new ArrayList<>();

    public List<Tbviajepasajero> getLista() {
        return lista;
    }

    public void setLista(List<Tbviajepasajero> lista) {
        this.lista = lista;
    }

    public void add(Tbviajepasajero item) {
        this.lista.add(item);
    }

    public Tbviajepasajero itemPos(Integer pos) {
        return this.lista.get(pos);
    }
}
