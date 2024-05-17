package com.mrChill.Relax.context;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectSQLServer {

	public static Connection conn;

	public static Connection getConnection() throws SQLException {

		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		}

//		Connection conn = null;
		try {
			DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=KDShop;encrypt=false", "sa",
					"Mac!@#456");

		} catch (SQLException e) {

			e.printStackTrace();
		}

		try {
			conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=KDShop;encrypt=false",
					"sa", "Mac!@#456");
			return conn;
		} catch (SQLException e) {

			e.printStackTrace();
			return null;
		}

	}

	public static void disconnect() throws SQLException {
		if (conn != null && !conn.isClosed()) {
			conn.close();
		}
	}

}
