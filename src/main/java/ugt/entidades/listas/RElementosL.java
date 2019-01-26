package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.reportes.RElemento;

/**
 *
 * @author Xavy PC
 */
public class RElementosL {
    private List<RElemento> lista = new ArrayList<>();

    public List<RElemento> getLista() {
        return lista;
    }

    public void setLista(List<RElemento> lista) {
        this.lista = lista;
    }
    
    public void add(RElemento item){
        this.lista.add(item);
    }
    public RElemento itemPos(int pos){
        return this.lista.get(pos);
    }
}
