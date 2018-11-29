package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbentidad;

/**
 *
 * @author Xavy PC
 */
public class EntidadesL {
    private List<Tbentidad> lista = new ArrayList<>();

    public List<Tbentidad> getLista() {
        return lista;
    }

    public void setLista(List<Tbentidad> lista) {
        this.lista = lista;
    }
    
    public void add(Tbentidad item){
        this.lista.add(item);
    }
    
    public Tbentidad itemPos(int pos){
        return this.lista.get(pos);
    }
}
