/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.vehiculos.iu;

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
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import ugt.entidades.Tbrevisionesmecanicas;
import ugt.entidades.Tbvehiculosdependencias;
import ugt.pdf.iu.EncabezadoReportes;
import ugt.reportes.ConductorRepNomina;
import ugt.reportes.VehiculosRepNomina;

/**
 *
 * @author Xavy PC
 */
public class GenVehiculosNomina {

    private List<VehiculosRepNomina> listavehiculos = new ArrayList<>();

    /**
     * Parametro define el tamaño de la fuente en general
     */
    private static final float FONTSIZEGENERAL = 10;

    public List<VehiculosRepNomina> getListavehiculos() {
        return listavehiculos;
    }

    public void setListavehiculos(List<VehiculosRepNomina> listavehiculos) {
        this.listavehiculos = listavehiculos;
    }

    public ByteArrayOutputStream generarNominaPDF() {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
//    public String generarPDF() {
//        String baos = "";
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
//            File myfile = new File("D:\\pdfs\\out.pdf");
//            result = myfile.getName();
//            FileOutputStream baos = new FileOutputStream(myfile);
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

            titulo = new Paragraph("NÓMINA DE VEHÍCULOS INSTITUCIONALES", timesNewRomanBold(12));
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);
            document.add(new Paragraph(" "));
            /**
             * Inicio tabla nomina
             */
            PdfPTable tablaNomina = new PdfPTable(12);
            tablaNomina.setWidthPercentage(100f);
            tablaNomina.setWidths(new float[]{
                4, 7, 5, 8,
                7, 8, 11, 11,
                4, 9, 14, 12
            });//n-placa-disco-marca/modelo
//            -color-matricula- tipo-motor
//            -revisiones-ultima-conductor-depenecia
            /**
             * Inicio de encabezado de tablas
             */
            PdfPCell celda = new PdfPCell(new Paragraph("No", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Placa", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Disco", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Marca/Modelo", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Color", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Matrícula", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Tipo Vehículo", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Motor", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Total revisiones", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Ultima revision", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Conductor", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Dependencia", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
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
            for (VehiculosRepNomina vehiculos : this.getListavehiculos()) {
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
                 * Ingerso de placa
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoPlaca(vehiculos));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de disco
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoDisco(vehiculos));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de marca
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoMarca_Modelo(vehiculos));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de color
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoColor(vehiculos));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de matricula año
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoAnioMatricula(vehiculos));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de tipo vehiculo
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoTipoAuto(vehiculos));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de motor vehiculo
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoMotor(vehiculos));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de motor revisiones
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoRevisionesTotal(vehiculos));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de revision última
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoRevisionesUltima(vehiculos));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de conductor
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getConductorNombres(vehiculos));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de dependencias
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoDependencia(vehiculos));
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
        } catch (DocumentException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en generar conductor pdf - nominaPDF ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return baos;
    }

    private String getVehiculoDependencia(VehiculosRepNomina nomina) {
        String result = " ";
        try {
            if (nomina.getVehiculoDependencia() != null && nomina.getVehiculoDependencia().getTbentidad() != null
                    && nomina.getVehiculoDependencia().getTbentidad().getNombre() != null) {
                result = nomina.getVehiculoDependencia().getTbentidad().getCodigoentidad() + " " + nomina.getVehiculoDependencia().getTbentidad().getNombre();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer dependencia vehiculo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getConductorNombres(VehiculosRepNomina nomina) {
        String result = " ";
        try {
            if (nomina.getVehiculoConductor() != null && nomina.getVehiculoConductor().getTbconductores() != null
                    && nomina.getVehiculoConductor().getTbconductores().getApellidos() != null && nomina.getVehiculoConductor().getTbconductores().getNombres() != null) {
                result = nomina.getVehiculoConductor().getTbconductores().getApellidos() + " " + nomina.getVehiculoConductor().getTbconductores().getNombres();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer nombres conductores ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoRevisionesUltima(VehiculosRepNomina nomina) {
        String result = " ";
        try {
            if (nomina.getRevisiones() != null) {
                if (nomina.getRevisiones().size() > 0) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    result = sdf.format(nomina.getRevisiones().get(0).getFecha());
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer total revisiones ultima de vehiculo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoRevisionesTotal(VehiculosRepNomina nomina) {
        String result = "0";
        try {
            if (nomina.getRevisiones() != null) {
                int total = 0;
                total = nomina.getRevisiones().size();
                result = String.valueOf(total);
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer total revisiones de vehiculo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoMotor(VehiculosRepNomina nomina) {
        String result = " ";
        try {
            if (nomina.getVehiculo() != null && nomina.getVehiculo().getMotor() != null) {
                result = nomina.getVehiculo().getMotor();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer motor de vehiculo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoTipoAuto(VehiculosRepNomina nomina) {
        String result = " ";
        try {
            if (nomina.getVehiculo() != null && nomina.getVehiculo().getIdgrupo() != null && nomina.getVehiculo().getIdgrupo().getNombre() != null) {
                result = nomina.getVehiculo().getIdgrupo().getNombre();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer tipo de vehiculo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoAnioMatricula(VehiculosRepNomina nomina) {
        String result = " ";
        try {
            if (nomina.getVehiculo() != null) {
                result = String.valueOf(nomina.getVehiculo().getAnio());
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer anio de vehiculo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoColor(VehiculosRepNomina nomina) {
        String result = " ";
        try {
            if (nomina.getVehiculo() != null && nomina.getVehiculo().getColor() != null) {
                result = nomina.getVehiculo().getColor().toUpperCase();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer color de vehiculo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoMarca_Modelo(VehiculosRepNomina nomina) {
        String result = " ";
        try {
            if (nomina.getVehiculo() != null && nomina.getVehiculo().getMarca() != null && nomina.getVehiculo().getModelo() != null) {
                result = nomina.getVehiculo().getMarca() + " / " + nomina.getVehiculo().getModelo();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer marca/modelo de vehiculo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoDisco(VehiculosRepNomina nomina) {
        String result = " ";
        try {
            if (nomina.getVehiculo() != null) {
                result = String.valueOf(nomina.getVehiculo().getDisco());
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer disco de vehiculo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoPlaca(VehiculosRepNomina nomina) {
        String result = " ";
        try {
            if (nomina.getVehiculo() != null && nomina.getVehiculo().getPlaca() != null) {
                result = nomina.getVehiculo().getPlaca();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer placa de vehiculo ", e.getClass().getName() + "****" + e.getMessage());
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
