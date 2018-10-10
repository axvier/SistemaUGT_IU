var cambiarRol = function (rol) {
    VentanaPorte();
    $("#contenidoDinamico").html("");
    $.ajax({
        url: "protected/PaginasPrincipales/MenuControlador.jsp",
        type: "GET",
        data: {opcion:"cambiarRol", rol:rol},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#left-sidebar").html(datos);
        },
        error: function (error) {
            location.reload();
        }
    });
};