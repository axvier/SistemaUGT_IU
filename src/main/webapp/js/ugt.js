var fncambiarRol = function (rol) {
    VentanaPorte();
    $(".sidebar-scroll").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/PaginasPrincipales/MenuControlador.jsp",
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
            alert("Error al cambiar Rol" + error.toString());
            location.reload();
        }
    });
};

var fncGestionChoferes = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/Administrador/Conductores/conductorControlador.jsp",
        type: "GET",
        data: {opc: "tableConductores"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTablaConductor();
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncGestionChoferesBlock = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/Administrador/Conductores/conductorControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableCondUnlock"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTablaConductorUnlock();
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncGestionAuto = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/Administrador/Vehiculos/vehiculoControlador.jsp",
        type: "GET",
        data: {opc: "tableVehiculos"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTableVehiculos();
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncGestionAutoBlock = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/Administrador/Vehiculos/vehiculoControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableVehiculosUnlock"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTableVehiculosUnlock();
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncGestionUsuarios = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/SuperAdministrador/Usuarios/UsuariosControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableUsuarios"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTableGUsuarios("tbUsuariosG");
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncGestionRoles = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/SuperAdministrador/Roles/RolesControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "tableGRoles"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarTableGRoles("tbRolesG");
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncAsignarRolOpcion = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/SuperAdministrador/Roles/RolesControlador.jsp",
        type: "GET",
        data: {opc: "GAddGRolOpcion"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
//            fncDibujarTableGRoles("tbRolesG");
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncNuevaSolicitud = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "nuevaSolicitudU"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
//            fncDibujarNuev("tbRolesG");
        },
        error: function (error) {
            location.reload();
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