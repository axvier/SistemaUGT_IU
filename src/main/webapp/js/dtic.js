$(document).ready(function () {
    if ($(window).width() < 992) {
        $('.left-sidebar').addClass('minified');
        $('.content-wrapper').addClass('expanded');
    }
    fncambiarRol("first");
});

function abrecierra() {
    if (!$('.left-sidebar').hasClass('left-sidebar')) {
        $('.left-sidebar').addClass('sidebar-float-active');
    }
    if (!$('.left-sidebar').hasClass('left-sidebar sidebar-float-active')) {
        $('.left-sidebar').removeClass('sidebar-float-active');
    }
}

function VentanaPorte() {
    if ($(window).width() < 992) {
        $('.left-sidebar').addClass('minified');
        $('.content-wrapper').addClass('expanded');

    } else {


    }
}

function CerrarMenu() {
    $('#menu1').removeClass('active');
    $('#submenu1').css("display", "none");
    $('#ico1').removeClass("fa fa-angle-down");
    $('#ico1').addClass("fa fa-angle-left");
}

function fncLnkAdmin() {
    VentanaPorte();
    $("#left-sidebar").css("background-color", "#304A54");
    $("#contenidoDinamico").html("");
    $.ajax({
        url: "protected/PaginasPrincipales/MenuSA.jsp",
        type: "GET",
        data: {},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#left-sidebar").html(datos);
            $("#contenidoDinamico").html("");
            $("#contenidoDinamico").html("<div class='main-header'><h2>Ejemplo</h2><em>Ejemplo.</p></br></div></div>");
        },
        error: function (error) {
            location.reload();
        }
    });
}


function convertirObjetoJson(idFrm) {

    var result = JSON.stringify($('#' + idFrm).serialize());
    var uscape = "";

    result = result.replace(/&/gi, '","');
    result = result.replace(/=/gi, '":"');
    result = result.replace(/\+/gi, '" "');

    result = '{'.concat(result);
    result = result.concat('}');

    uscape = unescape(result);
    result = uscape;

    var obj = JSON.parse(result);

    for (var propiedad in obj) {
        if (propiedad.substring(0, 3) == 'str') {
            obj[propiedad] = decodeURI(obj[propiedad]);
        }
        if (propiedad.substring(0, 3) == 'int') {
            obj[propiedad] = parseInt(obj[propiedad]);
        }
        if (propiedad.substring(0, 2) == 'dt') {
            obj[propiedad] = toSQLDate(obj[propiedad]);
        }
    }
    return JSON.stringify(obj);
}

//    Convertir la fecha a formato DateSQL 
function toSQLDate(fechaInput) {
    var fechaFormato = new Date(fechaInput + 'T12:00-0500');
    var fecha = fechaFormato.toDateString().substr(4, 11);
    fecha = fecha.replace('' + fechaFormato.getDate(), '' + (fechaFormato.getDate()) + ',');
    fecha = fecha.replace(fecha.substr(0, 3), traducirMes(fecha.substr(0, 3)));
    return fecha;
}

//    Traducir meses de Ingles a Español
function traducirMes(mes) {
    var traducido = '';
    switch (mes) {
        case 'Jan':
            traducido = 'ene';
            break;
        case 'Feb':
            traducido = 'feb';
            break;
        case 'Mar':
            traducido = 'mar';
            break;
        case 'Apr':
            traducido = 'abr';
            break;
        case 'May':
            traducido = 'may';
            break;
        case 'Jun':
            traducido = 'jun';
            break;
        case 'Jul':
            traducido = 'jul';
            break;
        case 'Aug':
            traducido = 'ago';
            break;
        case 'Sep':
            traducido = 'sep';
            break;
        case 'Oct':
            traducido = 'oct';
            break;
        case 'Nov':
            traducido = 'nov';
            break;
        case 'Dec':
            traducido = 'dic';
            break;
    }
    return traducido;
}

// Recoge un parametro de la URL segun su nombre 
// @name: Nombre del parametro a recoger 
function getURLParameter(name) {
    return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [, ""])[1].replace(/\+/g, '%20')) || null;
}

