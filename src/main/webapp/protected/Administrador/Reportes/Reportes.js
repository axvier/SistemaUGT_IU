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
            console.log(datos);
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


