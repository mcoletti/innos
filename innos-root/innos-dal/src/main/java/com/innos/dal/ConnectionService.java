package com.innos.dal;

import com.innos.model.core.DataSource;
import org.hibernate.Session;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 3/2/13
 * Time: 8:06 AM
 * To change this template use File | Settings | File Templates.
 */
public class ConnectionService {


    private Connection connection;
    private DataSource dataSource;


    public ConnectionService(DataSource dataSource) throws Exception{
        this.dataSource = dataSource;
        initConnection();
    }

    public void initConnection() throws Exception {

        String userName = dataSource.getUseName(); // "root";
        String password = dataSource.getPassword(); // "ortronics";
        String url = dataSource.getDbUrl(); // "jdbc:mysql://10.88.41.125:3306/RSDB";
        Class.forName(dataSource.getDriverClass()).newInstance();
        connection = DriverManager.getConnection(url, userName, password);
    }

    public Connection getConnection() {
        return connection;
    }
}
