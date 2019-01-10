var contagenda = 0;
var viajeSolicitudModal = function (idmodal, idtabla, data) {
//    var data = $("#" + idtabla + " #" + selRowId).attr("data-json");
    var objeto = JSON.parse(decodeURI(data));
    console.log(objeto);
    var htmlc = "" +
            "                <div class='modal-header'>" +
            "    <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>" +
            "    <h4 class='modal-title' id='modalLicenciaTitulo'> Solicitud " + objeto.numero + " | Viaje </h4>" +
            "</div>" +
            "<div class='modal-body'>" +
            "    <form class='form-horizontal' role='form'>";
    if (typeof objeto.motivo !== 'undefined') {
        var motivo = (typeof objeto.motivo.descripcion === "undefined") ? "No tiene motivo" : objeto.motivo.descripcion;
        htmlc += "<div class='form-group'>" +
                "            <label class='col-sm-2 control-label' >Motivo</label>" +
                "            <div class='col-sm-10'>" +
                "                <p>" + motivo + "' </p>" +
                "            </div>" +
                "        </div>";
    } else {
        htmlc += "   <p>No hay información del motivo</p>";
    }
    if (typeof objeto.viaje !== 'undefined') {
        var obj = objeto.viaje;
        var fecha_s = obj.fechasalida;
        fecha_s = fecha_s.replace('-05:00', '');
        var fecha_r = obj.fecharetorno;
        fecha_r = fecha_r.replace('-05:00', '');
        htmlc += "        <div class='form-group'>" +
                "            <label  class='col-sm-2 control-label' >Origen</label>" +
                "            <div class='col-sm-10'>" +
                "                <input type='text' class='form-control' value='" + obj.origen + "' readonly/>" +
                "            </div>" +
                "        </div>" +
                "        <div class='form-group'>" +
                "            <label class='col-sm-2 control-label' >Destino</label>" +
                "            <div class='col-sm-10'>" +
                "                <input type='text' class='form-control' value='" + obj.destino + "' readonly/>" +
                "            </div>" +
                "        </div>" +
                "        <div class='form-group'>" +
                "            <label class='col-sm-2 control-label' >Fecha salida</label>" +
                "            <div class='col-sm-10'>" +
                "                <input type='datetime-local' class='form-control' value='" + fecha_s + "' readonly/>" +
                "            </div>" +
                "        </div>" +
                "        <div class='form-group'>" +
                "            <label class='col-sm-2 control-label' >Fecha retorno</label>" +
                "            <div class='col-sm-10'>" +
                "                <input type='datetime-local' class='form-control' value='" + fecha_r + "' readonly/>" +
                "            </div>" +
                "        </div>" +
                "        <div class='form-group'>" +
                "            <label class='col-sm-2 control-label' >Telefono</label>" +
                "            <div class='col-sm-10'>" +
                "                <input type='text' class='form-control' value='" + obj.telefono + "' readonly/>" +
                "            </div>" +
                "        </div>";
    } else {
        htmlc += "   <p>No hay información del viaje</p>";
    }
    htmlc += "   </form>" +
            "</div>" +
            "<div class='modal-footer'>" +
            "<button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Close</button>" +
            "</div>";
    $("#" + idmodal + " .modal-content").html(htmlc);
    $('#' + idmodal).modal({show: true});
//    } else
//        swalTimer("Solicitud", "Seleccione una solicitud", "error");
};

var usuarioSolModal = function (idmodal, idtabla, data) {
//    var $grid = $("#" + idtabla);
//    var selRowId = $grid.jqGrid("getGridParam", "selrow");
//    if (selRowId !== null) {
//        var data = $("#" + idtabla + " #" + selRowId).attr("data-json");
    var objeto = JSON.parse(decodeURI(data)).solicitante;
    if (typeof objeto.cedulau !== 'undefined') {
        $('#' + idmodal + ' .modal-content').load('protected/Solicitudes/SolicitudesGestion/SolicitudesControlador.jsp?opc=modSolicitanteInfo&cedulaSolicitante=' + objeto.cedulau.cedula + "&idSolicitud=" + objeto.numero, function () {
            $('#' + idmodal).modal({show: true});
        });
    } else {
        $("#" + idmodal + " .modal-content").html("<p>No hay información del usuario que envio la solicitud</p>");
    }
//    } else
//        swalTimer("Solicitud", "Seleccione una solicitud", "error");
};

