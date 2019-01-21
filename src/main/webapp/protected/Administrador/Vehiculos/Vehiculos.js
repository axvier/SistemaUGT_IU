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
    var jsonVehiculo = JSON.stringify(objeto);
    $.ajax({
        url: "Administrador/Vehiculos/vehiculoControlador.jsp",
        type: "POST",
        dataType: "text",
        data: {jsonVehiculo: jsonVehiculo, opc: "saveVehiculo", placa: objeto.placa},
        success: function (datos) {
            datos = JSON.parse(datos);
            if (datos.codigo === "OK") {
                swalTimer("Vehículo", datos.respuesta, "success");
                $("#jqgridVehiculo").jqGrid('setGridParam', {datatype: 'json'}).trigger('reloadGrid');
                $("#miModalVehiculo").modal('hide');
            }
            if (datos.codigo === "KO") {
                swalTimer("Vehículo", datos.respuesta, "error");
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert("Error de ejecucion -> " + textStatus + jqXHR);
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

var verVehiculoConductor = function (idModGeneral) {
    var $grid = $("#jqgridVehiculo");
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        var rowData = $grid.jqGrid('getRowData', selRowId);
        $('#modGeneralVehiculo .modal-content').load('protected/Administrador/Vehiculos/vehiculoControlador.jsp?opc=contentModalVerCond&placa=' + rowData.placa, function () {
            $('#' + idModGeneral).modal({show: true});
        });
    } else
        swalTimer("Vehículo", "Seleccione una fila", "error");
};

var fncaddNuevoVehiculo = function () {
    var obj = {};
    obj.placa = $("#addPlaca").val();
    obj.disco = $("#addDisco").val();
    obj.marca = $("#addMarca").val();
    obj.modelo = $("#addModelo").val();
    obj.anio = $("#addAnio").val();
    obj.anio = $("#addAnio").val();
    obj.color = $("#addColor").val();
    obj.color = $("#addColor").val();
    obj.descripcion = $("#addDescrip").val();
    var idgrupo = $("#addGrupo").find(':selected').attr('data-idgrupo');
    var detalle = $("#addGrupo").find(':selected').attr('data-detalle');
    var nombre = $("#addGrupo").val();
    obj.idgrupo = {nombre: nombre, idgrupo: idgrupo, detalle: detalle};
    obj.estado = $("#addEstado").val();
    guardarVehiculo(obj);
};

var cambiarJQGVehiculo = function (tipo) {
    var $grid = $("#jqgridVehiculo");
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Administrador/Vehiculos";
    $grid.jqGrid('clearGridData');
    $grid.jqGrid('setGridParam', {url: urlbase + "/vehiculoControlador.jsp?opc=" + tipo, datatype: "json"}).trigger("reloadGrid");
};

var addModalRevisionMecanica = function (idmodal, idtabla) {
    var $grid = $("#" + idtabla);
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        var rowData = $grid.jqGrid('getRowData', selRowId);
        $('#' + idmodal + ' .modal-content').load('protected/Administrador/Vehiculos/vehiculoControlador.jsp?opc=modRevisionM&placaRM=' + rowData.placa, function () {
            $('#' + idmodal + " .modal-header .modal-title").html("<strong>[" + rowData.disco + "] Vehículo " + rowData.placa + "</strong> | Revisiones mecánicas ");
            $('#' + idmodal).modal({show: true});
        });
    } else
        swalTimer("Vehículo", "Seleccione un vehículo", "error");
};

var cerrarModRevisionM = function (idmodal) {
    $('#' + idmodal).modal("hide");
    $('#' + idmodal + ' .modal-content').html();
};
var countRM = 0;
var fncVerListaRevisiones = function (idDivModal, idtabla) {
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Administrador/Vehiculos";
    var $grid = $("#jqgridVehiculo");
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        var rowData = $grid.jqGrid('getRowData', selRowId);
        $grid = $("#" + idtabla);
        $grid.jqGrid({
            url: urlbase + "/vehiculoControlador.jsp?opc=jsonRevisionMecanica&matricula=" + rowData.placa,
            editurl: urlbase + "/vehiculoControlador.jsp",
            mtype: "POST",
            datatype: "json",
            colModel: [
                {label: 'ID', name: 'idrevision', key: true, width: 70, editable: false},
                {label: 'Placa', name: 'matricula', jsonmap: 'matricula.placa', width: 80, editable: false, editrules: {required: true}},
                {label: 'Detalle', name: 'detalle', width: 100, editable: true, editrules: {required: true}},
                {label: 'Fecha', name: 'fecha', width: 90, editable: true, editrules: {date: true, required: true},
                    sortable: false,
                    search: false,
                    formatter: 'date',
                    formatoptions: {
                        srcformat: "ISO8601Long",
                        newformat: 'Y-m-d H:i'
                    },
                    edittype: 'text',
                    editoptions: {
                        dataInit: function (element) {
                            $(element).datepicker({
                                format: "yyyy-mm-dd"
                            });
                        }
                    }
                },
                {label: 'PDF', name: 'idpdf', width: 70, editable: false, editrules: {required: true, number: true}},
                {
                    label: "Opciones",
                    name: "actions",
                    sortable: false,
                    search: false,
                    width: 90,
                    formatter: "actions",
                    formatoptions: {
                        keys: true,
                        editOptions: {},
                        addOptions: {},
                        delOptions: {
                            height: 150,
                            width: 300,
                            serializeDelData: function (postdata) {
                                console.log(postdata);
//                            return {opc: "eliminarRevision", idrevision : 'idrevision'};
                            }
                        }
                    }
                }
            ],
            rownumbers: true,
            viewrecords: true,
            loadtext: '<center><i class="fa fa-spinner fa-pulse fa-4x fa-fw"></i><span class="sr-only">Cargando...</span></center>',
            caption: 'Revisiones mecánicas',
            rowNum: 5,
            loadonce: true,
            pager: "#" + idtabla + "_pager",
            serializeRowData: function (postdata) {
                console.log(postdata);
//                var idgrupo = postdata.nombre;
//                delete postdata.nombre;
//                delete postdata.oper;
//                if (typeof postdata.observacion === "undefined" || postdata.observacion === null || postdata.observacion === "")
//                    delete postdata.observacion;
//                return {opc: "modificarVehiculo", jsonVehiculo: JSON.stringify(postdata), placa: postdata.placa, idgrupo: idgrupo};
            }
        });

        $grid.navGrid("#" + idtabla + "_pager", {edit: false, add: false, del: false, search: true, refresh: false, view: false, position: "left"});

//        $("#"+idDivModal).on("resize", function () {
//            var grid = $grid, newWidth = $grid.closest(".ui-jqgrid").parent().width();
//            grid.jqGrid("setGridWidth", newWidth, true);
//        }).trigger('resize');
    }
};

var fncAddRevisionMForm = function (idform, idmodal) {
    var parsleyForm = $('#' + idform).parsley();
    parsleyForm.validate();
    if (!parsleyForm.isValid())
        return false;
    else {
        var rowData = $("#placaRM").val();
        if (typeof rowData !== 'undefined') {
            var input = document.getElementById('filePDF');
            if (!input) {
                alert("Um, couldn't find the fileinput element.");
            } else if (!input.files) {
                alert("This browser doesn't seem to support the `files` property of file inputs.");
            } else if (!input.files[0]) {
                alert("Please select a file before clicking 'Load'");
            } else {
                swalTimerLoading("Subiendo PDF", "Se esta subiendo la revisión vehicular PDF", 10000);
                var file = input.files[0];
                var myform = $("#" + idform);
                var fd = new FormData(myform);
                var revision = {
                    detalle: $("#" + idform + " #addRMDetalle").val(),
                    fecha: $("#" + idform + " #addRMFecha").val() + ":00-05:00"
                };
                fd.append("dato", file);
                fd.append("jsonRevisionM", encodeURI(JSON.stringify(revision)));
                fd.append("placaRM", rowData);
                $.ajax({
                    url: "protected/Administrador/Vehiculos/vehiculoControlador.jsp?opc=addRevisionM",
                    data: fd,
                    cache: false,
                    processData: false,
                    contentType: false,
                    type: 'POST',
                    success: function (datos) {
                        cerrarModRevisionM('modGeneralVehiculo');
                        datos = JSON.parse(datos);
                        if (datos.codigo === "OK") {
                            swalNormal("Completado", datos.respuesta, "success");
                        } else {
                            swalNormal("Completado", datos.respuesta, "error");
                        }
                    },
                    error: function () {
                        window.location.reload();
                    }
                });
            }
        }
        $('#' + idmodal).modal('hide');
    }
};

var fncDibujarTableVehiculos = function () {
    countRM = 0;
    var $grid = $("#jqgridVehiculo");
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Administrador/Vehiculos";
    $grid.jqGrid({
        url: urlbase + "/vehiculoControlador.jsp?opc=jsonVehiculos",
        editurl: urlbase + "/vehiculoControlador.jsp",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'Placa', name: 'placa', key: true, width: 80, editable: false},
            {label: 'Disco', name: 'disco', width: 60, editable: true, editrules: {required: true}},
            {label: 'Marca', name: 'marca', width: 110, editable: true, editrules: {required: true}},
            {label: 'Modelo', name: 'modelo', width: 110, editable: true, editrules: {required: true}},
            {label: 'Año matricula', name: 'anio', width: 100, editable: true, editrules: {required: true, number: true}},
            {label: 'Color', name: 'color', width: 100, editable: true, editrules: {required: true}},
            {label: 'Descripcion', name: 'descripcion', width: 150, editable: true, search: false,
                edittype: "textarea",
                editoptions: {cols: 15}
                , editrules: {required: true}
            },
            {label: 'Grupo/Tipo', name: 'nombre', jsonmap: "idgrupo.nombre", width: 130, editable: true, editrules: {required: true},
                edittype: 'select',
                editoptions: {
                    value: '1:Automovil;2:Bus;3:otros'
                }
            },
            {label: 'Estado', name: 'estado', width: 110, editable: true, editrules: {required: true},
                edittype: 'select',
                editoptions: {
                    value: 'Disponible:Disponible;Ocupado:Ocupado;Rematado:Rematado'
                }
            },
            {label: 'Observación', name: 'observacion', width: 160, search: false, sortable: false, editable: true,
                edittype: 'textarea',
                editoptions: {
                    cols: 20
                }
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
                            var nombreGrupo = rowData.nombre;
                            delete rowData.actions;
//                            rowData.idgrupo = {nombre: rowData.nombre};
                            delete rowData.nombre;
                            return {opc: "eliminarVehiculo", placa: postdata.id, jsonVehiculo: JSON.stringify(rowData), nombreGrupo: nombreGrupo};
                        }
                    }
                }
            }
        ],
        rownumbers: true,
        viewrecords: true,
        width: 780,
        height: 250,
        caption: 'Vehículos disponibles',
        rowNum: 10,
        loadonce: true,
        pager: "#jqgVehiculo_pager",
        serializeRowData: function (postdata) {
            var idgrupo = postdata.nombre;
            delete postdata.nombre;
            delete postdata.oper;
            if (typeof postdata.observacion === "undefined" || postdata.observacion === null || postdata.observacion === "")
                delete postdata.observacion;
            console.log({opc: "modificarVehiculo", jsonVehiculo: JSON.stringify(postdata), placa: postdata.placa, idgrupo: idgrupo});
            return {opc: "modificarVehiculo", jsonVehiculo: JSON.stringify(postdata), placa: postdata.placa, idgrupo: idgrupo};
        }
    });

    $grid.navGrid('#jqgVehiculo_pager', {edit: false, add: false, del: false, search: true, beforeRefresh: function () {
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
                var not_found = (id.indexOf(value) === -1);
                $(this).closest('tr').toggle(!not_found);
                return not_found;
            });
        });
    });
};

