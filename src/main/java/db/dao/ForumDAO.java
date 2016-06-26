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

        Statement csGetForum = null;
        ResultSet rsGetForum = null;
        try {
            shortName = input.getString("forum");
            csGetForum = connection.createStatement();
            rsGetForum = csGetForum.executeQuery(
                    String.format("SELECT * FROM forum WHERE forum.shortName = '%s'", shortName)
            );
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
        Statement csGetForum = null;
        ResultSet rsGetForum = null;
        JSONObject jsGetUser = null;
        JSONObject jsGetForum = null;
        ForumDataset forumDataset = new ForumDataset();
        UserDAO userDAO = new UserDAO(connection);
        JSONObject res = null;
        try {
            csGetForum = connection.createStatement();
            rsGetForum = csGetForum.executeQuery(
                    String.format("SELECT * FROM forum WHERE forum.id = %d", id)
            );
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
        Statement cs = null;
        Statement csForumId = null;
        ForumDataset forumDataset = new ForumDataset();
        PostDataset postDataset = new PostDataset();
        ResultSet rs = null;
        ResultSet rsForumId = null;
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

            csForumId = connection.createStatement();
            String s = String.format("SELECT forum.id FROM forum WHERE forum.shortName = '%s'", shortName);
            rsForumId = csForumId.executeQuery(
                    String.format("SELECT forum.id FROM forum WHERE forum.shortName = '%s'", shortName)
            );
            rsForumId.next();
            Long forumId = rsForumId.getLong("id");

            //forumListPostsByForumShortName
            cs = connection.createStatement();
            if(order.equals("desc")) {
                rs = cs.executeQuery(
                        String.format("SELECT * FROM post WHERE post.idForum = %d AND post.date >= '%s' ORDER BY post.date DESC LIMIT %d",
                                forumId,
                                sinceDate,
                                limit
                        )
                );
            }
            else {
                rs = cs.executeQuery(
                        String.format("SELECT * FROM post WHERE post.idForum = %d AND post.date >= '%s' ORDER BY post.date ASC LIMIT %d",
                                forumId,
                                sinceDate,
                                limit
                        )
                );
            }
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
            if(csForumId != null)
                csForumId.close();
            if(rsForumId != null)
                rsForumId.close();
        }
    }

    public JSONArray listThreads (JSONObject input) throws SQLException {
        Statement cs = null;
        Statement csForumId = null;
        ThreadDataset threadDataset = new ThreadDataset();
        ResultSet rs = null;
        ResultSet rsForumId = null;
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

            csForumId = connection.createStatement();
            rsForumId = csForumId.executeQuery(
                    String.format("SELECT forum.id FROM forum WHERE forum.shortName = '%s'", shortName)
            );
            rsForumId.next();
            Long forumId = rsForumId.getLong("id");

            //forumListThreadsByForumShortName
            cs = connection.createStatement();
            if(order.equals("desc")) {
                rs = cs.executeQuery(
                        String.format("SELECT * FROM thread WHERE thread.idForum = %d AND thread.date >= '%s' ORDER BY thread.date DESC LIMIT %d",
                                forumId,
                                sinceDate,
                                limit
                        )
                );
            }
            else {
                rs = cs.executeQuery(
                        String.format("SELECT * FROM thread WHERE thread.idForum = %d AND thread.date >= '%s' ORDER BY thread.date ASC LIMIT %d",
                                forumId,
                                sinceDate,
                                limit
                        )
                );
            }
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
            if(csForumId != null)
                csForumId.close();
            if(rsForumId != null)
                rsForumId.close();
        }
    }

    public JSONArray listUsers (JSONObject input) throws SQLException {
        Statement cs = null;
        Statement csForumId = null;
        UserDataset userDataset = new UserDataset();
        ResultSet rs = null;
        ResultSet rsForumId = null;
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

            csForumId = connection.createStatement();
            rsForumId = csForumId.executeQuery(
                    String.format("SELECT forum.id FROM forum WHERE forum.shortName = '%s'", shortName)
            );
            rsForumId.next();
            Long forumId = rsForumId.getLong("id");

            //forumListUserByForumShortName
            cs = connection.createStatement();
            if(order.equals("desc")) {
                rs = cs.executeQuery(
                        String.format("SELECT u1.* FROM post AS p1 JOIN user AS u1 ON p1.idUser = u1.id WHERE p1.idForum = %d AND p1.idUser >= %d GROUP BY p1.idUser ORDER BY p1.name DESC LIMIT %d",
                                forumId,
                                since_id,
                                limit
                        )
                );
            }
            else {
                rs = cs.executeQuery(
                        String.format("SELECT u1.* FROM post AS p1 JOIN user AS u1 ON p1.idUser = u1.id WHERE p1.idForum = %d AND p1.idUser >= %d GROUP BY p1.idUser ORDER BY p1.name ASC LIMIT %d",
                                forumId,
                                since_id,
                                limit
                        )
                );
            }

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
            if(csForumId != null)
                csForumId.close();
            if(rsForumId != null)
                rsForumId.close();
        }
    }

}
