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
            $("#left-sidebar").html("Error al cambiar Rol" + error.toString());
        }
    });
};

var fncGestionChoferes = function() {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/Administrador/Conductores/conductorControlador.jsp",
        type: "GET",
        data: {opc:"tableConductores"},
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

var fncGestionChoferesBlock = function() {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/Administrador/Conductores/conductorControlador.jsp",
        type: "GET",
        data: {opc:"mostrar",accion:"tableCondUnlock"},
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
        data: {opc:"mostrar",accion:"tableVehiculos"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
//            fncDibujarTablaConductor();
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncGestionAutoBlock = function () {
    alert("Programar vehiculos dados de baja");
};