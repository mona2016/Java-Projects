package com.sh.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class dbConn {
private static Connection connection =null;

public static Connection getConnection(){
	System.out.println("in get connection");
	
	if(connection!=null)
		
		return connection;
	else
	{
		System.out.println("in else of get connection");
		
		try {
			
			Properties prop = new Properties();
	        InputStream inputStream = dbConn.class.getClassLoader().getResourceAsStream("/db.properties");
	        prop.load(inputStream);
	        String driver = prop.getProperty("driver");
	        String url = prop.getProperty("url");
	        String user = prop.getProperty("user");
	        String password = prop.getProperty("password");
			Class.forName(driver);
			connection = DriverManager.getConnection(url,user,password);
			System.out.println("Connection in dbConn is done");
			if (connection==null)
			{
				System.out.println("connection cant be eastablished!");
			}
		} catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
	return connection;
	}
	
}
}
