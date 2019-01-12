var idcont = 0;

var fncConfirmarGenerarSolcitud = function (datos) {
    var titulo;
    var mensaje;
    var tipo;
    if (datos.codigo === "KO") {
        titulo = "Datos Imcompletos!", mensaje = "Algunas partes no se han guardado correctamete, desea generar su solicitud Pdf de todos modos",
                tipo = "warning";
    } else {
        titulo = "Todo listo!", mensaje = "Desea Generar su solicitud en PDF", tipo = "success";
    }
    swal({
        title: titulo,
        text: mensaje,
        type: tipo,
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI',
        cancelButtonText: 'NO'
    }).then((valor) => {
        if (valor)
            this.fncGenerarSOlcitud('modGestionSol', datos, "fncNuevaSolicitud()", "SolicitudPDFServelet"); // this should execute now
    }, function (dismiss) {
        this.fncNuevaSolicitud();
    });
};
var modalcierre = function (idmodal, funcionCall) {
    $('#' + idmodal).modal('hide');
//    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
    if (funcionCall === 'fncNuevaSolicitud') {
        fncNuevaSolicitud();
    }
};

var fncGenerarSOlcitud = function (idmodal, datos, notfnccerrar, actionform) {
    $('#' + idmodal + ' .modal-content').load('protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp?opc=modConfirmSolPDF&idSolicitud=' + datos.idSolicitud, function () {
        if (typeof notfnccerrar !== 'undefined') {
            if (notfnccerrar === "fncNuevaSolicitud()") {
                $('#' + idmodal + ' .modal-body .btn-default').attr("onclick", "modalcierre('" + idmodal + "','fncNuevaSolicitud')");
            }
            if (notfnccerrar === "null") {
                $('#' + idmodal + ' .modal-body .btn-default').attr("onclick", null);
            }
        }
        if (typeof actionform !== 'undefined') {
            $('#' + idmodal + ' .modal-body #formAddInfoSol').attr("action", actionform);
        }

        $('#' + idmodal).modal({show: true, backdrop: 'static', keyboard: false});
    });
};

var fncAddInfoSolPDF = function (idform, idSolicitud) {
    $("#modGestionSol").modal('hide');
    swalTimerLoading("Procesando..", "Se esté generando su solicitud esto puede tardar", 9000);
    var nom_apell = $('#' + idform + ' #addNombres_Apellidos').val();
    var rol_entidad = $('#' + idform + ' #addRol_entidad').val();
    $.ajax({
        url: "protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp",
        type: "POST",
        data: {opc: 'generarPDFSolID', idSolicitud: idSolicitud, nombre_apellido: nom_apell, rol_entidad: rol_entidad}
//        success: function () {
//            swal.close();
//            fncNuevaSolicitud();
//        },
//        error: function (e) {
//            swal.close();
//            location.reload();
//        }
    });
};

var fncGuardarSolicitud = function () {
    swalTimerLoading("Enviando", "Solicitud", 90000);
    var motivo = JSON.stringify(fncObjSeccionMotivo());
    var viaje = JSON.stringify(fncObjSeccionViaje());
    var listaPasajeros = JSON.stringify(fnObjSeccionPasajeros());
    var extension = $("#form1 #addExtension").val();
    var $dropZone = Dropzone.forElement("#drop_pdfs");
    $dropZone.on('sendingmultiple', function (data, xhr, formData) {
        motivo = encodeURI(motivo);
        viaje = encodeURI(viaje);
        listaPasajeros = encodeURI(listaPasajeros);
        extension = encodeURI(extension);
        formData.append("jsonMotivo", motivo);
        formData.append("jsonViaje", viaje);
        formData.append("jsonPasajeros", listaPasajeros);
        formData.append("extension", extension);
    });
    $dropZone.processQueue();
};

var fncObjSeccionMotivo = function () {
    var seccionMotivo = {
        idmotivo: 0,
        descripcion: $("#form1 #addTxtMotivo").val()
    };
    return seccionMotivo;
};

var fncObjSeccionViaje = function () {
    var seccionViaje = {
        destino: $("#form2 #addDestino").val(),
        fecharetorno: $("#form2 #addFechaRetorno").val() + ":00-05:00",
        fechasalida: $("#form2 #addFechaSalida").val() + ":00-05:00",
        idviaje: 0,
        origen: $("#form2 #addOrigen").val(),
        telefono: $("#form2 #addTelefono").val()
    };
    return seccionViaje;
};

