var fncambiarRol = function (rol) {
    VentanaPorte();
    $(".sidebar-scroll").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/PaginasPrincipales/MenuControlador.jsp",
        type: "GET",
        data: {opcion: "cambiarRol", rol: rol},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#left-sidebar").html(datos);
            if (rol === "Admin")
                $("#left-sidebar").css("background-color", "#304A54");
            else
                $("#left-sidebar").css("background-color", "#ececec");
            $("#contenidoDinamico").html("<div class='main-header'><h2>UGT</h2><em>ESPOCH</em></div><div id='contenidoInferior' class='main-content'><p class='lead'>Bienvenido.</p></div>");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionChoferes = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Administrador/Conductores/conductorControlador.jsp",
        type: "GET",
        data: {opc: "tableConductores"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTablaConductor();
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionChoferesBlock = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Administrador/Conductores/conductorControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableCondUnlock"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTablaConductorUnlock();
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionAuto = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Administrador/Vehiculos/vehiculoControlador.jsp",
        type: "GET",
        data: {opc: "tableVehiculos"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTableVehiculos();
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionAutoBlock = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Administrador/Vehiculos/vehiculoControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableVehiculosUnlock"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTableVehiculosUnlock();
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionUsuarios = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/SuperAdministrador/Usuarios/UsuariosControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableUsuarios"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTableGUsuarios("tbUsuariosG");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionRoles = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/SuperAdministrador/Roles/RolesControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableGRoles"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTableGRoles("tbRolesG");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncAsignarRolOpcion = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/SuperAdministrador/Roles/RolesControlador.jsp",
        type: "GET",
        data: {opc: "GAddGRolOpcion"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
//            fncDibujarTableGRoles("tbRolesG");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncNuevaSolicitud = function () {

    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp",
        type: "GET",
        data: {opc: "nuevaSolicitudU"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
//            fncDibujarNuev("tbRolesG");
//            fncConfirmarGenerarSolcitud({nombres_apellidos:"Giovanni Aranda", rol_entidad:"rol de "});
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncMisSolicitudes = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableMisSolicitudes"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarMisSolicitudes("tbMisSolicitudes");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionSolicitudesAdmin = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Solicitudes/SolicitudesGestion/SolicitudesControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableSolicitudesNuevas"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarSolicitudesNuevas("tbSolicitudesNuevas");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionSProcesadasAdmin = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Solicitudes/SolicitudesGestion/SolicitudesControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableSolicitudesProcesadas"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarSolicitudesProcesadas("tbSolicitudesNuevas");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionSolicitudesVR = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Solicitudes/SolicitudesGestionVA/SolicitudesVAControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableSolicitudesAsignadas"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarSolicitudesAsignadas("tbSolicitudesAsignadas");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionSAprobadasVR = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Solicitudes/SolicitudesGestionVA/SolicitudesVAControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableSolicitudesAsignadas"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarSolicitudesAprobadas("tbSolicitudesAsignadas");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGenerarOrden = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Administrador/SalvoConductos/SalvoConductosControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableSolSalvoConducto"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarSolSalvoConducto("tbSolSalvoConducto");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGeListaOrden = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Administrador/SalvoConductos/SalvoConductosControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableListaSalvoConductos"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujaListaSalvoConductos("tbSolSalvoConducto");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncGestionSAprobadasSec = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Solicitudes/SolicitudesGestionVA/SolicitudesVAControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableSolicitudesAsignadas"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarSolicitudesAprobadasSecVA("tbSolicitudesAsignadas");
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncReporteConductores = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Administrador/Reportes/ReportesControlador.jsp",
        type: "GET",
        data: {opc: "conductoresReporte", accion: "conductoresReporte"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarGraficosConductores("placeholder");//iniciar grafico
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncReporteVehiculos = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Administrador/Reportes/ReportesControlador.jsp",
        type: "GET",
        data: {opc: "vehiculosReporte"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarGraficosVehiculosEstado();//iniciar grafico
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncReporteSolicitudes = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Administrador/Reportes/ReportesControlador.jsp",
        type: "GET",
        data: {opc: "solicitudesReporte"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarGraficosSolicitudEstado();//iniciar grafico
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncReporteOrdenes = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "../protected/Administrador/Reportes/ReportesControlador.jsp",
        type: "GET",
        data: {opc: "ordenesReporte"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarGraficosOrdenesEstado();//iniciar grafico
        },
        error: function (error) {
            window.location.reload();
        }
    });
};

var fncRecargarJQG = function (idtabla, urlbase, urltable) {
    var $grid = $("#" + idtabla);
    $(window).on("resize", function () {
        var grid = $grid, newWidth = $grid.closest(".ui-jqgrid").parent().width();
        grid.jqGrid("setGridWidth", newWidth, true);
    }).trigger('resize');
    $grid.jqGrid('clearGridData');
    $grid.jqGrid('setGridParam', {url: urlbase + urltable, datatype: "json"}).trigger("reloadGrid");
};

var fncCheckAll = function (idform, idcontchck) {
    $('#' + idform + ' #' + idcontchck + ' input').prop('checked', true);
};

var fncCheckAllNot = function (idform, idcontchck) {
    $('#' + idform + ' #' + idcontchck + ' input').prop('checked', false);
};