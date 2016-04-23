package db;

import db.dao.*;
import org.json.JSONArray;
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
            CommonDAO commonDAO = new CommonDAO(connection);
            String s = commonDAO.clear();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", s);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject status(JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            CommonDAO commonDAO = new CommonDAO(connection);
            response = commonDAO.status();
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    /*Forum******************************************************************************************************/
    public JSONObject forumCreate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ForumDAO forumDAO = new ForumDAO(connection);
            response = forumDAO.create(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject forumDetails (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ForumDAO forumDAO = new ForumDAO(connection);
            response = forumDAO.details(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject forumListPosts (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            ForumDAO forumDAO = new ForumDAO(connection);
            response = forumDAO.listPosts(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject forumListThreads (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            ForumDAO forumDAO = new ForumDAO(connection);
            response = forumDAO.listThreads(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject forumListUsers (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            ForumDAO forumDAO = new ForumDAO(connection);
            response = forumDAO.listUsers(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    /*Post******************************************************************************************************/
    public JSONObject postCreate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.create(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject postDetails (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.details(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject postList (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.list(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject postRemove (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.remove(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject postRestore (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.restore(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject postUpdate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.update(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject postVote (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            PostDAO postDAO = new PostDAO(connection);
            response = postDAO.vote(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    /*User******************************************************************************************************/
    public JSONObject userCreate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.create(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject userDetails (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.details(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject userFollow (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.follow(input.getString("follower"), input.getString("followee"));
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject userListFollowers (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.listFollowers(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject userListFollowing (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.listFollowing(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject userListPosts (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.listPosts(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject userUnfollow (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.unfollow(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject userUpdateProfile (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            UserDAO userDAO = new UserDAO(connection);
            response = userDAO.updateProfile(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    /*Thread******************************************************************************************************/
    public JSONObject threadClose (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.close(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadCreate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.create(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadDetails (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.details(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadList (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.list(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadListPosts (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONArray response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.listPosts(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadOpen (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.open(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadRemove (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.remove(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadRestore (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.restore(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadSubscribe (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.subscribe(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadUnsubscribe (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.unsubscribe(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadUpdate (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.update(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

    public JSONObject threadVote (JSONObject input) {
        Connection connection = null;
        JSONObject res = new JSONObject();
        JSONObject response;
        try {
            connection = dbConnector.getConnection();
            ThreadDAO threadDAO = new ThreadDAO(connection);
            response = threadDAO.vote(input);
            res = new JSONObject();
            res.put("code", 0);
            res.put("response", response);
            return res;
        }
        catch (SQLException ex) {
            res.put("code", 4);
            res.put("response", ex.getMessage());
            return res;
        }
    }

}
