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
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
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
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import ugt.entidades.Tbordenesmovilizaciones;
import ugt.entidades.Tbpasajeros;
import ugt.entidades.Tbvehiculos;
import ugt.entidades.Tbviajepasajero;
import ugt.solicitudes.Solicitudesfull;
import utils.Constantes;

/**
 * Clase para generar una orden de movilziacion heredando los datos de la
 * solicitud
 *
 * @author Xavy PC
 */
public class OrdenMovilizacionPDF extends Solicitudesfull {

    /**
     * Parametro define el tamaño de la fuente en general
     */
    private static final float FONTSIZEGENERAL = 10;
    /**
     * parametro que define la orden de movilziacion
     */
    private Tbordenesmovilizaciones orden;
    /**
     * parametro que define la persona encargada de firmar la orden de
     * movilizacion
     */
    private String nombresApellidos;
    /**
     * parametro que define el cargo de la persona encargada de firmar la orden
     * de movilizacion en una entidad
     */
    private String cargoEntidad;

    /**
     * Método que define el retorno del nombre y el apellido
     *
     * @return nombresApellidos
     */
    public String getNombresApellidos() {
        return nombresApellidos;
    }

    /**
     * Método que define el ingreso de un valor del nombre y el apellido
     *
     * @param nombresApellidos
     */
    public void setNombresApellidos(String nombresApellidos) {
        this.nombresApellidos = nombresApellidos;
    }

    /**
     * Método que define el retorno del valor del cargo en la entidad
     *
     * @return cargoEntidad
     */
    public String getCargoEntidad() {
        return cargoEntidad;
    }

    /**
     * Método que define el ingreso del valor para el cargo en la entidad
     *
     * @param cargoEntidad
     */
    public void setCargoEntidad(String cargoEntidad) {
        this.cargoEntidad = cargoEntidad;
    }

    /**
     * Metodo que define el retorno de la clase orden
     *
     * @return orden
     */
    public Tbordenesmovilizaciones getOrden() {
        return orden;
    }

    /**
     * Metodo que define el ingreso de la orden
     *
     * @param orden
     */
    public void setOrden(Tbordenesmovilizaciones orden) {
        this.orden = orden;
    }

