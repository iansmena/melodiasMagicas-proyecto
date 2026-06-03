package com.productos.negocio;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.productos.datos.Conexion;

public class Hijo {
    private int idHijo;
    private int idPadre;
    private String nombre;
    private String fechaNacimiento;
    private int numeroAvatar;
    private int instrumentoFavorito;

    // Getters y Setters
    
    public int getIdHijo() {
		return idHijo;
	}

	public void setIdHijo(int idHijo) {
		this.idHijo = idHijo;
	}

	public int getIdPadre() {
		return idPadre;
	}

	public void setIdPadre(int idPadre) {
		this.idPadre = idPadre;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	public int getNumeroAvatar() {
		return numeroAvatar;
	}

	public void setNumeroAvatar(int numeroAvatar) {
		this.numeroAvatar = numeroAvatar;
	}

	public int getInstrumentoFavorito() {
		return instrumentoFavorito;
	}

	public void setInstrumentoFavorito(int instrumentoFavorito) {
		this.instrumentoFavorito = instrumentoFavorito;
	}

	// Constructor vacio
    public Hijo() {}

    // Constructor
    public Hijo(int idPadre, String nombre, String fechaNacimiento, int numeroAvatar, int instrumentoFavorito) {
        this.idPadre = idPadre;
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
        this.numeroAvatar = numeroAvatar;
        this.instrumentoFavorito = instrumentoFavorito;
    }

    public String insertarHijo() {
        String result = "";
        Conexion con = new Conexion();
        PreparedStatement pr = null;
        
        String sql = "INSERT INTO public.perfiles_hijos (usuario_id_padre, hijo_nombre, hijo_fecha_nacimiento, hijo_numero_avatar, hijo_instrumento_favorito) VALUES (?, ?, CAST(? AS DATE), ?, ?)";
        
        try {
            if (con.getConexion() == null) {
                return "Error de conexión con la base de datos.";
            }
            
            pr = con.getConexion().prepareStatement(sql);
            pr.setInt(1, this.getIdPadre());
            pr.setString(2, this.getNombre());
            pr.setString(3, this.getFechaNacimiento());
            pr.setInt(4, this.getNumeroAvatar());
            pr.setInt(5, this.getInstrumentoFavorito());
            
            if (pr.executeUpdate() == 1) {
                result = "Inserción correcta.";
            } else {
                result = "Error al registrar el perfil del niño.";
            }
        } catch (Exception ex) {
            result = "Error SQL: " + ex.getMessage();
        } finally {
            try {
                if (pr != null) pr.close();
                if (con.getConexion() != null) con.getConexion().close();
            } catch(Exception ex) {
                System.out.println("Error al cerrar recursos de Hijo: " + ex.getMessage());
            }
        }
        return result;
    }

    public ResultSet listarHijosPorPadre(int idPadreLogueado) {
        Conexion con = new Conexion();
        String sql = "SELECT hijo_id, hijo_nombre, hijo_numero_avatar, hijo_instrumento_favorito FROM public.perfiles_hijos WHERE usuario_id_padre = " + idPadreLogueado + " ORDER BY hijo_id ASC";
        return con.Consulta(sql);
    }
}