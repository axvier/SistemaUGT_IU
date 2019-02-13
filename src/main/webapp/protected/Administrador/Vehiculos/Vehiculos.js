/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//var servidor = "https://localhost:8181/SistemaUGT_IU";
var servidor = "https://pruebas.espoch.edu.ec:8181/SistemaUGT_IU";

function eliminarVehiculo(objeto) {
    var placa = $(objeto).attr('id');
    var vehiculo = obtenerObjetoVehiculo(objeto);
    var jsonVehiculo = JSON.stringify(vehiculo);
    $.ajax({
        url: "../protected/Administrador/Vehiculos/vehiculoControlador.jsp",
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
    console.log(objeto);
    console.log(jsonVehiculo);
    $.ajax({
        url: "../protected/Administrador/Vehiculos/vehiculoControlador.jsp",
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
        url: "../protected/Administrador/Vehiculos/vehiculoControlador.jsp",
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
        $('#modGeneralVehiculo .modal-content').load('../protected/Administrador/Vehiculos/vehiculoControlador.jsp?opc=contentModalVerCond&placa=' + rowData.placa, function () {
            $('#' + idModGeneral).modal({show: true});
        });
    } else
        swalTimer("Vehículo", "Seleccione una fila", "error");
};

var fncaddNuevoVehiculo = function () {
    var obj = {};
    obj.placa = $("#addPlaca").val();
    obj.motor = $("#addMotor").val();
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
    var urlbase = servidor + "/protected/Administrador/Vehiculos";
    $grid.jqGrid('clearGridData');
    $grid.jqGrid('setGridParam', {url: urlbase + "/vehiculoControlador.jsp?opc=" + tipo, datatype: "json"}).trigger("reloadGrid");
};

var addModalRevisionMecanica = function (idmodal, idtabla) {
    var $grid = $("#" + idtabla);
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        var rowData = $grid.jqGrid('getRowData', selRowId);
        $('#' + idmodal + ' .modal-content').load('../protected/Administrador/Vehiculos/vehiculoControlador.jsp?opc=modRevisionM&placaRM=' + rowData.placa, function () {
            $('#' + idmodal + " .modal-header .modal-title").html("<strong>[" + rowData.disco + "] Vehículo " + rowData.placa + "</strong> | Revisiones mecánicas ");
            $('#' + idmodal).modal({show: true});
        });
    } else
        swalTimer("Vehículo", "Seleccione un vehículo", "error");
};

var addModalDependencia = function (idmodal, idtabla) {
    var $grid = $("#" + idtabla);
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        var rowData = $grid.jqGrid('getRowData', selRowId);
        $('#' + idmodal + ' .modal-content').load('../protected/Administrador/Vehiculos/vehiculoControlador.jsp?opc=modDependencia&placaRM=' + rowData.placa, function () {
//            $('#' + idmodal + " .modal-header .modal-title").html("<strong>[" + rowData.disco + "] Vehículo " + rowData.placa + "</strong> | Revisiones mecánicas ");
            $('#' + idmodal).modal({show: true});
        });
    } else
        swalTimer("Vehículo", "Seleccione un vehículo", "error");
};

var fncVerVehiculoDependencias = function (idDivModal, matricula) {
    $('#' + idDivModal).html("");
    $('#' + idDivModal).load('../protected/Administrador/Vehiculos/vehiculoControlador.jsp?opc=divModalVerVehiculoEntida&placaVD=' + matricula);
};

var fncAddVhiculoDependencia = function (idForm, idmodal, idplaca) {
    var obj = fncObjFormGU_V_D(idForm, idplaca);
    if (obj !== null) {
        var json = JSON.stringify(obj);
        $.ajax({
            url: "../protected/Administrador/Vehiculos/vehiculoControlador.jsp",
            type: "POST",
            dataType: "text",
            data: {opc: "savedependencia", jsonvehdep: json, placaD: idplaca},
            success: function (datos) {
                datos = JSON.parse(datos);
                if (datos.codigo === "OK") {
                    swalTimer("Dependencia estado", datos.respuesta, "success");
                }
                if (datos.codigo === "KO") {
                    swalTimer("Dependencia estado", datos.respuesta, "error");
                }
                $("#" + idmodal).modal("hide");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error de ejecucion -> " + textStatus + jqXHR);
            }

        });
    }
};

var fncObjFormGU_V_D = function (idForm, idplaca) {
    var $grid = $("#jqgridVehiculo");
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    var rowData = $grid.jqGrid('getRowData', selRowId);
    delete rowData.actions;
    var tbVehiculoEntidad = {
        tbentidad: JSON.parse($("#" + idForm + " #addGUEntidad").find(':selected').attr('data-json')),
//        tbvehiculos: rowData,
        tbvehiculosdependenciasPK: {
            fechainicio: $("#" + idForm + " #addGUfechainicio").val() + "T00:00:00-05:00",
            iddependencia: JSON.parse($("#" + idForm + " #addGUEntidad").find(':selected').attr('data-json')).identidad,
            matricula: idplaca
        }
    };
    return tbVehiculoEntidad;
};

var fncEliminarGU_V_E = function (str) {
    var obj = $("#row" + str).data("json");
    if (obj !== null) {
        var json = JSON.stringify(obj);
        $.ajax({
            type: "POST",
            url: "../protected/Administrador/Vehiculos/vehiculoControlador.jsp",
            dataType: "text",
            data: {opc: "eliminardependencia", jsonvehdep: json},
            success: function (datos) {
                datos = JSON.parse(datos);
                if (datos.codigo === "OK") {
                    swalTimer("Vehículo - Entidad", datos.codigo + " - " + datos.respuesta, "success");
                    fncVerVehiculoDependencias('tabitem2', JSON.parse(json).tbvehiculos.placa);
                }
                if (datos.codigo === "KO") {
                    swalTimer("Vehículo - Entidad", datos.codigo + " - " + datos.respuesta, "error");
                }
                $("#modGeneralVehiculo").modal("hide");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                window.location.reload();
            }

        });
    }
};

var fncTerminarGU_V_E = function (str) {
    var obj = $("#row" + str).data("json");
    if (obj !== null) {
        var json = JSON.stringify(obj);
        $.ajax({
            type: "POST",
            url: "../protected/Administrador/Vehiculos/vehiculoControlador.jsp",
            dataType: "text",
            data: {opc: "modificardependencia", jsonvehdep: json},
            success: function (datos) {
                datos = JSON.parse(datos);
                if (datos.codigo === "OK") {
                    swalTimer("Vehículo - Entidad", datos.codigo + " - " + datos.respuesta, "success");
                    fncVerVehiculoDependencias('tabitem2', JSON.parse(json).tbvehiculos.placa);
                }
                if (datos.codigo === "KO") {
                    swalTimer("Vehículo - Entidad", datos.codigo + " - " + datos.respuesta, "error");
                }
                $("#modGeneralVehiculo").modal("hide");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                window.location.reload();
            }

        });
    }
};

var cerrarModRevisionM = function (idmodal) {
    $('#' + idmodal).modal("hide");
    $('#' + idmodal + ' .modal-content').html();
};

var downloadPDFOrden = function (idPDFRevision) {
    if (typeof idPDFRevision !== 'undefined' && idPDFRevision !== null && idPDFRevision !== "") {
        swalTimerLoading("Consultando pdf " + idPDFRevision, "Esto puede tardar un momento...", 9000);
        $.ajax({
            url: "../protected/Administrador/Vehiculos/vehiculoControlador.jsp",
            type: "POST",
            data: {opc: 'downloadPDFOrden', idPDFRevision: idPDFRevision},
            success: function (data) {
                data = JSON.parse(data);
                if (data.respuesta !== 'vacio') {
                    swal.close();
                    let pdfWindow = window.open("");
                    pdfWindow.document.write("<iframe width='100%' height='100%' src='data:application/pdf;base64, " + (data.respuesta) + "'></iframe>");
                } else {
                    swalNormal("Sin pdf", "No tiene un pdf de revisión vehicular", "error");
                }
            },
            error: function (e) {
                location.reload();
            }
        });
    } else
        swalNormal("Sin pdf", "No tiene un pdf de revisión vehicular", "error");
};

var countRM = 0;
var fncVerListaRevisiones = function (idDivModal, idtabla) {
    var urlbase = servidor+"/protected/Administrador/Vehiculos";
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
                {label: 'ID', name: 'idrevision', key: true, width: 60, editable: false},
                {label: 'Placa', name: 'matricula', jsonmap: 'matricula.placa', width: 70, editable: false, editrules: {required: true}},
                {label: 'Detalle', name: 'detalle', width: 110, editable: true, editrules: {required: true}},
                {label: 'Fecha', name: 'fecha', width: 125, editable: true, editrules: {date: true, required: true},
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
                {label: 'PDF', name: 'idpdf', width: 60, editable: false, editrules: {required: true, number: true}},
                {
                    label: "Opciones",
                    name: "actions",
                    sortable: false,
                    search: false,
                    width: 100,
                    formatter: "actions",
                    formatoptions: {
                        keys: true,
                        editbutton: false,
                        delbutton: true,
                        editOptions: {},
                        addOptions: {},
                        delOptions: {
                            height: 150,
                            width: 300,
                            serializeDelData: function (postdata) {
                                return {opc: "eliminarRevision", idrevision: postdata.id};
                            }
                        }
                    }
                }
            ],
//            rownumbers: true,
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
            },
            loadComplete: function () {
                var grid = $grid,
                        iCol = 5; // 'act' - name of the actions column
                grid.children("tbody")
                        .children("tr.jqgrow")
                        .children("td:nth-child(" + (iCol + 1) + ")")
                        .each(function () {
                            var i = 0;
                            var data = $(this).parent("tr.jqgrow").find("td[aria-describedby='tjqgRevision_idpdf']").text();
                            /**creación y asignación del botón para comibnar un pdf con los demas requerimientos*/
                            $("<div>",
                                    {
                                        title: "Descargar revisión mecánica PDF",
                                        id: "btnDOrden_" + i,
                                        onmouseover: "jQuery(this).addClass('ui-state-hover');",
                                        onmouseout: "jQuery(this).removeClass('ui-state-hover');",
                                        click: function (e) {
                                            downloadPDFOrden(data);
                                        }
                                    }

                            ).css({"margin-left": "6px", "margin-top": "2px", float: "left", cursor: "pointer"})
                                    .addClass("ui-pg-div ui-inline-edit")
                                    .append('<span class="fa fa-cloud-download fa-2x text-primary"></span>')
                                    .appendTo($(this).children("div"));
                            i++;
                        });
            }
        });

        $grid.navGrid("#" + idtabla + "_pager", {edit: false, add: false, del: false, search: true, refresh: false, view: false, position: "left"});

        $("#" + idDivModal).on("resize", function () {
            var grid = $grid, newWidth = $grid.closest(".ui-jqgrid").parent().width();
            grid.jqGrid("setGridWidth", newWidth, true);
        }).trigger('resize');
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
                    url: "../protected/Administrador/Vehiculos/vehiculoControlador.jsp?opc=addRevisionM",
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
    var urlbase = servidor+"/protected/Administrador/Vehiculos";
    $grid.jqGrid({
        url: urlbase + "/vehiculoControlador.jsp?opc=jsonVehiculos",
        editurl: urlbase + "/vehiculoControlador.jsp",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'Placa', name: 'placa', key: true, width: 80, editable: false},
            {label: 'Disco', name: 'disco', width: 60, editable: true, editrules: {required: true}, sorttype: 'integer'},
            {label: 'Marca', name: 'marca', width: 110, editable: true, editrules: {required: true}},
            {label: 'Modelo', name: 'modelo', width: 110, editable: true, editrules: {required: true}},
            {label: 'Motor', name: 'motor', width: 110, editable: true, editrules: {required: true}},
            {label: 'Año matricula', name: 'anio', width: 70, editable: true, editrules: {required: true, number: true}},
            {label: 'Color', name: 'color', width: 80, editable: true, editrules: {required: true}},
            {label: 'Descripcion', name: 'descripcion', width: 150, editable: true, search: false,
                edittype: "textarea",
                editoptions: {cols: 15}
                , editrules: {required: true}
            },
            {label: 'Grupo/Tipo', name: 'nombre', jsonmap: "idgrupo.nombre", width: 110, editable: true, editrules: {required: true},
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
        var rules = [], i, cm,
                postData = $grid.jqGrid("getGridParam", "postData"),
                colModel = $grid.jqGrid("getGridParam", "colModel"),
                searchText = $("#search_cells").val(),
                l = colModel.length;

        for (i = 0; i < l; i++) {
            cm = colModel[i];
            if (cm.search !== false && (typeof cm.stype === "undefined" || cm.stype === "text")) {
                rules.push({
                    field: cm.name,
                    op: "cn",
                    data: searchText
                });
            }
        }

        $.extend(postData, {
            filters: {
                groupOp: "OR",
                rules: rules
            }
        });

        $grid.jqGrid("setGridParam", {search: true, postData: postData});
        $grid.trigger("reloadGrid", [{page: 1, current: true}]);
        return false;
    });
};

var fncDibujarTableVehiculosUnlock = function () {
    var $grid = $("#jqgridVehiculoUnlock");
    var urlbase = servidor+"/protected/Administrador/Vehiculos";
    $grid.jqGrid({
        url: urlbase + "/vehiculoControlador.jsp?opc=jsonVehiculosUnlock",
        editurl: urlbase + "/vehiculoControlador.jsp",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'Placa', name: 'placa', key: true, width: 80, editable: false},
            {label: 'Disco', name: 'disco', width: 60, editable: true, sorttype: 'integer'},
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
