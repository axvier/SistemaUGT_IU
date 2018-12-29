package ugt.solicitudes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
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
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import ugt.entidades.Tbusuariosentidad;
import ugt.entidades.Tbviajepasajero;
import ugt.pdf.iu.Encabezado;
import ugt.servicios.swLogin;
import ugt.servicios.swSeccionSolicitante;
import ugt.servicios.swSolicitudes;
import utils.Constantes;

/**
 *
 * @author Xavy PC
 */
public class SolicitudPDF extends Solicitudesfull {

    public static final String CAMBRIA
            = "src/main/resources/font/Cambria.ttf";
    private static final float FONTSIZEGENERAL = 10;

    private String solicitanteTitulos;
    private String solicitantRolEntidad;
    private Tbusuariosentidad entidadrol;

    public String getSolicitantRolEntidad() {
        return solicitantRolEntidad;
    }

    public void setSolicitantRolEntidad(String solicitantRolEntidad) {
        this.solicitantRolEntidad = solicitantRolEntidad;
    }

    public Tbusuariosentidad getEntidadrol() {
        return entidadrol;
    }

    public String getSolicitanteTitulos() {
        return solicitanteTitulos;
    }

    public void setSolicitanteTitulos(String solicitanteTitulos) {
        this.solicitanteTitulos = solicitanteTitulos;
    }

    public void setEntidadrol(Tbusuariosentidad entidadrol) {
        this.entidadrol = entidadrol;
    }

