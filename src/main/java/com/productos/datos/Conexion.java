package com.productos.datos;

import java.sql.*;

public class Conexion {
    private Statement St; 
    private String driver;
    private String user;
    private String pwd;
    private String cadena;
    private Connection con;

    String getDriver() {
        return this.driver;
    }
    String getUser() {
        return this.user;
    }
    String getPwd() {
        return this.pwd;
    }
    String getCadena() {
        return this.cadena;
    }
    public Connection getConexion() { 
        return this.con; 
    }
    
    public Conexion() {
        this.driver = "org.postgresql.Driver";
        this.user = "postgres";
        this.pwd = "00221"; // Tu clave de Postgres de clase
        this.cadena = "jdbc:postgresql://localhost:5432/bd_proyectos"; // Ajustado a tu BD actual
        this.con = this.crearConexion();    
    }
    
    Connection crearConexion() {
        try {
            Class.forName(this.driver);
            Connection conexion = DriverManager.getConnection(getCadena(), getUser(), getPwd());
            return conexion;
        } catch(Exception ee) {
            System.out.println("Error de conexión: " + ee.getMessage());
            return null;
        }
    }

    public String Ejecutar(String sql) {
        String result = "";
        try {
            St = getConexion().createStatement();
            St.execute(sql);
            result = "Operación realizada con éxito";
        } catch(Exception ex) {
            result = ex.getMessage();
        }
        return result;
    }

    public ResultSet Consulta(String sql) {
        ResultSet reg = null;
        try {
            St = getConexion().createStatement();
            reg = St.executeQuery(sql);
        } catch(Exception ee) {
            System.out.println("Error en consulta: " + ee.getMessage());
        }
        return reg;
    }
}