package com.melodiasmagicas.seguridad;

import java.sql.PreparedStatement;

import com.melodiasmagicas.datos.Conexion;

public class Usuario {
    private String correo;
    private String clave;
    private int rol;
    private boolean activo;
    
    // Getters y Setters
    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
    
    public String getClave() { return clave; }
    public void setClave(String clave) { this.clave = clave; }
    
    public int getRol() { return rol; }
    public void setRol(int rol) { this.rol = rol; }
    
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
    
    // Constructor
    public Usuario(String correo, String clave) {
        this.correo = correo;
        this.clave = clave;
        this.rol = 2;
        this.activo = true;
    }

    public String insertarUsuario() {
        String result = "";
        Conexion con = new Conexion();
        PreparedStatement pr = null;
        
        String sql = "INSERT INTO public.usuarios (usuario_correo, usuario_clave, usuario_rol, usuario_estado_activo) VALUES (?, ?, ?, ?)";
        
        try {
            if (con.getConexion() == null) {
                return "Error: No se pudo conectar a PostgreSQL.";
            }
            
            pr = con.getConexion().prepareStatement(sql);
            
            pr.setString(1, this.getCorreo());
            pr.setString(2, this.getClave());
            pr.setInt(3, this.getRol());
            pr.setBoolean(4, this.isActivo());
            
            if (pr.executeUpdate() == 1) {
                result = "Inserción correcta.";
            } else {
                result = "Error en la inserción.";
            }
        } catch (Exception ex) {
            result = "Error SQL: " + ex.getMessage();
        } finally {
            try {
                if (pr != null) pr.close();
                if (con.getConexion() != null) con.getConexion().close();
            } catch(Exception ex) {
                System.out.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        return result;
    }
    
    private int idUsuarioDetectado;

    public int getIdUsuarioDetectado() { 
    	return idUsuarioDetectado;
    	
    	}

    public String validarUsuario() {
        String resultadoStr = "";
        Conexion con = new Conexion();
        PreparedStatement prLogin = null;
        PreparedStatement prBitacora = null;
        java.sql.ResultSet rs = null;

        String sqlLogin = "SELECT usuario_id, usuario_rol, usuario_estado_activo FROM public.usuarios WHERE usuario_correo = ? AND usuario_clave = ?";

        try {
            if (con.getConexion() == null) {
                return "error_conexion";
            }

            prLogin = con.getConexion().prepareStatement(sqlLogin);
            prLogin.setString(1, this.getCorreo());
            prLogin.setString(2, this.getClave());

            rs = prLogin.executeQuery();

            if (rs.next()) {
                boolean estaActivo = rs.getBoolean("usuario_estado_activo");
                
                if (!estaActivo) {
                    resultadoStr = "usuario_bloqueado";
                } else {
                    this.idUsuarioDetectado = rs.getInt("usuario_id");
                    this.setRol(rs.getInt("usuario_rol"));
                    this.setActivo(estaActivo);

                    String sqlBitacora = "INSERT INTO public.bitacora_accesos (usuario_id) VALUES (?)";
                    prBitacora = con.getConexion().prepareStatement(sqlBitacora);
                    prBitacora.setInt(1, this.idUsuarioDetectado);
                    prBitacora.executeUpdate();

                    if (this.getRol() == 1) {
                        resultadoStr = "es_admin";
                    } else {
                        resultadoStr = "es_padre";
                    }
                }
            } else {
                resultadoStr = "datos_incorrectos";
            }

        } catch (Exception ex) {
            resultadoStr = "error_sql: " + ex.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (prLogin != null) prLogin.close();
                if (prBitacora != null) prBitacora.close();
                if (con.getConexion() != null) con.getConexion().close();
            } catch (Exception ex) {
                System.out.println("Error al cerrar recursos en login: " + ex.getMessage());
            }
        }
        return resultadoStr;
    }
}