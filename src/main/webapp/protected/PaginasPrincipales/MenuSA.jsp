<!--Querido colega programador: 
Cuando escribí este código, solo Dios y yo sabíamos cómo funcionaba.
Ahora solo dios lo sabe!!

Así que si estas tratando de ‘OPTIMIZAR’ esta rutina 
y fracasas (seguramente), por favor, incrementa 
el siguiente contador como una advertencia para el siguiente colega:

Total_horas_perdidas_aqui = 0-->

<link href="assets/css/skins/fulldark.css" rel="stylesheet" type="text/css"/>
<script src="assets/js/jquery/jquery-2.1.0.min.js"></script>
<script src="assets/js/king-common.js"></script>

<%@page contentType='text/html' pageEncoding='UTF-8'%>
<div class="sidebar-minified js-toggle-minified">
    <i class="fa fa-exchange"></i>

</div>
<div class="sidebar-scroll">
    <nav class="main-nav">
        <ul class="main-menu">
            <li id="menu1"><a href="#" class="js-sub-menu-toggle"><i class="fa fa-clipboard fa-fw"></i><span class="text">Usuarios</span>
                    <i id="ico1" class="toggle-icon fa fa-angle-left"></i></a>
                <ul id="submenu1" class="sub-menu ">
                    
                    <li style='cursor: pointer'>
                        <a onclick="clickTipoUsuario();">
                            <i class="fa fa-list-ol"></i><span class="text">Tipo de usuario</span>
                        </a>
                    </li>
                    <li style='cursor: pointer'>
                        <a onclick="clickPersona();">
                            <i class="fa fa-filter"></i><span class="text">Usuario</span>
                        </a>
                    </li>
                    <li style='cursor: pointer'>
                        <a onclick="clickRolPersona();">
                            <i class="fa fa-filter"></i><span class="text">Rol a usuario</span>
                        </a>
                    </li>
                </ul>
            </li>
            
            <li id="menu1"><a href="#" class="js-sub-menu-toggle"><i class="fa fa-clipboard fa-fw"></i><span class="text">Flujo</span>
                    <i id="ico1" class="toggle-icon fa fa-angle-left"></i></a>
                <ul id="submenu1" class="sub-menu ">
                    <li style='cursor: pointer'>
                        <a onclick="clickTipoFlujo()">
                            <i class="fa fa-list-ol"></i><span class="text">Tipo de flujo</span>
                        </a>
                    </li>
                    <li style='cursor: pointer'>
                        <a onclick="clickFlujo()">
                            <i class="fa fa-filter"></i><span class="text">Flujo</span>
                        </a>
                    </li>
                </ul>
            </li>

            <li style='cursor: pointer'>
                <a onclick="clickTipoDepartamento()">
                    <i class="fa fa-certificate"></i><span class="text">Tipo departamento</span>
                </a>
            </li>
            <li style='cursor: pointer'>
                <a onclick="">
                    <i class="fa fa-line-chart"></i><span class="text">Departamento</span>
                </a>
            </li>
            
        </ul>
    </nav>
</div>
