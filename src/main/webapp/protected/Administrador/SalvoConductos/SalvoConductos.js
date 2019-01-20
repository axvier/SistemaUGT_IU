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

var fncRecargarJQGenerarSalvoDNuevo = function (idtabla, estado) {
    var urltabla = "/SalvoConductosControlador.jsp?opc=" + estado;
    var idviajemn = "mnViajeSol";
    var idpasajmn = "mnPasjerosSol";
    var idpdfmn = "mnReqPDF";
    var idasigVCmn = "mnAsignarV_C";
    var idUsuarioSolmn = "mnUsuarioSol";
    var idObservacionSolmn = "mnobservacion";
    var idordenPDF = "mnOrdenPDF";

    $(".list-inline #" + idpdfmn).addClass("inactive");
    $(".list-inline #" + idpdfmn).attr("onclick", null);

    $(".list-inline #" + idordenPDF).addClass("inactive");
    $(".list-inline #" + idordenPDF).attr("onclick", null);

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
    var idordenPDF = "mnOrdenPDF";

    $(".list-inline #" + idpdfmn).addClass("inactive");
    $(".list-inline #" + idpdfmn).attr("onclick", null);
    
    $(".list-inline #" + idordenPDF).addClass("inactive");
    $(".list-inline #" + idordenPDF).attr("onclick", null);

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
        solicitud.solicitud = objeto.numero;
        if (typeof objeto.idpdf !== "undefined")
            solicitud.idpdf = objeto.idpdf;
        if (typeof objeto.observacion !== "undefined" && objeto.observacion !== "" && objeto.observacion !== null)
            solicitud.observacion = objeto.observacion;
        $('#' + idmodal + ' .modal-content').load('protected/Administrador/SalvoConductos/SalvoConductosControlador.jsp?opc=mostrar&accion=modGenerarSalvoConducto', function () {
            $('#' + idmodal + ' .modal-body #formGenSalvoC').attr("action", "GenerarSalvoConducto");
            $("#" + idmodal + " #SolicitudGenerar").val(encodeURI(JSON.stringify(solicitud)));
            $("#" + idmodal + " #titlemodGeneralSalvoConducto").html(" Solicitud " + solicitud.numero.toString() + " | Generar salvo conducto ");
            $('#' + idmodal).modal({show: true});
        });
    }
};

var fncModalGenerarSalvoConductoDNuevo = function (idmodal, idtabla, rowid) {
    var data = $("#" + idtabla + " #" + rowid).attr("data-json");
    var objeto = JSON.parse(decodeURI(data));
    if (typeof objeto !== "undefined") {
        var rowData = $("#" + idtabla).jqGrid('getRowData', rowid);
        var solicitud = objeto.jsonsolicitud;
        delete solicitud.observacion;
        if (typeof rowData.observacion !== "undefined" && rowData.observacion !== "" && rowData.observacion !== null) {
            solicitud.observacion = rowData.observacion;
        }
        $('#' + idmodal + ' .modal-content').load('protected/Administrador/SalvoConductos/SalvoConductosControlador.jsp?opc=mostrar&accion=modGenerarSalvoConductoDNuevo', function () {
            $('#' + idmodal + ' .modal-body #formGenSalvoC').attr("action", "GenerarSalvoConducto");
            $("#" + idmodal + " #SolicitudGenerar").val(encodeURI(JSON.stringify(solicitud)));
            $("#" + idmodal + " #titlemodGeneralSalvoConducto").html(" Solicitud " + solicitud.numero.toString() + " | Generar salvo conducto ");
            $('#' + idmodal).modal({show: true});
        });
    }
};

var saveOrdenSolicitudDNuevo = function (idinputuri, idkminicio) {
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
            fncRecargarJQGenerarSalvoDNuevo("tbSolSalvoConducto", "jsonFullOrdenes");
        },
        error: function (error) {
            console.log(error);
        }
    }).always(function () {
        return true;
    });
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

var disponVCSolOrdenModal = function (idmodal, idtabla, data) {
    console.log(data);
    var $grid = $("#" + idtabla);
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        swalTimerLoading("Consultado datos", "Esto puede tardar un momento...", 9000);
        var dcodes = decodeURI(data);
        var objeto = JSON.parse(dcodes);
        $('#' + idmodal + ' .modal-content').load('protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp?opc=modDisponibilidadV_C&idSolicitud=' + objeto.solicitud, function () {
            swal.close();
            $('#' + idmodal).modal({show: true});
        });
    } else
        swalTimer("Solicitud", "Seleccione una solicitud", "error");
};

var fncModalSubirOrdenPDF = function (idmodal, idtabla, rowid) {
    var objeto = JSON.parse(decodeURI($("#" + idtabla + " #" + rowid).attr("data-json")));
    if (typeof objeto !== "undefined") {
        console.log(objeto);
        $('#' + idmodal + ' .modal-content').load(
                'protected/Administrador/SalvoConductos/SalvoConductosControlador.jsp?opc=mostrar&accion=modSubirOrden',
                function () {
                    $('#' + idmodal).modal({show: true});
                    $('#' + idmodal + " #numeroOrden").val(objeto.numero);
                    $('#' + idmodal + " #titleOrdenSubirPDF").html(" Orden <strong>" + objeto.numero + "</strong> | Subir PDF ");
                });
    }
};