var fnObjSeccionPasajeros = function () {
    var lista = [];
    $("#form3 #dynamic_div_solicitud div[id^='r']").each(function () {
        var tbpasajeros = {
            apellidos: $(this).find('.apellidos').find('#apellidos').val(),
            cedula: $(this).find('.cedula').find('#cedula').val(),
            descripcion: $(this).find('.descripcion').find('#descripcion').val(),
            entidad: $(this).find('.entidad').find('#entidad').val(),
            nombres: $(this).find('.nombres').find('#nombres').val()
        };
        var tipo = $(this).find('.tipo').find('#tipo').val();
        var obj = {
            tbpasajeros: tbpasajeros,
            tipo: tipo
        };
        lista.push(obj);
    });
    return {lista: lista};
};

var fncRemovePasjero = function (idrow) {
    $("#r" + idrow + "").remove();
};

var fncPutTitlePasajero = function (obj) {
    var idDiv = $(obj).parent().children().attr("data-id");
    var tipo = $(obj).parent().children().attr("data-tipo");
    var value = $(obj).parent().children().val();
    if (tipo === 'c') {
        var apellido = $("#" + idDiv + " #apellidos").val();
        $("#title" + idDiv).val(value + " " + apellido);
    }
    if (tipo === 'a') {
        var nombre = $("#" + idDiv + " #nombres").val();
        $("#title" + idDiv).val(nombre + " " + value);
    }
};

var fncAddPasajeroManual = function (idform) {
    var div = "                                <div class='row' id='r" + idcont + "'>"
            + "                                    <div class='panel panel-default col-sm-8'>"
            + "                                        <div class='panel-heading'>"
            + "                                            <a data-toggle='collapse' data-parent='#accordion' href='#collapseOne" + idcont + "'>"
            + "                                                <div class='input-group'>"
            + "                                                  <input type='text' name='pasajeros[]' data-salto='s' id='title" + idcont + "' class='form-control pasajeros_lista' placeholder='Ingrese uno' readonly style='cursor: pointer'>"
            + "                                                  <span class='input-group-addon'><i class='fa fa-arrows-v'></i></span>"
            + "                                                </div>"
            + "                                            </a>"
            + "                                        </div>"
            + "                                        <div id='collapseOne" + idcont + "' class='panel-collapse collapse in'>"
            + "                                            <div class='panel-body'>"
            + "                                                <div class='contenidoPasajero' id='" + idcont + "'>"
            + "                                                    <div class='form-group cedula'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Cédula</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <input type='text' id='cedula' class='form-control' placeholder='0987654387' value='' aria-describedby='basic-addon1'>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                    <div class='form-group nombres'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Nombres</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <input type='text' id='nombres' class='form-control' placeholder='Nombres' value='' aria-describedby='basic-addon1' data-tipo='c' data-id='" + idcont + "' onkeyup='fncPutTitlePasajero(this)'>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                    <div class='form-group apellidos'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Apellids</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <input type='text' id='apellidos' class='form-control' placeholder='Apellidos' value='' aria-describedby='basic-addon1' data-tipo='a' data-id='" + idcont + "' onkeyup='fncPutTitlePasajero(this)'>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                    <div class='form-group entidad'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Entidad</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <input type='text' id='entidad' class='form-control' placeholder='Describa la entidad a la que pertenece' value='' aria-describedby='basic-addon1'>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                    <div class='form-group descripcion'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Cargo</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <input type='text' id='descripcion' class='form-control' placeholder='Describa el cargo/ocupación' value='' aria-describedby='basic-addon1'>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                   <div class='form-group tipo'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Tipo</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <select id='tipo' class='form-control' title='Tipo de pasajero'>"
            + "                                                               <option disabled value='' selected hidden> -Escoja uno- </option>"
            + "                                                               <option data-tokens='Servidor institucional' value='Normal'>Servidor institucional</option>"
            + "                                                               <option data-tokens='Comision' value='Comision'>Comision</option>"
            + "                                                               <option data-tokens='Expositor' value='Expositor'>Expositor</option>"
            + "                                                               <option data-tokens='Invitado' value='Invitado'>Invitado</option>"
            + "                                                               <option data-tokens='Otros' value='Otros'>Otros</option>"
            + "                                                            </select>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                </div>"
            + "                                            </div>"
            + "                                        </div>"
            + "                                    </div>"
            + "                                    <div class='col-sm-2'>"
            + "                                        <button class='btn btn-danger' type='button' onclick=\"fncRemovePasjero('" + idcont + "')\"><i class='fa fa-minus'></i>"
            + "                                    </div>"
            + "                                </div>";
    $("#" + idform + " #dynamic_div_solicitud").append(div);
    idcont++;
};

