/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.reportes;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Xavy PC
 */
public class RElemento {

    private boolean layenda;
    private String titulo;
    private List<RDataset> data;

    public List<RDataset> getData() {
        return data;
    }

    public void setData(List<RDataset> data) {
        this.data = data;
    }

    public RElemento() {
    }

    public boolean isLayenda() {
        return layenda;
    }

    public void setLayenda(boolean layenda) {
        this.layenda = layenda;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }
}
