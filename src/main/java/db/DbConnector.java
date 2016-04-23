package db;

import org.apache.tomcat.jdbc.pool.PoolProperties;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by Installed on 10.04.2016.
 */
public class DbConnector {

    private static org.apache.tomcat.jdbc.pool.DataSource connectionPoolRes;

    public DbConnector(String hostname, String port, String dbName, String driverName,
                       String login, String password) {
        PoolProperties poolProperties = new PoolProperties();
        StringBuilder url = new StringBuilder();
        url.
                append("jdbc:mysql://").
                append(hostname).append(':').
                append(port).append('/').
                append(dbName);
        poolProperties.setUrl(url.toString());
        poolProperties.setDriverClassName(driverName);
        poolProperties.setUsername(login);
        poolProperties.setPassword(password);
        connectionPoolRes = new org.apache.tomcat.jdbc.pool.DataSource();
        connectionPoolRes.setPoolProperties(poolProperties);
    }

    public Connection getConnection() throws SQLException {return  connectionPoolRes.getConnection();}
}
