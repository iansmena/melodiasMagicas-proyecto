<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.productos.seguridad.Usuario" %>

<%
    String correo = request.getParameter("txt_registro_correo");
    String clave = request.getParameter("txt_registro_clave");

    Usuario nuevoUsuario = new Usuario(correo, clave);
    
    String respuesta = nuevoUsuario.insertarUsuario();
    
    if (respuesta.equals("Inserción correcta.")) {
        response.sendRedirect("index.jsp?registro=ok");
    } else {
        // Si hay un error (ej. correo duplicado o fallo de BD)
        System.out.println("Fallo al registrar: " + respuesta);
        response.sendRedirect("registroPadre.jsp?error=error_registro");
    }
%>