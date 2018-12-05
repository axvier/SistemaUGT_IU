package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbrolesopciones;

/**
 *
 * @author Xavy PC
 */
public class RolesOpcionesL {

    private List<Tbrolesopciones> lista = new ArrayList<>();

    public List<Tbrolesopciones> getLista() {
        return lista;
    }

    public void setLista(List<Tbrolesopciones> lista) {
        this.lista = lista;
    }
    
    public void add(Tbrolesopciones item){
        this.lista.add(item);
    }
    
    public Tbrolesopciones itemPos(int pos){
        return this.lista.get(pos);
    }
}
