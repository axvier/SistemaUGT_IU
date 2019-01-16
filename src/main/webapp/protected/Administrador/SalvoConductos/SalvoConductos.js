var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Administrador/SalvoConductos";

var fncRecargarJQGenerarSalvo = function (idtabla) {
    var urltabla = "/SalvoConductosControlador.jsp?opc=jsonSolicitudesEstado&estadoSolicitudes=aprobada";
    var idviajemn = "mnViajeSol";
    var idpasajmn = "mnPasjerosSol";
    var idpdfmn = "mnReqPDF";
    var idasigVCmn = "mnAsignarV_C";
    var idUsuarioSolmn = "mnUsuarioSol";
    var idObservacionSolmn = "mnobservacion";

    $(".list-inline #" + idpdfmn).addClass("inactive");
    $(".list-inline #" + idpdfmn).attr("onclick", null);

    $(".list-inline #" + idviajemn).addClass("inactive");
    $(".list-inline #" + idviajemn).attr("onclick", null);

    $(".list-inline #" + idpasajmn).addClass("inactive");
    $(".list-inline #" + idpasajmn).attr("onclick", null);

    $(".list-inline #" + idUsuarioSolmn).addClass("inactive");
    $(".list-inline #" + idUsuarioSolmn).attr("onclick", null);

    $(".list-inline #" + idObservacionSolmn).addClass("inactive");
    $(".list-inline #" + idObservacionSolmn).attr("onclick", null);

    $(".list-inline #" + idasigVCmn).addClass("inactive");
    $(".list-inline #" + idasigVCmn).attr("onclick", null);

    fncRecargarJQG(idtabla, urlbase, urltabla);
};

var fncRecargarJQGListaSalvo = function (idtabla) {
    var urltabla = "/SalvoConductosControlador.jsp?opc=jsonFullOrdenes";
    var idviajemn = "mnViajeSol";
    var idpasajmn = "mnPasjerosSol";
    var idpdfmn = "mnReqPDF";
    var idasigVCmn = "mnAsignarV_C";
    var idUsuarioSolmn = "mnUsuarioSol";
    var idObservacionSolmn = "mnobservacion";

    $(".list-inline #" + idpdfmn).addClass("inactive");
    $(".list-inline #" + idpdfmn).attr("onclick", null);

    $(".list-inline #" + idviajemn).addClass("inactive");
    $(".list-inline #" + idviajemn).attr("onclick", null);

    $(".list-inline #" + idpasajmn).addClass("inactive");
    $(".list-inline #" + idpasajmn).attr("onclick", null);

    $(".list-inline #" + idUsuarioSolmn).addClass("inactive");
    $(".list-inline #" + idUsuarioSolmn).attr("onclick", null);

    $(".list-inline #" + idObservacionSolmn).addClass("inactive");
    $(".list-inline #" + idObservacionSolmn).attr("onclick", null);

    $(".list-inline #" + idasigVCmn).addClass("inactive");
    $(".list-inline #" + idasigVCmn).attr("onclick", null);

    fncRecargarJQG(idtabla, urlbase, urltabla);
};

var fncModalGenerarSalvoConducto = function (idmodal, idtabla, rowid) {
    var data = $("#" + idtabla + " #" + rowid).attr("data-json");
    var objeto = JSON.parse(decodeURI(data));
    if (typeof objeto !== "undefined") {
        var solicitud = {};
        solicitud.estado = objeto.estado;
        solicitud.fecha = objeto.fecha;
        solicitud.numero = objeto.numero;
        if (typeof objeto.idpdf !== "undefined")
            solicitud.idpdf = objeto.idpdf;
        if (typeof objeto.observacion !== "undefined")
            solicitud.observacion = objeto.observacion;
        $('#' + idmodal + ' .modal-content').load('protected/Administrador/SalvoConductos/SalvoConductosControlador.jsp?opc=mostrar&accion=modGenerarSalvoConducto', function () {
            $('#' + idmodal + ' .modal-body #formGenSalvoC').attr("action", "GenerarSalvoConducto");
            $("#" + idmodal + " #SolicitudGenerar").val(encodeURI(JSON.stringify(solicitud)));
            $("#" + idmodal + " #titlemodGeneralSalvoConducto").html(" Solicitud " + solicitud.numero.toString() + " | Generar salvo conducto ");
            $('#' + idmodal).modal({show: true});
        });
    }
};

