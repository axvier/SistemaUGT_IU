/* global $scope, RiskHomePageService, $http, URL */

function Matar() {
    var Tipo = $("#Logeo").text();
    $.ajax({
        url: "../final.jsp",
        type: "POST",
        dataType: "text",
        data: {opcion: 'cerrar'},
        success: function (msg) {
            if (Tipo.length === 14) {
                //INSTITUCIONAL
                var urlLogout = "https://login.microsoftonline.com/common/oauth2/logout?post_logout_redirect_uri=";
                var urlQuery = "https://seguridad.espoch.edu.ec/cas/logout?service=https://localhost:8181/SistemaUGT_IU/index.jsp"; //Local
//                var urlQuery = "https://seguridad.espoch.edu.ec/cas/logout?service=https://contratacion.espoch.edu.ec/certificadosIU/index.jsp"; //Insitucional
                urlQuery = encodeURI(urlQuery);
                window.location.replace(urlLogout + urlQuery);
            }
            if (Tipo.length === 6) {
                //BD CENTRALIZADA
                var urlLogout = "https://seguridad.espoch.edu.ec/cas/logout?service=";
                var urlQuery = "https://localhost:8181/EjemploDticIU/index.jsp"; //Local
//                var urlQuery = "https://contratacion.espoch.edu.ec/certificadosIU/index.jsp"; //Institucional
                urlQuery = encodeURI(urlQuery);
                window.location.replace(urlLogout + urlQuery);
            }
        }
    });
}

function Matar2() {
    var Tipo = $("#Logeo").text();
    $.ajax({
        url: "../../final.jsp",
        type: "POST",
        dataType: "text",
        data: {opcion: 'cerrar'},
        success: function (msg) {
            if (Tipo.length === 14) {
                //INSTITUCIONAL
                var urlLogout = "https://login.microsoftonline.com/common/oauth2/logout?post_logout_redirect_uri=";
                var urlQuery = "https://seguridad.espoch.edu.ec/cas/logout?service=https://localhost:8181/SistemaUGT_IU/index.jsp"; //Local
//                var urlQuery = "https://seguridad.espoch.edu.ec/cas/logout?service=https://contratacion.espoch.edu.ec/certificadosIU/index.jsp"; //Insitucional
                urlQuery = encodeURI(urlQuery);
                window.location.replace(urlLogout + urlQuery);
            }
            if (Tipo.length === 6) {
                //BD CENTRALIZADA
                var urlLogout = "https://seguridad.espoch.edu.ec/cas/logout?service=";
                var urlQuery = "https://localhost:8181/EjemploDticIU/index.jsp"; //Local
//                var urlQuery = "https://contratacion.espoch.edu.ec/certificadosIU/index.jsp"; //Institucional
                urlQuery = encodeURI(urlQuery);
                window.location.replace(urlLogout + urlQuery);
            }
        }
    });
}


function soloLetras(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = " áéíóúabcdefghijklmnñopqrstuvwxyz";
    especiales = [8, 37, 39, 46];
    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
}

function NumerosLetras(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = " áéíóúabcdefghijklmnñopqrstuvwxyz1234567890";
    especiales = [8, 37, 39, 46];
    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
}

function soloCorreo(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "abcdefghijklmnopqrstuvwxyz@-_1234567890";
    especiales = [8, 37, 39, 46];
    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
}

function soloNumeros(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "1234567890";
    especiales = [8, 37, 39, 46];
    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
}

function omitirAcentos(text) {
    var acentos = "ÃÀÁÄÂÈÉËÊÌÍÏÎÒÓÖÔÙÚÜÛãàáäâèéëêìíïîòóöôùúüûÑñÇç";
    var original = "AAAAAEEEEIIIIOOOOUUUUaaaaaeeeeiiiioooouuuunncc";
    for (var i = 0; i < acentos.length; i++) {
        text = text.replace(new RegExp(acentos.charAt(i), 'g'), original.charAt(i));
    }
    return text;
}
