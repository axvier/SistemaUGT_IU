package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbopciones;

/**
 *
 * @author Xavy PC
 */
public class OpcionesL {
    private List<Tbopciones> lista = new ArrayList<>();

    public List<Tbopciones> getLista() {
        return lista;
    }

    public void setLista(List<Tbopciones> lista) {
        this.lista = lista;
    }
    
    public void add(Tbopciones item){
        this.lista.add(item);
    }
    
    public Tbopciones itemPos(int pos){
        return this.lista.get(pos);
    }
}
