<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // SECCIÓN DE SEGURIDAD Y CONTROL DE SESIÓN
    Integer idPadre = (Integer) session.getAttribute("idUsuarioPadre");
    String nombreNino = (String) session.getAttribute("nombreHijoActivo");
    if (idPadre == null) {
        response.sendRedirect("index.jsp?error=sin_sesion");
        return; // Detiene la ejecución del JSP de manera segura
    }

    // CAPTURA DEL PARÁMETRO DINÁMICO DESDE LA URL
    String idInstrumento = request.getParameter("idInstrumento");
    
    // Variables de control para renderizado condicional e instrucciones por voz
    String tituloInstrumento = "";
    String instruccionesVoz = "";
    String urlModel3D = "";
    String urlAudio = "";
    
    if (idInstrumento != null) {
        if (idInstrumento.equals("1")) {
            tituloInstrumento = "🎸 La Guitarra Acústica";
            instruccionesVoz = "¡Estás viendo la guitarra acústica en tres de! Usa tu ratón o tus dedos para girarla y presiona reproducir para escuchar cómo suena.";
            urlModel3D = "https://xpxcidh4nv94qxjy.public.blob.vercel-storage.com/3d/guitar.glb";
            urlAudio = "https://xpxcidh4nv94qxjy.public.blob.vercel-storage.com/mp3/guitar.mp3";
        }
    } else {
        instruccionesVoz = "¡Bienvenidos al Museo Virtual de Instrumentos! Elige un instrumento de la lista para explorar su magia en tres de.";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melodías Mágicas - Laboratorio 3D</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="css/estilos.css">
    
    <script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/3.4.0/model-viewer.min.js"></script>
</head>
<body>

    <div class="barra-accesibilidad">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning" aria-label="Alternar alto contraste">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('<%= instruccionesVoz %>')" class="boton-accesible btn-info text-white" aria-label="Escuchar instrucciones por voz">
            <i class="bi bi-volume-up-fill"></i> Escuchar Instrucciones
        </button>
    </div>

    <div class="contenedor-infantil">
        
        <aside class="menu-lateral-infantil">
            <h4 class="text-center fw-bold mb-4 text-muted">Menú Musical</h4>
            <button class="boton-menu-infantil btn-mora" onclick="window.location.href='karaoke.jsp'">
                <i class="bi bi-music-player-fill fs-3"></i>
                <span>1. Karaoke Infantil</span>
            </button>
            <button class="boton-menu-infantil btn-limon activo-laboratorio" onclick="window.location.href='instrumentos3d.jsp'">
                <i class="bi bi-box-fill fs-3"></i>
                <span>2. Instrumentos 3D</span>
            </button>
            <button class="boton-menu-infantil btn-sol" onclick="window.location.href='realidadAR.jsp'">
                <i class="bi bi-camera-fill fs-3"></i>
                <span>3. Vive la Magia RA</span>
            </button>
            <hr class="my-4">
            <a href="principal.jsp?idHijo=<%= session.getAttribute("idHijoActivo") %>" class="btn btn-outline-primary w-100 boton-accessible d-flex align-items-center justify-content-center">
                <i class="bi bi-house-door-fill me-2"></i> Inicio Infantil
            </a>
        </aside>

        <main class="pantalla-contenido-principal">
            
            <% if (idInstrumento == null) { %>
                <div class="tarjeta-blanca-infantil max-anchura-cancionero text-center">
                    <h2 class="fw-black text-success mb-3"><i class="bi bi-box-fill"></i> ¡El Laboratorio 3D de <%= nombreNino %>! 🧸</h2>
                    <p class="fs-5 text-muted mb-4">Elige un instrumento de la tabla para inspeccionarlo en tres dimensiones y escuchar su sonido real.</p>
                    
                    <div class="table-responsive mt-3">
                        <table class="table table-hover align-middle border-0 tabla-infantil-redondeada">
                            <thead class="cabecera-verde-infantil text-white">
                                <tr>
                                    <th scope="col" class="py-3 px-4 text-start" style="width: 20%;">Ícono</th>
                                    <th scope="col" class="py-3 px-4 text-start">Nombre del Instrumento</th>
                                    <th scope="col" class="py-3 px-4 text-center" style="width: 25%;">¡Explorar!</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="fila-interactiva-museo">
                                    <td class="py-3 px-4 text-start">
                                        <img src="https://xpxcidh4nv94qxjy.public.blob.vercel-storage.com/img/instruments/instruments1.png" 
                                             alt="Ícono de Guitarra" 
                                             class="icono-tabla-instrumento animate-pulse">
                                    </td>
                                    <td class="py-3 px-4 text-start fw-bold text-dark fs-5">Guitarra Acústica</td>
                                    <td class="py-3 px-4 text-center">
                                        <a href="instrumentos3d.jsp?idInstrumento=1" class="btn btn-success fw-bold px-4 rounded-3 text-white">
                                            <i class="bi bi-eye"></i> Ver en 3D
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            <% } else { %>
                <div class="tarjeta-blanca-infantil">
                    
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="fw-bold text-success m-0"><i class="bi bi-box"></i> El Museo 3D de <%= nombreNino %> 🧸</h2>
                        <a href="instrumentos3d.jsp" class="btn btn-outline-secondary rounded-pill fw-bold">
                            <i class="bi bi-arrow-left-short"></i> Volver a la Galería
                        </a>
                    </div>
                    
                    <div class="row g-4 align-items-center">
                        <div class="col-lg-7">
                            <div class="visor-3d-contenedor shadow-sm overflow-hidden mb-4">
                                <model-viewer 
                                    src="<%= urlModel3D %>" 
                                    alt="Instrumento musical interactivo en 3D" 
                                    auto-rotate 
                                    camera-controls 
                                    shadow-intensity="1">
                                </model-viewer>
                            </div>
                            
                            <div class="p-3 bg-light reproductor-audio-recuadro">
                                <label class="form-label fw-bold text-success d-block mb-2">
                                    <i class="bi bi-volume-up-fill"></i> ¡Escucha cómo suena!
                                </label>
                                <audio controls class="w-100" style="min-height: 45px;">
                                    <source src="<%= urlAudio %>" type="audio/mpeg">
                                    Tu navegador no soporta la reproducción de audio interactivo.
                                </audio>
                                <div class="form-text text-muted text-center mt-1">
                                    Pulsa el botón de reproducir (▶) para escuchar su hermosa melodía.
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-5">
                            <div class="p-4 rounded tarjeta-datos-curiosos">
                                <h4 class="fw-bold text-success mb-3"><%= tituloInstrumento %></h4>
                                
                                <% if (idInstrumento.equals("1")) { %>
                                    <p class="fs-5 text-dark mb-3">
                                        ¡Las guitarras son instrumentos mágicos que tienen <strong>6 cuerdas</strong>! 
                                    </p>
                                    <p class="fs-5 text-dark mb-4">
                                        Al tocar sus cuerdas con tus dedos, el sonido viaja dentro de su cuerpo de madera y sale al aire con una melodía preciosa.
                                    </p>
                                    <button onclick="reproducirVoz('Dato curioso: Las guitarras tienen seis cuerdas de diferentes grosores para hacer sonidos graves y agudos.')" class="btn btn-success w-100 btn-lg boton-accessible">
                                        <i class="bi bi-ear-fill"></i> ¿Quieres escuchar un secreto?
                                    </button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
            
        </main>
    </div>

    <script>
    // 1. FUNCIÓN INTERACTIVA DEL BOTÓN
    function cambiarContraste() {
        // Alternamos la clase en el body
        let activo = document.body.classList.toggle('modo-alto-contraste');
        
        // Guardamos de forma persistente el estado en el navegador del usuario
        if (activo) {
            localStorage.setItem('altoContraste', 'activado');
        } else {
            localStorage.setItem('altoContraste', 'desactivado');
        }
    }

    // 2. COMPROBACIÓN INMEDIATA AL CARGAR LA PÁGINA (Persistence Check)
    // Este evento se dispara automáticamente en cuanto el navegador termina de renderizar el HTML
    document.addEventListener("DOMContentLoaded", function() {
        // Leemos la pequeña base de datos del navegador
        let estadoContraste = localStorage.getItem('altoContraste');
        
        // Si el usuario ya lo había activado en otra página, lo encendemos de inmediato
        if (estadoContraste === 'activado') {
            document.body.classList.add('modo-alto-contraste');
        }
    });

    // 3. FUNCIÓN DE ACCESIBILIDAD POR VOZ (Mantenemos tu lógica existente)
    function reproducirVoz(mensaje) {
        if ('speechSynthesis' in window) {
            window.speechSynthesis.cancel();
            let lectura = new SpeechSynthesisUtterance(mensaje);
            lectura.lang = 'es-ES';
            window.speechSynthesis.speak(lectura);
        }
    }
</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>