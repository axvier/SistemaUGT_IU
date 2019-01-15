/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.salvoconducto;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import ugt.solicitudes.Solicitudesfull;

/**
 *
 * @author Xavy PC
 */
public class OrdenMovilizacionPDF extends Solicitudesfull {

    public ByteArrayOutputStream generarPDF() {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            Document document = new Document(PageSize.A4, 60, 55, 55, 45);
            PdfWriter write = PdfWriter.getInstance(document, baos);
            document.open();
            document.newPage();
            Paragraph serieOficio = new Paragraph("Oficio", fcambria_Normal());
            document.add(serieOficio);
            document.close();
        } catch (DocumentException e) {
        }
        return baos;
    }

    private Font fcambria_Normal() {
        Font fuente = FontFactory.getFont("f-Cambria");
        fuente.setSize(10);
        fuente.setStyle(Font.NORMAL);
        return fuente;
    }
}