var pasajerosSolModal = function (idmodal, idtabla, data) {
//    var $grid = $("#" + idtabla);
//    var selRowId = $grid.jqGrid("getGridParam", "selrow");
//    if (selRowId !== null) {
//        var data = $("#" + idtabla + " #" + selRowId).attr("data-json");
    var dcodes = decodeURI(data);
    var objeto = JSON.parse(dcodes);
    var divAtomatic = "<table class='table table-striped table-hover'>"
            + "    <thead>"
            + "        <tr>"
            + "            <th>Tipo</th>         "
            + "            <th>Cédula</th>         "
            + "            <th>Nombres</th>          "
            + "            <th>Apellidos</th>       "
            + "            <th>Cargo</th>       "
            + "            <th>Entidad</th>       "
            + "         </tr>   "
            + "    </thead> "
            + "    <tbody>";
    var pasajerosL = [];
    pasajerosL = objeto.pasajeros;
    if (typeof objeto.pasajeros !== "undefined") {
        pasajerosL.forEach(function (e) {
            var pasAux = e.tbpasajeros;
            divAtomatic += "<tr>"
                    + "         <td>" + e.tipo + "</td>"
                    + "         <td>" + pasAux.cedula + "</td>"
                    + "         <td>" + pasAux.nombres + "</td>"
                    + "         <td>" + pasAux.apellidos + "</td>"
                    + "         <td>" + pasAux.descripcion + "</td>"
                    + "         <td>" + pasAux.entidad + "</td>"
                    + "     </tr>";
        });
        divAtomatic += "</tbody></table>";
    } else
        divAtomatic += "</tbody></table> Sin Pasajeros";

    $("#" + idmodal + " .modal-content").html("" +
            "                <div class='modal-header'>" +
            "    <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>" +
            "    <h4 class='modal-title' id='modalLicenciaTitulo'> Solicitud " + objeto.numero + " | Pasajeros </h4>" +
            "</div>" +
            "<div class='modal-body'>" +
            divAtomatic +
            "</div>" +
            "<div class='modal-footer'>" +
            "<button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Close</button>" +
            "</div>");
    $('#' + idmodal).modal({show: true});
//    } else
//        swalTimer("Solicitud", "Seleccione una solicitud", "error");
};

var gDisponibilidadVC = function (idmodal, idtabla, data) {
    $("#gSolicitudes_body").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    var $grid = $("#" + idtabla);
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        var dcode = decodeURI(data);
        var objeto = JSON.parse(dcode);
        var solicitanteCedula = 'todos';
        if (typeof objeto.solicitante !== "undefined")
            if (typeof objeto.solicitante.cedulau !== "undefined")
                if (typeof objeto.solicitante.cedulau.cedula !== "undefined")
                    solicitanteCedula = objeto.solicitante.cedulau.cedula;

        $.ajax({
            url: "protected/Solicitudes/SolicitudesGestion/SolicitudesControlador.jsp",
            type: "GET",
            data: {opc: "disponibilidadVehiculoConductor", cedulaSolicitante: solicitanteCedula},
            contentType: "application/json ; charset=UTF-8",
            success: function (datos) {
                $("#gSolicitudes_body").html(datos);
                $(".list-inline #mnListarSolG").removeClass("inactive");
                $(".list-inline #mnListarSolG").attr("onclick", "fncGestionSolicitudesAdmin()");
//                fncIniciarCalendar();
            },
            error: function (error) {
                location.reload();
            }
        });
    }
};

var fncVerAgendaPlaca = function () {
    if (typeof $("#addDVehiculoC").val() !== "undefined") {
        var selectVehiculo = $("#addDVehiculoC").val();
        if (contagenda < 1) {
            fncIniciarCalendar(selectVehiculo);
        } else {
            var events = {
                url: 'protected/Solicitudes/SolicitudesGestion/SolicitudesControlador.jsp?opc=AgendaVehiculo',
                type: "POST",
                data: {// a function that returns an object
                    placaAgenda: selectVehiculo
                }
            };

            $('.calendar').fullCalendar('removeEventSource', events);
            $('.calendar').fullCalendar('addEventSource', events);
            $('.calendar').fullCalendar('refetchEvents');
        }
    }
};

var fncIniciarCalendar = function (selectVehiculo) {
    contagenda++;
    var initialLocaleCode = 'es';
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var hh = today.getHours();
    var mim = today.getMinutes();
    var ss = today.getSeconds();
    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd;
    }
    if (mm < 10) {
        mm = '0' + mm;
    }
    if (mim < 10) {
        mim = '0' + mim;
    }
    if (hh < 10) {
        hh = '0' + hh;
    }
//    today = yyyy + '-' + mm + '-' + dd + 'T' + hh + ':' + mim;
    today = yyyy + '-' + mm + '-' + dd;
    $('.calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay,listMonth'
        },
        defaultDate: today,
        locale: initialLocaleCode,
        buttonIcons: false, // show the prev/next text
        weekNumbers: true,
        navLinks: true, // can click day/week names to navigate views
        editable: true,
        eventLimit: true, // allow "more" link when too many events
        events: {
            url: 'protected/Solicitudes/SolicitudesGestion/SolicitudesControlador.jsp?opc=AgendaVehiculo',
            data: {
                placaAgenda: selectVehiculo
            },
            error: function (xmlResponse) {
                console.log(xmlResponse);
                $('#alertgeneral').html("<div class='alert alert-danger alert-dismissable'><a href='#' class='close' onclick=\"fnccerraralert('alertgeneral')\">X</a><strong>Oh no!</strong> Ha ocurrido un error con la agenda.</div>");
            }
        },
        loading: function (bool) {
            $('#loading').toggle(bool);
        }
    });
};

