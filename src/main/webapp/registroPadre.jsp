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

    <main class="seccion-presentacion">
        <div class="row justify-content-center">
            <div class="col-md-6">
                
                <div id="tarjeta-login">
                    <h3 id="titulo-login">Crear Cuenta de Adulto</h3>
                    <p class="text-muted text-center mb-4">Regístrate para poder configurar el perfil de tus hijos.</p>
                    
                    <form action="procesarRegistro.jsp" method="POST">
                        
                        <div class="mb-3">
                            <label for="correo" class="form-label">Correo Electrónico del Adulto:</label>
                            <input type="email" class="form-control" id="correo" name="txt_registro_correo" required placeholder="nombre@ejemplo.com">
                            <div class="form-text">Debe ser un correo electrónico válido.</div>
                        </div>
                        
                        <div class="mb-4">
                            <label for="clave" class="form-label">Contraseña Segura:</label>
                            <input type="password" class="form-control" id="clave" name="txt_registro_clave" required minlength="8" placeholder="Mínimo 8 caracteres">
                            <div class="form-text">Por seguridad, tu clave debe tener al menos 8 caracteres.</div>
                        </div>

                        <button type="submit" id="boton-ingresar" class="btn boton-accesible">
                            <i class="bi bi-person-plus-fill"></i> Registrarme e Iniciar
                        </button>
                        
                    </form>
                    
                    <div class="text-center mt-4">
                        <p class="mb-0 text-muted">¿Ya tienes una cuenta?</p>
                        <a href="index.jsp" class="text-decoration-none fw-bold" style="color: #4a90e2;">Inicia sesión aquí</a>
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
            } else {
                alert("Lector no soportado por tu navegador.");
            }
        }
    </script>
</body>
</html>