    /**
     * Metodo para generar la orden de movilizacion en formato pd
     *
     * @return baos Este parametro define la memoria temporal en servidor para
     * generar la orden
     */
    public ByteArrayOutputStream generarPDF() {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
//    public String generarPDF() {
//        String result = "";
        try {
            Document document = new Document(PageSize.A4, 30, 30, 15, 15);
//            File myfile = new File("D:\\pdfs\\out.pdf");
//            result = myfile.getName();
//            FileOutputStream baos = new FileOutputStream(myfile);
            //fin eliminar despues
            PdfWriter write = PdfWriter.getInstance(document, baos);
            document.open();
            document.setPageSize(PageSize.A4.rotate());
            document.newPage();

            PdfPTable tablaGeneral = new PdfPTable(3);
            tablaGeneral.setWidths(new float[]{50, 5, 50});
            tablaGeneral.setWidthPercentage(100f);

            /**
             * Inicio del encabezado en tabla
             */
            PdfPCell celdavacia = new PdfPCell();
            celdavacia.setBorder(Rectangle.NO_BORDER);
            PdfPTable tableTituloEntidad = new PdfPTable(2);
            tableTituloEntidad.setWidths(new float[]{15, 85});
            /**
             * Logo Espoch
             */
            PdfPCell celEspoch = new PdfPCell();
            String data1 = Constantes.SRCIMGENORDEN;
            String base64Image1 = data1.split(",")[1];
            byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image1);
            Image imgespoch = Image.getInstance(imageBytes);
            imgespoch.scaleToFit(60, 50);
            imgespoch.setAlignment(Element.ALIGN_LEFT);
            celEspoch.setVerticalAlignment(Element.ALIGN_CENTER);
            celEspoch.setHorizontalAlignment(Element.ALIGN_CENTER);
            celEspoch.addElement(imgespoch);
            celEspoch.setRowspan(3);
            celEspoch.setBorder(0);
            /**
             * Titulo de la espoch
             */
            Paragraph parrafoEntidad = new Paragraph("ESCUELA SUPERIOR POLITÉCNICA DE CHIMBORAZO\n", timesNewRomanBold((float) 10.5));
            PdfPCell celEntidad = new PdfPCell(parrafoEntidad);
            celEntidad.setVerticalAlignment(Element.ALIGN_CENTER);
            celEntidad.setHorizontalAlignment(Element.ALIGN_CENTER);
            celEntidad.setBorder(0);
            /**
             * Dirección y contacto ciudad
             */
            Paragraph parrafoDir = new Paragraph("Panamericana Sur Km. 1 ½   Telef: 2605.900/ 2998.307 Riobamba", timesNewRomanNormal(9));
            PdfPCell celDireccion = new PdfPCell(parrafoDir);
            celDireccion.setVerticalAlignment(Element.ALIGN_CENTER);
            celDireccion.setHorizontalAlignment(Element.ALIGN_CENTER);
            celDireccion.setBorder(0);
            /**
             * titulo y numero orden
             */
            PdfPTable tableOrdenNumero = new PdfPTable(2);
            tableOrdenNumero.setWidths(new float[]{60, 40});
            PdfPCell celTituloOrden = new PdfPCell(new Paragraph("ORDEN DE MOVILIZACION", timesNewRomanBold((float) 10)));
            celTituloOrden.setBorder(0);
            Paragraph parrafoNumOrden = new Paragraph(getNumeroOrden(), timesNewRomanBold((float) 10));
            PdfPCell celNumeroOrden = new PdfPCell(parrafoNumOrden);
            celNumeroOrden.setHorizontalAlignment(Element.ALIGN_RIGHT);
            celNumeroOrden.setBorder(0);
            tableOrdenNumero.addCell(celTituloOrden);
            tableOrdenNumero.addCell(celNumeroOrden);
            PdfPCell celTitNumOrden = new PdfPCell(tableOrdenNumero);
            celTitNumOrden.setBorder(0);
            /**
             * Add Elementos del encaezado a la tabla encabezado
             */
            tableTituloEntidad.addCell(celEspoch);//insertar logo
            tableTituloEntidad.addCell(celEntidad);//insertar espoch nombre
            tableTituloEntidad.addCell(celDireccion);//insertar direccion
            tableTituloEntidad.addCell(celTitNumOrden);//insertar direccion

            PdfPCell celLados = new PdfPCell(tableTituloEntidad);
            celLados.setBorder(0);
            tablaGeneral.addCell(celLados);
            tablaGeneral.addCell(celdavacia);
            tablaGeneral.addCell(celLados); //reflejar contenido en lado derecho
            /**
             * Fin del encabezado en tabla
             */
            /**
             * Inicio del cuerpo de la orden
             */
            PdfPTable tableCuerpo = new PdfPTable(1);
            /**
             * Encabezado de lugar fecha hora
             */
            PdfPTable tableLugarFechaHora = new PdfPTable(2);
            tableLugarFechaHora.setWidths(new float[]{85, 15});
            PdfPCell cellLugarFecha = new PdfPCell(new Paragraph(getFechaActual(), timesNewRomanNormal((float) 9.5)));
            cellLugarFecha.setVerticalAlignment(Element.ALIGN_LEFT);
            cellLugarFecha.setBorder(0);
            PdfPCell cellHoraActual = new PdfPCell(new Paragraph("Hora: " + getHoraActual(), timesNewRomanNormal((float) 9.5)));
            cellHoraActual.setVerticalAlignment(Element.ALIGN_RIGHT);
            cellHoraActual.setBorder(0);
            tableLugarFechaHora.addCell(cellLugarFecha);
            tableLugarFechaHora.addCell(cellHoraActual);

            PdfPCell cellLugarFechaHora = new PdfPCell(tableLugarFechaHora);
            cellLugarFechaHora.setBorder(0);
            tableCuerpo.addCell(cellLugarFechaHora);

            /**
             * Fin del Encabezado de lugar fecha hora
             */
            /**
             * Inicio del Motivo
             */
            Paragraph pMotivoBold = new Paragraph("\nMotivo: ", timesNewRomanBold(FONTSIZEGENERAL));
            Paragraph pMotivo = new Paragraph(this.getSolTextoMotivo(), timesNewRomanNormal(FONTSIZEGENERAL));
            Paragraph pMotivoCompleto = new Paragraph();
            pMotivoCompleto.add(pMotivoBold);
            pMotivoCompleto.add(pMotivo);

            PdfPCell celMotivo = new PdfPCell(pMotivoCompleto);
            celMotivo.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
            celMotivo.setBorder(Rectangle.NO_BORDER);
            tableCuerpo.addCell(celMotivo);
            /**
             * Fin del motivo
             */
            /**
             * Inicio datos viaje
             */
            PdfPTable tableViaje = new PdfPTable(2);
            tableViaje.setWidths(new float[]{40, 60});

            //fila uno
            PdfPCell celdaViaje = new PdfPCell(new Paragraph("\n"));
            celdaViaje.setBorder(0);
            tableCuerpo.addCell(celdaViaje);

            celdaViaje = new PdfPCell();
            celdaViaje.setBorder(0);
            tableViaje.addCell(celdaViaje);
            celdaViaje = new PdfPCell(new Paragraph("HORA DE SALIDA: " + this.getViajeHORASalida(), timesNewRomanBold(FONTSIZEGENERAL)));
            celdaViaje.setBorder(0);
            tableViaje.addCell(celdaViaje);

            //fila dos
            celdaViaje = new PdfPCell(new Paragraph("Lugar de origen: ", timesNewRomanNormal(FONTSIZEGENERAL)));
            celdaViaje.setBorder(0);
            tableViaje.addCell(celdaViaje);
            celdaViaje = new PdfPCell(new Paragraph(this.getViajeOrigen(), timesNewRomanNormal(FONTSIZEGENERAL)));
            celdaViaje.setBorder(0);
            tableViaje.addCell(celdaViaje);

            //fila tres
            celdaViaje = new PdfPCell(new Paragraph("Lugar de destino: ", timesNewRomanNormal(FONTSIZEGENERAL)));
            celdaViaje.setBorder(0);
            tableViaje.addCell(celdaViaje);
            celdaViaje = new PdfPCell(new Paragraph(this.getViajeDestino() + " - Riobamba", timesNewRomanNormal(FONTSIZEGENERAL)));
            celdaViaje.setBorder(0);
            tableViaje.addCell(celdaViaje);

            //fila cuatro
            celdaViaje = new PdfPCell(new Paragraph("Tiempo de duración: ", timesNewRomanNormal(FONTSIZEGENERAL)));
            celdaViaje.setBorder(0);
            tableViaje.addCell(celdaViaje);
            celdaViaje = new PdfPCell(new Paragraph(this.getViajeDuracion() + " (" + this.getViajeFECHARetorno() + ")", timesNewRomanNormal(FONTSIZEGENERAL)));
            celdaViaje.setBorder(0);
            tableViaje.addCell(celdaViaje);

            PdfPCell celViaje = new PdfPCell(tableViaje);
            celViaje.setBorder(Rectangle.NO_BORDER);
            tableCuerpo.addCell(celViaje);
            /**
             * Fin datos viaje
             */
            /**
             * Inicio Conductor pasajero
             */
            Paragraph pCondPasajero = new Paragraph("Nombres y Apellidos conductor: " + this.getSolConductor() + "\nDNI: "
                    + this.getSolCedulaConductor(), timesNewRomanNormal(FONTSIZEGENERAL));
            PdfPCell celConductorPasajero = new PdfPCell();
            celConductorPasajero.addElement(pCondPasajero);
            pCondPasajero = new Paragraph("\n" + this.getServidorPasajero(), timesNewRomanNormal(FONTSIZEGENERAL));
            celConductorPasajero.addElement(pCondPasajero);
            celConductorPasajero.addElement(new Paragraph(" "));
            tableCuerpo.addCell(celConductorPasajero);

            /**
             * Fin Conductor pasajero
             */
            /**
             * Inicio datos vehiculo
             */
            Paragraph pCaractVehiculo = new Paragraph("CARACTERISTICAS DEL VEHICULO", timesNewRomanBold(FONTSIZEGENERAL));
            pCaractVehiculo.setAlignment(Element.ALIGN_CENTER);
            PdfPTable tableDatosVehiculo = new PdfPTable(4);
            PdfPCell celDatosVehciulo = new PdfPCell();

            celDatosVehciulo = new PdfPCell(new Paragraph("Placa: ", timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph(this.getVehiculoPlaca(), timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph("Marca/Modelo: ", timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph(this.getVehiculoMarcaModelo(), timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph("No.: ", timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph(this.getVehiculoDisco(), timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph("Color: ", timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph(this.getVehiculoColor(), timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph("Matrícula: ", timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph(this.getVehiculoAnio(), timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph("Motor: ", timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(new Paragraph(this.getVehiculoMotor(), timesNewRomanNormal(FONTSIZEGENERAL)));
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_LEFT);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableDatosVehiculo.addCell(celDatosVehciulo);

            celDatosVehciulo = new PdfPCell(pCaractVehiculo);
            celDatosVehciulo.setHorizontalAlignment(Element.ALIGN_CENTER);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableCuerpo.addCell(celDatosVehciulo);
            Paragraph vacio = new Paragraph(" ");
            vacio.setLeading(0.5f);
            celDatosVehciulo = new PdfPCell(vacio);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableCuerpo.addCell(celDatosVehciulo);
            celDatosVehciulo = new PdfPCell(tableDatosVehiculo);
            celDatosVehciulo.setBorder(Rectangle.NO_BORDER);
            tableCuerpo.addCell(celDatosVehciulo);
            /**
             * Fin datos vehiculo
             */
            /**
             * Inicio seccion firma encargado
             */
            Paragraph pfirmas = new Paragraph("\n\n\n\n\n\n\n" + this.nombresApellidos(), timesNewRomanNormal(FONTSIZEGENERAL));
            PdfPCell celFirmas = new PdfPCell(pfirmas);
            celFirmas.setHorizontalAlignment(Element.ALIGN_CENTER);
            celFirmas.setBorder(Rectangle.NO_BORDER);
            tableCuerpo.addCell(celFirmas);

            celFirmas = new PdfPCell(new Paragraph(this.cargoEntidad(), timesNewRomanBold(FONTSIZEGENERAL)));
            celFirmas.setHorizontalAlignment(Element.ALIGN_CENTER);
            celFirmas.setBorder(Rectangle.NO_BORDER);
            tableCuerpo.addCell(celFirmas);
            /**
             * Fin seccion firma encargado
             */
            PdfPCell cellBodyTLFH = new PdfPCell(tableCuerpo);
            tablaGeneral.addCell(cellBodyTLFH);
            tablaGeneral.addCell(celdavacia);
            tablaGeneral.addCell(cellBodyTLFH);
            /**
             * Fin del cuerpo de la orden
             */
            document.add(tablaGeneral);
            document.close();
//        } catch (DocumentException e) {
        } catch (DocumentException | IOException e) {
        }
        return baos;
//        return result;
    }

    private String cargoEntidad() {
        String result = "";
        try {
            result = (this.cargoEntidad != null) ? this.cargoEntidad : Constantes.CARGOUGT;
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer cargo de autoridad firma", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String nombresApellidos() {
        String result = "";
        try {
            result = (this.nombresApellidos != null) ? this.nombresApellidos : Constantes.JefeUnidad;
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el nombre y apellidos de autoridad firma", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoAnio() {
        String result = "";
        try {
            if (this.getDVC_Vehiculo() != null) {
                result = (this.getDVC_Vehiculo().getAnio() != null)
                        ? String.valueOf(this.getDVC_Vehiculo().getAnio())
                        : "";
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer anio de vehiculo", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoMotor() {
        String result = "";
        try {
            if (this.getDVC_Vehiculo() != null) {
                result = (this.getDVC_Vehiculo().getMotor() != null)
                        ? String.valueOf(this.getDVC_Vehiculo().getMotor())
                        : "";
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer anio de vehiculo", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoColor() {
        String result = "";
        try {
            result = (this.getDVC_Vehiculo() != null)
                    ? this.getDVC_Vehiculo().getColor().toUpperCase()
                    : "";
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer color de vehiculo", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoDisco() {
        String result = "";
        try {
            result = (this.getDVC_Vehiculo() != null)
                    ? String.valueOf(this.getDVC_Vehiculo().getDisco())
                    : "";
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer Disco de vehiculo", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoPlaca() {
        String result = "";
        try {
            result = (this.getDVC_Vehiculo() != null)
                    ? this.getDVC_Vehiculo().getPlaca()
                    : "";
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer placa de vehiculo", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getVehiculoMarcaModelo() {
        String result = "";
        try {
            result = (this.getDVC_Vehiculo() != null)
                    ? this.getDVC_Vehiculo().getMarca() + "/" + this.getDVC_Vehiculo().getModelo()
                    : "";
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer marca/modelo de vehiculo", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getServidorPasajero() {
        String result = "";
        try {
            if (this.getViajeTotalPasajeros() > 0) {
                if (this.getViajeTotalPasajeros() > 1) {
                    Tbpasajeros pasajero = this.getPasajeros().get(0).getTbpasajeros();
                    result = "Nombres y Apellidos servidor: " + pasajero.getNombres() + " " + pasajero.getNombres() + "\nDNI: " + pasajero.getCedula();
                } else {
                    Tbpasajeros pasajero = this.getViajeComision();
                }
            } else {
                result = this.getSolConductor() + "/DNI: " + this.getSolCedulaConductor();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el servidor pasajero", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getSolCedulaConductor() {
        String result = "";
        try {
            if (this.getDisponibilidadvc() != null) {
                if (this.getDisponibilidadvc().getCedulaCond() != null) {
                    result = this.getDisponibilidadvc().getCedulaCond().getCedula();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer cedula conductor", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getSolConductor() {
        String result = "";
        try {
            if (this.getDisponibilidadvc() != null) {
                if (this.getDisponibilidadvc().getCedulaCond() != null) {
                    String nomApell = this.getDisponibilidadvc().getCedulaCond().getNombres() + " " + this.getDisponibilidadvc().getCedulaCond().getApellidos();
                    switch (this.getDisponibilidadvc().getCedulaCond().getGenero()) {
                        case "Masculino": {
                            result = "Sr. " + nomApell;
                            break;
                        }
                        case "Femenino": {
                            result = "Sra. " + nomApell;
                            break;
                        }
                    }
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el conductor", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private Tbvehiculos getDVC_Vehiculo() {
        Tbvehiculos result = null;
        try {
            if (this.getDisponibilidadvc() != null) {
                if (this.getDisponibilidadvc().getMatricula() != null) {
                    result = this.getDisponibilidadvc().getMatricula();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el conductor", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private Integer getViajeTotalPasajeros() {
        Integer total = 0;
        try {
            if (this.getPasajeros() != null) {
                if (this.getPasajeros().size() > 0) {
                    total = this.getPasajeros().size();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer total de pasajeros ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return total;
    }

    private Tbpasajeros getViajeComision() {
        Tbpasajeros result = new Tbpasajeros();
        try {
            if (this.getPasajeros() != null) {
                for (Tbviajepasajero obj : this.getPasajeros()) {
                    if (obj.getTipo().equals("Comision")) {
                        if (obj.getTbpasajeros() != null) {
                            result = obj.getTbpasajeros();
                            break;
                        }
                    }
                }
                if (this.getPasajeros() != null && result.getCedula() == null) {
                    result = this.getPasajeros().get(0).getTbpasajeros();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer total de pasajeros ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getViajeDuracion() {
        String result = "";
        try {
            DateFormat sdf = new SimpleDateFormat("EEEE, dd 'de' MMMMM 'de' yyyy',' HH:mm");
            if (this.getViaje() != null) {
                if (this.getViaje().getFechasalida() != null && this.getViaje().getFecharetorno() != null) {
                    Date salida = this.getViaje().getFechasalida();
                    Date retorno = this.getViaje().getFecharetorno();
                    long diffInMillies = Math.abs(salida.getTime() - retorno.getTime());
                    long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
                    result = (diff == 1) ? String.valueOf(diff) + " día" : String.valueOf(diff) + " días";
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer la duracion del viaje ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getViajeDestino() {
        String result = "_";
        try {
            if (this.getViaje() != null) {
                if (this.getViaje().getDestino() != null) {
                    result = this.getViaje().getDestino();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer origen del viaje ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getViajeOrigen() {
        String result = "_";
        try {
            if (this.getViaje() != null) {
                if (this.getViaje().getOrigen() != null) {
                    result = this.getViaje().getOrigen();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer origen del viaje ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getViajeFECHARetorno() {
        String result = "";
        try {
            DateFormat sdf = new SimpleDateFormat("dd 'de' MMMMM 'del' yyyy");
            if (this.getViaje() != null) {
                if (this.getViaje().getFechasalida() != null) {
                    result = sdf.format(this.getViaje().getFecharetorno());
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer fecha de retorno ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getViajeHORASalida() {
        String result = "";
        try {
            DateFormat sdf = new SimpleDateFormat("HH'H'mm");
            if (this.getViaje() != null) {
                if (this.getViaje().getFechasalida() != null) {
                    result = sdf.format(this.getViaje().getFechasalida());
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer hora de salida ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getViajeFECHASalida() {
        String result = "";
        try {
            DateFormat sdf = new SimpleDateFormat("EEEE, dd 'de' MMMMM 'de' yyyy',' HH:mm");
            if (this.getViaje() != null) {
                if (this.getViaje().getFechasalida() != null) {
                    result = sdf.format(this.getViaje().getFechasalida());
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer fecha de salida ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getSolTextoMotivo() {
        String result = "";
        try {
            if (this.getMotivo() != null) {
                if (this.getMotivo().getDescripcion() != null) {
                    result = this.getMotivo().getDescripcion();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer motivo de solicitud ", e.getClass().getName() + "****" + e.getMessage());
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

    private String getNumeroOrden() {
        String result = "";
        try {
            if (this.getOrden() != null) {
                if (this.getOrden().getNumeroOrden() != null) {
                    result = this.getOrden().getNumeroOrden();
                } else {
                    int year = Calendar.getInstance().get(Calendar.YEAR);
                    result = this.getSolicitud().getNumero() + "-UGT-" + year;
                }
            } else {
                int year = Calendar.getInstance().get(Calendar.YEAR);
                result = this.getSolicitud().getNumero() + "-UGT-" + year;
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer motivo de solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private Font timesNewRomanNormal(float size) {
        Font fuenteTotal = new Font(Font.FontFamily.TIMES_ROMAN, 11, Font.NORMAL, BaseColor.BLACK);
        fuenteTotal.setSize(size);
        fuenteTotal.setFamily("Times Roman");
        fuenteTotal.setColor(BaseColor.BLACK);
        return fuenteTotal;
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

    private Font fcambria_Normal() {
        Font fuente = FontFactory.getFont("f-Cambria");
        fuente.setSize(10);
        fuente.setStyle(Font.NORMAL);
        return fuente;
    }
}
