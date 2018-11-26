/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var fncAddGUsuario = function (idForm) {
    var obj = objAddGUser(idForm);
    if (obj !== null) {
        var json = JSON.stringify(obj);
        $.ajax({
            url: "protected/SuperAdministrador/Usuarios/UsuariosControlador.jsp",
            type: "POST",
            dataType: "text",
            data: {opc: "saveUser", jsonUser: json},
            success: function (datos) {
                datos = JSON.parse(datos);
                if (datos.codigo === "OK") {
                    swalTimer("Usuario estado", datos.respuesta, "success");
                    $("#tbUsuariosG").jqGrid('setGridParam', {datatype: 'json'}).trigger('reloadGrid');
                    $("#modGeneralUsuarios").modal('hide');
                }
                if (datos.codigo === "KO") {
                    swalTimer("Usuario estado", datos.respuesta, "error");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error de ejecucion -> " + textStatus + jqXHR);
            }

        });
    }
};

var objAddGUser = function (idForm) {
    var user = {
        apellidos: $("#" + idForm + " #addGApellidos").val(),
        cedula: $("#" + idForm + " #addGCedula").val(),
        email: $("#" + idForm + " #addGEmail").val(),
        estado: $("#" + idForm + " #addGEstado").val(),
        nombres: $("#" + idForm + " #addGNombres").val(),
        tipousuario: $("#" + idForm + " #addGTipo").val()
    };

    return user;
};

var addModalUsuario = function (idmodal) {
    $('#' + idmodal + ' .modal-content').load('protected/SuperAdministrador/Usuarios/UsuariosControlador.jsp?opc=mostrar&accion=modalAddGUsuario', function () {
        $('#' + idmodal).modal({show: true});
    });
};

var fncRecargatTGUsuarios = function (idtabla) {
    var $grid = $("#" + idtabla);
    $(window).on("resize", function () {
        var grid = $grid, newWidth = $grid.closest(".ui-jqgrid").parent().width();
        grid.jqGrid("setGridWidth", newWidth, true);
    }).trigger('resize');
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/SuperAdministrador/Usuarios";
    $grid.jqGrid('clearGridData');
    $grid.jqGrid('setGridParam', {url: urlbase + "/UsuariosControlador.jsp?opc=jsonUsuarios", datatype: "json"}).trigger("reloadGrid");
};

var fncDibujarTableGUsuarios = function (idtabla) {
    var $grid = $("#" + idtabla);
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/SuperAdministrador/Usuarios";
    $grid.jqGrid({
        url: urlbase + "/UsuariosControlador.jsp?opc=jsonUsuarios",
        editurl: urlbase + "/UsuariosControlador.jsp",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'Cedula', name: 'cedula', key: true, width: 70, editable: false},
            {label: 'Email', name: 'email', width: 150, editable: true},
            {label: 'Nombres', name: 'nombres', width: 120, editable: true},
            {label: 'Apellidos', name: 'apellidos', width: 120},
            {label: 'Tipo', name: 'tipousuario', width: 70, editable: true,
                edittype: 'select',
                editoptions: {
                    value: 'OASIS:OASIS;Instituto:Instituto'
                }
            },
            {label: 'Estado', name: 'estado', width: 70, editable: true,
                edittype: 'select',
                editoptions: {
                    value: 'Habilitado:Habilitado;Deshabilitado:Deshabilitado'
                }
            },
            {
                label: "Opciones",
                name: "actions",
                sortable: false,
                search: false,
                width: 100,
                formatter: "actions",
                formatoptions: {
                    keys: true,
                    editOptions: {},
                    addOptions: {},
                    delOptions: {
                        height: 150,
                        width: 300,
                        serializeDelData: function (postdata) {
                            var rowData = $grid.jqGrid('getRowData', postdata.id);
                            delete rowData.actions;
                            console.log(JSON.stringify(rowData));
                            return {opc: "eliminarUsuario", cedula: postdata.id, jsonUser: JSON.stringify(rowData)};
                        }
                    }
                }
            }
        ],
        rownumbers: true,
        viewrecords: true,
        width: 780,
        height: 250,
        loadtext: '<center><i class="fa fa-spinner fa-pulse fa-3x fa-fw"></i><span class="sr-only">Cargando...</span></center>',
        rowNum: 10,
        loadonce: true,
        pager: "#" + idtabla + "_pager",
        serializeRowData: function (postdata) {
            delete postdata.oper;
            console.log(JSON.stringify(postdata));
            return {opc: "modificarUser", jsonUser: JSON.stringify(postdata), cedula: postdata.cedula};
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