var fncCatchSelectS = function (idform) {
//    $("<div>").text(message).prependTo("#log");
//    $("#log").scrollTop(0);
//    console.log(message.item.json);
    var obj = JSON.parse($('#json_solicitud_pasajeros').val());
    var div = "                                <div class='row' id='r" + idcont + "'>"
            + "                                    <div class='panel panel-default col-sm-8'>"
            + "                                        <div class='panel-heading'>"
            + "                                            <a data-toggle='collapse' data-parent='#accordion' href='#collapseOne" + idcont + "'>"
            + "                                                <div class='input-group'>"
            + "                                                  <input type='text' value='" + obj.nombres + " " + obj.apellidos + "' data-salto='s' name='pasajeros[]' id='title" + idcont + "' class='form-control pasajeros_lista' placeholder='Ingrese uno' readonly style='cursor: pointer'>"
            + "                                                  <span class='input-group-addon'><i class='fa fa-arrows-v'></i></span>"
            + "                                                </div>"
            + "                                            </a>"
            + "                                        </div>"
            + "                                        <div id='collapseOne" + idcont + "' class='panel-collapse collapse in'>"
            + "                                            <div class='panel-body'>"
            + "                                                <div class='contenidoPasajero' id='" + idcont + "'>"
            + "                                                    <div class='form-group cedula'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Cédula</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <input type='text' id='cedula' class='form-control' placeholder='0987654387' value='" + obj.cedula + "' aria-describedby='basic-addon1'>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                    <div class='form-group nombres'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Nombres</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <input type='text' id='nombres' class='form-control' placeholder='Nombres' value='" + obj.nombres + "' aria-describedby='basic-addon1' data-tipo='c' data-id='" + idcont + "' onkeyup='fncPutTitlePasajero(this)'>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                    <div class='form-group apellidos'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Apellids</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <input type='text' id='apellidos' class='form-control' placeholder='Apellidos' value='" + obj.apellidos + "' aria-describedby='basic-addon1' data-tipo='a' data-id='" + idcont + "' onkeyup='fncPutTitlePasajero(this)'>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                    <div class='form-group entidad'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Entidad</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <input type='text' id='entidad' class='form-control' placeholder='Describa la entidad a la que pertenece' value='" + obj.entidad + "' aria-describedby='basic-addon1'>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                    <div class='form-group descripcion'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Cargo</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <input type='text' id='descripcion' class='form-control' placeholder='Describa el cargo/ocupación' value='" + obj.descripcion + "' aria-describedby='basic-addon1'>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                    <div class='form-group tipo'>"
            + "                                                        <label for='ticket-name' class='col-sm-2 control-label'>Tipo</label>"
            + "                                                        <div class='col-sm-6'>"
            + "                                                            <select id='tipo' class='form-control' title='Tipo de pasajero'>"
            + "                                                               <option disabled value='' selected hidden> -Escoja uno- </option>"
            + "                                                               <option data-tokens='Servidor institucional' value='Normal'>Servidor institucional</option>"
            + "                                                               <option data-tokens='Comision' value='Comision'>Comision</option>"
            + "                                                               <option data-tokens='Expositor' value='Expositor'>Expositor</option>"
            + "                                                               <option data-tokens='Invitado' value='Invitado'>Invitado</option>"
            + "                                                               <option data-tokens='Otros' value='Otros'>Otros</option>"
            + "                                                            </select>"
            + "                                                        </div>"
            + "                                                    </div>"
            + "                                                </div>"
            + "                                            </div>"
            + "                                        </div>"
            + "                                    </div>"
            + "                                    <div class='col-sm-2'>"
            + "                                        <button class='btn btn-danger' type='button' onclick=\"fncRemovePasjero('" + idcont + "')\"><i class='fa fa-minus'></i>"
            + "                                    </div>"
            + "                                </div>";
    $("#" + idform + " #dynamic_div_solicitud").append(div);
    idcont++;
    $("#search_solicitud_pasajeros").val("");
    $("#json_solicitud_pasajeros").val("");
    $("#search_solicitud_pasajeros_button").prop('disabled', true);

};

