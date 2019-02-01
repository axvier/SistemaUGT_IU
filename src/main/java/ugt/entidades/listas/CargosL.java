package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbcargos;

/**
 *
 * @author Xavy PC
 */
public class CargosL {

    private List<Tbcargos> lista = new ArrayList<>();

    public List<Tbcargos> getLista() {
        return lista;
    }

    public void setLista(List<Tbcargos> lista) {
        this.lista = lista;
    }

    public void add(Tbcargos item) {
        this.lista.add(item);
    }

    public Tbcargos itemPos(int pos) {
        return this.lista.get(pos);
    }
}
