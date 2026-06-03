<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Forzar la destrucción completa del contenedor de sesión en el servidor Tomcat
    if (session != null) {
        session.removeAttribute("idUsuarioPadre");
        session.removeAttribute("correoUsuario");
        session.removeAttribute("nombreHijoActivo");
        session.removeAttribute("idHijoActivo");
        session.invalidate(); 
    }
    
    // 2. Redirección inmediata y limpia hacia la página inicial (Login / Bienvenida)
    response.sendRedirect("index.jsp");
%>