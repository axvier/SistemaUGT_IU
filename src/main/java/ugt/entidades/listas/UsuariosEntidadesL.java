package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbusuariosentidad;

/**
 *
 * @author Xavy PC
 */
public class UsuariosEntidadesL {

    private List<Tbusuariosentidad> lista = new ArrayList<>();

    public List<Tbusuariosentidad> getLista() {
        return lista;
    }

    public void setLista(List<Tbusuariosentidad> lista) {
        this.lista = lista;
    }
    
    public void add(Tbusuariosentidad item){
        this.lista.add(item);
    }

    public Tbusuariosentidad itemPos(int pos) {
        return this.lista.get(pos);
    }
}
