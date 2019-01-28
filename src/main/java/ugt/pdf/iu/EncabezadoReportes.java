/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.pdf.iu;

import com.itextpdf.text.BadElementException;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import utils.Constantes;

/**
 *
 * @author Xavy PC
 */
public class EncabezadoReportes extends PdfPageEventHelper {

    protected PdfPTable table;
    protected float tableHeight;

    public EncabezadoReportes(Paragraph parrafo, float ancho) throws BadElementException, IOException, DocumentException {
        table = new PdfPTable(2);
        //establecer el ancho
        table.setTotalWidth(ancho);
        table.setLockedWidth(true);
        table.setWidths(new float[]{12, 88});
        // instancia de la imgen localicada en src
        Image imagen = Image.getInstance(Constantes.SRCIMGENORDEN);
        imagen.scaleToFit(75, 95);
        PdfPCell espoch = new PdfPCell(imagen);
        espoch.setBorder(Rectangle.NO_BORDER);
        espoch.setPaddingRight(14);
        espoch.setVerticalAlignment(Element.ALIGN_LEFT);
        espoch.setRowspan(3);
        table.addCell(espoch);
        //instancia de la celda para la tabla
        espoch = new PdfPCell(new Paragraph("ESPOCH", timesNewRomanBold(30)));
        espoch.setBorder(Rectangle.NO_BORDER);
        espoch.setHorizontalAlignment(Element.ALIGN_LEFT);
        espoch.setPaddingTop(10);
        table.addCell(espoch);

        espoch = new PdfPCell(new Paragraph("ESCUELA SUPERIOR POLITÉCNICA DEL CHIMBORAZO", timesNewRomanNormal((float) 14)));
        espoch.setBorder(Rectangle.NO_BORDER);
        espoch.setHorizontalAlignment(Element.ALIGN_LEFT);
        espoch.setPaddingBottom(10);
        table.addCell(espoch);

        espoch = new PdfPCell();
        parrafo.setAlignment(Element.ALIGN_CENTER);
        espoch.addElement(parrafo);
        espoch.setBorder(Rectangle.NO_BORDER);
        espoch.setBackgroundColor(new BaseColor(66, 169, 74));
        espoch.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(espoch);

        tableHeight = table.getTotalHeight();
    }
    
    public EncabezadoReportes(Paragraph parrafo, float ancho, float alto) throws BadElementException, IOException, DocumentException {
        table = new PdfPTable(2);
        //establecer el ancho
        table.setTotalWidth(ancho);
        table.setLockedWidth(true);
        table.setWidths(new float[]{(14*alto/100), (88*alto/100)});
        // instancia de la imgen localicada en src
        Image imagen = Image.getInstance(Constantes.SRCIMGENORDEN);
        imagen.scaleToFit((75*alto)/100, (100*alto)/100);
        PdfPCell espoch = new PdfPCell(imagen);
        espoch.setBorder(Rectangle.NO_BORDER);
        espoch.setPaddingRight(14*alto/100);
        espoch.setVerticalAlignment(Element.ALIGN_LEFT);
        espoch.setRowspan(3);
        table.addCell(espoch);
        //instancia de la celda para la tabla
        espoch = new PdfPCell(new Paragraph("ESPOCH", timesNewRomanBold(30*alto/100)));
        espoch.setBorder(Rectangle.NO_BORDER);
        espoch.setHorizontalAlignment(Element.ALIGN_LEFT);
        espoch.setPaddingTop(10*alto/100);
        table.addCell(espoch);

        espoch = new PdfPCell(new Paragraph("ESCUELA SUPERIOR POLITÉCNICA DEL CHIMBORAZO", timesNewRomanNormal((float) (14*alto/100))));
        espoch.setBorder(Rectangle.NO_BORDER);
        espoch.setHorizontalAlignment(Element.ALIGN_LEFT);
        espoch.setPaddingBottom(10*alto/100);
        table.addCell(espoch);

        espoch = new PdfPCell();
        parrafo.setAlignment(Element.ALIGN_CENTER);
        espoch.addElement(parrafo);
        espoch.setBorder(Rectangle.NO_BORDER);
        espoch.setBackgroundColor(new BaseColor(66, 169, 74));
        espoch.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(espoch);

        tableHeight = table.getTotalHeight();
    }

    public float getTableHeight() {
        return tableHeight;
    }

    public void onEndPage(PdfWriter writer, Document document) {
        table.writeSelectedRows(0, -1,
                document.left(),
                document.top() + ((document.topMargin() + tableHeight) / 2),
                writer.getDirectContent());
    }

    private Font timesNewRomanBold(float size) {
        Font fuenteTotal = new Font(Font.FontFamily.TIMES_ROMAN, 11, Font.BOLD, BaseColor.BLACK);
        fuenteTotal.setSize(size);
        fuenteTotal.setFamily(Font.FontFamily.TIMES_ROMAN.name());
        fuenteTotal.setColor(BaseColor.BLACK);
        return fuenteTotal;
    }

    private Font timesNewRomanNormal(float size) {
        Font fuenteTotal = new Font(Font.FontFamily.TIMES_ROMAN, 11, Font.NORMAL, BaseColor.BLACK);
        fuenteTotal.setSize(size);
        fuenteTotal.setFamily("Times Roman");
        fuenteTotal.setColor(BaseColor.BLACK);
        return fuenteTotal;
    }

    public PdfPTable getTable() {
        return table;
    }

    public void setTable(PdfPTable table) {
        this.table = table;
    }

}