var fncDibujarTableVehiculosUnlock = function () {
    var $grid = $("#jqgridVehiculoUnlock");
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Administrador/Vehiculos";
    $grid.jqGrid({
        url: urlbase + "/vehiculoControlador.jsp?opc=jsonVehiculosUnlock",
        editurl: urlbase + "/vehiculoControlador.jsp",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'Placa', name: 'placa', key: true, width: 80, editable: false},
            {label: 'Disco', name: 'disco', width: 60, editable: true},
            {label: 'Marca', name: 'marca', width: 150, editable: true},
            {label: 'Modelo', name: 'modelo', width: 150, editable: true},
            {label: 'Año', name: 'anio', width: 100},
            {label: 'Color', name: 'color', width: 150, editable: true},
            {label: 'Descripcion', name: 'descripcion', width: 150, editable: true, search: false,
                edittype: "textarea",
                editoptions: {cols: 15}
            },
            {label: 'Grupo/Tipo', name: 'nombre', jsonmap: "idgrupo.nombre", width: 150, editable: true,
                edittype: 'select',
                editoptions: {
                    value: '1:Automovil;2:Bus;3:otros'
                }
            },
            {label: 'Estado', name: 'estado', width: 110, editable: true,
                edittype: 'select',
                editoptions: {
                    value: 'Disponible:Disponible;Ocupado:Ocupado;Rematado:Rematado'
                }
            },
            {label: 'Observación', name: 'observacion', width: 160, search: false, sortable: false, editable: true,
                edittype: 'textarea',
                editoptions: {
                    cols: 20
                }
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
                    delbutton: false,
                    editOptions: {},
                    addOptions: {},
                    delOptions: {
                    }
                }
            }
        ],
        rownumbers: true,
        viewrecords: true,
        width: 780,
        height: 250,
        caption: 'Vehículos que están de baja en la institución',
        rowNum: 10,
        loadonce: true,
        pager: "#jqgVehiculoUnlock_pager",
        serializeRowData: function (postdata) {
            var idgrupo = postdata.nombre;
            delete postdata.oper;
//            postdata.idgrupo = {idgrupo: postdata.nombre};
            delete postdata.nombre;
            return {opc: "modificarVehiculo", jsonVehiculo: JSON.stringify(postdata), placa: postdata.placa, idgrupo: idgrupo};
        }
    });

    $grid.navGrid('#jqgVehiculoUnlock_pager', {edit: false, add: false, del: false, search: true, beforeRefresh: function () {
            $grid.jqGrid('setGridParam', {datatype: 'json'}).trigger('reloadGrid');
        }, view: false, position: "left"});

    $grid.jqGrid('filterToolbar', {stringResult: true, searchOnEnter: false,
        defaultSearch: 'cn', ignoreCase: true});

    $(window).on("resize", function () {
        var grid = $grid, newWidth = $grid.closest(".ui-jqgrid").parent().width();
        grid.jqGrid("setGridWidth", newWidth, true);
    }).trigger('resize');
};
