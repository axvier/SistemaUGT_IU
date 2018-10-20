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

var fncaddNuevoConductor = function () {
    var json = convertirObjetoJson("formAddCond");
    var obj = JSON.parse(json);
    obj.fechanac = obj.fechanac + "T00:00:00-05:00";
    var licencia = {};
    licencia.cedula = obj.cedula;
    licencia.fechaexpedicion = obj.fechaexpedicion + "T00:00:00-05:00";
    licencia.fechaexpiracion = obj.fechaexpiracion + "T00:00:00-05:00";
    licencia.tipo = obj.tipo;
    delete obj.tipo;
    delete obj.fechaexpiracion;
    delete obj.fechaexpedicion;
    json = JSON.stringify(obj);
    console.log(json);
    console.log(JSON.stringify(licencia));
    $("#jqgridChofer").jqGrid('setGridParam', {datatype: 'json'}).trigger('reloadGrid');
    $("#miModal").modal('hide');
};

var fncDibujarTablaConductor = function () {
    var $grid = $("#jqgridChofer");
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Administrador/Conductores";
    $grid.jqGrid({
        url: urlbase + "/conductorControlador.jsp?opc=jsonConductores",
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
                    value: 'Disponible:Disponible;Ocupado:Ocupado'
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
                            console.log(JSON.stringify(rowData));
                            return {opc: "eliminarconductor", cedula: postdata.id, jsonConductor: JSON.stringify(rowData)};
                        }
                    }
                }
            }
        ],
        rownumbers: true,
        viewrecords: true,
        width: 780,
        height: 250,
        rowNum: 15,
        loadonce: true,
        pager: "#jqgrid_pager",
        serializeRowData: function (postdata) {
            delete postdata.oper;
            return {opc: "modificarConductor", jsonConductor: JSON.stringify(postdata), cedula: postdata.cedula};
        }
    });

    $grid.navGrid('#jqgrid_pager', {edit: false, add: false, del: false, search: true, beforeRefresh: function () {
            $grid.jqGrid('setGridParam', {datatype: 'json'}).trigger('reloadGrid');
        }, view: false, position: "left"});

    $grid.jqGrid('filterToolbar', {stringResult: true, searchOnEnter: false,
        defaultSearch: 'cn', ignoreCase: true});

    $(window).on("resize", function () {
        var grid = $grid, newWidth = $grid.closest(".ui-jqgrid").parent().width();
        grid.jqGrid("setGridWidth", newWidth, true);
    }).trigger('resize');

    $("#search_cells").on("keyup", function () {
        var value = $(this).val();
        $("table tr").each(function (index) {
            if (!index)
                return;
            $(this).find("td").each(function () {
                var id = $(this).text().toLowerCase().trim();
                var not_found = (id.indexOf(value) == -1);
                $(this).closest('tr').toggle(!not_found);
                return not_found;
            });
        });
    });
};

