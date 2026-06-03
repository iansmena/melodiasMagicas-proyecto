package com.melodiasmagicas.datos;

import java.sql.*;

public class Conexion {
    private Statement St; 
    private String driver;
    private String user;
    private String pwd;
    private String cadena;
    private Connection con;

    // Getters estándar
    public String getDriver() { return this.driver; }
    public String getUser() { return this.user; }
    public String getPwd() { return this.pwd; }
    public String getCadena() { return this.cadena; }
    public Connection getConexion() { return this.con; }
    
    // Constructor adaptado a la infraestructura de la U y AnyDesk
    public Conexion() {
        this.driver = "org.postgresql.Driver";
        this.user = "postgres";
        this.pwd = "1234"; 
        this.cadena = "jdbc:postgresql://172.17.42.121:5432/BD_melodias"; 
        this.con = this.crearConexion();    
    }
    
    // Cambiado a private para encapsular correctamente la lógica
    private Connection crearConexion() {
        try {
            Class.forName(this.driver);
            return DriverManager.getConnection(getCadena(), getUser(), getPwd());
        } catch(Exception ee) {
            System.out.println("❌ Error crítico de conexión al Data Center: " + ee.getMessage());
            return null;
        }
    }

    // Optimizado para evitar colapsos y asegurar el flujo
    public String Ejecutar(String sql) {
        String result = "";
        if (getConexion() == null) {
            return "Error: No hay conexión activa con el servidor DataCenter.";
        }
        
        try {
            St = getConexion().createStatement();
            St.execute(sql);
            result = "Operación realizada con éxito";
            St.close(); // Cerramos el Statement para liberar memoria en Tomcat
        } catch(Exception ex) {
            result = "Error SQL: " + ex.getMessage();
        }
        return result;
    }

    // Optimizado para consultas seguras
    public ResultSet Consulta(String sql) {
        ResultSet reg = null;
        if (getConexion() == null) {
            System.out.println("❌ Error: Conexión nula al intentar consultar.");
            return null;
        }
        
        try {
            // Nota: El Statement se mantiene abierto temporalmente para que el JSP pueda leer el ResultSet, 
            // se cerrará automáticamente al cerrar el ResultSet en tus DAOs.
            St = getConexion().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            reg = St.executeQuery(sql);
        } catch(Exception ee) {
            System.out.println("❌ Error en consulta SQL: " + ee.getMessage());
        }
        return reg;
    }
}