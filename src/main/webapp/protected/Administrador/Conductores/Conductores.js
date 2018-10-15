/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function eliminarConductor(objeto) {
    var cedula = $(objeto).attr('id'); //
    $.ajax({
        url: "Administrador/Conductores/conductorControlador.jsp",
        type: "POST",
        dataType: "text",
        data: {cedula: cedula, opc: "eliminarConductor"},
        success: function (datos) {
            mostrarFormularioAdministrador(datos);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            _fncBtnGuardarKO();
        }

    });
}
function  guardarConductor(objeto) {
    var conductor = obtenerObjetoConductor(objeto);
    var jsonConductor = JSON.stringify(conductor);
    $.ajax({
        url: "Administrador/Conductores/conductorControlador.jsp",
        type: "POST",
        dataType: "text",
        data: {jsonConductor: jsonConductor, opc: "saveConductor"},
        success: function (datos) {
            mostrarFormularioAdministrador(datos);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            _fncBtnGuardarKO();
        }

    });
}
function obtenerObjetoConductor(objeto) {
    var conductor = {};

//    conductor.opc = $(objeto).parent().attr('id');
    conductor.apellidos = $(objeto).parent().find('.apellidos').find('#apellidos').val();
    conductor.cedula = $(objeto).parent().find('.cedula').find('#cedula').val();
    conductor.fechanac = $(objeto).parent().find('.fecha').find('#fecha').val();
    conductor.genero = $(objeto).parent().find('.genero').find('#genero').val();
    conductor.nombres = $(objeto).parent().find('.nombres').find('#nombres').val();
    return conductor;
}

function editarConductor(objeto) {
    $(objeto).parent().parent().find('.contenidoConductor').css('display', 'block');
    $(objeto).html('<i class="fa fa-ban"></i>');
    $(objeto).attr('title', 'Cancelar');
    $(objeto).attr('onclick', 'cancelarEdicionConductor(this);');
}
function cancelarEdicionConductor(objeto) {
    var icon = 'fa-edit';
    $(objeto).parent().parent().find('.contenidoConductor').css('display', 'none');
    $(objeto).html('<i class="fa ' + icon + '"></i>');
    $(objeto).attr('onclick', 'editarConductor(this);');
    $(objeto).attr('title', 'Editar');
}

var fncDibujarTablaConductor = function () {
    var $grid = $("#jqgridChofer");
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Administrador/Conductores";
    $grid.jqGrid({
        url: urlbase + "/conductorControlador.jsp?opc=jsonConductores",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'Céedula', name: 'cedula', key: true, width: 100},
            {label: 'Nombres', name: 'nombres', width: 150,editable: true},
            {label: 'Apellidos', name: 'apellidos', width: 150,editable: true},
            {label: 'Género', name: 'genero', width: 80,editable: true},
            {label: 'Estado', name: 'estado', width: 90,editable: true},
            {label: 'Fecha Nac', name: 'fechanac', width: 150,
                formatter: 'date', formatoptions: {newformat: 'Y/m/d'},
                editable: true
            },
            {
                label: "Opciones",
                name: "actions",
                width: 100,
                formatter: "actions",
                formatoptions: {
                    keys: true,
                    editOptions: {},
                    addOptions: {},
                    delOptions: {}
                }
            }
        ],
        rownumbers:true,
        viewrecords: true,
        width: 780,
        height: 250,
        rowNum: 15,
        loadonce: true,
        pager: "#jqgrid_pager"
    });

    $(window).on("resize", function () {
        var newWidth = $grid.closest(".ui-jqgrid").parent().width();
        $grid.jqGrid("setGridWidth", newWidth, true);
    });
};

