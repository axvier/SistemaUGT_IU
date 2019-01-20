var fncAprobarSolictud = function (idmodal, idtabla, rowid) {
    var data = $("#" + idtabla + " #" + rowid).attr("data-json");
    var objeto = JSON.parse(decodeURI(data));
    if (typeof objeto !== "undefined") {
        var solicitud = {};
        solicitud.estado = objeto.estado;
        solicitud.fecha = objeto.fecha;
        solicitud.numero = objeto.numero;
        if (typeof objeto.idpdf !== "undefined")
            solicitud.idpdf = objeto.idpdf;
        if (typeof objeto.observacion !== "undefined" && objeto.observacion !== "" && objeto.observacion !== null)
            solicitud.observacion = objeto.observacion;
        $.ajax({
            url: "protected/Solicitudes/SolicitudesGestionVA/SolicitudesVAControlador.jsp",
            type: "GET",
            data: {opc: "aprobarSolicitud", jsonSolicitud: JSON.stringify(solicitud), idSolicitud: solicitud.numero},
            contentType: "application/json ; charset=UTF-8",
            success: function (datos) {
                datos = JSON.parse(datos);
                if (datos.codigo === "OK") {
                    swalNormal("Solicitud " + solicitud.numero, datos.codigo + " la solicitud ha sido aprobada, esta se envíara a UGT para su salvoconducto ", "success");
                    fncRecargarJQGSolicitud(idtabla);
                } else {
                    swalNormal("Estado Solicitud", datos.codigo + " " + datos.respuesta, "error");
                }
            },
            error: function (error) {
                location.reload();
            }
        });
    }
};

var fncRechazarSolicitud = function (idmodal, idtabla, rowid) {
    var data = $("#" + idtabla + " #" + rowid).attr("data-json");
    var objeto = JSON.parse(decodeURI(data));
    if (typeof objeto !== "undefined") {
        var solicitud = {};
        solicitud.estado = objeto.estado;
        solicitud.fecha = objeto.fecha;
        solicitud.numero = objeto.numero;
        if (typeof objeto.idpdf !== "undefined")
            solicitud.idpdf = objeto.idpdf;
        if (typeof objeto.observacion !== "undefined" && objeto.observacion !== "" && objeto.observacion !== null) {
            solicitud.observacion = objeto.observacion;
            $.ajax({
                url: "protected/Solicitudes/SolicitudesGestionVA/SolicitudesVAControlador.jsp",
                type: "GET",
                data: {opc: "rechazarSolicitud", jsonSolicitud: JSON.stringify(solicitud), idSolicitud: solicitud.numero},
                contentType: "application/json ; charset=UTF-8",
                success: function (datos) {
                    datos = JSON.parse(datos);
                    if (datos.codigo === "OK") {
                        swalNormal("Solicitud " + solicitud.numero, datos.codigo + " Se ha rechazado la solicitud esta sera enviada de nuevo al usuario que la solcito", "success");
                        var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Solicitudes/SolicitudesGestionVA";
                        var urltabla = "/SolicitudesVAControlador.jsp?opc=jsonSolicitudesAsignada";
                        fncRecargarJQG(idtabla, urlbase, urltabla);
                    } else {
                        swalNormal("Estado Solicitud", datos.codigo + " " + datos.respuesta, "error");
                    }
                },
                error: function (error) {
                    location.reload();
                }
            });
        } else {
            swalNormal("Sin observación", "Debe especificar el motivo del por el cual, se rechaza la solicitud.", "info");
        }
    }
};

var fncRechazarSolicitudAprobadas = function (idmodal, idtabla, rowid) {
    var data = $("#" + idtabla + " #" + rowid).attr("data-json");
    var objeto = JSON.parse(decodeURI(data));
    if (typeof objeto !== "undefined") {
        var solicitud = {};
        solicitud.estado = objeto.estado;
        solicitud.fecha = objeto.fecha;
        solicitud.numero = objeto.numero;
        if (typeof objeto.idpdf !== "undefined")
            solicitud.idpdf = objeto.idpdf;
        if (typeof objeto.observacion !== "undefined" && objeto.observacion !== "" && objeto.observacion !== null) {
            solicitud.observacion = objeto.observacion;
            $.ajax({
                url: "protected/Solicitudes/SolicitudesGestionVA/SolicitudesVAControlador.jsp",
                type: "GET",
                data: {opc: "rechazarSolicitud", jsonSolicitud: JSON.stringify(solicitud), idSolicitud: solicitud.numero},
                contentType: "application/json ; charset=UTF-8",
                success: function (datos) {
                    datos = JSON.parse(datos);
                    if (datos.codigo === "OK") {
                        swalNormal("Solicitud " + solicitud.numero, datos.codigo + " Se ha rechazado la solicitud esta sera enviada de nuevo al usuario que la solcito", "success");
                        var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Solicitudes/SolicitudesGestionVA";
                        var urltabla = "/SolicitudesVAControlador.jsp?opc=jsonSolicitudesAprobadas";
                        fncRecargarJQG(idtabla, urlbase, urltabla);
                    } else {
                        swalNormal("Estado Solicitud", datos.codigo + " " + datos.respuesta, "error");
                    }
                },
                error: function (error) {
                    location.reload();
                }
            });
        } else {
            swalNormal("Sin observación", "Debe especificar el motivo del por el cual, se rechaza la solicitud.", "info");
        }
    }
};

