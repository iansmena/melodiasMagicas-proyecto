<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // SECCIÓN DE SEGURIDAD Y CONTROL DE SESIÓN
    // Validamos que exista una sesión activa del Padre antes de permitir la interacción del niño.
    Integer idPadre = (Integer) session.getAttribute("idUsuarioPadre");
    String nombreNino = (String) session.getAttribute("nombreHijoActivo");
    
    if (idPadre == null) {
        response.sendRedirect("index.jsp?error=sin_sesion");
        return; // Detiene la ejecución de la página inmediatamente
    }

    // CAPTURA DE PARÁMETROS DE LA PETICIÓN
    // Leemos el parámetro 'idCancion' enviado por el método GET a través de la URL
    String idCancion = request.getParameter("idCancion");
    
    // Variables de control para la personalización de la interfaz
    String tituloCancion = "";
    String instruccionesVoz = "";
    
    if (idCancion != null) {
        if (idCancion.equals("1")) {
            tituloCancion = "Los Pollitos Dicen Pío Pío Pío";
            instruccionesVoz = "¡A cantar Los Pollitos Dicen!";
        } else if (idCancion.equals("2")) {
            tituloCancion = "La Vaca Lola";
            instruccionesVoz = "¡A cantar La Vaca Lola!";
        } else if (idCancion.equals("3")) {
            tituloCancion = "La Gallina Turuleca";
            instruccionesVoz = "¡A cantar La Gallina Turuleca!";
        }
    } else {
        instruccionesVoz = "¡Bienvenidos al Cancionero Infantil! Selecciona una canción de la tabla para empezar a cantar.";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melodías Mágicas - Karaoke Infantil</title>
    <!-- Framework de Estilos -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

    <!-- BARRA DE ACCESIBILIDAD SUPERIOR -->
    <div class="barra-accesibilidad">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning" aria-label="Cambiar contraste visual">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('<%= instruccionesVoz %>')" class="boton-accesible btn-info text-white" aria-label="Escuchar instrucciones por altavoz">
            <i class="bi bi-volume-up-fill"></i> Escuchar Instrucción
        </button>
    </div>

    <!-- CONTENEDOR PRINCIPAL FLUIDO (Layout de Dos Columnas: Menú + Contenido) -->
    <div class="contenedor-infantil">
        
        <!-- MENÚ LATERAL DE NAVEGACIÓN -->
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
            
            <!-- Retorno dinámico inyectando el ID del hijo activo en la sesión -->
            <a href="principal.jsp?idHijo=<%= session.getAttribute("idHijoActivo") %>" class="btn btn-outline-primary w-100 boton-accessible d-flex align-items-center justify-content-center">
                <i class="bi bi-house-door-fill me-2"></i> Inicio Infantil
            </a>
        </aside>

        <!-- PANTALLA DE CONTENIDO DINÁMICO -->
        <main class="pantalla-contenido-principal">
            
            <% if (idCancion == null) { %>
                <!-- ========================================================== -->
                <!-- ESTADO 1: CANCIONERO GENERAL EN FORMATO DE TABLA           -->
                <!-- ========================================================== -->
                <div class="container bg-white p-5 rounded shadow-sm text-center" style="border-radius: 25px !important; max-width: 850px;">
                    <h2 class="fw-black text-primary mb-3" style="font-weight: 800;"><i class="bi bi-music-note-list"></i> ¡Tu Cancionero Mágico, <%= nombreNino %>! 🎤</h2>
                    <p class="fs-5 text-muted mb-4">Elige una hermosa canción de la lista para abrir tu reproductor de Karaoke.</p>
                    
                    <div class="table-responsive mt-2">
                        <table class="table table-hover align-middle border-0">
                            <thead class="table-primary text-white">
                                <tr>
                                    <th scope="col" class="py-3 px-4 text-start" style="border-top-left-radius: 15px; background-color: #7000ff !important;">#</th>
                                    <th scope="col" class="py-3 px-4 text-start" style="background-color: #7000ff !important;">Título de la Canción</th>
                                    <th scope="col" class="py-3 px-4 text-center" style="border-top-right-radius: 15px; background-color: #7000ff !important; width: 25%;">¡Cantar!</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="py-4 px-4 text-start fw-bold text-secondary fs-5">1</td>
                                    <td class="py-4 px-4 text-start fw-bold text-dark fs-5">Los Pollitos dicen Pío Pío Pío</td>
                                    <td class="py-4 px-4 text-center">
                                        <a href="karaoke.jsp?idCancion=1" class="btn btn-mora fw-bold px-4 rounded-3 text-white">
                                            <i class="bi bi-play-fill"></i> Abrir
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="py-4 px-4 text-start fw-bold text-secondary fs-5">2</td>
                                    <td class="py-4 px-4 text-start fw-bold text-dark fs-5">La Vaca Lola</td>
                                    <td class="py-4 px-4 text-center">
                                        <a href="karaoke.jsp?idCancion=2" class="btn btn-mora fw-bold px-4 rounded-3 text-white">
                                            <i class="bi bi-play-fill"></i> Abrir
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="py-4 px-4 text-start fw-bold text-secondary fs-5">3</td>
                                    <td class="py-4 px-4 text-start fw-bold text-dark fs-5">La Gallina Turuleca</td>
                                    <td class="py-4 px-4 text-center">
                                        <a href="karaoke.jsp?idCancion=3" class="btn btn-mora fw-bold px-4 rounded-3 text-white">
                                            <i class="bi bi-play-fill"></i> Abrir
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            <% } else { %>
                <!-- ========================================================== -->
                <!-- ESTADO 2: REPRODUCTOR DE VIDEO + LETRAS DE CANCIÓN ACTIVA   -->
                <!-- ========================================================== -->
                <div class="container bg-white p-4 rounded shadow-sm text-start" style="border-radius: 25px !important;">
                    
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="fw-bold text-danger m-0"><i class="bi bi-music-player-fill"></i> El Karaoke de <%= nombreNino %> 🎤</h2>
                        <a href="karaoke.jsp" class="btn btn-outline-secondary rounded-pill fw-bold">
                            <i class="bi bi-arrow-left-short"></i> Volver al Cancionero
                        </a>
                    </div>
                    
                    <div class="row g-4">
                        <!-- Columna Izquierda: Video Embebido de YouTube -->
                        <div class="col-lg-7">
                            <div class="ratio ratio-16x9 shadow-sm rounded overflow-hidden" style="border: 3px solid #cbd5e0;">
                                <% if (idCancion.equals("1")) { %>
                                    <iframe width="560" height="315" src="https://www.youtube.com/embed/XqUwK46IBSk?si=zQqytledtZuTitiJ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                                <% } else if (idCancion.equals("2")) { %>
                                    <iframe width="560" height="315" src="https://www.youtube.com/embed/eNLjdPI9zdE?si=iljRddhA2vBXAdG0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                                <% } else if (idCancion.equals("3")) { %>
                                    <iframe width="560" height="315" src="https://www.youtube.com/embed/XQaKFU3Fh_M?si=V4P3mKGkS_HYA73n" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                                <% } %>
                            </div>
                        </div>
                        
                        <!-- Columna Derecha: Letra Dinámica de la Canción Seleccionada -->
                        <div class="col-lg-5">
                            <div class="p-4 bg-light rounded text-center overflow-auto" style="max-height: 350px; border: 2px dashed #fc8181;">
                                <h4 class="fw-bold text-dark mb-4 text-uppercase"><%= tituloCancion %></h4>
                                
                                <% if (idCancion.equals("1")) { %>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">Los pollitos dicen</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">pio pio pio</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">cuando tienen hambre</p>
                                    <p class="fs-5 mb-4 fw-bold text-secondary">cuando tienen frio</p>
                                    
                                    <p class="fs-5 mb-2 fw-bold text-secondary">La gallina busca</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">el maíz y el trigo</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">les da la comida</p>
                                    <p class="fs-5 mb-4 fw-bold text-secondary">y les presta abrigo</p>
                                    
                                    <p class="fs-5 mb-2 fw-bold text-secondary">Bajo sus dos alas</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">acurrucaditos</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">duermen los pollitos</p>
                                    <p class="fs-5 mb-4 fw-bold text-secondary">hasta el otro día</p>
                                    
                                    <p class="fs-5 mb-2 fw-bold text-secondary">Cuando se despiertan</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">dicen mamacita</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">tengo mucha hambre</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">dame lombricitas</p>
                                <% } else if (idCancion.equals("2")) { %>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">La Vaca Lola, la Vaca Lola</p>
                                    <p class="fs-5 mb-4 fw-bold text-secondary">tiene cabeza y tiene cola.</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">La Vaca Lola, la Vaca Lola</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">tiene cabeza y tiene cola</p>
                                    <p class="fs-5 mb-4 fw-bold text-danger font-monospace">y hace ¡Muuu!</p>
                                    
                                    <p class="fs-5 mb-2 fw-bold text-secondary">La Vaca Lola, la Vaca Lola</p>
                                    <p class="fs-5 mb-4 fw-bold text-secondary">tiene cabeza y tiene cola.</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">La Vaca Lola, la Vaca Lola</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">tiene cabeza y tiene cola</p>
                                    <p class="fs-5 mb-4 fw-bold text-danger font-monospace">y hace ¡Muuu!</p>
                                <% } else if (idCancion.equals("3")) { %>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">Yo conozco una vecina</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">que ha comprado una gallina</p>
                                    <p class="fs-5 mb-4 fw-bold text-secondary">me parece una sardina enlatada.</p>
                                    
                                    <p class="fs-5 mb-2 fw-bold text-secondary">Tiene las patas de alambre</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">porque pasa mucho hambre</p>
                                    <p class="fs-5 mb-4 fw-bold text-secondary">y la pobre está todita desplumada.</p>
                                    
                                    <p class="fs-5 mb-2 fw-bold text-secondary">Pone huevos en la sala</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">y también en la cocina</p>
                                    <p class="fs-5 mb-4 fw-bold text-secondary">pero nunca los pone en el corral.</p>
                                    
                                    <p class="fs-5 mb-1 fw-bold text-primary">¡¡La Gallina!! ¡¡Turuleca!!</p>
                                    <p class="fs-5 mb-3 fw-bold text-secondary">es un caso singular.</p>
                                    <p class="fs-5 mb-1 fw-bold text-primary">¡¡La Gallina!! ¡¡Turuleca!!</p>
                                    <p class="fs-5 mb-4 fw-bold text-secondary">está loca de verdad.</p>
                                    
                                    <p class="fs-5 mb-2 fw-bold text-secondary">La Gallina Turuleca</p>
                                    <p class="fs-5 mb-4 fw-bold text-success">ha puesto un huevo, ha puesto dos, ha puesto tres.</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">La Gallina Turuleca</p>
                                    <p class="fs-5 mb-4 fw-bold text-success">ha puesto cuatro, ha puesto cinco, ha puesto seis.</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">La Gallina Turuleca</p>
                                    <p class="fs-5 mb-4 fw-bold text-success">ha puesto siete, ha puesto ocho, ha puesto nueve.</p>
                                    
                                    <p class="fs-5 mb-2 fw-bold text-primary">¿Dónde está esa gallinita?</p>
                                    <p class="fs-5 mb-2 fw-bold text-secondary">déjala a la pobrecita,</p>
                                    <p class="fs-5 mb-2 fw-bold text-dark fw-bold">déjala que ponga diez.</p>
                                <% } %>
                                
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
            
        </main>
    </div>

    <!-- CONTROLADORES JAVASCRIPT DE ACCESIBILIDAD -->
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