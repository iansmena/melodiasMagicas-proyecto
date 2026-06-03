<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melodías Mágicas - Registro de Padres</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

    <div class="barra-accesibilidad">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning" aria-label="Cambiar contraste">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('Formulario de registro para mamás, papás o tutores. Por favor completa los datos.')" class="boton-accesible btn-info text-white" aria-label="Escuchar instrucción">
            <i class="bi bi-volume-up-fill"></i> Escuchar Instrucción
        </button>
    </div>

    <nav class="menu-principal">
        <div class="fila-flexible">
            <a href="index.jsp" class="texto-logotipo">
                <i class="bi bi-music-note-beamed"></i> Melodías Mágicas
            </a>
            <div>
                <a href="index.jsp" class="btn btn-outline-secondary boton-accesible">
                    Volver al Login
                </a>
            </div>
        </div>
    </nav>

    <main class="contenedor-registro-centrado">
        
        <div id="tarjeta-registro">
            <h2>Crear Cuenta de Adulto</h2>
            <p>Regístrate para poder configurar el perfil de tus hijos.</p>
            
            <form action="procesarRegistro.jsp" method="POST">
                
                <div class="mb-3">
                    <label for="correo" class="form-label fw-bold">Correo Electrónico del Adulto:</label>
                    <input type="email" class="form-control" id="correo" name="txt_registro_correo" required placeholder="nombre@ejemplo.com">
                    <div class="form-text text-secondary">Debe ser un correo electrónico válido.</div>
                </div>
                
                <div class="mb-4">
                    <label for="clave" class="form-label fw-bold">Contraseña Segura:</label>
                    <input type="password" class="form-control" id="clave" name="txt_registro_clave" required minlength="8" placeholder="Mínimo 8 caracteres">
                    <div class="form-text text-secondary">Por seguridad, tu clave debe tener al menos 8 caracteres.</div>
                </div>

                <button type="submit" class="boton-registrar">
                    <i class="bi bi-person-plus-fill me-2"></i>Registrarme e Iniciar
                </button>
                
            </form>
            
            <div class="text-center mt-4 border-top pt-3">
                <p class="mb-1 text-muted">¿Ya tienes una cuenta?</p>
                <a href="index.jsp" class="text-decoration-none fw-bold" style="color: #7000ff;">Inicia sesión aquí</a>
            </div>
        </div>

    </main>

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
</body>
</html>