var fncSelectConductorDVC = function () {
    var obj = JSON.parse($("#addDVehiculoC").find(':selected').attr("data-jsonvehiculo"));
    if (typeof obj.tbconductores !== "undefined") {
        $('#addDVConductor option[value="' + obj.tbconductores.cedula + '"]').prop('selected', true);
    } else {
        $('#addDVConductor option').eq(0).prop('selected', true);
    }
};

//var fncRefreshGNewSolicitudes = function (idtabla) {
//    var $grid = $("#" + idtabla);
//    $(window).on("resize", function () {
//        var grid = $grid, newWidth = $grid.closest(".ui-jqgrid").parent().width();
//        grid.jqGrid("setGridWidth", newWidth, true);
//    }).trigger('resize');
//    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/SuperAdministrador/Usuarios";
//    $grid.jqGrid('clearGridData');
//    $grid.jqGrid('setGridParam', {url: urlbase + "/UsuariosControlador.jsp?opc=jsonUsuarios", datatype: "json"}).trigger("reloadGrid");
//};


var fncDibujarSolicitudesNuevas = function (idtabla) {
    contagenda =0;
    var $grid = $("#" + idtabla);
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Solicitudes/SolicitudesGestion";
    $grid.jqGrid({
        url: urlbase + "/SolicitudesControlador.jsp?opc=jsonSolicitudesEnviados",
        editurl: urlbase + "/SolicitudControlador.jsp",
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
            {label: 'Estado', name: 'estado', jsonmap: "solicitud.estado", width: 70, editable: false, search: false},
            {label: 'Observación', name: 'observacion', jsonmap: "solicitud.observacion", width: 140, editable: true, search: false, sortable: false},
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
            delete postdata.oper;
            delete postdata.gerarquia;
            postdata.gerarquia = {
                descripcion: $("#" + postdata.idrol + "_gerarquia").find(':selected').attr('data-descripcion'),
                idtipo: $("#" + postdata.idrol + "_gerarquia").val()
            };
            return {opc: "modificarRol", jsonRol: JSON.stringify(postdata), idrol: postdata.idrol};
        },
        onSelectRow: function (rowid, selected) {
            if (typeof rowid !== 'undefined') {
                var data = $("#" + idtabla + " #" + rowid).attr("data-json");
                var rowData = JSON.parse(decodeURI(data));
                var idviajemn = "mnViajeSol";
                var idpasajmn = "mnPasjerosSol";
                var idpdfmn = "mnReqPDF";
                var idasigVCmn = "mnAsignarV_C";
                var idUsuarioSolmn = "mnUsuarioSol";

                if (typeof rowData.idpdf === "undefined") {
                    $(".list-inline #" + idpdfmn).addClass("inactive");
                    $(".list-inline #" + idpdfmn).attr("onclick", null);
                } else {
                    $(".list-inline #" + idpdfmn).removeClass("inactive");
                    $(".list-inline #" + idpdfmn).attr("onclick", "verSolRequisitosPDF('" + rowData.idpdf + "','" + idtabla + "')");
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
            }
        },
        loadComplete: function () {
            var grid = $grid,
                    iCol = 11; // 'act' - name of the actions column
            grid.children("tbody")
                    .children("tr.jqgrow")
                    .children("td:nth-child(" + (iCol + 1) + ")")
                    .each(function () {
                        var i = 0;
                        $("<div>",
                                {
                                    title: "Asignacion",
                                    id: "nwbtn_" + i++,
                                    onmouseover: "jQuery(this).addClass('ui-state-hover');",
                                    onmouseout: "jQuery(this).removeClass('ui-state-hover');",
//                                    onclick: "gDisponibilidadVC('modGeneralSolicitudes', '"+idtabla+"')"
                                    click: function (e) {
                                        gDisponibilidadVC('modGeneralSolicitudes', idtabla, $(e.target).closest("tr.jqgrow").attr("data-json"));
                                    }
                                }

                        ).css({"margin-left": "15px", "margin-top": "8px", float: "left", cursor: "pointer"})
                                .addClass("ui-pg-div ui-inline-edit")
                                .append('<span class="fa fa-car fa-3"></span>')
                                .appendTo($(this).children("div"));
                    });
        }
//        afterInsertRow: function (rowid, rowdata, rowelem) {
//            var selRowId = $(this).getGridParam('selrow'),
//                    tr = $("#" + rowid);
//            if (selRowId !== rowid && rowdata.estado === 'finalizado') {
//                $("#" + idtabla + " #jDeleteButton_" + rowid).hide();
//            }
//            return true;
//        }
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

    var getColumnIndexByName = function (columnName) {
        var cm = $grid.jqGrid('getGridParam', 'colModel'), i = 0, l = cm.length;
        for (; i < l; i += 1) {
            if (cm[i].name === columnName) {
                return i; // return the index
            }
        }
        return -1;
    };
};