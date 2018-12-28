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
            this.fncGenerarSOlcitud(); // this should execute now
        else
            this.fncNuevaSolicitud();
    });
};

var fncGenerarSOlcitud = function () {
    alert("PDFGenerado");
    fncNuevaSolicitud();
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
            + "                                                               <option data-tokens='Normal' value='Normal'>Normal</option>"
            + "                                                               <option data-tokens='Comision' value='Comision'>Comision</option>"
            + "                                                               <option data-tokens='Controlador' value='Controlador'>Controlador</option>"
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
            + "                                                               <option data-tokens='Normal' value='Normal'>Normal</option>"
            + "                                                               <option data-tokens='Comision' value='Comision'>Comision</option>"
            + "                                                               <option data-tokens='Controlador' value='Controlador'>Controlador</option>"
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