package db.dao;

import db.dataset.ForumDataset;
import db.dataset.PostDataset;
import db.dataset.ThreadDataset;
import db.dataset.UserDataset;
import main.Main;
import org.json.JSONArray;
import org.json.JSONObject;

import java.sql.*;

/**
 * Created by Installed on 10.04.2016.
 */
public class ForumDAO {

    private Connection connection;

    public ForumDAO (Connection connection) {this.connection = connection;}


    public static void getForumFromResultSet (ForumDataset forumDataset, ResultSet rs) throws SQLException {
        forumDataset.id = rs.getLong("id");
        forumDataset.idUser = rs.getLong("idUser");
        forumDataset.name = rs.getString("name");
        forumDataset.shortName = rs.getString("shortName");
    }

    public JSONObject create (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        ForumDataset forumDataset = new ForumDataset();
        try {

            String user = input.getString("user");
            forumDataset.fromJSONObject(input);


            /*
            CREATE FUNCTION `forumCreate` (forumName VARCHAR(255),
								forumShortName VARCHAR(255),
                                forumFounderEmail VARCHAR(255))
            */


            cs = connection.prepareCall("{ ? = call forumCreate(?, ?, ?) }");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.setObject(2, forumDataset.name);
            cs.setObject(3, forumDataset.shortName);
            cs.setObject(4, user);
            cs.execute();

            long postId = cs.getLong(1);
            input.put("id", postId);
            return input;
        }
        catch (SQLException e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject details (JSONObject input) throws SQLException {
        boolean needUser = false;
        String shortName;

        CallableStatement csGetForum = null;
        ResultSet rsGetForum = null;
        try {
            shortName = input.getString("forum");
            csGetForum = connection.prepareCall("{ call getForumByShortName(?) }");
            csGetForum.setObject(1, shortName);
            rsGetForum = csGetForum.executeQuery();
            rsGetForum.next();
            Long id = rsGetForum.getLong("id");
            if(input.has("related")) {
                JSONArray related = input.getJSONArray("related");
                for(Object i : related) {
                    switch ((String)i) {
                        case "user" : needUser = true;
                            break;
                    }
                }
            }
            return detailsById(id, needUser);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(csGetForum != null)
                csGetForum.close();
            if(rsGetForum != null)
                rsGetForum.close();
        }
    }

    public JSONObject detailsById (long id,
                                    boolean needUser) throws SQLException {
        CallableStatement csGetForum = null;
        ResultSet rsGetForum = null;
        JSONObject jsGetUser = null;
        JSONObject jsGetForum = null;
        ForumDataset forumDataset = new ForumDataset();
        UserDAO userDAO = new UserDAO(connection);
        JSONObject res = null;
        try {
            csGetForum = connection.prepareCall("{ call getForumById(?) }");
            csGetForum.setObject(1, id);
            rsGetForum = csGetForum.executeQuery();
            rsGetForum.next();

            getForumFromResultSet(forumDataset, rsGetForum);
            res = forumDataset.toJSONObject();

            jsGetUser = userDAO.detailsById(forumDataset.idUser);
            if(needUser) {
                res.put("user", jsGetUser);
            }
            else {
                res.put("user", jsGetUser.get("email"));
            }

            return res;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(csGetForum != null)
                csGetForum.close();
            if(rsGetForum != null)
                rsGetForum.close();
        }
    }

    public JSONArray listPosts (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        ForumDataset forumDataset = new ForumDataset();
        PostDataset postDataset = new PostDataset();
        ResultSet rs = null;
        JSONArray array = null;
        JSONObject tmp = null;
        Boolean needUser = false;
        Boolean needThread = false;
        Boolean needForum = false;
        PostDAO postDAO = new PostDAO(connection);
        try {

            Long limit;
            if(input.has("limit"))
                limit = input.getLong("limit");
            else limit = Main.dbInfo.STANDART_MYSQL_MAX_LIMIT;

            String order;
            if(input.has("order"))
                order = input.getString("order");
            else order = "desc";

            String sinceDate;
            if(input.has("since"))
                sinceDate = input.getString("since");
            else sinceDate = "1970-10-10 01-01-01";

            if(input.has("related")) {
                JSONArray related = input.getJSONArray("related");
                for(Object i : related) {
                    switch ((String)i) {
                        case "user" : needUser = true;
                            break;
                        case "forum" : needForum = true;
                            break;
                        case "thread" : needThread = true;
                            break;
                    }
                }
            }

            array = new JSONArray();
            String shortName = input.getString("forum");
            cs = connection.prepareCall("{ call forumListPostsByForumShortName(?, ?, ?, ?) }");
            cs.setObject(1, shortName);
            cs.setObject(2, limit);
            cs.setObject(3, order);
            cs.setObject(4, sinceDate);
            rs = cs.executeQuery();
            while (rs.next()) {
                PostDAO.getPostFromResultSet(postDataset, rs);
                tmp = postDAO.detailsById(postDataset.id, needUser, needThread, needForum);
                array.put(tmp);
            }

            return array;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
            if(rs != null)
                rs.close();
        }
    }

    public JSONArray listThreads (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        ThreadDataset threadDataset = new ThreadDataset();
        ResultSet rs = null;
        JSONArray array = null;
        JSONObject tmp = null;
        Boolean needUser = false;
        Boolean needThread = false;
        Boolean needForum = false;
        PostDAO postDAO = new PostDAO(connection);
        ThreadDAO threadDAO = new ThreadDAO(connection);
        try {

            Long limit;
            if(input.has("limit"))
                limit = input.getLong("limit");
            else limit = Main.dbInfo.STANDART_MYSQL_MAX_LIMIT;

            String order;
            if(input.has("order"))
                order = input.getString("order");
            else order = "desc";

            String sinceDate;
            if(input.has("since"))
                sinceDate = input.getString("since");
            else sinceDate = "1970-10-10 01-01-01";

            if(input.has("related")) {
                JSONArray related = input.getJSONArray("related");
                for(Object i : related) {
                    switch ((String)i) {
                        case "user" : needUser = true;
                            break;
                        case "forum" : needForum = true;
                            break;
                    }
                }
            }

            array = new JSONArray();
            String shortName = input.getString("forum");
            cs = connection.prepareCall("{ call forumListThreadsByForumShortName(?, ?, ?, ?) }");
            cs.setObject(1, shortName);
            cs.setObject(2, limit);
            cs.setObject(3, order);
            cs.setObject(4, sinceDate);
            rs = cs.executeQuery();
            while (rs.next()) {
                ThreadDAO.getThreadFromResultSet(threadDataset, rs);
                tmp = threadDAO.detailsById(threadDataset.id, needUser, needForum);
                array.put(tmp);
            }

            return array;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
            if(rs != null)
                rs.close();
        }
    }

    public JSONArray listUsers (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        UserDataset userDataset = new UserDataset();
        ResultSet rs = null;
        JSONArray array = null;
        JSONObject tmp = null;
        Boolean needUser = false;
        Boolean needThread = false;
        Boolean needForum = false;
        UserDAO userDAO = new UserDAO(connection);
        try {

            Long limit;
            if(input.has("limit"))
                limit = input.getLong("limit");
            else limit = Main.dbInfo.STANDART_MYSQL_MAX_LIMIT;

            String order;
            if(input.has("order"))
                order = input.getString("order");
            else order = "desc";

            Long since_id;
            if(input.has("since_id"))
                since_id = input.getLong("since_id");
            else since_id = 0L;


            array = new JSONArray();
            String shortName = input.getString("forum");
            cs = connection.prepareCall("{ call forumListUserByForumShortName(?, ?, ?, ?) }");
            cs.setObject(1, shortName);
            cs.setObject(2, limit);
            cs.setObject(3, order);
            cs.setObject(4, since_id);
            rs = cs.executeQuery();
            while (rs.next()) {
                UserDAO.getUserFromResultSet(userDataset, rs);
                tmp = userDAO.detailsById(userDataset.id);
                array.put(tmp);
            }

            return array;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
            if(rs != null)
                rs.close();
        }
    }

}
