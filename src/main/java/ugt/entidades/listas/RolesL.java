package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbroles;

/**
 *
 * @author Xavy PC
 */
public class RolesL {
    private List<Tbroles> lista = new ArrayList<>();

    public List<Tbroles> getLista() {
        return lista;
    }

    public void setLista(List<Tbroles> lista) {
        this.lista = lista;
    }
    
    public void add(Tbroles item){
        this.lista.add(item);
    }
    
    public Tbroles itemPos(int pos){
        return this.lista.get(pos);
    }
}
