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
public class RDataset {

    private String label;
    private String background;
    private String borderColor;
    private long data;

    public RDataset() {
    }

    public RDataset(String label, String background, String borderColor, long data) {
        this.label = label;
        this.background = background;
        this.borderColor = borderColor;
        this.data = data;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getBackground() {
        return background;
    }

    public void setBackground(String background) {
        this.background = background;
    }

    public String getBorderColor() {
        return borderColor;
    }

    public void setBorderColor(String borderColor) {
        this.borderColor = borderColor;
    }

    public long getData() {
        return data;
    }

    public void setData(long data) {
        this.data = data;
    }

}
