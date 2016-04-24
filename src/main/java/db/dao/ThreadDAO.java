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
        return null;
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
        CallableStatement csGetThread = null;
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
            csGetThread = connection.prepareCall("{ call getThreadById(?) }");
            csGetThread.setObject(1, id);
            rsGetThread = csGetThread.executeQuery();
            rsGetThread.next();
            getThreadFromResultSet(threadDataset, rsGetThread);
            res = threadDataset.toJSONObject();

            Long posts = 0L;
            rsGetThread.close();
            csGetNumPosts = connection.prepareCall("{ call getNumOfPostsByThreadId(?) }");
            csGetNumPosts.setObject(1, id);
            rsGetNumOfPosts = csGetNumPosts.executeQuery();
            rsGetNumOfPosts.next();
            posts = rsGetNumOfPosts.getLong(1);
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
                csGetThread.close();
            if(rsGetNumOfPosts != null)
                rsGetThread.close();
        }
    }

    public JSONArray list (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        PostDataset postDataset = new PostDataset();
        ResultSet rs = null;
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
                String founderEmail = input.getString("thread");
                cs = connection.prepareCall("{ call threadListThreadsByFounderEmail(?, ?, ?, ?) }");
                cs.setObject(1, founderEmail);
                cs.setObject(2, limit);
                cs.setObject(3, order);
                cs.setObject(4, sinceDate);
                rs = cs.executeQuery();
                while (rs.next()) {
                    PostDAO.getPostFromResultSet(postDataset, rs);
                    tmp = postDataset.toJSONObject();
                    tmp.put("forum", rs.getString("shortName"));
                    tmp.put("user", founderEmail);
                    array.put(tmp);
                }

            }
            else if(input.has("forum")) {
                String forumShortname = input.getString("forum");
                cs = connection.prepareCall("{ call threadListThreadsByParentForum(?, ?, ?, ?) }");
                cs.setObject(1, forumShortname);
                cs.setObject(2, limit);
                cs.setObject(3, order);
                cs.setObject(4, sinceDate);
                rs = cs.executeQuery();
                while (rs.next()) {
                    PostDAO.getPostFromResultSet(postDataset, rs);
                    tmp = postDataset.toJSONObject();
                    tmp.put("forum", forumShortname);
                    tmp.put("user", rs.getString("email"));
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
        }
    }

    public JSONArray listPosts (JSONObject input) throws SQLException {
        CallableStatement cs = null;
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
                cs = connection.prepareCall("{ call threadListPostsFlat(?, ?, ?, ?) }");
                cs.setObject(1, idThread);
                cs.setObject(2, limit);
                cs.setObject(3, order);
                cs.setObject(4, sinceDate);
                rs = cs.executeQuery();
            }
            else if(sort.equals("tree")) {
                cs = connection.prepareCall("{ call threadListPostsTree(?, ?, ?, ?) }");
                cs.setObject(1, idThread);
                cs.setObject(2, limit);
                cs.setObject(3, order);
                cs.setObject(4, sinceDate);
                rs = cs.executeQuery();
            }
            else if(sort.equals("parent_tree")) {
                cs = connection.prepareCall("{ call threadListPostsParentTree(?, ?, ?, ?) }");
                cs.setObject(1, idThread);
                cs.setObject(2, limit);
                cs.setObject(3, order);
                cs.setObject(4, sinceDate);
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
            String slug = input.getString("slug");
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
