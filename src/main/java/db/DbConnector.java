package db;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.apache.tomcat.jdbc.pool.PoolProperties;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by Installed on 10.04.2016.
 */
public class DbConnector {

    private static org.apache.tomcat.jdbc.pool.DataSource connectionPoolRes;

    private String _hostname;
    private String _port;
    private String _dbName;
    private String _driverName;
    private String _login;
    private String _password;

    public DbConnector(String hostname, String port, String dbName, String driverName,
                       String login, String password) {
        _hostname = hostname;
        _port = port;
        _dbName = dbName;
        _driverName = driverName;
        _login = login;
        _password = password;


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

        /*performance conf*/
        poolProperties.setJmxEnabled(true);
        poolProperties.setTestWhileIdle(false);
        poolProperties.setTestOnBorrow(true);
        poolProperties.setValidationQuery("SELECT 1");
        poolProperties.setTestOnReturn(false);
        poolProperties.setValidationInterval(30000);
        poolProperties.setTimeBetweenEvictionRunsMillis(30000);
        poolProperties.setMaxActive(1000);
        poolProperties.setInitialSize(100);
        poolProperties.setMaxWait(10000);
        poolProperties.setRemoveAbandonedTimeout(60);
        poolProperties.setMinEvictableIdleTimeMillis(300000);
        poolProperties.setMinIdle(100);
        poolProperties.setLogAbandoned(true);
        poolProperties.setRemoveAbandoned(true);
        poolProperties.setJdbcInterceptors(
                "org.apache.tomcat.jdbc.pool.interceptor.ConnectionState;"+
                        "org.apache.tomcat.jdbc.pool.interceptor.StatementFinalizer");



        connectionPoolRes = new DataSource();
        connectionPoolRes.setPoolProperties(poolProperties);
    }

    public Connection getConnection() throws SQLException {return  getConnectionFromPool();}

    public Connection getConnectionFromPool() throws SQLException {return  connectionPoolRes.getConnection();}

    public Connection getSingleConnection() {
        try {
            DriverManager.registerDriver((Driver) Class.forName(_driverName).newInstance());

            StringBuilder url = new StringBuilder();

            url.
                    append("jdbc:mysql://").        //db type
                    append(_hostname).append(':').            //host name
                    append(_port).append('/').                //port
                    append(_dbName).append('?').           //db name
                    append("user=").append(_login).append('&').            //login
                    append("password=").append(_password);        //password

            Connection connection = DriverManager.getConnection(url.toString());

            return connection;

        }
        catch (SQLException | InstantiationException | IllegalAccessException | ClassNotFoundException | NullPointerException e) {
            return null;
        }
    }
}
