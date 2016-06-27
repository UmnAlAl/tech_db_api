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
public class PostDAO {

    private Connection connection;

    public PostDAO(Connection connection) {this.connection = connection;}

    public static void getPostFromResultSet(PostDataset postDataset, ResultSet rs) throws SQLException {
        postDataset.id = rs.getLong("id");
        postDataset.date = rs.getString("date");
        postDataset.date = postDataset.date.substring(0, postDataset.date.lastIndexOf('.'));
        postDataset.idParent = rs.getObject("idParent") == null ? null : rs.getLong("idParent");
        postDataset.idThread = rs.getLong("idThread");
        postDataset.idUser = rs.getLong("idUser");
        postDataset.idForum = rs.getLong("idForum");
        postDataset.likes = rs.getLong("likes");
        postDataset.dislikes = rs.getLong("dislikes");
        postDataset.message = rs.getString("message");
        postDataset.isApproved = rs.getInt("isApproved");
        postDataset.isDeleted = rs.getInt("isDeleted");
        postDataset.isEdited = rs.getInt("isEdited");
        postDataset.isHighlighted = rs.getInt("isHighlighted");
        postDataset.isSpam = rs.getInt("isSpam");
        /*
        {
            "date": "2014-01-03 00:01:01",
            "dislikes": 0,
            "forum": "forum1",
            "id": 4,
            "isApproved": true,
            "isDeleted": false,
            "isEdited": false,
            "isHighlighted": false,
            "isSpam": false,
            "likes": 0,
            "message": "my message 1",
            "parent": null,
            "points": 0,
            "thread": 3,
            "user": "example@mail.ru"
        }
        */
    }

