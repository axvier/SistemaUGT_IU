<!--Querido colega programador: 
Cuando escribí este código, solo Dios y yo sabíamos cómo funcionaba.
Ahora solo dios lo sabe!!

Así que si estas tratando de ‘OPTIMIZAR’ esta rutina 
y fracasas (seguramente), por favor, incrementa 
el siguiente contador como una advertencia para el siguiente colega:

Total_horas_perdidas_aqui = 0-->

<%@page import="servicios.*"%>
<%@page import="entidades.*"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String strOpc = request.getParameter("opc");
    if (strOpc != null) {
        if (strOpc.equals("Periodo")) {
            String tsk = request.getParameter("tsk");
            if (tsk.equals("agregarPeriodo")) {
                String idUser = request.getParameter("idUser");
                String datos = request.getParameter("datos");
                JSONObject req = new JSONObject(datos);
                Periodo objPeriodo = new Periodo();
                objPeriodo.setPerDescipcion(req.getString("DetaPeriodo").replace("+", " "));
                try {
                    if (req.getString("idEstadoPerio").equals("on")) {
                        objPeriodo.setPerEstado(1);
                    }
                } catch (Exception e) {
                    objPeriodo.setPerEstado(2);
                }
                String jsonPeriodo = new Gson().toJson(objPeriodo, Periodo.class);
                sPeriodo.InsertarPeriodo(jsonPeriodo);
            }  else if (tsk.equals("eliminarFisicoPeriodo")) {
                String idUser = request.getParameter("idUser");
                String idDato = request.getParameter("idDato");
                sPeriodo.EliminarPeriodo(Integer.parseInt(idDato));
            } else if (tsk.equals("editaPeriodo")) {
                String idUser = request.getParameter("idUser");
                String idDato = request.getParameter("idDato");
                String datos = request.getParameter("datos");
                JSONObject req = new JSONObject(datos);
                Periodo objPeriodo = new Periodo();
                objPeriodo.setPerId(Integer.parseInt(idDato));
                objPeriodo.setPerDescipcion(req.getString("DetaPeriodo").replace("+", " "));
                try {
                    if (req.getString("idEstadoPerio").equals("on")) {
                        objPeriodo.setPerEstado(1);
                    }
                } catch (Exception e) {
                    objPeriodo.setPerEstado(2);
                }
                String jsonPeriodo = new Gson().toJson(objPeriodo, Periodo.class);
                sPeriodo.ModficarPeriodo(jsonPeriodo, Integer.parseInt(idDato));
            }
        }
        



    } else {
        response.sendRedirect("index.jsp");
    }
%>