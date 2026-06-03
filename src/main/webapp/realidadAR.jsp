<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // CONTROL DE SESIÓN ACADÉMICO: Validamos que exista un usuario y un hijo activo
    Integer idPadre = (Integer) session.getAttribute("idUsuarioPadre");
    String nombreNino = (String) session.getAttribute("nombreHijoActivo");
    if (idPadre == null) {
        response.sendRedirect("index.jsp?error=sin_sesion");
        return;
    }
    if (nombreNino == null) {
        nombreNino = "Pequeño Músico";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melodías Mágicas - Escenario 3D Real</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/estilos.css">
    <link rel="stylesheet" href="css/estilos.css">
    <script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/3.4.0/model-viewer.min.js"></script>
    
    <style>
        
    </style>
</head>
<body>

    <!-- Barra de Accesibilidad Superior -->
    <div class="barra-accesibilidad">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('¡Explora el plano real de la orquesta! Toca los círculos de colores que flotan en el escenario para descubrir dónde se sientan los músicos.')" class="boton-accesible btn-info text-white">
            <i class="bi bi-volume-up-fill"></i> Escuchar Instrucciones
        </button>
    </div>

    <div class="contenedor-infantil">
        
        <!-- Menú Lateral Reutilizado -->
        <aside class="menu-lateral-infantil">
            <h4 class="text-center fw-bold mb-4 text-muted">Menú Musical</h4>
            <button class="boton-menu-infantil btn-mora" onclick="window.location.href='karaoke.jsp'">
                <i class="bi bi-music-player-fill fs-3"></i>
                <span>1. Karaoke Infantil</span>
            </button>
            <button class="boton-menu-infantil btn-limon" onclick="window.location.href='instrumentos3d.jsp'">
                <i class="bi bi-box-fill fs-3"></i>
                <span>2. Instrumentos 3D</span>
            </button>
            <button class="boton-menu-infantil btn-sol" style="border: 3px solid #744210;" onclick="window.location.href='realidadAR.jsp'">
                <i class="bi bi-layers-half fs-3"></i>
                <span>3. Plano Orquesta</span>
            </button>
            <hr class="my-4">
            <a href="principal.jsp?idHijo=<%= session.getAttribute("idHijoActive") != null ? session.getAttribute("idHijoActive") : "1" %>" class="btn btn-outline-primary w-100 boton-accessible d-flex align-items-center justify-content-center">
                <i class="bi bi-house-door-fill me-2"></i> Inicio Infantil
            </a>
        </aside>

        <!-- Contenido Central: El Escenario Real Interactuable -->
        <main class="pantalla-contenido-principal">
            <div class="container bg-white p-4 rounded shadow-sm text-start" style="border-radius: 25px !important;">
                <h2 class="fw-bold text-dark mb-2 text-center"><i class="bi bi-music-note-beamed text-warning"></i> El Escenario Real de <%= nombreNino %> 🎼</h2>
                <p class="text-muted text-center mb-4">Usa tu ratón para girar el teatro y haz clic en los números flotantes para explorar el plano.</p>
                
                <!-- RENDERIZADO DEL MODELO LOCAL GLB -->
                <div class="escenario-macro-3d shadow">
                    
                    <!-- REQUERIMIENTO SENIOR: Invocación del archivo local de la carpeta webapp -->
                    <model-viewer 
                        src="https://xpxcidh4nv94qxjy.public.blob.vercel-storage.com/RA.glb" 
                        alt="Plano detallado tridimensional de un escenario de orquesta" 
                        camera-controls 
                        auto-rotate 
                        shadow-intensity="1"
                        camera-orbit="0deg 75deg 105%"
                        min-camera-orbit="auto auto 20%"
                        max-camera-orbit="auto auto 200%"
                        interaction-prompt="auto">
                        
                        <!-- HOTSPOT 1: Sección Frontal (Cuerdas) -->
                        <button class="punto-interactivo" 
                                slot="hotspot-cuerdas" 
                                data-position="-0.2m 0.1m 0.3m" 
                                data-normal="0m 1m 0m" 
                                onclick="reproducirVoz('¡Sección de cuerdas al frente! Aquí se ubican los violines y las guitarras, justo en la entrada del escenario cerca del público.')">
                            1
                        </button>
                        
                        <!-- HOTSPOT 2: Sección Intermedia (Vientos) -->
                        <button class="punto-interactivo punto-vientos" 
                                slot="hotspot-vientos" 
                                data-position="0.4m 0.1m 0.0m" 
                                data-normal="0m 1m 0m" 
                                onclick="reproducirVoz('¡Sección de vientos! En la zona media del plano encontramos las flautas, trompetas y clarinetes.')">
                            2
                        </button>
                        
                        <!-- HOTSPOT 3: Sección Posterior (Percusión) -->
                        <button class="punto-interactivo punto-percusion" 
                                slot="hotspot-percusion" 
                                data-position="0.0m 0.2m -0.5m" 
                                data-normal="0m 1m 0m" 
                                onclick="reproducirVoz('¡Sección de percusión al fondo! En la parte más alta y trasera del escenario se acomodan los tambores y platillos.')">
                            3
                        </button>
                        
                    </model-viewer>
                    
                </div>
                
                <!-- Caja de Texto Informativo Dinámico -->
                <div id="info-pantalla-infantil" class="mt-4 p-3 bg-light rounded text-center fw-bold text-secondary fs-5" style="border-radius: 15px !important;">
                    📌 ¡Toca un número en el escenario para escuchar su secreto!
                </div>
                
            </div>
        </main>
        
    </div>

    <!-- Scripts de Accesibilidad e Interacción Lógica -->
    <script>
        function cambiarContraste() {
            document.body.classList.toggle('modo-alto-contraste');
        }

        function reproducirVoz(mensaje) {
            // Actualizamos la caja de texto visual para los niños que no pueden oír
            document.getElementById("info-pantalla-infantil").innerHTML = "📢 " + mensaje;
            
            // Web Speech API para síntesis de voz interactiva
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