/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.salvoconducto;

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
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import ugt.pdf.iu.EncabezadoReportes;
import ugt.solicitudes.Solicitudesfull;

/**
 *
 * @author Xavy PC
 */
public class ReporteOrdenesPDF {

    private List<Solicitudesfull> listaSolicitudes = new ArrayList<>();
    private static final float FONTSIZEGENERAL = 8;
    private String startFecha;
    private String endFecha;

    public List<Solicitudesfull> getListaSolicitudes() {
        return listaSolicitudes;
    }

    public void setListaSolicitudes(List<Solicitudesfull> listaSolicitudes) {
        this.listaSolicitudes = listaSolicitudes;
    }

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

    public ByteArrayOutputStream generarReporteOrdenPDF() {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
//    public String generarReporteOrdenPDF() {
//        String result = "";
        try {
            /**
             * Instancia de la clase encabezad, enviando como datos el parrafo
             * de la unidad y el tamaño total del encabezado, al constructor
             */
            EncabezadoReportes event = new EncabezadoReportes(new Paragraph("UNIDAD DE GESTIÓN DE TRANSPORTE", timesNewRomanNormalColor((float) 12.5, BaseColor.WHITE)), (float) 770);
            /**
             * Instancia del documento enviando al constructor el formato hoja
             * el margen izq, margen der, margen superior + ancho del
             * encabezado, margen inferior
             */
            Document document = new Document(PageSize.A4, 30, 30, 20, 20);
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
//            write.setPageEvent(event);
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
            document.add(event.getTable());
            Paragraph titulo = new Paragraph();

            titulo = new Paragraph("INFORME CONTROL VEHICULAR: " + this.getRangoFecha(), timesNewRomanBold(12));
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);

            titulo = new Paragraph(getFechaActual() + " hora " + getHoraActual(), timesNewRomanCursiva(9));
            titulo.setAlignment(Element.ALIGN_RIGHT);
            document.add(titulo);
//            document.add(new Paragrasph(" "));
            /**
             * Inicio tabla nomina
             */
            PdfPTable tablaNomina = new PdfPTable(14);
            tablaNomina.setWidthPercentage(100f);
            tablaNomina.setWidths(new float[]{
                4, 7, 4, 13, 6,
                6, 7, 7, 7, 7,
                8, 3, 6, 15});
            /**
             * Inicio de encabezado de tablas
             */
            PdfPCell celda = new PdfPCell(new Paragraph("No", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Solicitud", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Veh", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Conductor", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Origen", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Destino", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("FechaH/S", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Km/S", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("FechaH/E", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Km/E", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Orden", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Días", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Km/T", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            celda.setBackgroundColor(new BaseColor(118, 118, 118));
//            celda.setBorderColor(new BaseColor(118, 118, 118));
            tablaNomina.addCell(celda);

            celda = new PdfPCell(new Paragraph("Motivo", timesNewRomanNormalColor(FONTSIZEGENERAL, BaseColor.WHITE)));
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
            for (Solicitudesfull solicitud : this.getListaSolicitudes()) {
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
                 * Ingerso de Numero Solicitud
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getSolicitudNumero(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de Disco Vehiculo
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getVehiculoDisco(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de nombres conductor
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getConductorNombres(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_JUSTIFIED);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de viaje origen
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getSolicitudOrigen(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_JUSTIFIED);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de viaje destino
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getSolicitudDestino(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_JUSTIFIED);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de viaje fecha hora salida
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getSolictudFechaSalida(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_JUSTIFIED);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de viaje km inicio
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getOrdenKMinicio(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de viaje fecha hora retorno
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getSolictudFechaRetorno(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_JUSTIFIED);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de km fin
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getOrdenKMfin(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de numero de orden
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getOrdenNumero(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_JUSTIFIED);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de numero de dias
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getSolicitudViajeDuracion(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_CENTER);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de kilometraje final
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getOrdenKilometroFinal(solicitud));
                valor.setFont(timesNewRomanNormal(FONTSIZEGENERAL));
                valor.setAlignment(Element.ALIGN_JUSTIFIED);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                tablaNomina.addCell(celda);
                /**
                 * Ingerso de solcitud motivo
                 */
                celda = new PdfPCell();
                valor = new Paragraph();
                valor.add(this.getSolicitudMotivo(solicitud));
                valor.setFont(timesNewRomanNormal(6));
                valor.setAlignment(Element.ALIGN_JUSTIFIED);
                valor.setLeading(7f);
                celda.addElement(valor);
                celda.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
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

    private String getOrdenKilometroFinal(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getOrdenMovilzicion() != null && full.getOrdenMovilzicion().getKminicio() != null && full.getOrdenMovilzicion().getKmfin() != null) {
                result = String.valueOf(Integer.parseInt(full.getOrdenMovilzicion().getKmfin()) - Integer.parseInt(full.getOrdenMovilzicion().getKminicio()));
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el kilometro final de la solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getSolicitudMotivo(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getMotivo() != null && full.getMotivo().getDescripcion() != null) {
                result = full.getMotivo().getDescripcion();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el motivo de la solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getSolicitudViajeDuracion(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getViaje() != null && full.getViaje().getFechasalida() != null && full.getViaje().getFecharetorno() != null) {
                Date salida = full.getViaje().getFechasalida();
                Date retorno = full.getViaje().getFecharetorno();
                long diffInMillies = Math.abs(salida.getTime() - retorno.getTime());
                long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
                result = String.valueOf(diff);
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer la duracion del viaje de la solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getOrdenNumero(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getOrdenMovilzicion() != null && full.getOrdenMovilzicion().getNumeroOrden() != null) {
                result = full.getOrdenMovilzicion().getNumeroOrden();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el numero de la orden ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getOrdenKMfin(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getOrdenMovilzicion() != null && full.getOrdenMovilzicion().getKmfin() != null) {
                result = full.getOrdenMovilzicion().getKmfin();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el kilometro fin de la orden ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getOrdenKMinicio(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getOrdenMovilzicion() != null && full.getOrdenMovilzicion().getKminicio() != null) {
                result = full.getOrdenMovilzicion().getKminicio();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el kilometro inicio de la orden ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getSolictudFechaRetorno(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getViaje() != null && full.getViaje().getFecharetorno() != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                result = sdf.format(full.getViaje().getFecharetorno());
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer la fecha hora de retorno de la solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getSolictudFechaSalida(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getViaje() != null && full.getViaje().getFechasalida() != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                result = sdf.format(full.getViaje().getFechasalida());
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer la fehca hora salida de la solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getSolicitudDestino(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getViaje() != null && full.getViaje().getDestino() != null) {
                result = full.getViaje().getDestino();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el destino de la solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getSolicitudOrigen(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getViaje() != null && full.getViaje().getOrigen() != null) {
                result = full.getViaje().getOrigen();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el origen de la solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getConductorNombres(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getDisponibilidadvc() != null && full.getDisponibilidadvc().getCedulaCond() != null
                    && full.getDisponibilidadvc().getCedulaCond().getNombres() != null && full.getDisponibilidadvc().getCedulaCond().getApellidos() != null) {
                result = full.getDisponibilidadvc().getCedulaCond().getApellidos() + " " + full.getDisponibilidadvc().getCedulaCond().getNombres();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el nombre de conductor asignado ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoDisco(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getDisponibilidadvc() != null && full.getDisponibilidadvc().getMatricula() != null) {
                result = String.valueOf(full.getDisponibilidadvc().getMatricula().getDisco());
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el disco del vehiculo asignado ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getSolicitudNumero(Solicitudesfull full) {
        String result = " ";
        try {
            if (full.getSolicitud() != null && full.getSolicitud().getNumero() != null) {
                result = full.getSolicitud().getNumero().toString();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el numero de solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getRangoFecha() {
        String result = "";
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