var verViajeSolicitudModal = function (idmodal, idtabla) {
//    $("#modGeneralCondTitulo").html(" UGT | Asignados");
    var $grid = $("#tbMisSolicitudes");
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        var data = $("#" + idtabla + " #" + selRowId).attr("data-json");
        var dcodes = decodeURI(data);
        var objeto = JSON.parse(dcodes);
        var htmlc = "" +
                "                <div class='modal-header'>" +
                "    <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>" +
                "    <h4 class='modal-title' id='modalLicenciaTitulo'> Solicitud " + objeto.numero + " | Viaje </h4>" +
                "</div>" +
                "<div class='modal-body'>" +
                "    <form class='form-horizontal' role='form'>";
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
    } else
        swalTimer("Solicitud", "Seleccione una solicitud", "error");
};

var verPasajerosSolModal = function (idmodal, idtabla) {
//    $("#modGeneralCondTitulo").html(" UGT | Asignados");
    var $grid = $("#tbMisSolicitudes");
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        var data = $("#" + idtabla + " #" + selRowId).attr("data-json");
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
    } else
        swalTimer("Solicitud", "Seleccione una solicitud", "error");
};

var ingInfoDescSolicitudModal = function (idmodal, idtabla) {
    var $grid = $("#tbMisSolicitudes");
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        var data = $("#" + idtabla + " #" + selRowId).attr("data-json");
        var dcodes = decodeURI(data);
        var objeto = JSON.parse(dcodes);
        fncGenerarSOlcitud(idmodal, {idSolicitud: objeto.numero}, "null", "SolicitudPDFServelet");
    } else
        swalTimer("Solicitud", "Seleccione una solicitud", "error");
};

var verSolRequisitosPDF = function (idpdfreq, idtabla) {
    var $grid = $("#" + idtabla);
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        var rowData = $grid.jqGrid('getRowData', selRowId);
        swal({
            title: "Requisitos de la solicitud " + rowData.numero,
            text: "Desea ver los requisitos subidos a la solicutd",
            type: "info",
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'SI',
            cancelButtonText: 'NO'
        }).then((valor) => {
            if (valor)
                this.downloadReqSolicitud(idpdfreq); // this should execute now
        }, function (dismiss) {
            swal.close();
        });
    } else
        swalTimer("Solicitud", "Seleccione una solicitud", "error");
};

var downloadReqSolicitud = function (idpdfreq) {
    if (idpdfreq !== null) {
        swalTimerLoading("Consultando requisitos", "Esto puede tardar un momento...", 9000);
        $.ajax({
            url: "protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp",
            type: "POST",
            data: {opc: 'downloadReqSol', idSolicitud: idpdfreq},
            success: function (data) {
                swal.close();
                let pdfWindow = window.open("");
                pdfWindow.document.write("<iframe width='100%' height='100%' src='data:application/pdf;base64, " + (data) + "'></iframe>");
            },
            error: function (e) {
                location.reload();
            }
        });
    } else
        swalNormal("Sin requisitos", "No tiene un pdf de requisitos asignados", "error");
};

var verSolDisponV_C = function (idmodal, idtabla) {
    var $grid = $("#" + idtabla);
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        swalTimerLoading("Consultado datos", "Esto puede tardar un momento...", 9000);
        var rowData = $grid.jqGrid('getRowData', selRowId);
        $('#' + idmodal + ' .modal-content').load('protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp?opc=modDisponibilidadV_C&idSolicitud=' + rowData.numero, function () {
            swal.close();
            $('#' + idmodal).modal({show: true});
        });
    } else
        swalTimer("Solicitud", "Seleccione una solicitud", "error");
};

var fnccvalidarfecharetorno = function (idorigen, iddestino) {
    var value = $("#form2 #" + idorigen).val();
    $("#form2 #" + iddestino).attr("min", value);
};

