<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.melodiasmagicas.datos.Conexion" %>
<%@ page import="com.melodiasmagicas.datos.AdminDAO" %>
<%@ page import="java.sql.ResultSet" %>

<%
    // 1. SEGURIDAD: Validar sesión del administrador
    String correoAdmin = (String) session.getAttribute("correoUsuario");
    if (correoAdmin == null) {
        response.sendRedirect("index.jsp?error=sin_sesion");
        return;
    }

    // Instanciamos nuestro objeto de acceso a datos separado
    AdminDAO adminDao = new AdminDAO();
    String mensajeAccion = "";
    
    // 2. LÓGICA DE ACCIÓN: Detectar cambio de estado (Bloquear o Desbloquear)
    String idUserParam = request.getParameter("cambiarEstadoId");
    String nuevoEstadoParam = request.getParameter("nuevoEstado");
    
    if (idUserParam != null && nuevoEstadoParam != null) {
        int idUsuario = Integer.parseInt(idUserParam);
        boolean estadoObjetivo = Boolean.parseBoolean(nuevoEstadoParam);
        
        if (adminDao.cambiarEstadoUsuario(idUsuario, estadoObjetivo)) {
            if (estadoObjetivo) {
                mensajeAccion = "<div class='alert alert-success fw-bold text-center no-imprimir'>🔓 ¡Usuario desbloqueado y activado con éxito!</div>";
            } else {
                mensajeAccion = "<div class='alert alert-danger fw-bold text-center no-imprimir'>🔒 ¡Usuario bloqueado correctamente en la Base de Datos!</div>";
            }
        }
    }

    // 3. LÓGICA DE ACCIÓN: Vaciar Bitácora
    String accionVaciar = request.getParameter("vaciarBitacora");
    if (accionVaciar != null && accionVaciar.equals("confirmado")) {
        if (adminDao.vaciarBitacora()) {
            mensajeAccion = "<div class='alert alert-warning fw-bold text-center no-imprimir'>🗑️ ¡Bitácora de accesos limpiada y reiniciada con éxito!</div>";
        }
    }
    
    // Conexión auxiliar únicamente para renderizar las tablas mediante consultas directas
    Conexion conAux = new Conexion();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melodías Mágicas - Consola Admin</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/estilos.css">
    
