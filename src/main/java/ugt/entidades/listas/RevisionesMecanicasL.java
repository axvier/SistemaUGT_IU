package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbrevisionesmecanicas;

/**
 * Clase para definir la lista de revisiones mecánicas
 *
 * @author Xavy PC
 */
public class RevisionesMecanicasL {

    /**
     * Atributo tipo lista de la clase Tbrevisionesmecanicas
     */
    private List<Tbrevisionesmecanicas> lista = new ArrayList<>();

    /**
     * Método que define el retorno de la lista de revisiones
     *
     * @return lista
     */
    public List<Tbrevisionesmecanicas> getLista() {
        return lista;
    }

    /**
     * Método que define el ingreso de un valor tipo lista en el atributo lista
     *
     * @param lista
     */
    public void setLista(List<Tbrevisionesmecanicas> lista) {
        this.lista = lista;
    }

    /**
     * Método que define el ingreso de un valor de tipo Tbrevisionesmecanicas,
     * como un item en la lista
     *
     * @param item
     */
    public void addItem(Tbrevisionesmecanicas item) {
        this.lista.add(item);
    }

    /**
     * Método que define el retorno de un valor de la lista de acuerdo a la
     * posición
     *
     * @param pos
     * @return TbrevisionesMecanicas
     */
    public Tbrevisionesmecanicas itemPos(int pos) {
        return this.lista.get(pos);
    }
}