var fnccvalidarfechasalida = function (idorigen, iddestino) {
    var value = $("#form2 #" + idorigen).val();
    $("#form2 #" + iddestino).attr("max", value);
};

var fncDibujarMisSolicitudes = function (idtabla) {
    var $grid = $("#" + idtabla);
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/Solicitudes/SolicitudUsuario";
    $grid.jqGrid({
        url: urlbase + "/SolicitudControlador.jsp?opc=misSolicitudes",
        editurl: urlbase + "/SolicitudControlador.jsp",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'ID', name: 'numero', jsonmap: "solicitud.numero", key: true, width: 50, editable: false, sorttype: 'integer'},
            {label: 'fecha', name: 'fecha', jsonmap: "solicitud.fecha", width: 130, editable: false,
                formatter: 'date',
                formatoptions: {
                    srcformat: "ISO8601Long",
                    newformat: 'Y-m-d'
                }
            },
            {label: 'Estado', name: 'estado', jsonmap: "solicitud.estado", width: 70, editable: true, search: true,
                formatter: function (cellvalue, options, rowObject) {
                    if (cellvalue === "asignada")
                        return '<span style="background-color: #C0E7FB; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else if(cellvalue === 'rechazada')
                        return '<span style="background-color: #FBC9C0; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else if(cellvalue === 'aprobada')
                        return '<span style="background-color: #E2FBC0; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else if(cellvalue === 'finalizada')
                        return '<span style="background-color: #F3DAB0; display: block; width: 100%; height: 100%; ">' + cellvalue + '</span>';
                    else
                        return cellvalue;
                }
            },
            {label: 'PDF', name: 'idpdf', jsonmap: "solicitud.idpdf", width: 40, editable: true},
            {label: 'Motivo', name: 'descripcion', jsonmap: "motivo.descripcion", width: 140, editable: true, search: false, sortable: false},
            {label: 'Observacion', name: 'observacion', jsonmap: "solicitud.observacion", width: 140, editable: true, search: false, sortable: false, resizable: true},
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
                label: "Opciones",
                name: "actions",
                sortable: false,
                search: false,
                width: 50,
                formatter: "actions",
                formatoptions: {
                    keys: true,
                    editbutton: false,
                    editOptions: {},
                    addOptions: {},
                    delOptions: {
                        height: 150,
                        width: 300,
                        serializeDelData: function (postdata) {
                            delete postdata.oper;
//                            console.log({opc: "eliminarSolicitud", idSolicitud: postdata.id});
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
        height: 400,
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
                var rowData = $grid.jqGrid('getRowData', rowid);
                if (typeof (rowData.estado) !== 'undefined') {
                    if (rowData.estado === 'finalizado' || rowData.estado === 'asignada') {
                        $(".list-inline #mnSolGenerar").addClass("inactive");
                        $(".list-inline #mnSolGenerar").attr("onclick", null);
                    } else {
                        $(".list-inline #mnSolGenerar").removeClass("inactive");
                        $(".list-inline #mnSolGenerar").attr("onclick", "ingInfoDescSolicitudModal('modGeneralMisSolicitudes','tbMisSolicitudes')");
                    }
                }
                if (rowData.idpdf === "") {
                    $(".list-inline #mnSolReqPDF").addClass("inactive");
                    $(".list-inline #mnSolReqPDF").attr("onclick", null);
                } else {
                    $(".list-inline #mnSolReqPDF").removeClass("inactive");
                    $(".list-inline #mnSolReqPDF").attr("onclick", "verSolRequisitosPDF('" + rowData.idpdf + "','tbMisSolicitudes')");
                }
            }
        },
        afterInsertRow: function (rowid, rowdata, rowelem) {
            var selRowId = $(this).getGridParam('selrow'),
                    tr = $("#" + rowid);
            // you can use getCell or getRowData to examine the contain of
            // the selected row to decide whether the row is editable or not
            if (selRowId !== rowid && rowdata.estado === 'finalizado') {
                // eneble the "Edit" button in the navigator
//                console.log(rowdata.estado);
//                console.log(this.id);
                $("#" + idtabla + " #jDeleteButton_" + rowid).hide();
            }
            return true;
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