    public JSONObject create (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        PostDataset postDataset = new PostDataset();
        try {

            String user = input.getString("user");
            String forum = input.getString("forum");
            postDataset.fromJSONObject(input);


            /*
            CREATE FUNCTION `postCreate` (postIdThread INT,
								postAuthorEmail VARCHAR(255),
                                postForumShortName VARCHAR(255),
                                postIdParent INT,
                                postDate TIMESTAMP,
                                postMessage TEXT,
								postIsApproved TINYINT,
                                postIsHighlighted TINYINT,
                                postIsEdited TINYINT,
                                postIsSpam TINYINT,
                                postIsDeleted TINYINT)
            */


            cs = connection.prepareCall("{ ? = call postCreate(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.setObject(2, postDataset.idThread);
            cs.setObject(3, user);
            cs.setObject(4, forum);
            cs.setObject(5, postDataset.idParent);
            cs.setObject(6, postDataset.date);
            cs.setObject(7, postDataset.message);
            cs.setObject(8, postDataset.isApproved);
            cs.setObject(9, postDataset.isHighlighted);
            cs.setObject(10, postDataset.isEdited);
            cs.setObject(11, postDataset.isSpam);
            cs.setObject(12, postDataset.isDeleted);
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
        boolean needThread = false;
        boolean needForum = false;
        long id = -1;

        CallableStatement csGetPost = null;
        ResultSet rsGetPost = null;
        UserDataset postDataset = new UserDataset();
        try {
            id = input.getLong("post");
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
            return detailsById(id, needUser, needThread, needForum);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(csGetPost != null)
                csGetPost.close();
            if(rsGetPost != null)
                rsGetPost.close();
        }
    }

    public JSONObject detailsById (long id,
                                   boolean needUser,
                                   boolean needThread,
                                   boolean needForum) throws SQLException {
        Statement csGetPost = null;
        ResultSet rsGetPost = null;
        JSONObject jsGetPost = null;
        JSONObject jsGetUser = null;
        JSONObject jsGetThread = null;
        JSONObject jsGetForum = null;
        PostDataset postDataset = new PostDataset();
        UserDAO userDAO = new UserDAO(connection);
        ThreadDAO threadDAO = new ThreadDAO(connection);
        ForumDAO forumDAO = new ForumDAO(connection);
        JSONObject res = null;
        try {
            csGetPost = connection.createStatement();
            rsGetPost = csGetPost.executeQuery(
                    String.format("SELECT * FROM post WHERE post.id = %d", id)
            );
            rsGetPost.next();

            getPostFromResultSet(postDataset, rsGetPost);
            res = postDataset.toJSONObject();

            jsGetUser = userDAO.detailsById(postDataset.idUser);
            if(needUser) {
                res.put("user", jsGetUser);
            }
            else {
                res.put("user", jsGetUser.get("email"));
            }

            if(needThread) {
                jsGetThread = threadDAO.detailsById(postDataset.idThread, false, false);
                res.put("thread", jsGetThread);
            }
            else {
                res.put("thread", postDataset.idThread);
            }

            jsGetForum = forumDAO.detailsById(postDataset.idForum, false);
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
            if(csGetPost != null)
                csGetPost.close();
            if(rsGetPost != null)
                rsGetPost.close();
        }
    }

    public JSONArray list (JSONObject input) throws SQLException, Exception {
        Statement cs = null;
        Statement csForumId = null;
        PostDataset postDataset = new PostDataset();
        ResultSet rs = null;
        ResultSet rsForumId = null;
        JSONArray array = null;
        JSONObject tmp = null;
        try {

            if(input.has("post"))
                throw new Exception("Semantic error.");

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
            if(input.has("thread")) {
                Long idThread = input.getLong("thread");

                //postListByThreadId
                cs = connection.createStatement();
                if(order.equals("desc")) {
                    rs = cs.executeQuery(
                            String.format("SELECT p.* FROM post AS p WHERE p.idThread = %d AND p.date >= '%s' ORDER BY p.date DESC LIMIT %d",
                                    idThread,
                                    sinceDate,
                                    limit
                            )
                    );
                }
                else {
                    rs = cs.executeQuery(
                            String.format("SELECT p.* FROM post AS p WHERE p.idThread = %d AND p.date >= '%s' ORDER BY p.date ASC LIMIT %d",
                                    idThread,
                                    sinceDate,
                                    limit
                            )
                    );
                }

            }
            else if(input.has("forum")) {
                String shortName = input.getString("forum");

                csForumId = connection.createStatement();
                String s = String.format("SELECT forum.id FROM forum WHERE forum.shortName = '%s'", shortName);
                rsForumId = csForumId.executeQuery(
                        String.format("SELECT forum.id FROM forum WHERE forum.shortName = '%s'", shortName)
                );
                rsForumId.next();
                Long forumId = rsForumId.getLong("id");

                //postListByForumShortName
                cs = connection.createStatement();
                if(order.equals("desc")) {
                    rs = cs.executeQuery(
                            String.format("SELECT p.* FROM post AS p WHERE p.idForum = %d AND p.date >= '%s' ORDER BY p.date DESC LIMIT %d",
                                    forumId,
                                    sinceDate,
                                    limit
                            )
                    );
                }
                else {
                    rs = cs.executeQuery(
                            String.format("SELECT p.* FROM post AS p WHERE p.idForum = %d AND p.date >= '%s' ORDER BY p.date ASC LIMIT %d",
                                    forumId,
                                    sinceDate,
                                    limit
                            )
                    );
                }
            }

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
            if(csForumId != null)
                csForumId.close();
            if(rsForumId != null)
                rsForumId.close();
        }
    }

    public JSONObject remove (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        PostDataset postDataset = new PostDataset();
        try {

            Long id = input.getLong("post");
            cs = connection.prepareCall("{ call postRemoveDirectly(?) }");
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
        PostDataset postDataset = new PostDataset();
        try {

            Long id = input.getLong("post");
            cs = connection.prepareCall("{ call postRestoreDirectly(?) }");
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

    public JSONObject update (JSONObject input) throws SQLException {
        CallableStatement cs = null;
        PostDataset postDataset = new PostDataset();
        try {

            Long id = input.getLong("post");
            String message = input.getString("message");
            cs = connection.prepareCall("{ call postUpdate(?, ?) }");
            cs.setObject(1, id);
            cs.setObject(2, message);
            cs.execute();
            return detailsById(id, false, false, false);
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
        PostDataset postDataset = new PostDataset();
        try {

            Long id = input.getLong("post");
            int vote = input.getInt("vote");
            cs = connection.prepareCall("{ call postVote(?, ?) }");
            cs.setObject(1, id);
            cs.setObject(2, vote);
            cs.execute();
            return detailsById(id, false, false, false);
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
