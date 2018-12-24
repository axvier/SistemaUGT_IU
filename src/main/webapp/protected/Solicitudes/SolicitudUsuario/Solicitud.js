var idcont = 0;

var fncConfirmarGenerarSolcitud = function () {
    swal.close();
    swalConfirmNormal("Todo listo!", "Desea Generar su solicitud en PDF", "info", "fncGenerarSOlcitud");
};

var fncGenerarSOlcitud = function () {
    swal.close();
    swalTimerLoading("Solicitud PDF","Se esta generando su solicitud esto puede tardar unos minutos",3000);
}

var fncGuardarSolicitud = function () {
    swalTimerLoading("Enviando", "Solicitud", 90000);
    var motivo = JSON.stringify(fncObjSeccionMotivo());
    var viaje = JSON.stringify(fncObjSeccionViaje());
    var listaPasajeros = JSON.stringify(fnObjSeccionPasajeros());
    var extension = $("#form1 #addExtension").val();
    var $dropZone = Dropzone.forElement("#drop_pdfs");
    $dropZone.on('sendingmultiple', function (data, xhr, formData) {
        formData.append("jsonMotivo", motivo);
        formData.append("jsonViaje", viaje);
        formData.append("jsonPasajeros", listaPasajeros);
        formData.append("extension", extension);
    });
    $dropZone.processQueue();
//    var fd = new FormData();
//    fd.append("pdfdata", $dropZone.files[0]);
//    console.log(fd);
//    console.log(fd);
//    $.ajax({
//        url: "protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp?jsonMotivo=" + motivo + "&jsonViaje="+viaje+"&jsonPasajeros="+ listaPasajeros+"&extension="+$("#form1 #addExtension").val()+"&opc=saveSolicitud",
//        type: "POST",
//        cache: false,
//        processData: false,
//        contentType: false,
//        data: {fd: fd},
//        success: function (datos) {
//            datos = JSON.parse(datos);
//            swalTimer(" Solicitud ", "[" + datos.codigo + "] " + datos.respuesta, "info");
//        },
//        error: function (jqXHR, textStatus, errorThrown) {
//            alert("Error de ejecucion -> " + textStatus + jqXHR);
//        }
//
//    });
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
        var pasajero = {
            apellidos: $(this).find('.apellidos').find('#apellidos').val(),
            cedula: $(this).find('.cedula').find('#cedula').val(),
            descripcion: $(this).find('.descripcion').find('#descripcion').val(),
            entidad: $(this).find('.entidad').find('#entidad').val(),
            nombres: $(this).find('.nombres').find('#nombres').val()
        };
        lista.push(pasajero);
    });
    return lista;
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
            + "                                            <a data-toggle='collapse' data-parent='#accordion' href='#collapseOne" + idcont + "' aria-expanded='false' class='collapsed' >"
            + "                                                <input type='text' name='pasajeros[]' data-salto='s' id='title" + idcont + "' class='form-control pasajeros_lista' placeholder='Ingrese uno' readonly style='cursor: pointer'>"
            + "                                            </a>"
            + "                                        </div>"
            + "                                        <div id='collapseOne" + idcont + "' class='panel-collapse collapse' aria-expanded='false' style='height: 0px;'>"
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
            + "                                            <a data-toggle='collapse' data-parent='#accordion' href='#collapseOne" + idcont + "' aria-expanded='false' class='collapsed' >"
            + "                                                <input type='text' value='" + obj.nombres + " " + obj.apellidos + "' data-salto='s' name='pasajeros[]' id='title" + idcont + "' class='form-control pasajeros_lista' placeholder='Ingrese uno' readonly style='cursor: pointer'>"
            + "                                            </a>"
            + "                                        </div>"
            + "                                        <div id='collapseOne" + idcont + "' class='panel-collapse collapse' aria-expanded='false' style='height: 0px;'>"
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