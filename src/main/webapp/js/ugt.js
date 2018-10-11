var fncambiarRol = function (rol) {
    VentanaPorte();
    $(".sidebar-scroll").html("<center><i class='fa fa-spinner fa-pulse fa-3x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
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
        },
        error: function (error) {
            $("#left-sidebar").html("Error al cambiar Rol" + error.toString());
        }
    });
};