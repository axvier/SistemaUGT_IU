/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function eliminarVehiculo(objeto) {
    var placa = $(objeto).attr('id');
    var vehiculo = obtenerObjetoVehiculo(objeto);
    var jsonVehiculo = JSON.stringify(vehiculo);
    $.ajax({
        url: "Administrador/Vehiculos/vehiculoControlador.jsp",
        type: "POST",
        dataType: "text",
        data: {placa: placa, opc: "eliminarVehiculo", jsonVehiculo: jsonVehiculo},
        success: function (datos) {
            mostrarFormularioAdministrador(datos);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            _fncBtnGuardarKO();
        }

    });
}
function  guardarVehiculo(objeto) {
    var vehiculo = obtenerObjetoVehiculo(objeto);
    var placa = vehiculo.placaVehiculo = $(objeto).parent().find('.placa').find('#placa').val();
    var jsonVehiculo = JSON.stringify(vehiculo);
    $.ajax({
        url: "Administrador/Vehiculos/vehiculoControlador.jsp",
        type: "POST",
        dataType: "text",
        data: {jsonVehiculo: jsonVehiculo, opc: "saveVehiculo", placa: placa},
        success: function (datos) {
            mostrarFormularioAdministrador(datos);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            _fncBtnGuardarKO();
        }

    });
}

function  modificarVehiculo(objeto) {
    var vehiculo = obtenerObjetoVehiculo(objeto);
    var jsonVehiculo = JSON.stringify(vehiculo);
    $.ajax({
        url: "Administrador/Vehiculos/vehiculoControlador.jsp",
        type: "POST",
        dataType: "text",
        data: {jsonVehiculo: jsonVehiculo, opc: "modificarVehiculo", placa: vehiculo.placaVehiculo},
        success: function (datos) {
            mostrarFormularioAdministrador(datos);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            _fncBtnGuardarKO();
        }

    });
}


function obtenerObjetoVehiculo(objeto) {
    var vehiculo = {};
    vehiculo.placaVehiculo = $(objeto).parent().find('.placa').find('#placa').val();
    vehiculo.opc = $(objeto).parent().attr('id');
    vehiculo.descripVehiculo = $(objeto).parent().find('.vehiculo').find('#vehiculo').val();
    vehiculo.anio = $(objeto).parent().find('.anio').find('#anio').val();
    vehiculo.discoVehiculo = $(objeto).parent().find('.disco').find('#disco').val();
    return vehiculo;
}


function editarVehiculo(objeto) {
    $(objeto).parent().parent().find('.contenidoVehiculo').css('display', 'block');
    $(objeto).html('<i class="fa fa-ban"></i>');
    $(objeto).attr('title', 'Cancelar');
    $(objeto).attr('onclick', 'cancelarEdicion(this);');
}
function cancelarEdicion(objeto) {
    var icon = 'fa-edit';


    $(objeto).parent().parent().find('.contenidoVehiculo').css('display', 'none');
    $(objeto).html('<i class="fa ' + icon + '"></i>');
    $(objeto).attr('onclick', 'editarVehiculo(this);');
    $(objeto).attr('title', 'Editar');
}

