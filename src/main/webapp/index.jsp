<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melodías Mágicas - Aprendizaje Infantil</title>
    <link rel="stylesheet" href="css/estilos.css">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
</head>
<body>

    <div class="barra-accesibilidad">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning" aria-label="Cambiar contraste">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('¡Bienvenidos a la plataforma! Inicia sesión para jugar.')" class="boton-accesible btn-info text-white" aria-label="Escuchar audio">
            <i class="bi bi-volume-up-fill"></i> Escuchar Instrucción
        </button>
    </div>

    <nav class="menu-principal">
        <div class="fila-flexible">
            <a href="index.jsp" class="texto-logotipo">
                <i class="bi bi-music-note-beamed"></i> Melodías Mágicas
            </a>
            <div>
                <a href="registroPadre.jsp" class="btn btn-outline-primary boton-accesible">
                    Crear Cuenta de Padre
                </a>
            </div>
        </div>
    </nav>

    <main class="seccion-presentacion">
        <div class="row align-items-center">
            
            <div class="col-md-7 columna-izquierda">
                <h1 class="mb-4 fw-bold">Aprende música jugando y divirtiéndote</h1>
                <p class="fs-5 text-muted mb-4">
                    Una aplicación web interactiva diseñada para niños de hasta 5 años. 
                    Aquí podrán descubrir las notas musicales con un piano, ver instrumentos en 3D 
                    y cantar canciones en un entorno completamente protegido para tu tranquilidad.
                </p>
                <div class="mb-3">
                    <span class="etiqueta-informativa">Entorno Seguro</span>
                    <span class="etiqueta-informativa">Modelos 3D</span>
                    <span class="etiqueta-informativa">Accesibilidad Completa</span>
                </div>
            </div>

            <div class="col-md-5 columna-derecha">
                <div id="tarjeta-login">
                    <h3 id="titulo-login">Ingreso de Padres</h3>
                    
                    <form action="procesarLogin.jsp" method="POST">
                        
                        <div class="mb-3">
                            <label for="correo" class="form-label">Correo Electrónico:</label>
                            <input type="email" class="form-control" id="correo" name="txt_correo" required placeholder="ejemplo@correo.com">
                        </div>
                        
                        <div class="mb-4">
                            <label for="clave" class="form-label">Contraseña:</label>
                            <input type="password" class="form-control" id="clave" name="txt_clave" required placeholder="Mínimo 8 caracteres">
                        </div>

                        <button type="submit" id="boton-ingresar" class="btn boton-accesible">
                            <i class="bi bi-box-arrow-in-right"></i> Entrar al Sitio
                        </button>
                        
                    </form>
                </div>
            </div>
            
        </div>
    </main>

    <script>
        // Función para activar/desactivar la clase de alto contraste en el body
        function cambiarContraste() {
            document.body.classList.toggle('modo-alto-contraste');
        }

        // Función para el lector de voz nativo
        function reproducirVoz(mensaje) {
            if ('speechSynthesis' in window) {
                window.speechSynthesis.cancel(); // Detener audios anteriores
                let lectura = new SpeechSynthesisUtterance(mensaje);
                lectura.lang = 'es-ES';
                window.speechSynthesis.speak(lectura);
            } else {
                alert("Lector no soportado por tu navegador.");
            }
        }
    </script>
    
    <div class="modal fade" id="modalErrorSistema" tabindex="-1" aria-labelledby="modalErrorLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 20px; border: 3px solid #e53e3e;">
                <div class="modal-header bg-danger text-white" style="border-top-left-radius: 17px; border-top-right-radius: 17px;">
                    <h5 class="modal-title fw-bold" id="modalErrorLabel">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> Control de Acceso
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center p-4">
                    <p id="mensajeErrorTexto" class="fs-5 fw-bold text-secondary mb-0"></p>
                </div>
                <div class="modal-footer justify-content-center border-0">
                    <button type="button" class="btn btn-secondary fw-bold px-4 boton-accessible" data-bs-dismiss="modal" onclick="window.speechSynthesis.cancel();">
                        Entendido
                    </button>
                </div>
            </div>
        </div>
    </div>

    <%
        // Capturamos si viene algún código de error por la URL
        String errorUrl = request.getParameter("error");
        if (errorUrl != null && !errorUrl.isEmpty()) {
            String mensajeInyectar = "Ocurrió un inconveniente al intentar ingresar.";
            
            if (errorUrl.equals("datos_incorrectos")) {
                mensajeInyectar = "¡Ups! El correo o la contraseña que escribiste no son correctos. Por favor, revísalos e intenta de nuevo.";
            } else if (errorUrl.equals("cuenta_bloqueada")) {
                mensajeInyectar = "🔒 Tu cuenta ha sido temporalmente inhabilitada por el Administrador del sistema. Comunícate con soporte.";
            } else if (errorUrl.equals("sin_sesion")) {
                mensajeInyectar = "⚠️ Debes iniciar sesión con tu cuenta de adulto para poder explorar esta sección segura.";
            }
    %>
            <script>
                document.addEventListener("DOMContentLoaded", function() {
                    var mensaje = "<%= mensajeInyectar %>";
                    document.getElementById("mensajeErrorTexto").innerText = mensaje;
                    
                    // Inicializamos y mostramos el modal de Bootstrap
                    var miModal = new bootstrap.Modal(document.getElementById('modalErrorSistema'));
                    miModal.show();
                    
                    // Accesibilidad por voz inmediata para el error
                    if ('speechSynthesis' in window) {
                        window.speechSynthesis.cancel();
                        let lectura = new SpeechSynthesisUtterance(mensaje);
                        lectura.lang = 'es-ES';
                        window.speechSynthesis.speak(lectura);
                    }
                });
            </script>
    <%
        }
    %>
    
</body>
</html>