var fncRecargarJQGSolicitud = function (idtabla) {
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Solicitudes/SolicitudesGestionVA";
    var urltabla = "/SolicitudesVAControlador.jsp?opc=jsonSolicitudesAsignada";
    fncRecargarJQG(idtabla, urlbase, urltabla);
};

var fncRecargarJQGSolicitudaprobadas = function (idtabla) {
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Solicitudes/SolicitudesGestionVA";
    var urltabla = "/SolicitudesVAControlador.jsp?opc=jsonSolicitudesAprobadas";
    fncRecargarJQG(idtabla, urlbase, urltabla);
};

var fncModSubirCombinarPDFSec = function (idmodal, idtabla, rowid) {
    var data = $("#" + idtabla + " #" + rowid).attr("data-json");
    var objeto = JSON.parse(decodeURI(data));
    if (typeof objeto !== "undefined") {
        var solicitud = {};
        solicitud.estado = objeto.estado;
        solicitud.fecha = objeto.fecha;
        solicitud.numero = objeto.numero;
        if (typeof objeto.idpdf !== "undefined")
            solicitud.idpdf = objeto.idpdf;
        if (typeof objeto.observacion !== "undefined" && objeto.observacion !== "" && objeto.observacion !== null)
            solicitud.observacion = objeto.observacion;

        $('#' + idmodal + ' .modal-content').load(
                'protected/Solicitudes/SolicitudesGestion/SolicitudesControlador.jsp?opc=mostrar&accion=modCombinarSolicitud',
                function () {
                    $('#' + idmodal).modal({show: true});
                    $('#' + idmodal + " #jsonSolFormPDF").val(data);
                });
    }
};

