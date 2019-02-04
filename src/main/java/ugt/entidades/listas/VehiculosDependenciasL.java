/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbvehiculosdependencias;

/**
 *
 * @author Xavy PC
 */
public class VehiculosDependenciasL {

    private List<Tbvehiculosdependencias> lista = new ArrayList<>();

    public List<Tbvehiculosdependencias> getLista() {
        return lista;
    }

    public void setLista(List<Tbvehiculosdependencias> lista) {
        this.lista = lista;
    }

    public void add(Tbvehiculosdependencias item) {
        this.lista.add(item);
    }

    public Tbvehiculosdependencias itemPos(int pos) {
        return this.lista.get(pos);
    }
}
