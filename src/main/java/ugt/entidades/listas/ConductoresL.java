/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.entidades.listas;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbconductores;

/**
 *
 * @author Xavier Aranda
 */
public class ConductoresL {
    private List<Tbconductores> listaconductores = new ArrayList<>();

    public List<Tbconductores> getListaconductores() {
        return listaconductores;
    }

    public void setListaconductores(List<Tbconductores> listaconductores) {
        this.listaconductores = listaconductores;
    }
    
    public void add(Tbconductores dato){
        this.listaconductores.add(dato);
    }
    
    public Tbconductores itemPos(Integer pos) {
        return this.listaconductores.get(pos);
    }
    
}