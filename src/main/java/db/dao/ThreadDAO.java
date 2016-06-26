package db.dao;

import db.dataset.PostDataset;
import db.dataset.ThreadDataset;
import db.dataset.UserDataset;
import main.Main;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.sql.*;

/**
 * Created by Installed on 10.04.2016.
 */
public class ThreadDAO {

    private Connection connection;

    public ThreadDAO(Connection connection) {this.connection = connection;}

    public static void getThreadFromResultSet(ThreadDataset threadDataset, ResultSet rs) throws SQLException {
        threadDataset.id = rs.getLong("id");
        threadDataset.date = rs.getString("date");
        threadDataset.date = threadDataset.date.substring(0, threadDataset.date.lastIndexOf('.'));
        threadDataset.idUser = rs.getLong("idUser");
        threadDataset.idForum = rs.getLong("idForum");
        threadDataset.title = rs.getString("title");
        threadDataset.message = rs.getString("message");
        threadDataset.slug = rs.getString("slug");
        threadDataset.likes = rs.getLong("likes");
        threadDataset.dislikes = rs.getLong("dislikes");
        threadDataset.isDeleted = rs.getInt("isDeleted");
        threadDataset.isClosed = rs.getInt("isClosed");
    }

    public JSONObject close (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        try {

            Long id = input.getLong("thread");
            cs = connection.prepareCall("{ call threadClose(?) }");
            cs.setObject(1, id);
            cs.execute();
            return input;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject create (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        ThreadDataset threadDataset = new ThreadDataset();
        try {

            String user = input.getString("user");
            String forum = input.getString("forum");
            threadDataset.fromJSONObject(input);


            /*
            CREATE FUNCTION `threadCreate` (threadParentForumShortName VARCHAR(255),
								threadTitle VARCHAR(255),
                                threadIsClosed TINYINT,
                                threadFounderEmail VARCHAR(255),
                                threadDate TIMESTAMP,
                                threadMessage TEXT,
								threadSlug VARCHAR(255),
                                threadIsDeleted TINYINT)
            */


            cs = connection.prepareCall("{ ? = call threadCreate(?, ?, ?, ?, ?, ?, ?, ?) }");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.setObject(2, forum);
            cs.setObject(3, threadDataset.title);
            cs.setObject(4, threadDataset.isClosed);
            cs.setObject(5, user);
            cs.setObject(6, threadDataset.date);
            cs.setObject(7, threadDataset.message);
            cs.setObject(8, threadDataset.slug);
            cs.setObject(9, threadDataset.isDeleted);
            cs.execute();

            long postId = cs.getLong(1);
            input.put("id", postId);
            return input;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject details (JSONObject input) throws SQLException {
        boolean needUser = false;
        boolean needForum = false;
        long id = -1;

        CallableStatement csGetThread = null;
        ResultSet rsGetThread = null;
        try {
            id = input.getLong("thread"); /*"id"*/
            if(input.has("related")) {
                JSONArray related = input.getJSONArray("related");
                for(Object i : related) {
                    switch ((String)i) {
                        case "user" : needUser = true;
                            break;
                        case "forum" : needForum = true;
                            break;
                        case "thread" :
                            throw new JSONException("related thread");
                    }
                }
            }
            return detailsById(id, needUser, needForum);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(csGetThread != null)
                csGetThread.close();
            if(rsGetThread != null)
                rsGetThread.close();
        }
    }

    public JSONObject detailsById (long id,
                                   boolean needUser,
                                   boolean needForum) throws SQLException {
        PreparedStatement csGetThread = null;
        CallableStatement csGetNumPosts = null;
        ResultSet rsGetThread = null;
        ResultSet rsGetNumOfPosts = null;
        JSONObject jsGetPost = null;
        JSONObject jsGetUser = null;
        JSONObject jsGetForum = null;
        ThreadDataset threadDataset = new ThreadDataset();
        UserDAO userDAO = new UserDAO(connection);
        ThreadDAO threadDAO = new ThreadDAO(connection);
        ForumDAO forumDAO = new ForumDAO(connection);
        JSONObject res = null;
        try {
            csGetThread = connection.prepareStatement(
                    "SELECT t1.*, IF(t1.isDeleted != 0, 0, t1.posts) AS cnt FROM thread AS t1 WHERE t1.id = ?"
            );
            csGetThread.setObject(1, id);
            rsGetThread = csGetThread.executeQuery();
            rsGetThread.next();
            getThreadFromResultSet(threadDataset, rsGetThread);
            res = threadDataset.toJSONObject();
            Long posts = rsGetThread.getLong("cnt");
            res.put("posts", posts);

            jsGetUser = userDAO.detailsById(threadDataset.idUser);
            if(needUser) {
                res.put("user", jsGetUser);
            }
            else {
                res.put("user", jsGetUser.get("email"));
            }

            jsGetForum = forumDAO.detailsById(threadDataset.idForum, false);
            if(needForum) {
                res.put("forum", jsGetForum);
            }
            else {
                res.put("forum", jsGetForum.get("short_name"));
            }

            return res;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(csGetThread != null)
                csGetThread.close();
            if(rsGetThread != null)
                rsGetThread.close();
            if(csGetNumPosts != null)
                csGetNumPosts.close();
            if(rsGetNumOfPosts != null)
                rsGetNumOfPosts.close();
        }
    }

    public JSONArray list (JSONObject input) throws SQLException {
        PreparedStatement cs = null;
        PreparedStatement csForumId = null;
        PreparedStatement csUserId = null;
        ThreadDataset threadDataset = new ThreadDataset();
        ResultSet rs = null;
        ResultSet rsForumId = null;
        ResultSet rsUserId = null;
        JSONArray array = null;
        JSONObject tmp = null;
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



            array = new JSONArray();
            if(input.has("user")) {
                String founderEmail = input.getString("user");

                csUserId = connection.prepareStatement("SELECT user.id FROM user WHERE user.email = ?");
                csUserId.setObject(1, founderEmail);
                rsUserId = csUserId.executeQuery();
                rsUserId.next();
                Long userId = rsUserId.getLong("id");

                //threadListThreadsByFounderEmail
                if(order.equals("desc")) {
                    cs = connection.prepareStatement(
                            "SELECT t.*, f.shortName, COUNT(*) as cnt FROM thread AS t JOIN post AS p ON p.idThread = t.id JOIN forum AS f ON f.id = t.idForum WHERE t.idUser = ? AND t.date >= ? GROUP BY t.id ORDER BY t.date DESC LIMIT ?"
                    );
                }
                else {
                    cs = connection.prepareStatement(
                            "SELECT t.*, f.shortName, COUNT(*) as cnt FROM thread AS t JOIN post AS p ON p.idThread = t.id JOIN forum AS f ON f.id = t.idForum WHERE t.idUser = ? AND t.date >= ? GROUP BY t.id ORDER BY t.date ASC LIMIT ?"
                    );
                }
                cs.setObject(1, userId);
                cs.setObject(2, sinceDate);
                cs.setObject(3, limit);
                rs = cs.executeQuery();

                while (rs.next()) {
                    ThreadDAO.getThreadFromResultSet(threadDataset, rs);
                    tmp = threadDataset.toJSONObject();
                    tmp.put("forum", rs.getString("shortName"));
                    tmp.put("user", founderEmail);
                    tmp.put("posts", rs.getLong("cnt"));
                    array.put(tmp);
                }

            }
            else if(input.has("forum")) {
                String shortName = input.getString("forum");

                csForumId = connection.prepareStatement("SELECT forum.id FROM forum WHERE forum.shortName = ?");
                csForumId.setObject(1, shortName);
                rsForumId = csForumId.executeQuery();
                rsForumId.next();
                Long forumId = rsForumId.getLong("id");

                //threadListThreadsByParentForum
                if(order.equals("desc")) {
                    cs = connection.prepareStatement(
                            "SELECT t.*, u.email, COUNT(*) as cnt FROM thread AS t JOIN post AS p ON p.idThread = t.id JOIN user AS u ON u.id = t.idUser WHERE t.idForum = ? AND t.date >= ? GROUP BY t.id ORDER BY t.date DESC LIMIT ?"
                    );
                }
                else {
                    cs = connection.prepareStatement(
                            "SELECT t.*, u.email, COUNT(*) as cnt FROM thread AS t JOIN post AS p ON p.idThread = t.id JOIN user AS u ON u.id = t.idUser WHERE t.idForum = ? AND t.date >= ? GROUP BY t.id ORDER BY t.date ASC LIMIT ?"
                    );
                }
                cs.setObject(1, forumId);
                cs.setObject(2, sinceDate);
                cs.setObject(3, limit);
                rs = cs.executeQuery();

                while (rs.next()) {
                    ThreadDAO.getThreadFromResultSet(threadDataset, rs);
                    tmp = threadDataset.toJSONObject();
                    tmp.put("forum", shortName);
                    tmp.put("user", rs.getString("email"));
                    tmp.put("posts", rs.getLong("cnt"));
                    array.put(tmp);
                }
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
            if(csUserId != null)
                csUserId.close();
            if(rsUserId != null)
                rsUserId.close();
        }
    }

    public JSONArray listPosts (JSONObject input) throws SQLException {
        PreparedStatement cs = null;
        PostDataset postDataset = new PostDataset();
        ResultSet rs = null;
        JSONArray array = null;
        JSONObject tmp = null;
        try {
            Long idThread = input.getLong("thread");

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

            String sort;
            if(input.has("sort")) {
                sort = input.getString("sort");
            }
            else
                sort = "flat";


            if(sort.equals("flat")) {
                //threadListPostsFlat
                if(order.equals("desc")) {
                    cs = connection.prepareStatement(
                            "SELECT p.* FROM post AS p WHERE p.idThread = ? AND p.date >= ? ORDER BY p.date DESC LIMIT ?"
                    );
                }
                else {
                    cs = connection.prepareStatement(
                            "SELECT p.* FROM post AS p WHERE p.idThread = ? AND p.date >= ? ORDER BY p.date ASC LIMIT ?"
                    );
                }
                cs.setObject(1, idThread);
                cs.setObject(2, sinceDate);
                cs.setObject(3, limit);
                rs = cs.executeQuery();
            }
            else if(sort.equals("tree")) {
                //threadListPostsTree
                if(order.equals("desc")) {
                    cs = connection.prepareStatement(
                            "SELECT p.* FROM post AS p WHERE p.idThread = ? AND p.date >= ? ORDER BY firstIndex DESC, p.matPath ASC LIMIT ?"
                    );
                }
                else {
                    cs = connection.prepareStatement(
                            "SELECT p.* FROM post AS p WHERE p.idThread = ? AND p.date >= ? p.matPath ASC LIMIT ?"
                    );
                }
                cs.setObject(1, idThread);
                cs.setObject(2, sinceDate);
                cs.setObject(3, limit);
                rs = cs.executeQuery();
            }
            else if(sort.equals("parent_tree")) {
                //threadListPostsParentTree
                if(order.equals("desc")) {
                    cs = connection.prepareStatement(
                          "SELECT p1.* FROM post AS p1 WHERE p1.date >= ? AND p1.firstIndex IN ( SELECT * FROM ( SELECT DISTINCT post.firstIndex FROM post WHERE post.idThread = ? ORDER BY post.firstIndex DESC LIMIT ? ) AS p2) ORDER BY p1.firstIndex DESC, p1.matPath ASC"
                    );
                }
                else {
                    cs = connection.prepareStatement(
                            "SELECT p1.* FROM post AS p1 WHERE p1.date >= ? AND p1.firstIndex IN ( SELECT * FROM ( SELECT DISTINCT post.firstIndex FROM post WHERE post.idThread = ? ORDER BY post.firstIndex ASC LIMIT ? ) AS p2) ORDER BY p1.firstIndex ASC, p1.matPath ASC"
                    );
                }
                cs.setObject(1, sinceDate);
                cs.setObject(2, idThread);
                cs.setObject(3, limit);
                rs = cs.executeQuery();
            }

            array = new JSONArray();
            while (rs.next()) {
                PostDAO.getPostFromResultSet(postDataset, rs);
                tmp = postDataset.toJSONObject();
                tmp.put("forum", rs.getString("shortName"));
                tmp.put("user", rs.getString("email"));
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

    public JSONObject open (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        try {

            Long id = input.getLong("thread");
            cs = connection.prepareCall("{ call threadOpen(?) }");
            cs.setObject(1, id);
            cs.execute();
            return input;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject remove (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        try {

            Long id = input.getLong("thread");
            cs = connection.prepareCall("{ call threadRemove(?) }");
            cs.setObject(1, id);
            cs.execute();
            return input;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject restore (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        try {

            Long id = input.getLong("thread");
            cs = connection.prepareCall("{ call threadRestore(?) }");
            cs.setObject(1, id);
            cs.execute();
            return input;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject subscribe (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        try {

            Long idThread = input.getLong("thread");
            String email = input.getString("user");
            cs = connection.prepareCall("{ call threadSubscribe(?, ?) }");
            cs.setObject(1, email);
            cs.setObject(2, idThread);
            cs.execute();
            return input;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject unsubscribe (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        try {

            Long idThread = input.getLong("thread");
            String email = input.getString("user");
            cs = connection.prepareCall("{ call threadUnsubscribe(?, ?) }");
            cs.setObject(1, email);
            cs.setObject(2, idThread);
            cs.execute();
            return input;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject update (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        try {

            Long id = input.getLong("thread");
            String message = input.getString("message");
            String slug = input.getString("slug");
            cs = connection.prepareCall("{ call threadUpdate(?, ?, ?) }");
            cs.setObject(1, id);
            cs.setObject(2, slug);
            cs.setObject(3, message);
            cs.execute();
            return detailsById(id, false, false);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject vote (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        try {

            Long id = input.getLong("thread");
            int vote = input.getInt("vote");
            cs = connection.prepareCall("{ call threadVote(?, ?) }");
            cs.setObject(1, id);
            cs.setObject(2, vote);
            cs.execute();
            return detailsById(id, false, false);
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
