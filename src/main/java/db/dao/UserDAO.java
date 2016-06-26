package db.dao;

import db.dataset.PostDataset;
import db.dataset.UserDataset;
import main.Main;
import org.json.JSONArray;
import org.json.JSONObject;

import java.sql.*;

/**
 * Created by Installed on 10.04.2016.
 */
public class UserDAO {

    private Connection connection;

    public UserDAO(Connection con) {connection = con;}

    public static void getUserFromResultSet(UserDataset userDataset, ResultSet rs) throws SQLException {
        userDataset.id = rs.getLong("id");
        userDataset.email = rs.getString("email");
        userDataset.name = rs.getString("name");
        userDataset.username = rs.getString("username");
        userDataset.about = rs.getString("about");
        userDataset.isAnonymous = rs.getInt("isAnonymous");
    }

    public JSONObject create (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        UserDataset userDataset = new UserDataset();
        try {

            String email = input.getString("email");

            String username;
            if(input.get("username") instanceof String)
                username = input.getString("username");
            else username = null;

            String name;
            if(input.get("name") instanceof String)
                name = input.getString("name");
            else name = null;

            String about;
            if(input.get("about") instanceof String)
                about = input.getString("about");
            else about = null;

            int isAnonymous = input.getBoolean("isAnonymous") == true ? 1 : 0;

            cs = connection.prepareCall("{ ? = call userCreate(?, ?, ?, ?, ?) }");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.setObject(2, email);
            cs.setObject(3, username);
            cs.setObject(4, name);
            cs.setObject(5, about);
            cs.setObject(6, isAnonymous);
            cs.execute();

            long userId = cs.getLong(1);
            userDataset.id = userId;
            userDataset.email = email;
            userDataset.username = username;
            userDataset.name = name;
            userDataset.about = about;
            userDataset.isAnonymous = isAnonymous;
            return userDataset.toJSONObject();
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject details(JSONObject input) throws SQLException {
        String email = input.getString("user");
        return detailsByEmail(email);
    }

    public JSONObject detailsByEmail(String userEmail) throws SQLException {
        PreparedStatement csGetUser = null;
        ResultSet rsGetUser = null;
        UserDataset userDataset = new UserDataset();
        try {
            //csGetUser = connection.prepareCall("{ call getUserByEmail(?) }");
            csGetUser = connection.prepareStatement("SELECT * FROM user WHERE user.email = ?");
            csGetUser.setObject(1, userEmail);
            rsGetUser = csGetUser.executeQuery();
            rsGetUser.next();
            getUserFromResultSet(userDataset, rsGetUser);
            return detailsById(userDataset.id);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(csGetUser != null)
                csGetUser.close();
            if(rsGetUser != null)
                rsGetUser.close();
        }
    }

    public JSONObject detailsById(long userId) throws SQLException {
        PreparedStatement csGetUser = null;
        PreparedStatement csGetFollowers = null;
        PreparedStatement csGetFollowees = null;
        PreparedStatement csGetSubscriptions = null;
        ResultSet rsGetUser = null;
        ResultSet rsGetFollowers = null;
        ResultSet rsGetFollowees = null;
        ResultSet rsGetSubscriptions = null;
        UserDataset userDataset = new UserDataset();
        JSONObject res = null;
        try {
            csGetUser = connection.prepareStatement("SELECT * FROM user WHERE user.id = ?");
            csGetUser.setObject(1, userId);
            rsGetUser = csGetUser.executeQuery();
            rsGetUser.next();
            if(rsGetUser.isAfterLast()) {
                throw new SQLException("user not found");
            }

            getUserFromResultSet(userDataset, rsGetUser);
            /*userDataset.id = rsGetUser.getLong("id");
            userDataset.email = rsGetUser.getString("email");
            userDataset.name = rsGetUser.getString("name");
            userDataset.username = rsGetUser.getString("username");
            userDataset.about = rsGetUser.getString("about");
            userDataset.isAnonymous = rsGetUser.getInt("isAnonymous");*/

            //csGetFollowers = connection.prepareStatement("{ call userGetEmailsOfFollowersByUserId(?) }");
            csGetFollowers = connection.prepareStatement("SELECT  userFollowers.emailFollower FROM userFollowers USE INDEX(userGetEmailsOfFollowersByUserId_idx) WHERE userFollowers.idFollowee = ?");
            csGetFollowers.setObject(1, userDataset.id);
            rsGetFollowers = csGetFollowers.executeQuery();
            JSONArray arrayOfFollowers = new JSONArray();
            while (rsGetFollowers.next()) {
                arrayOfFollowers.put(rsGetFollowers.getString("emailFollower"));
            }

            //csGetFollowees = connection.prepareStatement("{ call userGetEmailsOfFolloweesByUserId(?) }");
            csGetFollowees = connection.prepareStatement("SELECT  userFollowers.emailFollowee FROM userFollowers USE INDEX(userGetEmailsOfFolloweesByUserId_idx) WHERE userFollowers.idFollower = ?");
            csGetFollowees.setObject(1, userDataset.id);
            rsGetFollowees = csGetFollowees.executeQuery();
            JSONArray arrayOfFollowees = new JSONArray();
            while (rsGetFollowees.next()) {
                arrayOfFollowees.put(rsGetFollowees.getString("emailFollowee"));
            }

            //csGetSubscriptions = connection.prepareStatement("{ call userGetSubscriptionsByUserId(?) }");
            csGetSubscriptions = connection.prepareStatement("SELECT  (idThread) FROM threadSubscribers WHERE idUser = ?");
            csGetSubscriptions.setObject(1, userDataset.id);
            rsGetSubscriptions = csGetSubscriptions.executeQuery();
            JSONArray arrayOfSubscriptions = new JSONArray();
            while (rsGetSubscriptions.next()) {
                arrayOfSubscriptions.put(rsGetSubscriptions.getLong("idThread"));
            }

            res = userDataset.toJSONObject();
            res.put("followers", arrayOfFollowers);
            res.put("following", arrayOfFollowees);
            res.put("subscriptions", arrayOfSubscriptions);
            return res;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(csGetUser != null)
                csGetUser.close();
            if(csGetFollowers != null)
                csGetFollowers.close();
            if(csGetFollowees != null)
                csGetFollowees.close();
            if(csGetSubscriptions != null)
                csGetSubscriptions.close();
            if(rsGetUser != null)
                rsGetUser.close();
            if(rsGetFollowers != null)
                rsGetFollowers.close();
            if(rsGetFollowees != null)
                rsGetFollowees.close();
            if(rsGetSubscriptions != null)
                rsGetSubscriptions.close();
        }
    }

    public JSONObject follow(String emailFollower, String emailFollowee) throws SQLException {
        CallableStatement cs = null;
        UserDataset userDataset = new UserDataset();
        try {

            cs = connection.prepareCall("{ call userFollow(?, ?) }");
            cs.setObject(1, emailFollower);
            cs.setObject(2, emailFollowee);
            cs.execute();

            return detailsByEmail(emailFollower);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONArray listFollowers(JSONObject input) throws SQLException {
        PreparedStatement cs = null;
        PreparedStatement csUserId = null;
        UserDataset userDataset = new UserDataset();
        ResultSet rs = null;
        ResultSet rsUserId = null;
        JSONArray array = null;
        try {
            String userEmail = input.getString("user");

            Long limit;
            if(input.has("limit"))
                limit = input.getLong("limit");
            else limit = Main.dbInfo.STANDART_MYSQL_MAX_LIMIT;

            String order;
            if(input.has("order"))
                order = input.getString("order");
            else order = "desc";

            Long sinceId;
            if(input.has("since_id"))
                sinceId = input.getLong("since_id");
            else sinceId = 0L;

            csUserId = connection.prepareStatement("SELECT user.id FROM user WHERE user.email = ?");
            csUserId.setObject(1, userEmail);
            rsUserId = csUserId.executeQuery();
            rsUserId.next();
            Long userIdFollowee = rsUserId.getLong("id");

            //userListFollowersIdsByUserEmail
            if(order.equals("desc")) {
                cs = connection.prepareStatement(
                        "SELECT DISTINCT u2.id FROM user AS u1 JOIN userFollowers AS f ON u1.id = ? AND u1.id = f.idFollowee JOIN user AS u2 ON f.idFollower = u2.id WHERE u2.id >= ? ORDER BY u2.name DESC LIMIT ?"
                );
            }
            else {
                cs = connection.prepareStatement(
                        "SELECT DISTINCT u2.id FROM user AS u1 JOIN userFollowers AS f ON u1.id = ? AND u1.id = f.idFollowee JOIN user AS u2 ON f.idFollower = u2.id WHERE u2.id >= ? ORDER BY u2.name ASC LIMIT ?"
                );
            }
            cs.setObject(1, userIdFollowee);
            cs.setObject(2, sinceId);
            cs.setObject(3, limit);
            rs = cs.executeQuery();

            array = new JSONArray();
            while (rs.next()) {
                long userId = rs.getLong("id");
                array.put(detailsById(userId));
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
            if(csUserId != null)
                csUserId.close();
            if(rsUserId != null)
                rsUserId.close();
        }
    }

    public JSONArray listFollowing(JSONObject input) throws SQLException {
        PreparedStatement cs = null;
        PreparedStatement csUserId = null;
        UserDataset userDataset = new UserDataset();
        ResultSet rs = null;
        ResultSet rsUserId = null;
        JSONArray array = null;
        try {
            String userEmail = input.getString("user");

            Long limit;
            if(input.has("limit"))
                limit = input.getLong("limit");
            else limit = Main.dbInfo.STANDART_MYSQL_MAX_LIMIT;

            String order;
            if(input.has("order"))
                order = input.getString("order");
            else order = "desc";

            Long sinceId;
            if(input.has("since_id"))
                sinceId = input.getLong("since_id");
            else sinceId = 0L;

            csUserId = connection.prepareStatement("SELECT user.id FROM user WHERE user.email = ?");
            csUserId.setObject(1, userEmail);
            rsUserId = csUserId.executeQuery();
            rsUserId.next();
            Long userIdFollower = rsUserId.getLong("id");

            //userListFolloweesIdsByUserEmail
            if(order.equals("desc")) {
                cs = connection.prepareStatement(
                        "SELECT DISTINCT u2.id FROM user AS u1 JOIN userFollowers AS f ON u1.id = ? AND u1.id = f.idFollower JOIN user AS u2 ON f.idFollowee = u2.id WHERE u2.id >= ? ORDER BY u2.name DESC LIMIT ?"
                );
            }
            else {
                cs = connection.prepareStatement(
                        "SELECT DISTINCT u2.id FROM user AS u1 JOIN userFollowers AS f ON u1.id = ? AND u1.id = f.idFollower JOIN user AS u2 ON f.idFollowee = u2.id WHERE u2.id >= ? ORDER BY u2.name ASC LIMIT ?"
                );
            }
            cs.setObject(1, userIdFollower);
            cs.setObject(2, sinceId);
            cs.setObject(3, limit);
            rs = cs.executeQuery();

            array = new JSONArray();
            while (rs.next()) {
                long userId = rs.getLong("id");
                array.put(detailsById(userId));
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
            if(csUserId != null)
                csUserId.close();
            if(rsUserId != null)
                rsUserId.close();
        }
    }

    public JSONArray listPosts(JSONObject input) throws SQLException {
        PreparedStatement cs = null;
        PreparedStatement csUserId = null;
        PostDataset postDataset = new PostDataset();
        ResultSet rs = null;
        ResultSet rsUserId = null;
        JSONArray array = null;
        JSONObject tmp = null;
        try {
            String userEmail = input.getString("user");

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

            csUserId = connection.prepareStatement("SELECT user.id FROM user WHERE user.email = ?");
            csUserId.setObject(1, userEmail);
            rsUserId = csUserId.executeQuery();
            rsUserId.next();
            Long userId = rsUserId.getLong("id");

            //userListPostsByUserEmail
            if(order.equals("desc")) {
                cs = connection.prepareStatement(
                        "SELECT p.* FROM post AS p WHERE p.idUser = ? AND p.date >= ? ORDER BY p.date DESC LIMIT ?"
                );
            }
            else {
                cs = connection.prepareStatement(
                        "SELECT p.* FROM post AS p WHERE p.idUser = ? AND p.date >= ? ORDER BY p.date ASC LIMIT ?"
                );
            }
            cs.setObject(1, userId);
            cs.setObject(2, sinceDate);
            cs.setObject(3, limit);
            rs = cs.executeQuery();

            array = new JSONArray();
            while (rs.next()) {
                PostDAO.getPostFromResultSet(postDataset, rs);
                tmp = postDataset.toJSONObject();
                tmp.put("forum", rs.getString("shortName"));
                tmp.put("user", userEmail);
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
            if(csUserId != null)
                csUserId.close();
            if(rsUserId != null)
                rsUserId.close();
        }
    }

    public JSONObject unfollow(JSONObject input) throws SQLException {
        CallableStatement cs = null;
        UserDataset userDataset = new UserDataset();
        try {
            String emailFollower = input.getString("follower");
            String emailFollowee = input.getString("followee");
            cs = connection.prepareCall("{ call userUnfollow(?, ?) }");
            cs.setObject(1, emailFollower);
            cs.setObject(2, emailFollowee);
            cs.execute();

            return detailsByEmail(emailFollower);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject updateProfile(JSONObject input) throws SQLException {
        CallableStatement cs = null;
        UserDataset userDataset = new UserDataset();
        try {
            String email = input.getString("user");
            String name = input.getString("name");
            String about = input.getString("about");
            cs = connection.prepareCall("{ call userUpdateByEmail(?, ?, ?) }");
            cs.setObject(1, email);
            cs.setObject(2, name);
            cs.setObject(3, about);
            cs.execute();

            return detailsByEmail(email);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }
}
