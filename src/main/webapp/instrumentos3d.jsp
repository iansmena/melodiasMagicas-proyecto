<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Seguridad: Validar sesión
    Integer idPadre = (Integer) session.getAttribute("idUsuarioPadre");
    String nombreNino = (String) session.getAttribute("nombreHijoActivo");
    if (idPadre == null) {
        response.sendRedirect("index.jsp?error=sin_sesion");
        return;
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
    
    <style>
        /* Contenedor especial para el visor 3D */
        .visor-3d-contenedor {
            width: 100%;
            height: 400px;
            background-color: #f8fafc;
            border-radius: 20px;
            border: 3px dashed #48bb78;
            position: relative;
        }
        
        model-viewer {
            width: 100%;
            height: 100%;
            --poster-color: transparent;
        }
    </style>
</head>
<body>

    <div class="barra-accesibilidad">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('¡Estás en el Museo de Instrumentos Tres De! Usa tu ratón o tus dedos para girar la guitarra y verla por todos lados.')" class="boton-accesible btn-info text-white">
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
            <button class="boton-menu-infantil btn-limon" style="border: 3px solid #22543d;" onclick="window.location.href='instrumentos3d.jsp'">
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
            <div class="container bg-white p-4 rounded shadow-sm text-start" style="border-radius: 25px !important;">
                <h2 class="fw-bold text-success mb-3 text-center"><i class="bi bi-box"></i> El Museo 3D de <%= nombreNino %> 🧸</h2>
                <p class="text-muted text-center mb-4">Haz clic sostenido sobre el instrumento y muévelo para explorar su forma.</p>
                
                <div class="row g-4 align-items-center">
                    <div class="col-lg-7">
                        <div class="visor-3d-contenedor shadow-sm overflow-hidden mb-4">
                            <model-viewer 
                                src="3d/guitarra.glb" 
                                alt="Una guitarra acústica en 3D interactiva" 
                                auto-rotate 
                                camera-controls 
                                shadow-intensity="1">
                            </model-viewer>
                        </div>
                        
                        <div class="p-3 bg-light rounded shadow-sm" style="border: 2px solid #48bb78; border-radius: 15px !important;">
                            <label class="form-label fw-bold text-success d-block mb-2">
                                <i class="bi bi-volume-up-fill"></i> ¡Escucha cómo suena la guitarra!
                            </label>
                            
                            <audio controls class="w-100" style="min-height: 45px;">
                                <source src="mp3/guitarra_sonido.mp3" type="audio/mpeg">
                                Tu navegador no soporta la reproducción de audio interactivo.
                            </audio>
                            
                            <div class="form-text text-muted text-center mt-1">
                                Pulsa el botón de reproducir (▶) para escuchar su hermosa melodía.
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-5">
                        <div class="p-4 rounded" style="background-color: #f0fff4; border-left: 6px solid #38a169;">
                            <h4 class="fw-bold text-success mb-3">🎸 La Guitarra Acústica</h4>
                            <p class="fs-5 text-dark mb-3">
                                ¡Las guitarras son instrumentos mágicos que tienen <strong>6 cuerdas</strong>! 
                            </p>
                            <p class="fs-5 text-dark mb-4">
                                Al tocar sus cuerdas con tus dedos, el sonido viaja dentro de su cuerpo de madera y sale al aire con una melodía preciosa.
                            </p>
                            
                            <button onclick="reproducirVoz('Dato curioso: Las guitarras tienen seis cuerdas de diferentes grosores para hacer sonidos graves y agudos.')" class="btn btn-success w-100 btn-lg boton-accessible">
                                <i class="bi bi-ear-fill"></i> ¿Quieres escuchar un secreto?
                            </button>
                        </div>
                    </div>
                </div>
                
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
    </script>
</body>
</html>