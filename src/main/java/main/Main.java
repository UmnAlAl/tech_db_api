package main;

import db.DbConnector;
import db.DbService;
import db.dao.UserDAO;
import frontend.GlobalServlet;
import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;
import org.eclipse.jetty.server.handler.HandlerList;
import org.eclipse.jetty.server.handler.ResourceHandler;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import org.eclipse.jetty.util.BlockingArrayQueue;
import org.eclipse.jetty.util.thread.QueuedThreadPool;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.Servlet;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

/**
 * Created by Installed on 10.04.2016.
 */
public class Main {

    public class dbInfo {
        public static final int STANDART_PORT = 9090;
        public static final String STANDART_MYSQL_HOST = "localhost";
        public static final String STANDART_MYSQL_PORT = "3306";
        public static final String STANDART_MYSQL_DB_NAME = "dbSUBD";
        public static final String STANDART_MYSQL_LOGIN = "test";
        public static final String STANDART_MYSQL_PASSWORD = "test";
        public static final String STANDART_MYSQL_DRIVER = "com.mysql.jdbc.Driver";
        public static final long STANDART_MYSQL_MAX_LIMIT = 1000000000;
    }

    public static final int STANDART_SERVER_PORT = 9090;

    public static void main(String[] args) throws Exception {
        int port = STANDART_SERVER_PORT;
        if(args.length > 0) {
            port = Integer.valueOf(args[0]);
        }

        DbService dbService = new DbService(
                dbInfo.STANDART_MYSQL_HOST,
                dbInfo.STANDART_MYSQL_PORT,
                dbInfo.STANDART_MYSQL_DB_NAME,
                dbInfo.STANDART_MYSQL_DRIVER,
                dbInfo.STANDART_MYSQL_LOGIN,
                dbInfo.STANDART_MYSQL_PASSWORD
        );

        /*String queryCreate = "{\"username\": \"user1\", \"about\": \"hello im user1\", \"isAnonymous\": false, \"name\": \"John\", \"email\": \"example@mail.ru\"}";
        String queryListFollowers = "{\"user\" : \"email3@email3.com\", \"order\" : \"asc\" }";
        JSONObject res = null;
        JSONArray resArr = null;
        try {
            UserDAO userDAO = new UserDAO(dbConnector.getConnection());
            //res = userDAO.create(new JSONObject(queryCreate));
            res = userDAO.detailsByEmail("email3@email3.com");
            //res = userDAO.follow("email5@email5.com", "email1@email1.com");
            //resArr = userDAO.listFollowers(new JSONObject(queryListFollowers));
            //System.out.print(res.toString());
            //System.out.print(resArr.toString(1));
        }
        catch (Exception ex) {
            System.out.print(ex.getMessage());
        }*/

        Servlet globalServlet = new GlobalServlet(dbService);

        ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
        context.addServlet(new ServletHolder(globalServlet), "/db/api/*");

        HandlerList handlers = new HandlerList();
        handlers.setHandlers(new Handler[]{context});

        QueuedThreadPool threadPool = new QueuedThreadPool(4, 1, 300000, new BlockingArrayQueue<Runnable>(1000));

        Server server = new Server(threadPool);
        ServerConnector connector = new ServerConnector(server);
        connector.setPort(port);

        server.addConnector(connector);

        server.setHandler(handlers);
        server.start();
        server.join();

    }//main
}