// Cambia un parametro de la URL 
// @param: Nombre del parametro a cambiar 
// @value: Valor nuevo asignado para el parametro 
function changeUrlParam(param, value) {
    var currentURL = window.location.href + '&';
    var change = new RegExp('(' + param + ')=(.*)&', 'g');
    var newURL = currentURL.replace(change, '$1=' + value + '&');

    if (getURLParameter(param) !== null) {
        try {
            window.history.replaceState('', '', newURL.slice(0, -1));
        } catch (e) {
            console.log(e);
        }
    } else {
        var currURL = window.location.href;
        if (currURL.indexOf("?") !== -1) {
            window.history.replaceState('', '', currentURL.slice(0, -1) + '&' + param + '=' + value);
        } else {
            window.history.replaceState('', '', currentURL.slice(0, -1) + '?' + param + '=' + value);
        }
    }
}

var validarCedula = function (idInput, idplay) {
    var cad = document.getElementById(idInput).value.trim();
    var total = 0;
    var longitud = cad.length;
    var longcheck = longitud - 1;

    if (cad !== "" && longitud === 10) {
        for (i = 0; i < longcheck; i++) {
            if (i % 2 === 0) {
                var aux = cad.charAt(i) * 2;
                if (aux > 9)
                    aux -= 9;
                total += aux;
            } else {
                total += parseInt(cad.charAt(i)); // parseInt o concatenará en lugar de sumar
            }
        }

        total = total % 10 ? 10 - total % 10 : 0;

        if (cad.charAt(longitud - 1) == total) {
            document.getElementById("salida").innerHTML = ("");
            $('#' + idplay).prop("disabled", false);
        } else {
            document.getElementById("salida").innerHTML = ("<p style='color:#FF0000';>Cedula Inválida</p>");
//            $('#'+idplay).attr("disabled","disabled");
        }
    }
};

var validarMatricula = function (idInput) {
    var cad = document.getElementById(idInput).value;
    $("#" + idInput).val(cad.toString().toUpperCase());
    cad = cad.toString().toUpperCase();
    var expPlaca = /^([A-Z]){3}\d{3,4}$/;

    if (expPlaca.test(cad)) {
        document.getElementById("salida").innerHTML = ("");
    } else {
        document.getElementById("salida").innerHTML = ("<p style='color:#FF0000';>Placa incorrecta</p>");
    }
};

var validarSoloNumeros = function (idInput, label) {
    var cad = document.getElementById(idInput).value;
    $("#" + idInput).val(cad.toString().toUpperCase());
    cad = cad.toString().toUpperCase();
    var expPlaca = /^([A-Z]){3}\d{3,4}$/;

    if (expPlaca.test(cad)) {
        document.getElementById(label).innerHTML = ("");
    } else {
        document.getElementById(label).innerHTML = ("<p style='color:#FF0000';>Placa incorrecta</p>");
    }
};

var swalTimer = function (titulo, mensaje, tipo) {
    swal({
        title: titulo,
        text: mensaje,
        type: tipo,
        timer: 3500
    });
};

var swalTimerLoading = function (titulo, mensaje, timer) {
    swal({
        title: titulo,
        text: mensaje,
        timer: timer,
        animation: true,
        onOpen: function () {
            swal.showLoading();
        }
    }).then(
            function () {},
            // handling the promise rejection
                    function (dismiss) {
                        if (dismiss === 'timer') {
                            console.log('El servidor no responde');
                        }
                    }
            );
        };

var swalNormal = function (titulo, mensaje, tipo) {
    swal({
        type: tipo,
        title: titulo,
        text: mensaje
    });
};

var swalConfirmNormal = function (titulo, mensaje, tipo, funcion) {
    swal({
        title: titulo,
        text: mensaje,
        type: tipo,
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI',
        cancelButtonText: 'NO'
    }).then((result) => {
        if (result.value) {
            if (funcion === "fncGenerarSOlcitud")
                fncGenerarSOlcitud();
        }
    });
};