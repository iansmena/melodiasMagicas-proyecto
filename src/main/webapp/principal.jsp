<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.melodiasmagicas.negocio.Hijo" %>
<%@ page import="java.sql.ResultSet" %>

<%
    // Validar que el usuario esté logueado de verdad
    Integer idPadre = (Integer) session.getAttribute("idUsuarioPadre");
    if (idPadre == null) {
        response.sendRedirect("index.jsp?error=sin_sesion");
        return;
    }

    // 2. Capturar el ID del hijo seleccionado desde la URL
    String idHijoSeleccionado = request.getParameter("idHijo");
    
    // Variables para personalizar la interfaz del niño
    String nombreNino = "¡Pequeño Músico!";
    int instrumentoFavorito = 1;
    
    if (idHijoSeleccionado != null && !idHijoSeleccionado.isEmpty()) {
        int idHijoInt = Integer.parseInt(idHijoSeleccionado);
        
        Hijo buscador = new Hijo();
        ResultSet rs = buscador.listarHijosPorPadre(idPadre);
        
        while (rs != null && rs.next()) {
            if (rs.getInt("hijo_id") == idHijoInt) {
                nombreNino = rs.getString("hijo_nombre");
                instrumentoFavorito = rs.getInt("hijo_instrumento_favorito");
                
                session.setAttribute("idHijoActivo", idHijoInt);
                session.setAttribute("nombreHijoActivo", nombreNino);
                break;
            }
        }
    }
    
    String[] nombresInstrumentos = {"", "🎹 Piano Mágico", "🥁 Tambor Divertido", "🎵 Xilófono de Colores", "🪇 Maracas Rítmicas", "🎸 Guitarra Pequeña"};
    String instrumentoTexto = (instrumentoFavorito >= 1 && instrumentoFavorito <= 5) ? nombresInstrumentos[instrumentoFavorito] : nombresInstrumentos[1];
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melodías Mágicas - ¡A Jugar!</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

    <div class="barra-accesibilidad">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('¡Hola! Bienvenido a tu espacio musical. Elige una de las tres opciones del menú del lado izquierdo para empezar a divertirte.')" class="boton-accesible btn-info text-white">
            <i class="bi bi-volume-up-fill"></i> Escuchar Instrucciones
        </button>
    </div>

    <div class="contenedor-infantil">
        
        <aside class="menu-lateral-infantil">
            <h4 class="text-center fw-bold mb-4 text-muted">Menú Musical</h4>
            
            <button class="boton-menu-infantil btn-mora" onclick="reproducirVoz('¡Vamos al Karaoke Infantil!'); irACategoria('karaoke')">
                <i class="bi bi-music-player-fill fs-3"></i>
                <span>1. Karaoke Infantil</span>
            </button>
            
            <button class="boton-menu-infantil btn-limon" onclick="reproducirVoz('¡Vamos al Museo de Instrumentos Tres De!'); irACategoria('museo3d')">
                <i class="bi bi-box-fill fs-3"></i>
                <span>2. Instrumentos 3D</span>
            </button>
            
            <button class="boton-menu-infantil btn-sol" onclick="reproducirVoz('¡Vamos a la Realidad Aumentada!'); irACategoria('realidad_ar')">
                <i class="bi bi-camera-fill fs-3"></i>
                <span>3. Vive la Magia RA</span>
            </button>
            
            <hr class="my-4">
            
            <a href="perfiles.jsp" class="btn btn-outline-secondary w-100 boton-accessible d-flex align-items-center justify-content-center">
                <i class="bi bi-arrow-left-circle-fill me-2"></i> Cambiar Perfil
            </a>
        </aside>

        <main class="pantalla-contenido-principal d-flex align-items-center justify-content-center">
            <div id="zona-interactiva" class="p-5 bg-white rounded shadow-sm" style="max-width: 700px; border-radius: 25px !important;">
                
                <h1 class="display-4 fw-bold text-primary mb-3">¡Hola, <%= nombreNino %>! 👋</h1>
				<p class="fs-4 text-secondary mb-2">
				    ¡Qué alegría tenerte aquí! Tu instrumento favorito es el <strong class="text-success"><%= instrumentoTexto %></strong>.
				</p>
				<p class="fs-5 text-muted mb-4">
				    Prepárate para explorar un mundo lleno de sonidos, ritmo y magia.
				</p>
                
                <div class="my-5">
                    <i class="bi bi-music-note-beamed text-warning" style="font-size: 100px; animation: pulse 2s infinite;"></i>
                </div>
                
                <p class="lead text-muted">
                    Haz clic en cualquiera de los tres botones de la izquierda para descubrir instrumentos increíbles.
                </p>
                
            </div>
        </main>
        
    </div>

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
        
        function irACategoria(nombreCategoria) {
            if (nombreCategoria === 'karaoke') {
                window.location.href = "karaoke.jsp";
            } else if (nombreCategoria === 'museo3d') {
                window.location.href = "instrumentos3d.jsp";
            } else if (nombreCategoria === 'realidad_ar') {
                window.location.href = "realidadAR.jsp";
            }
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>