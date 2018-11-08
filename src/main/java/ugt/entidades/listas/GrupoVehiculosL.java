package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbgrupovehiculos;

/**
 *
 * @author Xavy PC
 */
public class GrupoVehiculosL {
    List<Tbgrupovehiculos> lista = new ArrayList<>();

    public List<Tbgrupovehiculos> getLista() {
        return lista;
    }

    public void setLista(List<Tbgrupovehiculos> lista) {
        this.lista = lista;
    }
    
    public void add(Tbgrupovehiculos item) {
        this.lista.add(item);
    }
    
    public Tbgrupovehiculos itemPos(int pos){
        return this.lista.get(pos);
    }
}
