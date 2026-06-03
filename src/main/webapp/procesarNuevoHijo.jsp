<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.melodiasmagicas.negocio.Hijo" %>

<%
    Integer idPadreLogueado = (Integer) session.getAttribute("idUsuarioPadre");

    if (idPadreLogueado == null) {
        response.sendRedirect("index.jsp?error=sin_sesion");
        return;
    }

    String nombreHijo = request.getParameter("txt_hijo_nombre");
    String fechaNacimiento = request.getParameter("txt_hijo_fecha");
    
    int numeroAvatar = Integer.parseInt(request.getParameter("rb_hijo_avatar"));
    int instrumentoFavorito = Integer.parseInt(request.getParameter("sl_hijo_instrumento"));

    Hijo nuevoHijo = new Hijo(idPadreLogueado, nombreHijo, fechaNacimiento, numeroAvatar, instrumentoFavorito);

    String respuestaInsertar = nuevoHijo.insertarHijo();

    if (respuestaInsertar.equals("Inserción correcta.")) {
        response.sendRedirect("perfiles.jsp?registro_hijo=ok");
    } else {
        System.out.println("Error al registrar hijo: " + respuestaInsertar);
        response.sendRedirect("perfiles.jsp?error=fail_hijo");
    }
%>