</head>
<body style="background-color: #edf2f7;">

    <div class="barra-accesibilidad no-imprimir">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('Consola de administración activa. Gestión de usuarios y bitácoras.')" class="boton-accesible btn-info text-white">
            <i class="bi bi-volume-up-fill"></i> Escuchar Instrucciones
        </button>
    </div>

    <nav class="menu-principal shadow-sm bg-white mb-4 no-imprimir">
        <div class="fila-flexible container-fluid d-flex justify-content-between align-items-center py-2 px-4">
            <span class="texto-logotipo fs-4 fw-bold text-primary">
                <i class="bi bi-shield-lock-fill text-danger"></i> Consola del Administrador
            </span>
            <div>
                <span class="text-muted me-3">Admin: <strong><%= correoAdmin %></strong></span>
                <a href="index.jsp" class="btn btn-outline-danger fw-bold">Cerrar Sesión</a>
            </div>
        </div>
    </nav>

    <main class="container my-5">
        
        <%= mensajeAccion %>

        <div class="row g-4">
            
            <div class="col-lg-12 no-imprimir">
                <div class="p-4 bg-white rounded shadow-sm" style="border-radius: 20px !important;">
                    <h3 class="fw-bold text-primary mb-3"><i class="bi bi-people-fill text-success"></i> 1. Gestión de Cuentas de Usuarios</h3>
                    <p class="text-muted">Lista de cuentas en PostgreSQL. Puedes inhabilitar o restablecer accesos instantáneamente.</p>
                    
                    <div class="table-responsive">
                        <table class="table table-hover align-middle table-bordered text-center m-0">
                            <thead class="table-primary text-dark">
                                <tr>
                                    <th>ID Usuario</th>
                                    <th>Correo Electrónico</th>
                                    <th>Rol de Sistema</th>
                                    <th>Estado Actual</th>
                                    <th>Acción de Seguridad</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    ResultSet rsUsr = conAux.Consulta("SELECT usuario_id, usuario_correo, usuario_rol, usuario_estado_activo FROM public.usuarios ORDER BY usuario_id ASC");
                                    while (rsUsr != null && rsUsr.next()) {
                                        int idUser = rsUsr.getInt("usuario_id");
                                        String correoUser = rsUsr.getString("usuario_correo");
                                        int rolUser = rsUsr.getInt("usuario_rol");
                                        boolean estaActivo = rsUsr.getBoolean("usuario_estado_activo");
                                %>
                                        <tr>
                                            <td><strong><%= idUser %></strong></td>
                                            <td><code><%= correoUser %></code></td>
                                            <td><%= (rolUser == 1) ? "Administrador" : "Padre de Familia" %></td>
                                            <td>
                                                <% if (estaActivo) { %>
                                                    <span class="badge bg-success p-2"><i class="bi bi-check-circle"></i> Cuenta Activa</span>
                                                <% } else { %>
                                                    <span class="badge bg-danger p-2"><i class="bi bi-dash-circle"></i> Cuenta Bloqueada</span>
                                                <% } %>
                                            </td>
                                            <td>
                                                <% if (rolUser == 1) { %>
                                                    <span class="text-muted small fst-italic">Protegido (Admin)</span>
                                                <% } else { %>
                                                    <% if (estaActivo) { %>
                                                        <a href="admin.jsp?cambiarEstadoId=<%= idUser %>&nuevoEstado=false" 
                                                           class="btn btn-danger btn-sm fw-bold px-3"
                                                           onclick="return confirm('¿Seguro que deseas BLOQUEAR a <%= correoUser %>?');">
                                                            <i class="bi bi-lock-fill"></i> Bloquear
                                                        </a>
                                                    <% } else { %>
                                                        <a href="admin.jsp?cambiarEstadoId=<%= idUser %>&nuevoEstado=true" 
                                                           class="btn btn-success btn-sm fw-bold px-3"
                                                           onclick="return confirm('¿Seguro que deseas DESBLOQUEAR a <%= correoUser %>?');">
                                                            <i class="bi bi-unlock-fill"></i> Desbloquear
                                                        </a>
                                                    <% } %>
                                                <% } %>
                                            </td>
                                        </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-12 mt-4">
                <div class="p-4 bg-white rounded shadow-sm card-imprimible" style="border-radius: 20px !important;">
                    
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3 class="fw-bold text-primary m-0">
                            <i class="bi bi-journal-text text-warning no-imprimir"></i> Reporte Oficial: Bitácora de Accesos
                        </h3>
                        
                        <div class="no-imprimir">
                            <button onclick="window.print();" class="btn btn-primary fw-bold me-2">
                                <i class="bi bi-file-earmark-pdf-fill"></i> Imprimir Tabla / PDF
                            </button>
                            <a href="admin.jsp?vaciarBitacora=confirmado" class="btn btn-outline-danger fw-bold" 
                               onclick="return confirm('⚠️ ¿Estás seguro de borrar TODA la bitácora de PostgreSQL? Esta acción no se puede deshacer.');">
                                <i class="bi bi-trash3-fill"></i> Vaciar Bitácora (BD)
                            </a>
                        </div>
                    </div>
                    
                    <p class="text-muted">Historial de auditoría de ingresos del sistema Melodías Mágicas.</p>
                    
                    <div class="table-responsive">
                        <table class="table table-striped table-hover align-middle table-bordered text-center m-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID Registro</th>
                                    <th>Usuario que ingresó</th>
                                    <th>Fecha y Hora del Inicio de Sesión</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    String sqlBitacora = "SELECT b.bitacora_id, u.usuario_correo, b.bitacora_fecha_hora " +
                                                         "FROM public.bitacora_accesos b " +
                                                         "INNER JOIN public.usuarios u ON b.usuario_id = u.usuario_id " +
                                                         "ORDER BY b.bitacora_fecha_hora DESC";
                                    
                                    ResultSet rsBit = conAux.Consulta(sqlBitacora);
                                    boolean hayLogs = false;
                                    while (rsBit != null && rsBit.next()) {
                                        hayLogs = true;
                                        int idLog = rsBit.getInt("bitacora_id");
                                        String correoLog = rsBit.getString("usuario_correo");
                                        String fechaHoraLog = rsBit.getString("bitacora_fecha_hora");
                                %>
                                        <tr>
                                            <td><code>#<%= idLog %></code></td>
                                            <td><%= correoLog %></td>
                                            <td><%= fechaHoraLog %></td>
                                        </tr>
                                <%
                                    }
                                    if (!hayLogs) {
                                %>
                                        <tr>
                                            <td colspan="3" class="text-muted py-3">La bitácora de PostgreSQL está vacía.</td>
                                        </tr>
                                <%
                                    }
                                    
                                    // Cierre preventivo de cursores
                                    try {
                                        if (rsUsr != null) rsUsr.close();
                                        if (rsBit != null) rsBit.close();
                                        if (conAux.getConexion() != null) conAux.getConexion().close();
                                    } catch(Exception e){}
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <script>
        function cambiarContraste() {
            document.body.classList.toggle('modo-alto-contraste');
        }
        function reproducirVoz(mensaje) {
            if ('speechSynthesis' in window) {
                window.speechSynthesis.cancel();
                let lectura = new SpeechSynthesisUtterance(mensaje);
                lectura.lang = 'es-ES';
                window.speechSynthesis.speak(lectura);
            }
        }
    </script>
</body>
</html>