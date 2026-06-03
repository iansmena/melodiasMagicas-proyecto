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
    <title>Melodías Mágicas - Karaoke Infantil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

    <div class="barra-accesibilidad">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('¡Estás en el Karaoke Infantil! Escucha la música y canta la canción de los pollitos dicen.')" class="boton-accesible btn-info text-white">
            <i class="bi bi-volume-up-fill"></i> Escuchar Instrucciones
        </button>
    </div>

    <div class="contenedor-infantil">
        
        <aside class="menu-lateral-infantil">
            <h4 class="text-center fw-bold mb-4 text-muted">Menú Musical</h4>
            <button class="boton-menu-infantil btn-mora" style="border: 3px solid #553c9a;" onclick="window.location.href='karaoke.jsp'">
                <i class="bi bi-music-player-fill fs-3"></i>
                <span>1. Karaoke Infantil</span>
            </button>
            <button class="boton-menu-infantil btn-limon" onclick="window.location.href='instrumentos3d.jsp'">
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
                <h2 class="fw-bold text-danger mb-4 text-center"><i class="bi bi-music-player"></i> El Karaoke de <%= nombreNino %> 🎤</h2>
                
                <div class="row g-4">
                    <div class="col-lg-7">
                        <div class="ratio ratio-16x9 shadow-sm rounded overflow-hidden">
                            <iframe width="560" height="315" src="https://www.youtube.com/embed/XqUwK46IBSk?si=UjOyICXyYYXR9_2F" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                        </div>
                    </div>
                    
                    <div class="col-lg-5">
                        <div class="p-3 bg-light rounded text-center overflow-auto" style="max-height: 350px; border: 2px dashed #fc8181;">
                            <h4 class="fw-bold text-dark mb-3">Los Pollitos Dicen</h4>
                            <p class="fs-5 mb-2 fw-bold text-secondary">Los pollitos dicen</p>
                            <p class="fs-5 mb-2 fw-bold text-secondary">pío, pío, pío</p>
                            <p class="fs-5 mb-2 fw-bold text-secondary">cuando tienen hambre</p>
                            <p class="fs-5 mb-4 fw-bold text-secondary">cuando tienen frío.</p>
                            
                            <p class="fs-5 mb-2 fw-bold text-secondary">La gallina busca</p>
                            <p class="fs-5 mb-2 fw-bold text-secondary">el maíz y el trigo</p>
                            <p class="fs-5 mb-2 fw-bold text-secondary">les da la comida</p>
                            <p class="fs-5 mb-4 fw-bold text-secondary">y les presta abrigo.</p>
                            
                            <p class="fs-5 mb-2 fw-bold text-secondary">Bajo sus dos alas</p>
                            <p class="fs-5 mb-2 fw-bold text-secondary">acurrucaditos</p>
                            <p class="fs-5 mb-2 fw-bold text-secondary">duermen los pollitos</p>
                            <p class="fs-5 mb-4 fw-bold text-secondary">hasta el otro día.</p>
                            
                            <p class="fs-5 mb-2 fw-bold text-secondary">Cuando se despiertan</p>
                            <p class="fs-5 mb-2 fw-bold text-secondary">dicen mamacita</p>
                            <p class="fs-5 mb-2 fw-bold text-secondary">tengo mucha hambre</p>
                            <p class="fs-5 mb-4 fw-bold text-secondary">dame lombricitas.</p>
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