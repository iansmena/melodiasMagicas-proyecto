<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.melodiasmagicas.negocio.Hijo" %>
<%@ page import="java.sql.ResultSet" %>

<%
    //Validar que se haya iniciado sesión de verdad
    Integer idPadre = (Integer) session.getAttribute("idUsuarioPadre");
    String correoPadre = (String) session.getAttribute("correoUsuario");
    
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
    <title>Melodías Mágicas - ¿Quién va a jugar hoy?</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

    <div class="barra-accesibilidad">
        <button onclick="cambiarContraste()" class="boton-accesible btn-warning">
            <i class="bi bi-eye-fill"></i> Alto Contraste
        </button>
        <button onclick="reproducirVoz('Hola. Por favor, selecciona tu perfil para empezar a cantar y jugar.')" class="boton-accesible btn-info text-white">
            <i class="bi bi-volume-up-fill"></i> Escuchar Instrucción
        </button>
    </div>

    <nav class="menu-principal">
        <div class="fila-flexible">
            <span class="texto-logotipo"><i class="bi bi-music-note-beamed"></i> Melodías Mágicas</span>
            <div class="text-end">
                <span class="text-muted me-3">Cuenta: <%= correoPadre %></span>
                <button class="btn btn-primary boton-accesible me-2" data-bs-toggle="modal" data-bs-target="#modalNuevoHijo">
                    <i class="bi bi-plus-circle-fill"></i> Registrar Hijo
                </button>
                <a href="index.jsp" class="btn btn-outline-danger boton-accesible">Cerrar Sesión</a>
            </div>
        </div>
    </nav>

    <main class="container text-center mt-5">
        <h1 class="display-5 fw-bold mb-5">¿Quién va a jugar hoy?</h1>
        
        <div class="row justify-content-center">
            <%
                Hijo negocioHijo = new Hijo();
                ResultSet rsHijos = negocioHijo.listarHijosPorPadre(idPadre);
                
                boolean tieneHijos = false;
                
                String[] iconosAvatares = {"", "bi-music-note-beamed text-primary", "bi-emoji-smile-fill text-success", "bi-star-fill text-warning", "bi-heart-fill text-danger", "bi-brightness-high-fill text-info"};
                String[] coloresFondo = {"", "#e0f2fe", "#dcfce7", "#fef9c3", "#fee2e2", "#ecfeff"};

                while(rsHijos != null && rsHijos.next()) {
                    tieneHijos = true;
                    int idDelHijo = rsHijos.getInt("hijo_id");
                    String nombreDelHijo = rsHijos.getString("hijo_nombre");
                    int numAvatar = rsHijos.getInt("hijo_numero_avatar");
                    
                    if(numAvatar < 1 || numAvatar > 5) numAvatar = 1;
            %>
                    <div class="col-6 col-sm-4 col-md-3">
                        <a href="principal.jsp?idHijo=<%= idDelHijo %>" class="tarjeta-perfil-nino">
                            <div class="imagen-avatar d-flex align-items-center justify-content-center" style="background-color: <%= coloresFondo[numAvatar] %>;">
                                <i class="bi <%= iconosAvatares[numAvatar] %> fs-1"></i>
                            </div>
                            <div class="nombre-perfil-nino"><%= nombreDelHijo %></div>
                        </a>
                    </div>
            <%
                }
                
                if (!tieneHijos) {
            %>
                    <div class="col-12 mt-4">
                        <div class="alert alert-info d-inline-block p-4">
                            <i class="bi bi-info-circle fs-3 d-block mb-2"></i>
                            Todavía no tienes perfiles creados para tus hijos.<br>
                            Haz clic en el botón superior <strong>"Registrar Hijo"</strong> para empezar.
                        </div>
                    </div>
            <%
                }
            %>
        </div>
    </main>

    <div class="modal fade" id="modalNuevoHijo" tabindex="-1" aria-labelledby="modalTitulo" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content text-start">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalTitulo">Registrar Perfil de tu Hijo/a</h5>
                    <button type="white" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                
                <form action="procesarNuevoHijo.jsp" method="POST">
                    <div class="modal-body">
                        
                        <div class="mb-3">
                            <label for="nombreHijo" class="form-label">Nombre del Niño/a:</label>
                            <input type="text" class="form-control" id="nombreHijo" name="txt_hijo_nombre" required placeholder="Ej. Carlitos">
                        </div>
                        
                        <div class="mb-3">
                            <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                            <input type="date" class="form-control" id="fechaNacimiento" name="txt_hijo_fecha" required>
                            <div class="form-text">Dirigido a niños de hasta 5 años.</div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label d-block">Selecciona su Avatar Favorito:</label>
                            <div class="d-flex justify-content-between p-2 bg-light rounded">
                                <label class="mx-1 text-center"><input type="radio" name="rb_hijo_avatar" value="1" checked> <br><i class="bi bi-music-note-beamed text-primary fs-3"></i></label>
                                <label class="mx-1 text-center"><input type="radio" name="rb_hijo_avatar" value="2"> <br><i class="bi bi-emoji-smile-fill text-success fs-3"></i></label>
                                <label class="mx-1 text-center"><input type="radio" name="rb_hijo_avatar" value="3"> <br><i class="bi bi-star-fill text-warning fs-3"></i></label>
                                <label class="mx-1 text-center"><input type="radio" name="rb_hijo_avatar" value="4"> <br><i class="bi bi-heart-fill text-danger fs-3"></i></label>
                                <label class="mx-1 text-center"><input type="radio" name="rb_hijo_avatar" value="5"> <br><i class="bi bi-brightness-high-fill text-info fs-3"></i></label>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="instrumentoFav" class="form-label">Preferencia / Instrumento Favorito:</label>
                            <select class="form-select" id="instrumentoFav" name="sl_hijo_instrumento">
                                <option value="1">🎹 Piano Mágico</option>
                                <option value="2" selected>🥁 Tambor Divertido</option>
                                <option value="3">🎵 Xilófono de Colores</option>
                                <option value="4">🪇 Maracas Rítmicas</option>
                                <option value="5">🎸 Guitarra Pequeña</option>
                            </select>
                        </div>
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary boton-accessible" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-success boton-accessible">Crear Cuenta Infantil</button>
                    </div>
                </form>
                
            </div>
        </div>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>