var fncCombinarPDFSec = function (idform, idmodal) {
    var parsleyForm = $('#' + idform).parsley();
    parsleyForm.validate();
    if (!parsleyForm.isValid())
        return false;
    else {
        var json = decodeURI($('#' + idform + " #jsonSolFormPDF").val());
        if (typeof json !== 'undefined') {
            var input = document.getElementById('filePDF');
            if (!input) {
                alert("Um, couldn't find the fileinput element.");
            } else if (!input.files) {
                alert("This browser doesn't seem to support the `files` property of file inputs.");
            } else if (!input.files[0]) {
                alert("Please select a file before clicking 'Load'");
            } else {
                swalTimerLoading("Subiendo PDF", "Se esta combinando su pdf con los anteriores requerimientos esto puede tardar un momento", 10000);
                var file = input.files[0];
                var myform = $("#" + idform);
                var fd = new FormData(myform);
                fd.append("dato", file);
                fd.append("jsonSolicitud", encodeURI(json));
                console.log(fd);
                $.ajax({
                    url: "protected/Solicitudes/SolicitudesGestion/SolicitudesControlador.jsp?opc=combinarPDFs",
                    data: fd,
                    cache: false,
                    processData: false,
                    contentType: false,
                    type: 'POST',
                    success: function (datos) {
                        datos = JSON.parse(datos);
                        if (datos.codigo === "OK") {
                            swalNormal("Completado", datos.respuesta, "success");
                        } else {
                            swalNormal("Completado", datos.respuesta, "error");
                        }
                        fncRecargarJQGSolicitudaprobadas("tbSolicitudesAsignadas");
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

var fncDibujarSolicitudesAsignadas = function (idtabla) {
    var $grid = $("#" + idtabla);
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Solicitudes/SolicitudesGestionVA";
    $grid.jqGrid({
        url: urlbase + "/SolicitudesVAControlador.jsp?opc=jsonSolicitudesAsignada",
        editurl: urlbase + "/SolicitudesVAControlador.jsp",
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
            {label: 'Estado', name: 'estado', jsonmap: "solicitud.estado", width: 70, editable: false, search: true},
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
                label: "Accion",
                name: "actions",
                sortable: false,
                search: false,
                width: 80,
                formatter: "actions",
                formatoptions: {
                    keys: true,
                    delbutton: false,
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
            var solicitud = {
                estado: rowDatajqg.estado,
                fecha: rowData.fecha,
                observacion: postdata.observacion,
                idpdf: rowData.idpdf,
                numero: rowData.numero
            };
            return {opc: "modificarSolicitud", jsonSolicitud: JSON.stringify(solicitud), idSolicitud: solicitud.numero};
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
                    $(".list-inline #" + idviajemn).attr("onclick", "viajeSolicitudModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
                }
                if (typeof rowData.pasajeros === "undefined") {
                    $(".list-inline #" + idpasajmn).addClass("inactive");
                    $(".list-inline #" + idpasajmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idpasajmn).removeClass("inactive");
                    $(".list-inline #" + idpasajmn).attr("onclick", "pasajerosSolModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
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
                        $(".list-inline #" + idUsuarioSolmn).attr("onclick", "usuarioSolModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
                    }
                }
                if (typeof rowData.observacion === "undefined" || rowData.observacion === "" || rowData.observacion === null) {
                    $(".list-inline #" + idObservacionSolmn).addClass("inactive");
                    $(".list-inline #" + idObservacionSolmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idObservacionSolmn).removeClass("inactive");
                    $(".list-inline #" + idObservacionSolmn).attr("onclick", "observacionSolModal('modGeneralSolicitudes','" + idtabla + "','" + rowid + "')");
                }
                $(".list-inline #" + idasigVCmn).removeClass("inactive");
                $(".list-inline #" + idasigVCmn).attr("onclick", "disponibilidadVCSolModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
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
                        /** Creación de un boton para aprobar la solicitud con las funciones para dar click*/
                        $("<div>",
                                {
                                    title: "APROBAR",
                                    id: "btnAprobar_" + i,
                                    click: function (e) {
                                        fncAprobarSolictud('modGeneralSolicitudes', idtabla, $(e.target).closest("tr.jqgrow").attr("id")),
                                                onmouseover = jQuery(this).addClass('ui-state-hover'),
                                                onmouseout = jQuery(this).removeClass('ui-state-hover');
                                    }
                                }

                        ).css({"margin-left": "12px", "margin-top": "2px", float: "left", cursor: "pointer"})
                                .addClass("ui-pg-div ui-inline-edit")
                                .append('<span class="fa fa-check-circle fa-2x text-success"></span>')
                                .appendTo($(this).children("div"));
                        /**Creación del boton para rechazar la solicitud con las funciones al dar click*/
                        $("<div>",
                                {
                                    title: "RECHAZAR",
                                    id: "btnRechazado_" + i,
                                    click: function (e) {
                                        fncRechazarSolicitud('modGeneralSolicitudes', idtabla, $(e.target).closest("tr.jqgrow").attr("id")),
                                                onmouseover = jQuery(this).addClass('ui-state-hover'),
                                                onmouseout = jQuery(this).removeClass('ui-state-hover');
                                    }
                                }

                        ).css({"margin-left": "12px", "margin-top": "2px", float: "left", cursor: "pointer"})
                                .addClass("ui-pg-div ui-inline-edit")
                                .append('<span class="fa fa-ban fa-2x text-danger"></span>')
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

var fncDibujarSolicitudesAprobadas = function (idtabla) {
    $(".list-inline #mnRefresh").attr("onclick", "fncRecargarJQGSolicitudaprobadas('" + idtabla + "')");
    var $grid = $("#" + idtabla);
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Solicitudes/SolicitudesGestionVA";
    $grid.jqGrid({
        url: urlbase + "/SolicitudesVAControlador.jsp?opc=jsonSolicitudesAprobadas",
        editurl: urlbase + "/SolicitudesVAControlador.jsp",
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
                label: "Accion",
                name: "actions",
                sortable: false,
                search: false,
                width: 80,
                formatter: "actions",
                formatoptions: {
                    keys: true,
                    delbutton: false,
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
                    $(".list-inline #" + idviajemn).attr("onclick", "viajeSolicitudModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
                }
                if (typeof rowData.pasajeros === "undefined") {
                    $(".list-inline #" + idpasajmn).addClass("inactive");
                    $(".list-inline #" + idpasajmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idpasajmn).removeClass("inactive");
                    $(".list-inline #" + idpasajmn).attr("onclick", "pasajerosSolModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
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
                        $(".list-inline #" + idUsuarioSolmn).attr("onclick", "usuarioSolModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
                    }
                }
                if (typeof rowData.observacion === "undefined" || rowData.observacion === "" || rowData.observacion === null) {
                    $(".list-inline #" + idObservacionSolmn).addClass("inactive");
                    $(".list-inline #" + idObservacionSolmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idObservacionSolmn).removeClass("inactive");
                    $(".list-inline #" + idObservacionSolmn).attr("onclick", "observacionSolModal('modGeneralSolicitudes','" + idtabla + "','" + rowid + "')");
                }
                $(".list-inline #" + idasigVCmn).removeClass("inactive");
                $(".list-inline #" + idasigVCmn).attr("onclick", "disponibilidadVCSolModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
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
                                    title: "RECHAZAR",
                                    id: "btnRechazado_" + i,
                                    click: function (e) {
                                        fncRechazarSolicitudAprobadas('modGeneralSolicitudes', idtabla, $(e.target).closest("tr.jqgrow").attr("id")),
                                                onmouseover = jQuery(this).addClass('ui-state-hover'),
                                                onmouseout = jQuery(this).removeClass('ui-state-hover');
                                    }
                                }

                        ).css({"margin-left": "12px", "margin-top": "2px", float: "left", cursor: "pointer"})
                                .addClass("ui-pg-div ui-inline-edit")
                                .append('<span class="fa fa-ban fa-2x text-danger"></span>')
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

var fncDibujarSolicitudesAprobadasSecVA = function (idtabla) {
    $(".list-inline #mnRefresh").attr("onclick", "fncRecargarJQGSolicitudaprobadas('" + idtabla + "')");
    var $grid = $("#" + idtabla);
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Solicitudes/SolicitudesGestionVA";
    $grid.jqGrid({
        url: urlbase + "/SolicitudesVAControlador.jsp?opc=jsonSolicitudesAprobadas",
        editurl: urlbase + "/SolicitudesVAControlador.jsp",
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
                label: "Accion",
                name: "actions",
                sortable: false,
                search: false,
                width: 80,
                formatter: "actions",
                formatoptions: {
                    keys: true,
                    delbutton: false,
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
                    $(".list-inline #" + idviajemn).attr("onclick", "viajeSolicitudModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
                }
                if (typeof rowData.pasajeros === "undefined") {
                    $(".list-inline #" + idpasajmn).addClass("inactive");
                    $(".list-inline #" + idpasajmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idpasajmn).removeClass("inactive");
                    $(".list-inline #" + idpasajmn).attr("onclick", "pasajerosSolModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
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
                        $(".list-inline #" + idUsuarioSolmn).attr("onclick", "usuarioSolModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
                    }
                }
                if (typeof rowData.observacion === "undefined" || rowData.observacion === "" || rowData.observacion === null) {
                    $(".list-inline #" + idObservacionSolmn).addClass("inactive");
                    $(".list-inline #" + idObservacionSolmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idObservacionSolmn).removeClass("inactive");
                    $(".list-inline #" + idObservacionSolmn).attr("onclick", "observacionSolModal('modGeneralSolicitudes','" + idtabla + "','" + rowid + "')");
                }
                $(".list-inline #" + idasigVCmn).removeClass("inactive");
                $(".list-inline #" + idasigVCmn).attr("onclick", "disponibilidadVCSolModal('modGeneralSolicitudes','" + idtabla + "','" + data + "')");
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
                                        title: "Subir y combinar PDF",
                                        id: "btnRecibido_" + i,
                                        onmouseover: "jQuery(this).addClass('ui-state-hover');",
                                        onmouseout: "jQuery(this).removeClass('ui-state-hover');",
                                        click: function (e) {
                                            fncModSubirCombinarPDF('modGeneralSolicitudes', idtabla, $(e.target).closest("tr.jqgrow").attr("id"));
                                        }
                                    }

                            ).css({"margin-left": "12px", "margin-top": "2px", float: "left", cursor: "pointer"})
                                    .addClass("ui-pg-div ui-inline-edit")
                                    .append('<span class="fa fa-cloud-upload fa-2x text-primary"></span>')
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

