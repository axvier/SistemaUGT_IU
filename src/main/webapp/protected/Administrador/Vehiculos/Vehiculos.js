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

var fncDibujarTableVehiculos = function () {
    var $grid = $("#jqgridChoferBloq");
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Administrador/Vehiculos";
    $grid.jqGrid({
        url: urlbase + "/vehiculoControlador.jsp?opc=jsonVehiculos",
        editurl: urlbase + "/conductorControlador.jsp",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'Cédula', name: 'cedula', key: true, width: 100},
            {label: 'Nombres', name: 'nombres', width: 150, editable: true},
            {label: 'Apellidos', name: 'apellidos', width: 150, editable: true},
            {label: 'Género', name: 'genero', width: 110, editable: true,
                edittype: 'select',
                editoptions: {
                    value: 'Masculino:Masculino;Femenino:Femenino;Otros:Otros'
                }
            },
            {label: 'Estado', name: 'estado', width: 110, editable: true,
                edittype: 'select',
                search: false,
                editoptions: {
                    value: 'Disponible:Disponible;Ocupado:Ocupado;Bloqueado:Bloqueado'
                }
            },
            {label: 'Fecha Nacimiento', name: 'fechanac', width: 150,
                formatter: 'date',
                formatoptions: {
                    srcformat: "ISO8601Long",
                    newformat: 'Y-m-d'
                },
                editable: true,
                edittype: 'text',
                editoptions: {
                    dataInit: function (element) {
                        $(element).datepicker({
                            format: "yyyy-mm-dd"
                        });
                    }
                },
                editrules: {date: true},
                search: false
            },
            {
                label: "Opciones",
                name: "actions",
                sortable: false,
                search: false,
                width: 100,
                formatter: "actions",
                formatoptions: {
                    keys: true,
                    editOptions: {},
                    addOptions: {},
                    delOptions: {
                        height: 150,
                        width: 300,
                        serializeDelData: function (postdata) {
                            var rowData = $grid.jqGrid('getRowData', postdata.id);
                            delete rowData.actions;
                            rowData.fechanac = rowData.fechanac + "T00:00:00-05:00";
                            return {opc: "eliminarConductor", cedula: postdata.id, jsonConductor: JSON.stringify(rowData)};
                        }
                    }
                }
            }
        ],
        rownumbers: true,
        viewrecords: true,
        width: 780,
        height: 250,
        caption: 'Conductores disponibles',
        rowNum: 15,
        loadonce: true,
        pager: "#jqgpager_bloq",
        serializeRowData: function (postdata) {
            delete postdata.oper;
            postdata.fechanac = postdata.fechanac + "T00:00:00-05:00";
            return {opc: "modificarConductor", jsonConductor: JSON.stringify(postdata), cedula: postdata.cedula};
        }
    });

    $grid.navGrid('#jqgpager_bloq', {edit: false, add: false, del: false, search: true, beforeRefresh: function () {
            $grid.jqGrid('setGridParam', {datatype: 'json'}).trigger('reloadGrid');
        }, view: false, position: "left"});

    $grid.jqGrid('filterToolbar', {stringResult: true, searchOnEnter: false,
        defaultSearch: 'cn', ignoreCase: true});

    $(window).on("resize", function () {
        var grid = $grid, newWidth = $grid.closest(".ui-jqgrid").parent().width();
        grid.jqGrid("setGridWidth", newWidth, true);
    }).trigger('resize');
};
