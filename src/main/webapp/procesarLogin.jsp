<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.productos.seguridad.Usuario" %>

<%
    String correo = request.getParameter("txt_correo");
    String clave = request.getParameter("txt_clave");

    Usuario usuarioLogin = new Usuario(correo, clave);

    String resultadoLogin = usuarioLogin.validarUsuario();

    if (resultadoLogin.equals("es_admin") || resultadoLogin.equals("es_padre")) {
        
        session.setAttribute("idUsuarioPadre", usuarioLogin.getIdUsuarioDetectado());
        session.setAttribute("correoUsuario", usuarioLogin.getCorreo());
        session.setAttribute("rolUsuario", usuarioLogin.getRol());

        if (usuarioLogin.getRol() == 1) {
            response.sendRedirect("admin.jsp");
        } else {
            response.sendRedirect("perfiles.jsp");
        }
        
    } else if (resultadoLogin.equals("usuario_bloqueado")) {
        response.sendRedirect("index.jsp?error=bloqueado");
    } else if (resultadoLogin.equals("datos_incorrectos")) {
        response.sendRedirect("index.jsp?error=datos_incorrectos");
    } else {
        System.out.println("Error en el proceso de login: " + resultadoLogin);
        response.sendRedirect("index.jsp?error=error_general");
    }
%>