var fncSubirOrdenPDF = function (idform, idmodal) {
    var parsleyForm = $('#' + idform).parsley();
    parsleyForm.validate();
    if (!parsleyForm.isValid())
        return false;
    else {
        var numeroOrden = $('#' + idform + " #numeroOrden").val();
        if (typeof numeroOrden !== 'undefined') {
            var input = document.getElementById('filePDF');
            if (!input) {
                alert("Um, couldn't find the fileinput element.");
            } else if (!input.files) {
                alert("This browser doesn't seem to support the `files` property of file inputs.");
            } else if (!input.files[0]) {
                alert("Please select a file before clicking 'Load'");
            } else {
                swalTimerLoading("Transacción subir PDF", "Se esta subiendo su PDF, esto puede tardar un momento...", 10000);
                var file = input.files[0];
                var myform = $("#" + idform);
                var fd = new FormData(myform);
                fd.append("dato", file);
                fd.append("numeroOrden", numeroOrden);
                console.log(fd);
                $.ajax({
                    url: "protected/Administrador/SalvoConductos/SalvoConductosControlador.jsp?opc=subirOrdenPDF",
                    data: fd,
                    cache: false,
                    processData: false,
                    contentType: false,
                    type: 'POST',
                    success: function (datos) {
                        $("#modGeneralSalvoConducto").modal("hide");
                        datos = JSON.parse(datos);
                        if (datos.codigo === "OK") {
                            swalNormal("Completado", datos.respuesta, "success");
                        } else {
                            swalNormal("Completado", datos.respuesta, "error");
                        }
                        fncRecargarJQGenerarSalvoDNuevo("tbSolSalvoConducto", "jsonFullOrdenes");
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
            {label: 'Solicitud', name: 'solicitud', jsonmap: "solicitud.numero", width: 50, editable: false, align: 'center', sorttype: 'integer'},
            {label: 'Numero', name: 'numero', jsonmap: "ordenMovilzicion.numeroOrden", width: 100, editable: false, align: 'center', key: true},
            {label: 'Fecha Gen', name: 'fechagenerar', jsonmap: "ordenMovilzicion.fechagenerar", width: 90, editable: false, sorttype: 'date',
                autoResizing: {minColWidth: 85},
                formatter: 'date',
                formatoptions: {
                    srcformat: "ISO8601Long",
                    newformat: 'Y-m-d H:i'
                }
            },
            {label: 'Km Inicio', name: 'kminicio', jsonmap: "ordenMovilzicion.kminicio", width: 100, editable: true, search: false, sortable: false,
                editrules: {
                    required: true,
                    custom: true,
                    custom_func: function (value, colname) {
                        if (value.indexOf('+') > -1 || value.indexOf('-') > -1 || value.indexOf(',') > -1 || value.indexOf(' ') > -1)
                            return [false, "KM Fin solo admite números idx"];
                        if (parseFloat(value) === "NaN")
                            return [false, "KM fin solo admite números prs"];
                        else
                            return [true, ""];
                        if (isNaN(value))
                            return [false, "KM Fin solo admite números nan"];
                        else
                            return [true, ""];

                    }
                }
            },
            {label: 'Km Fin', name: 'kmfin', jsonmap: "ordenMovilzicion.kmfin", width: 100, editable: true, search: false, sortable: false,
                editrules: {
                    required: true,
                    custom: true,
                    custom_func: function (value, colname) {
                        if (value.indexOf('+') > -1 || value.indexOf('-') > -1 || value.indexOf(',') > -1 || value.indexOf(' ') > -1)
                            return [false, "KM Fin solo admite números idx"];
                        if (parseFloat(value) === "NaN")
                            return [false, "KM fin solo admite números prs"];
                        else
                            return [true, ""];
                        if (isNaN(value))
                            return [false, "KM Fin solo admite números nan"];
                        else
                            return [true, ""];

                    }
                }
            },
            {label: 'PDF req.', name: 'idpdfreq', jsonmap: "solicitud.idpdf", width: 50, editable: false, search: false, sortable: false,
                formatter: function (cellvalue, opts) {
                    if (typeof cellvalue !== "undefined")
                        return 'SI';
                    else
                        return 'No';
                }
            },
            {label: 'PDF orden', name: 'idpdf', jsonmap: "ordenMovilzicion.idpdf", width: 50, editable: false, search: false, sortable: false,
                formatter: function (cellvalue, opts) {
                    if (typeof cellvalue !== "undefined")
                        return 'SI';
                    else
                        return 'No';
                }
            },
            {label: 'Estado', name: 'estado', jsonmap: "solicitud.estado", width: 70, editable: false, search: true,
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
            {label: 'Observación', name: 'observacion', jsonmap: "solicitud.observacion", width: 150, editable: true, search: false, sortable: false,
                edittype: 'textarea',
                editoptions: {
                    cols: 34,
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
            {label: 'Solicitud', name: 'jsonsolicitud', width: 130, jsonmap: "ordenMovilzicion.solicitud", editable: false,
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
                label: "Opciones",
                name: "actions",
                sortable: false,
                search: false,
                width: 90,
                formatter: "actions",
                formatoptions: {
                    keys: true,
                    delbutton: false,
                    editbutton: true,
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
//        rownumbers: true,
        viewrecords: true,
        width: 780,
        height: 450,
        loadtext: '<center><i class="fa fa-spinner fa-pulse fa-4x fa-fw"></i><span class="sr-only">Cargando...</span></center>',
        rowNum: 10,
        loadonce: true,
        pager: "#" + idtabla + "_pager",
        serializeRowData: function (postdata) {
            var rowData = $grid.jqGrid('getRowData', postdata.numero);
            var data = JSON.parse(decodeURI($("#" + idtabla + " #" + postdata.numero).attr("data-json")));

            var orden = {
                fechagenerar: rowData.fechagenerar,
                idpdf: data.idpdf,
                kmfin: postdata.kmfin,
                kminicio: postdata.kminicio,
                numeroOrden: rowData.numero
            };
            var solicitud = data.jsonsolicitud;
            if (typeof postdata.observacion !== "undefined" && postdata.observacion !== "" && postdata.observacion !== null)
                solicitud.observacion = postdata.observacion;
            else
                delete solicitud.observacion;
            return {opc: "modificarOrden", jsonSolicitud: JSON.stringify(solicitud), idSolicitud: solicitud.numero, jsonOrden: JSON.stringify(orden), idOrden: orden.numeroOrden};
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
                var idordenPDF = "mnOrdenPDF";

                if (typeof rowData.idpdfreq === "undefined") {
                    $(".list-inline #" + idpdfmn).addClass("inactive");
                    $(".list-inline #" + idpdfmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idpdfmn).removeClass("inactive");
                    $(".list-inline #" + idpdfmn).attr("onclick", "verSolRequisitosPDF('" + rowData.idpdfreq + "','" + idtabla + "','" + rowData.solicitud + "')");
                }
                if (typeof rowData.idpdf === "undefined") {
                    $(".list-inline #" + idordenPDF).addClass("inactive");
                    $(".list-inline #" + idordenPDF).attr("onclick", null);
                } else {
                    $(".list-inline #" + idordenPDF).removeClass("inactive");
                    $(".list-inline #" + idordenPDF).attr("onclick", "verSolRequisitosPDF('" + rowData.idpdf + "','" + idtabla + "','" + rowData.numero + "')");
                    console.log(rowData.idpdf);
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
                $(".list-inline #" + idasigVCmn).attr("onclick", "disponVCSolOrdenModal('modGeneralSalvoConducto','" + idtabla + "','" + data + "')");
            }
        },
        loadComplete: function () {
            var grid = $grid,
                    iCol = 14; // 'act' - columna donde esta los botones de acciones
            var i = 0;
            grid.children("tbody")
                    .children("tr.jqgrow")
                    .children("td:nth-child(" + (iCol + 1) + ")") //buscamos los elementos en el dom de la columna accion
                    .each(function () {
                        var obj = JSON.parse(decodeURI($(this).children("div").parents("tr").attr("data-json"))).solicitud;
                        obj = encodeURI(JSON.stringify(obj));
                        /**Creación del boton para llamar al modal para generar una orden al dar click*/
                        $("<div>",
                                {
                                    title: "GENERAR SALVOCONDUCTO",
                                    id: "btnGenerar_" + i,
                                    click: function (e) {
                                        fncModalGenerarSalvoConductoDNuevo('modGeneralSalvoConducto', idtabla, $(e.target).closest("tr.jqgrow").attr("id")),
                                                onmouseover = jQuery(this).addClass('ui-state-hover'),
                                                onmouseout = jQuery(this).removeClass('ui-state-hover');
                                    }
                                }

                        ).css({"margin-left": "12px", "margin-top": "2px", float: "left", cursor: "pointer"})
                                .addClass("ui-pg-div ui-inline-edit")
                                .append('<span class="fa fa-download fa-2x text-primary"></span>')
                                .appendTo($(this).children("div"));
                        /**Creación del boton para subir una orden pdf al dar click*/
                        $("<div>",
                                {
                                    title: "SUBIR ORDEN PDF",
                                    id: "btnSubir_" + i,
                                    click: function (e) {
                                        fncModalSubirOrdenPDF('modGeneralSalvoConducto', idtabla, $(e.target).closest("tr.jqgrow").attr("id")),
                                                onmouseover = jQuery(this).addClass('ui-state-hover'),
                                                onmouseout = jQuery(this).removeClass('ui-state-hover');
                                    }
                                }

                        ).css({"margin-left": "12px", "margin-top": "2px", float: "left", cursor: "pointer"})
                                .addClass("ui-pg-div ui-inline-edit")
                                .append('<span class="fa fa-cloud-upload fa-2x text-success"></span>')
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
