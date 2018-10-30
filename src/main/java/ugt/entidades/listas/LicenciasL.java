package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tblicencias;

/**
 *
 * @author Xavy PC
 */
public class LicenciasL {
    List<Tblicencias> lista = new ArrayList<>();

    public List<Tblicencias> getLista() {
        return lista;
    }

    public void setLista(List<Tblicencias> lista) {
        this.lista = lista;
    }
    
    public void add(Tblicencias item){
        this.lista.add(item);
    }
    
    public Tblicencias itemPos(int pos){
        return this.lista.get(pos);
    }
}
