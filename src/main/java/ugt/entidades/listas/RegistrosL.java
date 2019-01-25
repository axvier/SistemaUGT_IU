package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbregistros;

/**
 *
 * @author Xavy PC
 */
public class RegistrosL {
    private List<Tbregistros> lista = new ArrayList<>();

    public List<Tbregistros> getLista() {
        return lista;
    }

    public void setLista(List<Tbregistros> lista) {
        this.lista = lista;
    }
    
    public void add(Tbregistros item){
        this.lista.add(item);
    }
    
    public Tbregistros itemPos(int pos){
        return this.lista.get(pos);
    }
}
