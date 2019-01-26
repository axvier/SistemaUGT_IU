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
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import ugt.entidades.Tbconductores;
import ugt.entidades.Tbvehiculosdependencias;
import ugt.pdf.iu.EncabezadoReportes;
import ugt.reportes.ConductorRepNomina;

/**
 *
 * @author Xavy PC
 */
public class GenConductorPDF {

    private List<ConductorRepNomina> listaConductor = new ArrayList<>();

    /**
     * Parametro define el tamaño de la fuente en general
     */
    private static final float FONTSIZEGENERAL = 11;

    public List<ConductorRepNomina> getListaConductor() {
        return listaConductor;
    }

    public void setListaConductor(List<ConductorRepNomina> listaConductor) {
        this.listaConductor = listaConductor;
    }

//    public ByteArrayOutputStream generarNominaPDF() {
//        ByteArrayOutputStream baos = new ByteArrayOutputStream();
    public String generarPDF() {
        String result = "";
        try {
            /**
             * Instancia de la clase encabezad, enviando como datos el parrafo
             * de la unidad y el tamaño total del encabezado, al constructor
             */
            EncabezadoReportes event = new EncabezadoReportes(new Paragraph("UNIDAD DE GESTIÓN DE TRANSPORTE", timesNewRomanNormalColor((float) 12.5, BaseColor.WHITE)), (float) 760);
            /**
             * Instancia del documento enviando al constructor el formato hoja
             * el margen izq, margen der, margen superior + ancho del
             * encabezado, margen inferior
             */
            Document document = new Document(PageSize.A4, 40, 40, 20 + event.getTableHeight(), 40);
            /**
             * inicio Para caso de prueba en consola
             */
            File myfile = new File("D:\\pdfs\\out.pdf");
            result = myfile.getName();
            FileOutputStream baos = new FileOutputStream(myfile);
            /**
             * fin de prueba de consola
             */

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
            document.setPageSize(PageSize.A4.rotate());
            /**
             * Insertamos una pagina
             */
            document.newPage();
            /**
             * Parrafo titulo
             */
            Paragraph titulo = new Paragraph();
            titulo = new Paragraph(getFechaActual() + " hora " + getHoraActual(), timesNewRomanCursiva(9));
            titulo.setAlignment(Element.ALIGN_RIGHT);
            document.add(titulo);

            titulo = new Paragraph("NÓMINA DE CONDUCTORES INSTITUCIONALES", timesNewRomanBold(12));
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);
            document.add(new Paragraph(" "));
            /**
             * Inicio tabla nomina
             */
            PdfPTable tablaNomina = new PdfPTable(8);
            tablaNomina.setWidthPercentage(100f);
            tablaNomina.setWidths(new float[]{5, 31, 15, 15, 8, 12, 7, 7});
            /**
             * Inicio de encabezado de tablas
             */
            PdfPCell celda = new PdfPCell(new Paragraph("No", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

//            celda = new PdfPCell(new Paragraph("APELLIDOS", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
//            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
//            celda.setBackgroundColor(new BaseColor(118, 118, 118));
////            celda.setBorderColor(new BaseColor(118, 118, 118));
//            tablaNomina.addCell(celda);
            celda = new PdfPCell(new Paragraph("NOMBRES", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("DNI CONDUCTOR", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("TELÉFONO", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("VEHÍCULOS", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("DEPENDENCIAS", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("LICENCIA", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("PUNTOS", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
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
            int cont = 0;
//            for (int i = 0; i < 20; i++) {
            for (ConductorRepNomina conductor : this.getListaConductor()) {
                /**
                 * Ingreso de numero orden
                 */
                Paragraph valor = new Paragraph();
                celda = new PdfPCell();
                valor = new Paragraph(String.valueOf(cont++), timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de apellidos
                 */
//                    celda = new PdfPCell();
//                    valor = new Paragraph();
//                    if (conductor.getConductor() != null) {
//                        if (conductor.getConductor().getApellidos() != null) {
//                            valor.add(conductor.getConductor().getApellidos());
//                        } else {
//                            valor.add("S/A");
//                        }
//                    } else {
//                        valor.add("S/A");
//                    }
//                    valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
//                    celda.addElement(valor);
//                    celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
//                    tablaNomina.addCell(celda);
                /**
                 * Ingerso de Nombres
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                if (conductor.getConductor() != null && (conductor.getConductor().getNombres() != null && conductor.getConductor().getApellidos() != null)) {
                    valor.add(conductor.getConductor().getApellidos() + " " + conductor.getConductor().getNombres());
                } else {
                    valor.add("S/N");
                }
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de Cedula
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                if (conductor.getConductor() != null) {
                    if (conductor.getConductor().getCedula() != null) {
                        valor.add(conductor.getConductor().getCedula());
                    } else {
                        valor.add("S/D");
                    }
                } else {
                    valor.add("S/D");
                }
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de Telefono
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                if (conductor.getConductor() != null && conductor.getConductor().getTelefono() != null) {
                    valor.add(conductor.getConductor().getTelefono());
                } else {
                    valor.add("S/T");
                }
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de vehículo disco
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                if (conductor.getListavehiculo() != null) {
                    PdfPTable tableVehDep = new PdfPTable(1);
                    for (Tbvehiculosdependencias en : conductor.getListavehiculo()) {
                        PdfPCell celdaVehDep = new PdfPCell();
                        if (en.getTbvehiculos() != null) {
                            celdaVehDep.addElement(new Paragraph("* " + en.getTbvehiculos().getDisco(), timesNewRomanNormal(FONTSIZEGENERAL)));
                        } else {
                            celdaVehDep.addElement(new Paragraph(" "));
                        }
                        celdaVehDep.setBorder(Rectangle.NO_BORDER);
                        tableVehDep.addCell(celdaVehDep);
                    }
                    valor.add(tableVehDep);
                } else {
                    valor.add(" ");
                }
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                celda.addElement(valor);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de Dependencia codigo
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                if (conductor.getListavehiculo() != null) {
                    PdfPTable tableVehDep = new PdfPTable(1);
                    for (Tbvehiculosdependencias en : conductor.getListavehiculo()) {
                        PdfPCell celdaVehDep = new PdfPCell();
                        if (en.getTbdependencias() != null && en.getTbdependencias().getCodigoentidad()!= null) {
                            celdaVehDep.addElement(new Paragraph("* " + en.getTbdependencias().getCodigoentidad(), timesNewRomanNormal(FONTSIZEGENERAL)));
                        } else {
                            celdaVehDep.addElement(new Paragraph(" "));
                        }
                        celdaVehDep.setBorder(Rectangle.NO_BORDER);
                        tableVehDep.addCell(celdaVehDep);
                    }
                    valor.add(tableVehDep);
                } else {
                    valor.add(" ");
                }
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                celda.addElement(valor);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de tipo Licencia
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                if (conductor.getLicencia() != null && conductor.getLicencia().getTipo() != null) {
                    valor.add(conductor.getLicencia().getTipo().toString());
                } else {
                    valor.add("-");
                }
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de puntos licencia
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                if (conductor.getLicencia() != null && conductor.getLicencia().getPuntos() != null) {
                    valor.add(conductor.getLicencia().getPuntos().toString());
                } else {
                    valor.add("0");
                }
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
            }
//            }
            /**
             * Fin lista de nomina
             */
            document.add(tablaNomina);
            /**
             * fin tabla nomina
             */
            document.close();
        } catch (DocumentException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en generar conductor pdf - nominaPDF ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getHoraActual() {
        String result = "_";
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
        String result = "_";
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
