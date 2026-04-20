package org.logistica.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConectaDB {

	private static final String URL = "jdbc:postgresql://localhost:5432/escuelamilitar";
    private static final String USER = "postgres";
    private static final String PASSWORD = "saberX100pre"; 

    public static Connection getConexion() {

        Connection cn = null;

        try {
            Class.forName("org.postgresql.Driver");
            cn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Conectado a PostgreSQL");

        } catch (Exception e) {
            System.out.println("❌ Error de conexión");
            e.printStackTrace();
        }

        return cn;
    }
}
