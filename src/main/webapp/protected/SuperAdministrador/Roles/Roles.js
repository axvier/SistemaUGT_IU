/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var addModalGRol = function (idmodal) {
    $('#' + idmodal + ' .modal-content').load('protected/SuperAdministrador/Roles/RolesControlador.jsp?opc=modalAddRol', function () {
        $('#' + idmodal).modal({show: true});
    });
};

var fncAddGRol = function (idForm, idmodal, idtabla) {
    var obj = objAddGRol(idForm);
    if (obj !== null) {
        var json = JSON.stringify(obj);
        $.ajax({
            url: "protected/SuperAdministrador/Roles/RolesControlador.jsp",
            type: "POST",
            dataType: "text",
            data: {opc: "saveRol", jsonRol: json},
            success: function (datos) {
                datos = JSON.parse(datos);
                if (datos.codigo === "OK") {
                    swalTimer("Rol ", "Estado: " + datos.codigo + " - " + datos.respuesta, "success");
                    $("#" + idtabla).jqGrid('setGridParam', {datatype: 'json'}).trigger('reloadGrid');
                    $("#" + idmodal).modal('hide');
                }
                if (datos.codigo === "KO") {
                    swalTimer("Rol error", "Estado: " + datos.codigo + " - " + datos.respuesta, "error");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error de ejecucion -> " + textStatus + jqXHR);
            }
        });
    }
};

var objAddGRol = function (idForm) {
    var tbroles = {
        charrol: $("#" + idForm + " #addCharRol").val(),
        descripcion: $("#" + idForm + " #addGRDescripcion").val(),
        estado: $("#" + idForm + " #addGREstado").val(),
        gerarquia: {
            descripcion: $("#" + idForm + " #addGRGerarquia").find(':selected').attr('data-descripcion'),
            idtipo: $("#" + idForm + " #addGRGerarquia").find(':selected').attr('data-tokens')
        },
        idrol: 0
    };
    return tbroles;
};


var addModalRolOpcion = function (idmodal, idtabla) {
    var $grid = $("#" + idtabla);
    var selRowId = $grid.jqGrid("getGridParam", "selrow");
    if (selRowId !== null) {
        $('#' + idmodal + ' .modal-content').load('protected/SuperAdministrador/Roles/RolesControlador.jsp?opc=modalAddGRolOpcion&idRol=' + selRowId, function () {
            $('#' + idmodal + " .modal-header .modal-title").html(" UGT | " + $grid.jqGrid('getRowData', selRowId).descripcion + " - Opciones ");
            $('#' + idmodal).modal({show: true});
        });
    } else
        swalTimer("Usuario", "Seleccione un usuario", "error");
};

var changeSelectRol = function (idSelectRol, idLoad) {
    var sel = $("#" + idSelectRol).find(':selected').attr('data-tokens');
    $('#' + idLoad).load('protected/SuperAdministrador/Roles/RolesControlador.jsp?opc=chksOpcionesRol&idRol=' + sel, function () {
    });
};

var fncAddGRol_Opcion = function (idForm) {
    var objRol = objAddGRol_O(idForm);
    var objOpciones = objAddGR_Opc(idForm);
    if (objRol !== null && objOpciones !== null) {
        $.ajax({
            url: "protected/SuperAdministrador/Roles/RolesControlador.jsp",
            type: "POST",
            dataType: "text",
            data: {opc: "saveRolOpciones", jsonRol: JSON.stringify(objRol), jsonOpciones: JSON.stringify(objOpciones)},
            success: function (datos) {
                datos = JSON.parse(datos);
                if (datos.codigo === "OK") {
                    swalTimer("Rol ", "Estado: " + datos.codigo + " - " + datos.respuesta, "success");
                }
                if (datos.codigo === "KO") {
                    swalTimer("Rol error", "Estado: " + datos.codigo + " - " + datos.respuesta, "error");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error de ejecucion -> " + textStatus + jqXHR);
            }
        });
    }

};

var objAddGRol_O = function (idForm) {
    var tbroles = JSON.parse($("#" + idForm + " #addGRol").find(':selected').attr('data-json'));
    return tbroles;
};

var objAddGR_Opc = function (idForm) {
    var lista = [];
    $('#' + idForm + ' #chksOpcionesRol input[type=checkbox]:checked').each(function () {
        var tbopciones = {
            accion:$(this).attr("data-accion"),
            descripcion:$(this).attr("data-descripcion"),
            estado:$(this).attr("data-estado"),
            idopcion:$(this).val()
        };
        lista.push(tbopciones);
    });
    return lista;
};

var fncDibujarTableGRoles = function (idtabla) {
    var $grid = $("#" + idtabla);
    var urlbase = "https://localhost:8181/SistemaUGT_IU/protected/SuperAdministrador/Roles";
    $grid.jqGrid({
        url: urlbase + "/RolesControlador.jsp?opc=jsonRoles",
        editurl: urlbase + "/RolesControlador.jsp",
        mtype: "POST",
        datatype: "json",
        colModel: [
            {label: 'ID', name: 'idrol', key: true, width: 70, editable: false},
            {label: 'Rol', name: 'charrol', width: 90, editable: true,
                editoptions: {size: 1, maxlength: 5}
            },
            {label: 'Descripción', name: 'descripcion', width: 130, editable: true},
            {label: 'Nivel', name: 'gerarquia', jsonmap: 'gerarquia.descripcion', width: 130,
                editable: true,
                edittype: 'select',
                editoptions: {
                    dataUrl: urlbase + "/RolesControlador.jsp?opc=selectTipoEntidad",
                    cacheUrlData: true,
                    buildSelect: function (response)
                    {
                        return response;
                    }
                }
            },
            {label: 'Estado', name: 'estado', width: 70, editable: true, search: false,
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
                    onSuccess: function (jqXHR) {
                        var datos = JSON.parse(jqXHR.responseText);
                        swalTimer("Roles", "Estado : " + datos.codigo + " - " + datos.respuesta, "info");
                        return true;
                    },
                    editOptions: {},
                    addOptions: {},
                    delOptions: {
                        height: 150,
                        width: 300,
                        serializeDelData: function (postdata) {
                            delete postdata.oper;
                            return {opc: "eliminarRol", idrol: postdata.id};
                        }
                    }
                }
            }
        ],
        rownumbers: true,
        viewrecords: true,
        width: 780,
        height: 250,
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

