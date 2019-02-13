/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.pdf.iu;

import com.itextpdf.text.BadElementException;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.ExceptionConverter;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPCellEvent;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import utils.Constantes;

/**
 *
 * @author Xavy PC
 */
public class Encabezado extends PdfPageEventHelper {

    protected PdfPTable table;
    protected float tableHeight;

    class ImageBackgroundEvent implements PdfPCellEvent {

        protected Image image;

        public ImageBackgroundEvent(Image image) {
            this.image = image;
        }

        public void cellLayout(PdfPCell cell, Rectangle position,
                PdfContentByte[] canvases) {
            try {
                PdfContentByte cb = canvases[PdfPTable.BACKGROUNDCANVAS];
                image.scaleAbsolute(position);
                image.setAbsolutePosition(position.getLeft(), position.getBottom());
                cb.addImage(image);
            } catch (DocumentException e) {
                throw new ExceptionConverter(e);
            }
        }

    }

    public Encabezado(Paragraph parrafo) throws BadElementException, IOException {
        //instancia de la tabla a insertar en el encabezado 
        //tabla con una fila
        table = new PdfPTable(1);
        //establecer el ancho
        table.setTotalWidth(558);
        table.setLockedWidth(true);
        //instancia de la celda para la tabla
        parrafo.setAlignment(Element.ALIGN_CENTER);
        PdfPCell espoch = new PdfPCell();
        espoch.addElement(parrafo);
        espoch.setBorder(Rectangle.NO_BORDER);
        espoch.setVerticalAlignment(Element.ALIGN_BOTTOM);
        // instancia de la imgen localicada en src
        String data1 = Constantes.ENCABEZADOIMG;
        String base64Image1 = data1.split(",")[1];
        byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image1);
        Image imagen = Image.getInstance(imageBytes);
        // add imagen en la celda
        espoch.setCellEvent(new ImageBackgroundEvent(imagen));
        espoch.setFixedHeight(580 * imagen.getScaledHeight() / imagen.getScaledWidth());
        //add celda en la tabla
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
}
