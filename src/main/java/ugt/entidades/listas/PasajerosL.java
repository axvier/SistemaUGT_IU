package ugt.entidades.listas;

import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbpasajeros;

/**
 *
 * @author Xavy PC
 */
public class PasajerosL {

    private List<Tbpasajeros> lista = new ArrayList<>();

    public List<Tbpasajeros> getLista() {
        return lista;
    }

    public void setLista(List<Tbpasajeros> lista) {
        this.lista = lista;
    }

    public void add(Tbpasajeros item) {
        this.lista.add(item);
    }

    public Tbpasajeros itemPos(int pos) {
        return this.lista.get(pos);
    }
}
