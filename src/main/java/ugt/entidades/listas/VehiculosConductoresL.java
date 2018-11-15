package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbvehiculosconductores;

/**
 *
 * @author Xavy PC
 */
public class VehiculosConductoresL {
    private List<Tbvehiculosconductores> lista = new ArrayList<>();

    public List<Tbvehiculosconductores> getLista() {
        return lista;
    }

    public void setLista(List<Tbvehiculosconductores> lista) {
        this.lista = lista;
    }
    
    public void add(Tbvehiculosconductores item){
        this.lista.add(item);
    }
    
    public Tbvehiculosconductores itemPos(int pos){
        return this.lista.get(pos);
    }
}
