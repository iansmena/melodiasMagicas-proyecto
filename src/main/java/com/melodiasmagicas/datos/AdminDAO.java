package com.melodiasmagicas.datos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {
    
    // Método para cambiar el estado de un usuario (Activar o Bloquear)
    public boolean cambiarEstadoUsuario(int idUsuario, boolean nuevoEstado) {
        Conexion con = new Conexion();
        PreparedStatement pr = null;
        boolean exito = false;
        try {
            String sql = "UPDATE public.usuarios SET usuario_estado_activo = ? WHERE usuario_id = ?";
            pr = con.getConexion().prepareStatement(sql);
            pr.setBoolean(1, nuevoEstado);
            pr.setInt(2, idUsuario);
            
            if (pr.executeUpdate() == 1) {
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("Error en AdminDAO.cambiarEstadoUsuario: " + e.getMessage());
        } finally {
            try {
                if (pr != null) pr.close();
                if (con.getConexion() != null) con.getConexion().close();
            } catch (Exception e) {}
        }
        return exito;
    }

    // Método para vaciar completamente la bitácora de accesos
    public boolean vaciarBitacora() {
        Conexion con = new Conexion();
        PreparedStatement pr = null;
        boolean exito = false;
        try {
            String sql = "TRUNCATE TABLE public.bitacora_accesos RESTART IDENTITY CASCADE";
            pr = con.getConexion().prepareStatement(sql);
            pr.executeUpdate();
            exito = true;
        } catch (Exception e) {
            System.out.println("Error en AdminDAO.vaciarBitacora: " + e.getMessage());
        } finally {
            try {
                if (pr != null) pr.close();
                if (con.getConexion() != null) con.getConexion().close();
            } catch (Exception e) {}
        }
        return exito;
    }
}