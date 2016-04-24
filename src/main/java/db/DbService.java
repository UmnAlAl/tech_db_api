package db;

import db.dao.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by Installed on 10.04.2016.
 */
public class DbService {

    private DbConnector dbConnector;

    public DbService(String hostname, String port, String dbName, String driverName,
                     String login, String password) {
        dbConnector = new DbConnector(hostname, port, dbName, driverName, login, password);
    }

    /*Commons******************************************************************************************************/
    public JSONObject clear(JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            CommonDAO commonDAO = new CommonDAO(connection);
            String s = commonDAO.clear();
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", s);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject status(JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            CommonDAO commonDAO = new CommonDAO(connection);
            response = commonDAO.status();
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    /*Forum******************************************************************************************************/
    public JSONObject forumCreate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ForumDAO forumDAO = new ForumDAO(connection);
            response = forumDAO.create(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject forumDetails (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ForumDAO forumDAO = new ForumDAO(connection);
            response = forumDAO.details(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject forumListPosts (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ForumDAO forumDAO = new ForumDAO(connection);
            response = forumDAO.listPosts(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject forumListThreads (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ForumDAO forumDAO = new ForumDAO(connection);
            response = forumDAO.listThreads(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject forumListUsers (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ForumDAO forumDAO = new ForumDAO(connection);
            response = forumDAO.listUsers(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    /*Post******************************************************************************************************/
    public JSONObject postCreate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.create(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject postDetails (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.details(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            switch (ex.getSQLState()) {
                case "S1000" : {
                    res.put("code", 1);
                    res.put("response", ex.getMessage());
                }
                break;
                default: {
                    res.put("code", 4);
                    res.put("response", ex.getMessage());
                }
                break;
            }
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject postList (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.list(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject postRemove (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.remove(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject postRestore (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.restore(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject postUpdate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.update(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject postVote (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.vote(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    /*User******************************************************************************************************/
    public JSONObject userCreate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.create(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            switch (ex.getSQLState()) {
                case "23000" : {
                    res.put("code", 5);
                    res.put("response", "Such user already exists.");
                    return res;
                }
                default: {
                    res.put("code", 4);
                    res.put("response", ex.getMessage());
                    return res;
                }
            }//switch
        }//catch
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject userDetails (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.details(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject userFollow (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.follow(input.getString("follower"), input.getString("followee"));
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject userListFollowers (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.listFollowers(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject userListFollowing (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.listFollowing(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject userListPosts (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.listPosts(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject userUnfollow (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.unfollow(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject userUpdateProfile (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.updateProfile(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    /*Thread******************************************************************************************************/
    public JSONObject threadClose (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.close(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadCreate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.create(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadDetails (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.details(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            switch (ex.getMessage()) {
                case "related thread" : {
                    res.put("code", 3);
                    res.put("response", ex.getMessage());
                }
                break;
                default: {
                    res.put("code", 3);
                    res.put("response", ex.getMessage());
                }
            }
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadList (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.list(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadListPosts (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.listPosts(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadOpen (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.open(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadRemove (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.remove(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadRestore (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.restore(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadSubscribe (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.subscribe(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadUnsubscribe (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.unsubscribe(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadUpdate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.update(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

    public JSONObject threadVote (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            connection.setAutoCommit(false);
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.vote(input);
            connection.commit();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            try {
                connection.rollback();
            }
            catch (Exception ignore) {

            }
            return res;
        }
        catch (JSONException ex) {
            res.put("code", 2);
            res.put("response", ex.getMessage());
            return res;
        }
        finally {
            try {
                connection.close();
            }
            catch (Exception ignore) {

            }
        }
    }

}
