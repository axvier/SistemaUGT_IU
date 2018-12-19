/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import com.google.gson.Gson;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Base64;
import org.json.JSONException;
import org.json.JSONObject;
import ugt.entidades.Tbpdf;
import ugt.pdf.iu.classpdf;
import ugt.servicios.swPDF;

/**
 *
 * @author Xavy PC
 */
public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws JSONException, FileNotFoundException, IOException {
        Gson g = new Gson();
        String jsonPDF = swPDF.listarPDFID("2");
        JSONObject obj = new JSONObject(jsonPDF);
        byte[] bytes = Base64.getDecoder().decode(obj.getString("archivo"));
//        byte[] bytes = Base64.getDecoder().decode(obj.getString("archivo"));
//        Tbpdf pdf = new Tbpdf();
//        pdf.setIdpdf(obj.getInt("idpdf"));
//        pdf.setArchivo(bytes);
//        File file = new File("D:\\Tesis\\457.pdf");
//        byte[] bytes = new byte[(int) file.length()];
//        FileInputStream fis = new FileInputStream(file);
//        fis.read(bytes); //read file into bytes[]
//        fis.close();
//        
//        String pdfJSON = new JSONObject()
//                .put("idpdf", 0)
//                .put("archivo", Base64.getEncoder().encodeToString(bytes)).toString();
//        String jsonPDF = swPDF.insertPDF(pdfJSON);
        classpdf pdf = g.fromJson(jsonPDF, classpdf.class);
        OutputStream out = new FileOutputStream("out.pdf");
        out.write(bytes);
        out.close();
        Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler out.pdf");
        System.out.println("utils.NewMain.main() => " + pdf.getArchivo());
    }

}