    public String generarPDF() {
        FontFactory.register(CAMBRIA, "f-Cambria");
        String result = "";
        String espacion = "                                ";
        try {
            Encabezado event = new Encabezado(new Paragraph(espacion + getEntidadSolicitante().toUpperCase(), fcambria_NormalWhite()));
            Document document = new Document(PageSize.A4, 60, 55, 20 + event.getTableHeight(), 45);
//            Document document = new Document();
            //inicio para caso de servidor
//            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            //fin de caso de servidor
            //inicio Para caso de prueba en consola
            File myfile = new File("D:\\pdfs\\out.pdf");
            result = myfile.getName();
            FileOutputStream baos = new FileOutputStream(myfile);
            //fin de prueba de consola
            //instanciar el pdf con el file
            PdfWriter write = PdfWriter.getInstance(document, baos);
            //Inicio instancia Encabezado
            write.setPageEvent(event);
            //Fin instancia encabezado
            document.open();
            document.newPage();

            //Parrafo de serial oficio
//            document.add(new Paragraph("\n", fcambria_Normal()));
            Paragraph serieOficio = new Paragraph("Oficio " + getOficioSerial(), fcambria_Normal());
            document.add(serieOficio);
            //Parrafo de fecha actual
            Paragraph fechaOficio = new Paragraph(getFechaActual(), fcambria_Normal());
            //Que no haya espacio entre lienas
            fechaOficio.setLeading(12, 0);
            document.add(fechaOficio);

            document.add(new Paragraph("\n", fcambria_Normal()));

            //Aquien va dirigido
            document.add(new Paragraph(Constantes.TITULOPERSONA, fcambria_Normal()));
            document.add(new Paragraph(Constantes.PERSONA, fcambria_Normal()));
            document.add(new Paragraph(Constantes.CARGOPERSONA, fcambria_Negrita()));
            document.add(new Paragraph("Presente.", fcambria_Normal()));

            //Formalismo
            document.add(new Paragraph("\n", fcambria_Normal()));
            document.add(new Paragraph("De mi consideración.", fcambria_Normal()));
            document.add(new Paragraph("\n", fcambria_Normal()));

            //Cuerpo
            Paragraph cuerpo = new Paragraph("Luego de un cordial saludo, por medio de la presente, yo " + getYoSolicitante()
                    + " con C.I: " + getCedulaSolicitante() //cedula
                    + " en calidad de " + getRolentidadSolicitante()//rol y entidad
                    + " de la ESPOCH, solicito se conceda un salvoconducto, con las siguientes características:",
                    fcambria_Normal());
            cuerpo.setAlignment(Element.ALIGN_JUSTIFIED);
            document.add(cuerpo);

            //Inicio Caractertísticas
            document.add(new Paragraph("\n", fcambria_Normal()));
            //tabla contenido solicitud
            PdfPTable tablaContenidos = new PdfPTable(5);
            //tablaContenidos.setLockedWidth(true);
            tablaContenidos.setWidths(new float[]{70, 120, 15, 70, 120});
            tablaContenidos.setWidthPercentage(100f);
            tablaContenidos.getDefaultCell().setBorder(0);

            //INICIO INSERCION DE LA PRIMERA FILA
            PdfPCell celdatitulo = new PdfPCell(new Paragraph("Origen: ", fcambria_Negrita()));
            celdatitulo.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
            celdatitulo.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdaorigen = new PdfPCell(new Paragraph(getViajeOrigen(), fcambria_Normal()));
            celdaorigen.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
            celdaorigen.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdavacia = new PdfPCell();
            celdavacia.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdatitulo2 = new PdfPCell(new Paragraph("Destino: ", fcambria_Negrita()));
            celdatitulo2.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
            celdatitulo2.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdadestino = new PdfPCell(new Paragraph(getViajeDestino(), fcambria_Normal()));
            celdadestino.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
            celdadestino.setBorder(Rectangle.NO_BORDER);
            //insertar celdas en tabla
            tablaContenidos.addCell(celdatitulo);
            tablaContenidos.addCell(celdaorigen);
            tablaContenidos.addCell(celdavacia);
            tablaContenidos.addCell(celdatitulo2);
            tablaContenidos.addCell(celdadestino);
            //FIN INSERCION DE LA PRIMERA FILA

            //INICIO INSERCION DE LA SEGUNDA FILA
            PdfPCell celdatitulo3 = new PdfPCell(new Paragraph("Fecha/hora de salida: ", fcambria_Negrita()));
            celdatitulo3.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdaFH_Salida = new PdfPCell(new Paragraph(getViajeFHSalida(), fcambria_Normal()));
            celdaFH_Salida.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
            celdaFH_Salida.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdatitulo4 = new PdfPCell(new Paragraph("Fecha/hora de retorno: ", fcambria_Negrita()));
            celdatitulo4.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdaFH_llegada = new PdfPCell(new Paragraph(getViajeFHRetorno(), fcambria_Normal()));
            celdaFH_llegada.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
            celdaFH_llegada.setBorder(Rectangle.NO_BORDER);
            //insertar celdas en tabla
            tablaContenidos.addCell(celdatitulo3);
            tablaContenidos.addCell(celdaFH_Salida);
            tablaContenidos.addCell(celdavacia);
            tablaContenidos.addCell(celdatitulo4);
            tablaContenidos.addCell(celdaFH_llegada);
            //FIN INSERCION DE LA SEGUNDA FILA

            //INICIO INSERCION DE LA TERCERA FILA
            PdfPCell celdatitulo5 = new PdfPCell(new Paragraph("Número de pasajeros: ", fcambria_Negrita()));
            celdatitulo5.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdaTotalPasaj = new PdfPCell(new Paragraph(getViajeTotalPasajeros().toString(), fcambria_Normal()));
            celdaTotalPasaj.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
            celdaTotalPasaj.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdatitulo6 = new PdfPCell(new Paragraph("Teléfono de contacto: ", fcambria_Negrita()));
            celdatitulo6.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdaTelefono = new PdfPCell(new Paragraph(getViajeTelefono(), fcambria_Normal()));
            celdaTelefono.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
            celdaTelefono.setBorder(Rectangle.NO_BORDER);
            //insertar celdas en tabla
            tablaContenidos.addCell(celdatitulo5);
            tablaContenidos.addCell(celdaTotalPasaj);
            tablaContenidos.addCell(celdavacia);
            tablaContenidos.addCell(celdavacia);
            tablaContenidos.addCell(celdavacia);
            tablaContenidos.addCell(celdatitulo6);
            tablaContenidos.addCell(celdaTelefono);
            tablaContenidos.addCell(celdavacia);
            tablaContenidos.addCell(celdavacia);
            tablaContenidos.addCell(celdavacia);
            //FIN INSERCION DE LA TERCERA FILA

            //INICIO INSERCION DE LA CUARTA FILA
            PdfPCell celdatitulo7 = new PdfPCell(new Paragraph("Responsble comisión: ", fcambria_Negrita()));
            celdatitulo7.setBorder(Rectangle.NO_BORDER);
            PdfPCell celdaComision = new PdfPCell(new Paragraph(getViajeComision(), fcambria_Normal()));
            celdaComision.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
            celdaComision.setBorder(Rectangle.NO_BORDER);
            //insertar celdas en tabla
            tablaContenidos.addCell(celdatitulo7);
            tablaContenidos.addCell(celdaComision);
            tablaContenidos.addCell(celdavacia);
            tablaContenidos.addCell(celdavacia);
            tablaContenidos.addCell(celdavacia);
            //FIN INSERCION DE LA PRIMERA FILA
            //insertar tabla en documento
            document.add(tablaContenidos);
            //fin caracteristicas

            //Inicio motivo
            document.add(new Paragraph("\n", fcambria_Normal()));
            document.add(new Paragraph("Justificación de requerimiento/motivo:", fcambria_Negrita()));
            document.add(new Paragraph("\n", fcambria_Normal()));
            Paragraph motivo  = new Paragraph(getSolicitudMotivo(), fcambria_Normal());
            motivo.setAlignment(Element.ALIGN_JUSTIFIED);
            document.add(motivo);
            //fin motivo
            
            //inicio favorable atencion
            document.add(new Paragraph("\n", fcambria_Normal()));
            Paragraph favorableAtencion  = new Paragraph("Por la atención dada al presente, anticipo mi agradecimiento.", fcambria_Normal());
            favorableAtencion.setAlignment(Element.ALIGN_JUSTIFIED);
            document.add(favorableAtencion);
            //fin favorable atencion
            
            //inicio atentamente
            document.add(new Paragraph("\n", fcambria_Normal()));
            Paragraph atentamente  = new Paragraph("Atentamente", fcambria_Normal());
            atentamente.setAlignment(Element.ALIGN_JUSTIFIED);
            document.add(atentamente);
            Paragraph atentamente2  = new Paragraph("\"SABER PARA SER\"", fcambria_Negrita());
            atentamente2.setAlignment(Element.ALIGN_JUSTIFIED);
            document.add(atentamente2);
            document.add(new Paragraph("\n", fcambria_Normal()));
            document.add(new Paragraph("\n", fcambria_Normal()));
            document.add(new Paragraph("\n", fcambria_Normal()));
            //fin atentamente
            //INICIO FIRMA
            Paragraph firma1  = new Paragraph(this.getYoSolicitante(), fcambria_Normal());
            firma1.setAlignment(Element.ALIGN_JUSTIFIED);
            document.add(firma1);
            Paragraph firmaEntidad  = new Paragraph(this.getRolentidadSolicitante().toUpperCase(), fcambria_Negrita());
            firmaEntidad.setAlignment(Element.ALIGN_JUSTIFIED);
            document.add(firmaEntidad);
            //FIN FIRMA
            document.close();
        } catch (DocumentException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en ejecutar el generador PDF Solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    
    private String getSolicitudMotivo() {
        String result = "";
        try {
            if (this.getMotivo()!= null) {
                if (this.getMotivo().getDescripcion()!= null) {
                    result = this.getMotivo().getDescripcion();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer motivo de solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    
    private String getViajeComision() {
        String result = "";
        try {
            if (this.getPasajeros() != null) {
                for (Tbviajepasajero obj : this.getPasajeros()) {
                    if (obj.getTipo().equals("Comision")) {
                        if (obj.getTbpasajeros() != null) {
                            result += obj.getTbpasajeros().getCedula() + "\n" + obj.getTbpasajeros().getApellidos() + " " + obj.getTbpasajeros().getNombres() + "\n";
                        }
                    }
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer total de pasajeros ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getViajeTelefono() {
        String result = "";
        try {
            if (this.getViaje() != null) {
                if (this.getViaje().getTelefono() != null) {
                    result = this.getViaje().getTelefono();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer total de pasajeros ", e.getClass().getName() + "****" + e.getMessage());
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

    private String getViajeFHRetorno() {
        String result = "";
        try {
            DateFormat sdf = new SimpleDateFormat("EEEE, dd 'de' MMMMM 'de' yyyy");
            if (this.getViaje() != null) {
                if (this.getViaje().getFechasalida() != null) {
                    result = sdf.format(this.getViaje().getFecharetorno());
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer fecha/hora de retorno ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getViajeFHSalida() {
        String result = "";
        try {
            DateFormat sdf = new SimpleDateFormat("EEEE, dd 'de' MMMMM 'de' yyyy");
            if (this.getViaje() != null) {
                if (this.getViaje().getFechasalida() != null) {
                    result = sdf.format(this.getViaje().getFechasalida());
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer fecha/hora de salida ", e.getClass().getName() + "****" + e.getMessage());
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

    private String getRolentidadSolicitante() {
        String result = "_";
        try {
            if (this.solicitantRolEntidad != null) {
                if (this.solicitantRolEntidad.length() > 5) {
                    return this.solicitantRolEntidad;
                }
            }
            if (this.getRolSolicitante().length() > 2 && this.getEntidadSolicitante().length() > 2) {
                int pos = this.getRolSolicitante().toLowerCase().indexOf(this.getEntidadSolicitante().toLowerCase());
                System.out.println(pos);
                result = this.getRolSolicitante() + " de " + this.getEntidadSolicitante();
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer rol con la entidad ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getRolSolicitante() {
        String result = "_";
        try {
            if (this.getEntidadrol() != null) {
                if (this.getEntidadrol().getTbroles() != null) {
                    result = this.getEntidadrol().getTbroles().getDescripcion();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer rol solicitante ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getCedulaSolicitante() {
        String result = "_";
        try {
            if (this.getEntidadrol() != null) {
                if (this.getEntidadrol().getTbusuarios() != null) {
                    result = this.getEntidadrol().getTbusuarios().getCedula();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer cedula solicitante ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getYoSolicitante() {
        String result = "_";
        try {
            if (this.solicitanteTitulos.length() > 5) {
                return this.solicitanteTitulos;
            }
            if (this.getEntidadrol() != null) {
                if (this.getEntidadrol().getTbusuarios() != null) {
                    result = this.getEntidadrol().getTbusuarios().getNombres() + " " + this.getEntidadrol().getTbusuarios().getApellidos();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer yo solicitante ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getEntidadSolicitante() {
        String result = "_";
        try {
            if (this.getEntidadrol() != null) {
                if (this.getEntidadrol().getTbentidad() != null) {
                    result = this.getEntidadrol().getTbentidad().getNombre();
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer la descripcion de la entidad ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private String getOficioSerial() {
        String result = "_";
        try {
            DateFormat sdf = new SimpleDateFormat("YYYY");
            Date actualDate = new Date();
            if (this.getSolicitud() != null && this.getEntidadrol() != null) {
                if (this.getSolicitud().getNumero() != null && this.getEntidadrol().getTbentidad() != null) {
                    result = this.getSolicitud().getNumero() + ".D."
                            + this.getEntidadrol().getTbentidad().getCodigoentidad() + ".ESPOCH." + sdf.format(actualDate);
                }
            }
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en extraer el numero de oficio ", e.getClass().getName() + "****" + e.getMessage());
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
            //Cambiar la fecha de la solicitud con la actual
//            Date compare = sdf.parse(dateTxt);
//            if (!this.getSolicitud().getFecha().equals(compare)) {
//                this.getSolicitud().setFecha(compare);
//                swSolicitudes.modificarSolicitudID(this.getSolicitud().getNumero().toString(), g.toJson(this.getSolicitud()));
//            }
            result = "Riobamba, " + dateTxt;
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en xtraer fecha actual oficio ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    private Font fcambria_NormalWhite() {
        Font fuente = FontFactory.getFont("f-Cambria");
        fuente.setSize(13);
        fuente.setStyle(Font.NORMAL);
        fuente.setColor(BaseColor.WHITE);
        return fuente;
    }

    private Font fcambria_Negrita() {
        Font fuente = FontFactory.getFont("f-Cambria");
        fuente.setSize(FONTSIZEGENERAL);
        fuente.setStyle(Font.BOLD);
        return fuente;
    }

    private Font fcambria_Normal() {
        Font fuente = FontFactory.getFont("f-Cambria");
        fuente.setSize(FONTSIZEGENERAL);
        fuente.setStyle(Font.NORMAL);
        return fuente;
    }
}