var saveOrdenSolicitud = function (idinputuri, idkminicio) {
    var dataJSON = decodeURI($("#" + idinputuri).val());
    var km = (typeof $("#" + idkminicio).val() !== "undefined") ? $("#" + idkminicio).val() : "";
    console.log(dataJSON);
    console.log(km);
    $.ajax({
        url: "protected/Administrador/SalvoConductos/SalvoConductosControlador.jsp",
        type: "GET",
        data: {opc: "saveOrdenMov", jsonSolicitud: dataJSON, kminicio: km},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            console.log(datos);
            fncRecargarJQGenerarSalvo("tbSolSalvoConducto");
        },
        error: function (error) {
            console.log(error);
        }
    }).always(function () {
        return true;
    });
};

var fncDibujarSolSalvoConducto = function (idtabla) {
    var $grid = $("#" + idtabla);
    $grid.jqGrid({
        url: urlbase + "/SalvoConductosControlador.jsp?opc=jsonSolicitudesEstado&estadoSolicitudes=aprobada",
        editurl: urlbase + "/SalvoConductosControlador.jsp",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'ID', name: 'numero', jsonmap: "solicitud.numero", key: true, width: 50, editable: false, align: 'center', sorttype: 'integer'},
            {label: 'fecha', name: 'fecha', jsonmap: "solicitud.fecha", width: 80, editable: false,
                formatter: 'date',
                formatoptions: {
                    srcformat: "ISO8601Long",
                    newformat: 'Y-m-d'
                }
            },
            {label: 'Requisitos PDF', name: 'idpdf', jsonmap: "solicitud.idpdf", width: 80, editable: false, align: 'center',
                formatter: function (cellvalue, opts) {
                    if (typeof cellvalue !== "undefined")
                        return 'SI';
                    else
                        return 'No';
                }
            },
            {label: 'Motivo', name: 'descripcion', jsonmap: "motivo.descripcion", width: 140, editable: false, search: false, sortable: false},
            {label: 'Estado', name: 'estado', jsonmap: "solicitud.estado", width: 70, editable: true, search: true,
                edittype: 'select',
                editoptions: {
                    value: 'aprobada:aprobada;asignada:asignada;enviada:inicio'
                },
                align: 'center',
                formatter: function (cellvalue, options, rowObject) {
                    if (cellvalue === "asignada")
                        return '<span style="background-color: #C0E7FB; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else if (cellvalue === 'rechazada')
                        return '<span style="background-color: #FE948C; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else if (cellvalue === 'aprobada')
                        return '<span style="background-color: #E2FBC0; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else if (cellvalue === 'finalizada')
                        return '<span style="background-color: #F3DAB0; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else
                        return cellvalue;
                }
            },
            {label: 'Observación', name: 'observacion', jsonmap: "solicitud.observacion", width: 140, editable: true, search: false, sortable: false,
                edittype: 'textarea',
                editoptions: {
                    cols: 38,
                    rows: 5
                }
            },
            {label: 'Motivo', name: 'motivo', width: 130, jsonmap: "motivo", editable: false,
                editrules: {
                    required: true,
                    edithidden: true
                },
                hidden: true,
                editoptions: {
                    dataInit: function (element) {
                        $(element).attr("readonly", "readonly");
                    }
                }
            },
            {label: 'Pasajeros', name: 'pasajeros', width: 130, jsonmap: "pasajeros", editable: false,
                editrules: {
                    required: true,
                    edithidden: true
                },
                hidden: true,
                editoptions: {
                    dataInit: function (element) {
                        $(element).attr("readonly", "readonly");
                    }
                }
            },
            {label: 'Solicitante', name: 'solicitante', width: 130, jsonmap: "solicitante", editable: false,
                editrules: {
                    required: true,
                    edithidden: true
                },
                hidden: true,
                editoptions: {
                    dataInit: function (element) {
                        $(element).attr("readonly", "readonly");
                    }
                }
            },
            {label: 'Viaje', name: 'viaje', width: 130, jsonmap: "viaje", editable: false,
                editrules: {
                    required: true,
                    edithidden: true
                },
                hidden: true,
                editoptions: {
                    dataInit: function (element) {
                        $(element).attr("readonly", "readonly");
                    }
                }
            },
            {
                label: "Generar",
                name: "actions",
                sortable: false,
                search: false,
                width: 80,
                formatter: "actions",
                formatoptions: {
                    keys: true,
                    delbutton: false,
                    editbutton: false,
                    editOptions: {},
                    addOptions: {},
                    delOptions: {
                        height: 150,
                        width: 300,
                        serializeDelData: function (postdata) {
                            delete postdata.oper;
                            var rowData = $grid.jqGrid('getRowData', postdata.id);
                            return {opc: "eliminarSolicitud", idSolicitud: rowData.numero};
                        }
                    }
                }
            }
        ],
        rowattr: function (rd) {
            var json = JSON.stringify(rd);
            var encodes = encodeURI(json);
//            console.log(encodes);
            return {"data-json": encodes};
        },
        rownumbers: true,
        viewrecords: true,
        width: 780,
        height: 450,
        loadtext: '<center><i class="fa fa-spinner fa-pulse fa-4x fa-fw"></i><span class="sr-only">Cargando...</span></center>',
        rowNum: 10,
        loadonce: true,
        pager: "#" + idtabla + "_pager",
        serializeRowData: function (postdata) {
            var rowDatajqg = $grid.jqGrid('getRowData', postdata.numero);
            var data = $("#" + idtabla + " #" + postdata.numero).attr("data-json");
            var rowData = JSON.parse(decodeURI(data));
            postdata.numero = rowData.numero;
            var solicitud = {
                estado: postdata.estado,
                fecha: rowData.fecha,
                observacion: postdata.observacion,
                idpdf: rowData.idpdf,
                numero: rowData.numero
            };
            return {opc: "modificarSolicitud", jsonSolicitud: JSON.stringify(solicitud), idSolicitud: solicitud.numero, numero: postdata.numero};
        },
        onSelectRow: function (rowid, selected) {
            if (typeof rowid !== 'undefined') {
                var data = $("#" + idtabla + " #" + rowid).attr("data-json");
                var rowData = JSON.parse(decodeURI(data));
//                console.log(rowData);
                var idviajemn = "mnViajeSol";
                var idpasajmn = "mnPasjerosSol";
                var idpdfmn = "mnReqPDF";
                var idasigVCmn = "mnAsignarV_C";
                var idUsuarioSolmn = "mnUsuarioSol";
                var idObservacionSolmn = "mnobservacion";

                if (typeof rowData.idpdf === "undefined") {
                    $(".list-inline #" + idpdfmn).addClass("inactive");
                    $(".list-inline #" + idpdfmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idpdfmn).removeClass("inactive");
                    $(".list-inline #" + idpdfmn).attr("onclick", "verSolRequisitosPDF('" + rowData.idpdf + "','" + idtabla + "','" + rowData.numero + "')");
                }
                if (typeof rowData.viaje === "undefined") {
                    $(".list-inline #" + idviajemn).addClass("inactive");
                    $(".list-inline #" + idviajemn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idviajemn).removeClass("inactive");
                    $(".list-inline #" + idviajemn).attr("onclick", "viajeSolicitudModal('modGeneralSalvoConducto','" + idtabla + "','" + data + "')");
                }
                if (typeof rowData.pasajeros === "undefined") {
                    $(".list-inline #" + idpasajmn).addClass("inactive");
                    $(".list-inline #" + idpasajmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idpasajmn).removeClass("inactive");
                    $(".list-inline #" + idpasajmn).attr("onclick", "pasajerosSolModal('modGeneralSalvoConducto','" + idtabla + "','" + data + "')");
                }
                if (typeof rowData.solicitante === "undefined") {
                    $(".list-inline #" + idUsuarioSolmn).addClass("inactive");
                    $(".list-inline #" + idUsuarioSolmn).attr("onclick", null);
                } else {
                    if (typeof rowData.solicitante.cedulau === "undefined") {
                        $(".list-inline #" + idUsuarioSolmn).addClass("inactive");
                        $(".list-inline #" + idUsuarioSolmn).attr("onclick", null);
                    } else {
                        $(".list-inline #" + idUsuarioSolmn).removeClass("inactive");
                        $(".list-inline #" + idUsuarioSolmn).attr("onclick", "usuarioSolModal('modGeneralSalvoConducto','" + idtabla + "','" + data + "')");
                    }
                }
                if (typeof rowData.observacion === "undefined" || rowData.observacion === "" || rowData.observacion === null) {
                    $(".list-inline #" + idObservacionSolmn).addClass("inactive");
                    $(".list-inline #" + idObservacionSolmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idObservacionSolmn).removeClass("inactive");
                    $(".list-inline #" + idObservacionSolmn).attr("onclick", "observacionSolModal('modGeneralSalvoConducto','" + idtabla + "','" + rowid + "')");
                }
                $(".list-inline #" + idasigVCmn).removeClass("inactive");
                $(".list-inline #" + idasigVCmn).attr("onclick", "disponibilidadVCSolModal('modGeneralSalvoConducto','" + idtabla + "','" + data + "')");
            }
        },
        loadComplete: function () {
            var grid = $grid,
                    iCol = 11; // 'act' - columna donde esta los botones de acciones
            grid.children("tbody")
                    .children("tr.jqgrow")
                    .children("td:nth-child(" + (iCol + 1) + ")") //buscamos los elementos en el dom de la columna accion
                    .each(function () {
                        var i = 0;
                        /**Creación del boton para rechazar la solicitud con las funciones al dar click*/
                        $("<div>",
                                {
                                    title: "GENERAR SALVOCONDUCTO",
                                    id: "btnGenerar_" + i,
                                    click: function (e) {
                                        fncModalGenerarSalvoConducto('modGeneralSalvoConducto', idtabla, $(e.target).closest("tr.jqgrow").attr("id")),
                                                onmouseover = jQuery(this).addClass('ui-state-hover'),
                                                onmouseout = jQuery(this).removeClass('ui-state-hover');
                                    }
                                }

                        ).css({"margin-left": "12px", "margin-top": "2px", float: "left", cursor: "pointer"})
                                .addClass("ui-pg-div ui-inline-edit")
                                .append('<span class="fa fa-download fa-2x text-primary"></span>')
                                .appendTo($(this).children("div"));
                        i++;
                    });
        }
    });

    $grid.navGrid('#' + idtabla + '_pager', {edit: false, add: false, del: false, search: true, beforeRefresh: function () {
            $grid.jqGrid('setGridParam', {datatype: 'json'}).trigger('reloadGrid');
        }, view: false, position: "left"});

    $(window).on("resize", function () {
        var grid = $grid, newWidth = $grid.closest(".ui-jqgrid").parent().width();
        grid.jqGrid("setGridWidth", newWidth, true);
    }).trigger('resize');

    $("#search_cells").keyup(function () {
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

var fncDibujaListaSalvoConductos = function (idtabla) {
    var $grid = $("#" + idtabla);
    $grid.jqGrid({
        url: urlbase + "/SalvoConductosControlador.jsp?opc=jsonFullOrdenes",
        editurl: urlbase + "/SalvoConductosControlador.jsp",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'ID', name: 'numero', jsonmap: "solicitud.numero", key: true, width: 50, editable: false, align: 'center', sorttype: 'integer'},
            {label: 'fecha', name: 'fecha', jsonmap: "solicitud.fecha", width: 80, editable: false,
                formatter: 'date',
                formatoptions: {
                    srcformat: "ISO8601Long",
                    newformat: 'Y-m-d'
                }
            },
            {label: 'Requisitos PDF', name: 'idpdf', jsonmap: "solicitud.idpdf", width: 80, editable: false, align: 'center',
                formatter: function (cellvalue, opts) {
                    if (typeof cellvalue !== "undefined")
                        return 'SI';
                    else
                        return 'No';
                }
            },
            {label: 'Motivo', name: 'descripcion', jsonmap: "motivo.descripcion", width: 140, editable: false, search: false, sortable: false},
            {label: 'Estado', name: 'estado', jsonmap: "solicitud.estado", width: 70, editable: true, search: true,
                edittype: 'select',
                editoptions: {
                    value: 'aprobada:aprobada;asignada:asignada;enviada:inicio'
                },
                align: 'center',
                formatter: function (cellvalue, options, rowObject) {
                    if (cellvalue === "asignada")
                        return '<span style="background-color: #C0E7FB; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else if (cellvalue === 'rechazada')
                        return '<span style="background-color: #FE948C; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else if (cellvalue === 'aprobada')
                        return '<span style="background-color: #E2FBC0; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else if (cellvalue === 'finalizada')
                        return '<span style="background-color: #F3DAB0; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else
                        return cellvalue;
                }
            },
            {label: 'Observación', name: 'observacion', jsonmap: "solicitud.observacion", width: 140, editable: true, search: false, sortable: false,
                edittype: 'textarea',
                editoptions: {
                    cols: 38,
                    rows: 5
                }
            },
            {label: 'Motivo', name: 'motivo', width: 130, jsonmap: "motivo", editable: false,
                editrules: {
                    required: true,
                    edithidden: true
                },
                hidden: true,
                editoptions: {
                    dataInit: function (element) {
                        $(element).attr("readonly", "readonly");
                    }
                }
            },
            {label: 'Pasajeros', name: 'pasajeros', width: 130, jsonmap: "pasajeros", editable: false,
                editrules: {
                    required: true,
                    edithidden: true
                },
                hidden: true,
                editoptions: {
                    dataInit: function (element) {
                        $(element).attr("readonly", "readonly");
                    }
                }
            },
            {label: 'Solicitante', name: 'solicitante', width: 130, jsonmap: "solicitante", editable: false,
                editrules: {
                    required: true,
                    edithidden: true
                },
                hidden: true,
                editoptions: {
                    dataInit: function (element) {
                        $(element).attr("readonly", "readonly");
                    }
                }
            },
            {label: 'Viaje', name: 'viaje', width: 130, jsonmap: "viaje", editable: false,
                editrules: {
                    required: true,
                    edithidden: true
                },
                hidden: true,
                editoptions: {
                    dataInit: function (element) {
                        $(element).attr("readonly", "readonly");
                    }
                }
            },
            {label: 'Solicitud', name: 'solicitud', width: 130, jsonmap: "solicitud", editable: false,
                editrules: {
                    required: true,
                    edithidden: true
                },
                hidden: true,
                editoptions: {
                    dataInit: function (element) {
                        $(element).attr("readonly", "readonly");
                    }
                }
            },
            {
                label: "Generar",
                name: "actions",
                sortable: false,
                search: false,
                width: 80,
                formatter: "actions",
                formatoptions: {
                    keys: true,
                    delbutton: false,
                    editbutton: false,
                    editOptions: {},
                    addOptions: {},
                    delOptions: {
                        height: 150,
                        width: 300,
                        serializeDelData: function (postdata) {
                            delete postdata.oper;
                            var rowData = $grid.jqGrid('getRowData', postdata.id);
                            return {opc: "eliminarSolicitud", idSolicitud: rowData.numero};
                        }
                    }
                }
            }
        ],
        rowattr: function (rd) {
            var json = JSON.stringify(rd);
            var encodes = encodeURI(json);
//            console.log(encodes);
            return {"data-json": encodes};
        },
        rownumbers: true,
        viewrecords: true,
        width: 780,
        height: 450,
        loadtext: '<center><i class="fa fa-spinner fa-pulse fa-4x fa-fw"></i><span class="sr-only">Cargando...</span></center>',
        rowNum: 10,
        loadonce: true,
        pager: "#" + idtabla + "_pager",
        serializeRowData: function (postdata) {
            var rowDatajqg = $grid.jqGrid('getRowData', postdata.numero);
            var data = $("#" + idtabla + " #" + postdata.numero).attr("data-json");
            var rowData = JSON.parse(decodeURI(data));
            postdata.numero = rowData.numero;
            var solicitud = {
                estado: postdata.estado,
                fecha: rowData.fecha,
                observacion: postdata.observacion,
                idpdf: rowData.idpdf,
                numero: rowData.numero
            };
            return {opc: "modificarSolicitud", jsonSolicitud: JSON.stringify(solicitud), idSolicitud: solicitud.numero, numero: postdata.numero};
        },
        onSelectRow: function (rowid, selected) {
            if (typeof rowid !== 'undefined') {
                var data = $("#" + idtabla + " #" + rowid).attr("data-json");
                var rowData = JSON.parse(decodeURI(data));
//                console.log(rowData);
                var idviajemn = "mnViajeSol";
                var idpasajmn = "mnPasjerosSol";
                var idpdfmn = "mnReqPDF";
                var idasigVCmn = "mnAsignarV_C";
                var idUsuarioSolmn = "mnUsuarioSol";
                var idObservacionSolmn = "mnobservacion";

                if (typeof rowData.idpdf === "undefined") {
                    $(".list-inline #" + idpdfmn).addClass("inactive");
                    $(".list-inline #" + idpdfmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idpdfmn).removeClass("inactive");
                    $(".list-inline #" + idpdfmn).attr("onclick", "verSolRequisitosPDF('" + rowData.idpdf + "','" + idtabla + "','" + rowData.numero + "')");
                }
                if (typeof rowData.viaje === "undefined") {
                    $(".list-inline #" + idviajemn).addClass("inactive");
                    $(".list-inline #" + idviajemn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idviajemn).removeClass("inactive");
                    $(".list-inline #" + idviajemn).attr("onclick", "viajeSolicitudModal('modGeneralSalvoConducto','" + idtabla + "','" + data + "')");
                }
                if (typeof rowData.pasajeros === "undefined") {
                    $(".list-inline #" + idpasajmn).addClass("inactive");
                    $(".list-inline #" + idpasajmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idpasajmn).removeClass("inactive");
                    $(".list-inline #" + idpasajmn).attr("onclick", "pasajerosSolModal('modGeneralSalvoConducto','" + idtabla + "','" + data + "')");
                }
                if (typeof rowData.solicitante === "undefined") {
                    $(".list-inline #" + idUsuarioSolmn).addClass("inactive");
                    $(".list-inline #" + idUsuarioSolmn).attr("onclick", null);
                } else {
                    if (typeof rowData.solicitante.cedulau === "undefined") {
                        $(".list-inline #" + idUsuarioSolmn).addClass("inactive");
                        $(".list-inline #" + idUsuarioSolmn).attr("onclick", null);
                    } else {
                        $(".list-inline #" + idUsuarioSolmn).removeClass("inactive");
                        $(".list-inline #" + idUsuarioSolmn).attr("onclick", "usuarioSolModal('modGeneralSalvoConducto','" + idtabla + "','" + data + "')");
                    }
                }
                if (typeof rowData.observacion === "undefined" || rowData.observacion === "" || rowData.observacion === null) {
                    $(".list-inline #" + idObservacionSolmn).addClass("inactive");
                    $(".list-inline #" + idObservacionSolmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idObservacionSolmn).removeClass("inactive");
                    $(".list-inline #" + idObservacionSolmn).attr("onclick", "observacionSolModal('modGeneralSalvoConducto','" + idtabla + "','" + rowid + "')");
                }
                $(".list-inline #" + idasigVCmn).removeClass("inactive");
                $(".list-inline #" + idasigVCmn).attr("onclick", "disponibilidadVCSolModal('modGeneralSalvoConducto','" + idtabla + "','" + data + "')");
            }
        },
        loadComplete: function () {
            var grid = $grid,
                    iCol = 12; // 'act' - columna donde esta los botones de acciones
            var i = 0;
            grid.children("tbody")
                    .children("tr.jqgrow")
                    .children("td:nth-child(" + (iCol + 1) + ")") //buscamos los elementos en el dom de la columna accion
                    .each(function () {
                        var obj = JSON.parse(decodeURI($(this).children("div").parents("tr").attr("data-json"))).solicitud;
                        obj = encodeURI(JSON.stringify(obj));
                        /**Creación del boton para rechazar la solicitud con las funciones al dar click*/
                        $("<a>",
                                {
                                    title: "GENERAR SALVOCONDUCTO",
                                    id: "btnGenerar_" + i,
                                    href: "GenerarSalvoConducto?SolicitudGenerar="+obj,
                                    click: function (e) {
                                        onmouseover = jQuery(this).addClass('ui-state-hover'),
                                                onmouseout = jQuery(this).removeClass('ui-state-hover');
                                    }
                                }

                        ).css({"margin-left": "12px", "margin-top": "2px", float: "left", cursor: "pointer"})
                                .addClass("ui-pg-div ui-inline-edit")
                                .append('<span class="fa fa-download fa-2x text-primary"></span>')
                                .appendTo($(this).children("div"));
                        i++;
                    });
        }
    });

    $grid.navGrid('#' + idtabla + '_pager', {edit: false, add: false, del: false, search: true, beforeRefresh: function () {
            $grid.jqGrid('setGridParam', {datatype: 'json'}).trigger('reloadGrid');
        }, view: false, position: "left"});

    $(window).on("resize", function () {
        var grid = $grid, newWidth = $grid.closest(".ui-jqgrid").parent().width();
        grid.jqGrid("setGridWidth", newWidth, true);
    }).trigger('resize');

    $("#search_cells").keyup(function () {
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
