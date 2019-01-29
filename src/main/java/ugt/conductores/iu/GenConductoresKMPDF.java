/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.conductores.iu;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import ugt.entidades.Tbordenesmovilizaciones;
import ugt.pdf.iu.EncabezadoReportes;
import ugt.reportes.ConductoresKms;

/**
 *
 * @author Xavy PC
 */
public class GenConductoresKMPDF {

    private List<ConductoresKms> listaconductoreskm = new ArrayList<>();

    /**
     * Parametro define el tamaño de la fuente en general
     */
    private static final float FONTSIZEGENERAL = 11;
    private String startFecha;
    private String endFecha;

    public String getStartFecha() {
        return startFecha;
    }

    public void setStartFecha(String startFecha) {
        this.startFecha = startFecha;
    }

    public String getEndFecha() {
        return endFecha;
    }

    public void setEndFecha(String endFecha) {
        this.endFecha = endFecha;
    }

    public List<ConductoresKms> getListaconductoreskm() {
        return listaconductoreskm;
    }

    public void setListaconductoreskm(List<ConductoresKms> listaconductoreskm) {
        this.listaconductoreskm = listaconductoreskm;
    }

    public ByteArrayOutputStream generarReporteConductorOrdenPDF() {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
//    public String generarReporteConductorOrdenPDF() {
//        String result = "";
        try {
            /**
             * Instancia de la clase encabezad, enviando como datos el parrafo
             * de la unidad y el tamaño total del encabezado, al constructor
             */
            EncabezadoReportes event = new EncabezadoReportes(new Paragraph("UNIDAD DE GESTIÓN DE TRANSPORTE", timesNewRomanNormalColor((float) 12.5, BaseColor.WHITE)), (float) 550,80);
            /**
             * Instancia del documento enviando al constructor el formato hoja
             * el margen izq, margen der, margen superior + ancho del
             * encabezado, margen inferior
             */
            Document document = new Document(PageSize.A4, 20, 20, 10 + event.getTableHeight(), 20);
            //inicio eliminar despues
//            File myfile = new File("D:\\pdfs\\out.pdf");
//            result = myfile.getName();
//            FileOutputStream baos = new FileOutputStream(myfile);
            //fin eliminar despues
            /**
             * Uso de la clase pdfp write para escribir el encabezado en el
             * documento y en arhivo de salida
             */
            PdfWriter write = PdfWriter.getInstance(document, baos);
            write.setPageEvent(event);
            /**
             * Abrimos el documento para empezar a escribir en el
             */
            document.open();
            /**
             * Ingresamos la orientacion del documento
             */
//            document.setPageSize(PageSize.A4.rotate());
            /**
             * Insertamos una pagina
             */
            document.newPage();
            /**
             * Parrafo titulo
             */
            Paragraph titulo = new Paragraph();

            titulo = new Paragraph("INFORME CONTROL CONDUCTORES: " + this.getRangoFecha(), timesNewRomanBold(12));
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);

            titulo = new Paragraph(getFechaActual() + " hora " + getHoraActual(), timesNewRomanCursiva(9));
            titulo.setAlignment(Element.ALIGN_RIGHT);
            document.add(titulo);
//            document.add(new Paragrasph(" "));
            /**
             * Inicio tabla nomina
             */
            PdfPTable tablaNomina = new PdfPTable(5);
            tablaNomina.setWidthPercentage(100f);
            tablaNomina.setWidths(new float[]{
                5, 15, 30, 30, 20});
            /**
             * Inicio de encabezado de tablas
             */
            PdfPCell celda = new PdfPCell(new Paragraph("No", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Cédula", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Apellidos", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Nombres", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Km total", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);
            /**
             * fin encabezado de tablas
             */
            /**
             * Inicio lista de nomina
             */
            int cont = 1;
            for (ConductoresKms condOrdenes : this.getListaconductoreskm()) {
                Paragraph valor = new Paragraph();
                celda = new PdfPCell();
                /**
                 * Ingreso de numero orden
                 */
                valor = new Paragraph(String.valueOf(cont++), timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingreso de Cedula
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getConductorCedula(condOrdenes));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingreso de Apellidos
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getConductorApellidos(condOrdenes));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_JUSTIFIED);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingreso de Nombres
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getConductorNombres(condOrdenes));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_JUSTIFIED);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingreso de kms totales
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getOrdenKmsTotal(condOrdenes));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
            }
            /**
             * Fin lista de nomina
             */
            document.add(tablaNomina);
            /**
             * fin tabla nomina
             */
            document.close();
//        } catch (DocumentException e) {
        } catch (DocumentException | IOException e) {
        }
        return baos;
//        return result;
    }

    private String getOrdenKmsTotal(ConductoresKms condOrden) {
        String result = " ";
        try {
            if (condOrden != null && condOrden.getOrdenes() != null) {
                long count = 0;
                for (Tbordenesmovilizaciones orden : condOrden.getOrdenes()) {
                    count += Long.parseLong(orden.getKmfin()) - Long.parseLong(orden.getKminicio());
                }
                result = String.valueOf(count);
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer nombres de condcutor kmfinal ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getConductorNombres(ConductoresKms condOrden) {
        String result = " ";
        try {
            if (condOrden != null && condOrden.getConductor() != null && condOrden.getConductor().getNombres() != null) {
                result = condOrden.getConductor().getNombres();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer nombres de condcutor kmfinal ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getConductorApellidos(ConductoresKms condOrden) {
        String result = " ";
        try {
            if (condOrden != null && condOrden.getConductor() != null && condOrden.getConductor().getApellidos() != null) {
                result = condOrden.getConductor().getApellidos();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer Apellidos de condcutor kmfinal ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getConductorCedula(ConductoresKms condOrden) {
        String result = " ";
        try {
            if (condOrden != null && condOrden.getConductor() != null && condOrden.getConductor().getCedula() != null) {
                result = condOrden.getConductor().getCedula();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en xtraer cedula de condcutor kmfinal ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getRangoFecha() {
        String result = " ";
        try {
            if (this.getStartFecha() != null && this.getEndFecha() != null) {
                result = this.getStartFecha() + " - " + this.endFecha;
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en xtraer fecha actual oficio ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getHoraActual() {
        String result = " ";
        try {
            Date date = new Date();
            String strDateFormat = "HH:mm";
            DateFormat dateFormat = new SimpleDateFormat(strDateFormat);
            result = dateFormat.format(date);
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en xtraer fecha actual oficio ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getFechaActual() {
        String result = " ";
        try {
            DateFormat sdf = new SimpleDateFormat("dd 'de' MMMMM 'de' yyyy");
            Date actualDate = new Date();
            String dateTxt = sdf.format(actualDate);
            result = "Riobamba, " + dateTxt;
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en xtraer fecha actual oficio ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private Font timesNewRomanCursiva(float size) {
        Font fuenteTotal = new Font(Font.FontFamily.TIMES_ROMAN, 11, Font.ITALIC, BaseColor.BLACK);
        fuenteTotal.setSize(size);
        fuenteTotal.setFamily("Times Roman");
        fuenteTotal.setColor(BaseColor.BLACK);
        return fuenteTotal;
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

    private Font timesNewRomanNormalColor(float size, BaseColor color) {
        Font fuenteTotal = new Font(Font.FontFamily.TIMES_ROMAN, 11, Font.NORMAL, color);
        fuenteTotal.setSize(size);
        fuenteTotal.setFamily("Times Roman");
        fuenteTotal.setColor(color);
        return fuenteTotal;
    }
}
