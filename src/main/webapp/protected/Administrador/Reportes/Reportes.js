/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var fncDibujarGraficosConductores = function (idplaceholder) {
    $.ajax({
        url: "protected/Administrador/Reportes/ReportesControlador.jsp",
        type: "GET",
        data: {opc: "conductoresChartEstado"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            var ctx = document.getElementById("myChart");
            var myChart = new Chart(ctx, {
                type: 'horizontalBar',
                data: {
                    labels: ["Disponibles", "Fijados", "Indispuestos", "Jubilados"],
                    datasets: [{
                            label: 'Numero de conductores',
                            data: [datos.disponibles, datos.ocupados, datos.indispuestos, datos.jubilados],
                            backgroundColor: [
                                '#66B704',
                                '#4380C5',
                                '#FBF70D',
                                '#DE100A'
                            ],
                            borderColor: [
                                '#4FE60B',
                                '#0B95E6',
                                '#FBF70D',
                                '#FB2D0D'
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    legend: {display: false},
                    title: {
                        display: true,
                        text: 'Total estados de los conductores'
                    },
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                }
            });
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncDibujarGraficosConductoresGenero = function () {
    $.ajax({
        url: "protected/Administrador/Reportes/ReportesControlador.jsp",
        type: "GET",
        data: {opc: "conductoresChartGenero"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            var ctx = document.getElementById("myChart");
            var myChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ["Femenino", "Masculino", "Otros"],
                    datasets: [
                        {
                            label: "Numero de conductores ",
                            backgroundColor: ["#FB5DD7", "#4380C5", "#5DB9FB"],
                            data: [datos.femenino, datos.masculino, datos.otros]
                        }
                    ]
                },
                options: {
                    legend: {display: false},
                    title: {
                        display: true,
                        text: 'Total generos conductores'
                    }
                }
            });
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncReporteConductoresGenero = function () {
    $("#contenidoDinamico").html("<center><i class='fa fa-spinner fa-pulse fa-4x fa-fw'></i><span class='sr-only'>Cargando...</span></center>");
    $.ajax({
        url: "protected/Administrador/Reportes/ReportesControlador.jsp",
        type: "GET",
        data: {opc: "conductoresReporteGenero"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            $("#contenidoDinamico").html(datos);
            fncDibujarGraficosConductoresGenero();//iniciar grafico
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncDibujarGraficosVehiculosEstado = function () {
    $.ajax({
        url: "protected/Administrador/Reportes/ReportesControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "vehiculosChartEstadosesion"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            datos = fncParseElementosToChartJS(datos);
            console.log(JSON.stringify(datos));
            var ctx = document.getElementById("myChart");
            var myChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: datos.labels,
                    datasets: [{
                            label: datos.datasets[0].label,
                            data: datos.datasets[0].data,
                            backgroundColor: datos.datasets[0].backgroundColor,
                            borderWidth: 1
                        }]
                },
                options: {
                    legend: {display: datos.leyenda},
                    title: {
                        display: true,
                        text: datos.titulo
                    },
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                }
            });
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncParseElementosToChartJS = function (datos) {
    var data = {};
    if (datos[0]) {
        var valores = [];
        var colores = [];
        var bordes = [];
        var labels = [];
        for (var j = 0; j < datos[0].data.length; j++) {
            if (datos[0].data[j]) {
                valores.push(datos[0].data[j].data);
                labels.push(datos[0].data[j].label);
                colores.push(datos[0].data[j].background);
                bordes.push(datos[0].data[j].borderColor);
            }
        }
        var config = [];
        config.push({
            label: "Cantidad",
            backgroundColor: colores,
            borderColor: bordes,
            data: valores,
            borderWidth: 1
        });
        data.labels = labels;
        data.datasets = config;
        data.leyenda = datos[0].leyenda;
        data.titulo = datos[0].titulo;
    }
    return data;
};

var fncDibujarGraficosSolicitudEstado = function () {
    $.ajax({
        url: "protected/Administrador/Reportes/ReportesControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "vehiculosChartEstadosesion"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            datos = fncParseElementosToChartJS(datos);
            console.log(JSON.stringify(datos));
            var ctx = document.getElementById("myChart");
            var myChart = new Chart(ctx, {
                type: 'horizontalBar',
                data: {
                    labels: datos.labels,
                    datasets: [{
                            label: datos.datasets[0].label,
                            data: datos.datasets[0].data,
                            backgroundColor: datos.datasets[0].backgroundColor,
                            borderWidth: 1
                        }]
                },
                options: {
                    legend: {display: datos.leyenda},
                    title: {
                        display: true,
                        text: datos.titulo
                    },
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                }
            });
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fncDibujarGraficosOrdenesEstado = function () {
    $.ajax({
        url: "protected/Administrador/Reportes/ReportesControlador.jsp",
        type: "GET",
        data: {opc: "mostrar", accion: "respuestaJSON"},
        contentType: "application/json ; charset=UTF-8",
        success: function (datos) {
            datos = fncParseElementosToChartJS(datos);
            console.log(JSON.stringify(datos));
            var ctx = document.getElementById("myChart");
            var myChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: datos.labels,
                    datasets: [{
                            label: datos.datasets[0].label,
                            data: datos.datasets[0].data,
                            backgroundColor: datos.datasets[0].backgroundColor,
                            borderWidth: 1
                        }]
                },
                options: {
                    legend: {display: datos.leyenda},
                    title: {
                        display: true,
                        text: datos.titulo
                    },
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                }
            });
        },
        error: function (error) {
            location.reload();
        }
    });
};

var fcModalInformeViajes = function (idmodal) {
    $('#' + idmodal + ' .modal-content').load('protected/Administrador/Reportes/ReportesControlador.jsp?opc=mostrar&accion=modalInformeViajes', function () {
        $('#' + idmodal).modal({show: true, backdrop: 'static', keyboard: false});
        $('#' + idmodal + ' .modal-content .form-horizontal').prop("action","InformeOrdenesPDF");
    });
};
