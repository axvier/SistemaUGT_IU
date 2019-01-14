package ugt.pdf.iu;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.BadPdfFormatException;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfSmartCopy;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Esta clase permite la combinación de dos PDF con la ayuda de la libreria
 * ITEXTPDF
 *
 * @author Xavy PC
 * @see
 * https://itextpdf.com/en/resources/faq/technical-support/itext-7/how-merge-documents-correctly
 */
public class CombinarPDF {

    /**
     * Inicio del método para crear el pdf final
     *
     * @param bytesBase El parámetro bytesBase define el byte array del primer
     * PDF
     * @param bytesCombinar El parámetro bytesCombinar define el byte array del
     * segundo PDF a combinar al primero
     * @return El pdf final combinado en formato byte array
     * @throws com.itextpdf.text.DocumentException
     */
    public ByteArrayOutputStream combinarPDFs(byte[] bytesBase, byte[] bytesCombinar) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            Document documento = new Document();
            PdfSmartCopy copia = new PdfSmartCopy(documento, baos);
            documento.open();
            addDatosPDF(copia, bytesCombinar, bytesBase);
            documento.close();
        } catch (DocumentException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en crear el pdf final combinado ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return baos;
    }

    /**
     * Fin del método
     */
    /**
     * Inicio del metodo para combinar los dos pdfs
     *
     * @param bytes1 primer parametro define el primer pdf
     * @param bytes2 primer parametro define el segundo pdf
     * @param copia define el parametro del pdf final en donde se pegaradon los
     * pdfs recibidos
     * @throws java.io.IOException
     */
    public void addDatosPDF(PdfSmartCopy copia, byte[] bytes1, byte[] bytes2) {
        try {
            PdfReader lector;
            if (bytes1.length > 0) {
                lector = new PdfReader(bytes1);
                for (int i = 1; i <= lector.getNumberOfPages(); i++) {
                    copia.addPage(copia.getImportedPage(lector, i));
                }
            }
            if (bytes2.length > 0) {
                lector = new PdfReader(bytes2);
                for (int i = 1; i <= lector.getNumberOfPages(); i++) {
                    copia.addPage(copia.getImportedPage(lector, i));
                }
            }
        } catch (BadPdfFormatException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en combinar el pdf con pdfreader ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
    }
    /**
     * Fin del método para combinar los dos pdfs
     */
}
