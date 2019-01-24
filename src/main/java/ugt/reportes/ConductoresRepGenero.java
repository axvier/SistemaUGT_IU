/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.reportes;

/**
 *
 * @author Xavy PC
 */
public class ConductoresRepGenero {

    private int masculino;
    private int femenino;
    private int otros;

    public int getOtros() {
        return otros;
    }

    public void setOtros(int otros) {
        this.otros = otros;
    }

    public int getMasculino() {
        return masculino;
    }

    public void setMasculino(int masculino) {
        this.masculino = masculino;
    }

    public int getFemenino() {
        return femenino;
    }

    public void setFemenino(int femenino) {
        this.femenino = femenino;
    }

    public ConductoresRepGenero() {
        masculino = 0;
        femenino = 0;
        otros = 0;
    }
}
