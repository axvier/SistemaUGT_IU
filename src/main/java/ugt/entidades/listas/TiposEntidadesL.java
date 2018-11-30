package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbtipoentidad;

/**
 *
 * @author Xavy PC
 */
public class TiposEntidadesL {

    private List<Tbtipoentidad> lista = new ArrayList<>();

    public List<Tbtipoentidad> getLista() {
        return lista;
    }

    public void setLista(List<Tbtipoentidad> lista) {
        this.lista = lista;
    }

    public void add(Tbtipoentidad item) {
        this.lista.add(item);
    }

    public Tbtipoentidad itemPos(int pos) {
        return this.lista.get(pos);
    }
}
