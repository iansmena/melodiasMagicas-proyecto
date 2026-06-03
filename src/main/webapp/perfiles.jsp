<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.melodiasmagicas.negocio.Hijo" %>
<%@ page import="java.sql.ResultSet" %>

<%
    // SECCIÓN DE SEGURIDAD Y CONTROL DE SESIÓN
    Integer idPadre = (Integer) session.getAttribute("idUsuarioPadre");
    String correoPadre = (String) session.getAttribute("correoUsuario");
    
    if (idPadre == null) {
        response.sendRedirect("index.jsp?error=sin_sesion");
        return; // Detiene la ejecución del ciclo de vida del JSP de manera segura
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melodías Mágicas - ¿Quién va a jugar hoy?</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

    <div class="barra-accesibilidad">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning" aria-label="Cambiar contraste">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('Selecciona tu perfil infantil para empezar a jugar o añade un nuevo perfil.')" class="boton-accesible btn-info text-white" aria-label="Escuchar instrucción">
            <i class="bi bi-volume-up-fill"></i> Escuchar Instrucción
        </button>
    </div>

    <nav class="menu-principal">
        <div class="fila-flexible">
            <a href="perfiles.jsp" class="texto-logotipo">
                <i class="bi bi-music-note-beamed"></i> Melodías Mágicas
            </a>
            <div class="d-flex align-items-center gap-3">
                <span class="text-muted d-none d-md-inline fw-bold">Cuenta: <%= correoPadre %></span>
                
                <a href="procesarSalida.jsp" class="btn btn-outline-danger boton-accesible">
                    <i class="bi bi-box-arrow-left"></i> Salir
                </a>
            </div>
        </div>
    </nav>

    <main class="container text-center my-5">
        <h1 class="fw-black display-5 mb-2" style="color: #1a202c; font-weight: 800;">¿Quién va a jugar hoy?</h1>
        <p class="text-secondary fs-5 mb-5">Elige tu avatar para entrar a tu mundo musical</p>

        <div class="contenedor-perfiles-streaming">
            <%
                Hijo negocioHijo = new Hijo();
                ResultSet rsHijos = negocioHijo.listarHijosPorPadre(idPadre);
                
                if (rsHijos != null) {
                    while (rsHijos.next()) {
                        int idHijo = rsHijos.getInt("hijo_id");
                        String nombreHijo = rsHijos.getString("hijo_nombre");
                        int numeroAvatar = rsHijos.getInt("hijo_numero_avatar");
                        
                        // Vinculado dinámicamente a tu Vercel Blob Storage
                        String rutaAvatar = "https://xpxcidh4nv94qxjy.public.blob.vercel-storage.com/img/avatar/avatar" + numeroAvatar + ".png";
            %>
                        <a href="principal.jsp?idHijo=<%= idHijo %>" class="tarjeta-perfil-nino" aria-label="Jugar como <%= nombreHijo %>">
                            <img src="<%= rutaAvatar %>" onerror="this.src='https://api.dicebear.com/7.x/bottts/svg?seed=<%= nombreHijo %>'" class="imagen-avatar" alt="Avatar de <%= nombreHijo %>">
                            <span class="nombre-perfil-nino"><%= nombreHijo %></span>
                        </a>
            <%
                    }
                    rsHijos.close();
                }
            %>

            <a href="#" class="tarjeta-perfil-nino" data-bs-toggle="modal" data-bs-target="#modalNuevoHijo" aria-label="Añadir un nuevo perfil de hijo">
                <div class="avatar-agregar-nuevo">
                    <i class="bi bi-plus-lg"></i>
                </div>
                <span class="nombre-perfil-nino">Añadir</span>
            </a>
        </div>
    </main>

    <div class="modal fade" id="modalNuevoHijo" tabindex="-1" aria-labelledby="modalHijoLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 24px; border: 3px solid #7000ff; overflow: hidden;">
                
                <div class="modal-header bg-primary text-white p-4" style="background: linear-gradient(135deg, #7000ff 0%, #ff007f 100%) !important;">
                    <h5 class="modal-title fw-bold fs-4" id="modalHijoLabel">
                        <i class="bi bi-magic me-2"></i> Crear Nuevo Perfil Infantil
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <form action="procesarNuevoHijo.jsp" method="POST">
                    <div class="modal-body p-4 text-start">
                        
                        <div class="mb-3">
                            <label for="nombreHijo" class="form-label fw-bold text-dark">Nombre del Niño(a):</label>
                            <input type="text" class="form-control p-3" id="nombreHijo" name="txt_hijo_nombre" required placeholder="Escribe su nombre o apodo" style="border: 2px solid #cbd5e0; border-radius: 12px;">
                        </div>
                        
                        <div class="mb-3">
                            <label for="fechaNac" class="form-label fw-bold text-dark">Fecha de Nacimiento:</label>
                            <input type="date" class="form-control p-3" id="fechaNac" name="txt_hijo_fecha" required style="border: 2px solid #cbd5e0; border-radius: 12px;">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold text-dark d-block">1. Selecciona tu Avatar Mágico:</label>
                            <div class="selector-visual-grid">
                                <% for(int i=1; i<=5; i++) { %>
                                    <label class="opcion-visual-item" title="Avatar <%=i%>">
                                        <input type="radio" name="rb_hijo_avatar" value="<%=i%>" <%=(i==1)?"checked":""%> required>
                                        <img src="https://xpxcidh4nv94qxjy.public.blob.vercel-storage.com/img/avatar/avatar<%=i%>.png" alt="Opción Avatar <%=i%>">
                                    </label>
                                <% } %>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold text-dark d-block">2. Elige tu Instrumento Favorito:</label>
                            <div class="selector-visual-grid">
                                <% 
                                    String[] nombresInst = {"Guitarra", "Piano", "Tambor", "Xilófono", "Maracas"};
                                    for(int j=1; j<=5; j++) { 
                                %>
                                    <label class="opcion-visual-item" title="<%= nombresInst[j-1] %>">
                                        <input type="radio" name="sl_hijo_instrumento" value="<%=j%>" <%=(j==2)?"checked":""%>>
                                        <img src="https://xpxcidh4nv94qxjy.public.blob.vercel-storage.com/img/instruments/instruments<%=j%>.png" alt="<%= nombresInst[j-1] %>">
                                    </label>
                                <% } %>
                            </div>
                        </div>
                        
                    </div>
                    <div class="modal-footer border-top-0 p-4 justify-content-center gap-2">
                        <button type="button" class="btn btn-secondary px-4 py-2 fw-bold" data-bs-dismiss="modal" style="border-radius: 12px; min-height: 48px;">Cancelar</button>
                        <button type="submit" class="btn btn-success px-5 py-2 fw-bold" style="border-radius: 12px; min-height: 48px; background-color: #48bb78; border: none;">¡Crear Cuenta Infantil!</button>
                    </div>
                </form>
                
            </div>
        </div>
    </div>

    <script>
        // 1. FUNCIÓN INTERACTIVA DEL BOTÓN (Guarda el estado localmente)
        function cambiarContraste() {
            let activo = document.body.classList.toggle('modo-alto-contraste');
            if (activo) {
                localStorage.setItem('altoContraste', 'activado');
            } else {
                localStorage.setItem('altoContraste', 'desactivado');
            }
        }

        // 2. COMPROBACIÓN INMEDIATA AL CARGAR LA PÁGINA (Evita parpadeos de diseño)
        document.addEventListener("DOMContentLoaded", function() {
            let estadoContraste = localStorage.getItem('altoContraste');
            if (estadoContraste === 'activado') {
                document.body.classList.add('modo-alto-contraste');
            }
        });

        // 3. ASISTENTE DE VOZ INTEGRADO
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