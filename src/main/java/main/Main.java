package main;

import db.DbConnector;
import db.dao.UserDAO;
import org.json.JSONArray;
import org.json.JSONObject;

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

    public static void main(String[] args) {
        DbConnector dbConnector = new DbConnector(
                dbInfo.STANDART_MYSQL_HOST,
                dbInfo.STANDART_MYSQL_PORT,
                dbInfo.STANDART_MYSQL_DB_NAME,
                dbInfo.STANDART_MYSQL_DRIVER,
                dbInfo.STANDART_MYSQL_LOGIN,
                dbInfo.STANDART_MYSQL_PASSWORD
        );
        String queryCreate = "{\"username\": \"user1\", \"about\": \"hello im user1\", \"isAnonymous\": false, \"name\": \"John\", \"email\": \"example@mail.ru\"}";
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
        }
    }//main
}
