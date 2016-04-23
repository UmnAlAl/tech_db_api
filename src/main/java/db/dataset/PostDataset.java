package db.dataset;

import org.json.JSONObject;

/**
 * Created by Installed on 10.04.2016.
 */
public class PostDataset {
    public long id;
    public long idThread;
    public long idUser;
    public long idForum;
    public Long idParent;
    public String date;
    public String message;
    public int isApproved;
    public int isHighlighted;
    public int isEdited;
    public int isSpam;
    public int isDeleted;
    public long likes;
    public long dislikes;

    public JSONObject toJSONObject() {
        JSONObject post = new JSONObject();
        post.put("id", id);
        post.put("idThred", idThread);
        post.put("parent", idParent == -1 ? null : idParent);
        post.put("date", date);
        post.put("message", message);
        post.put("isApproved", isApproved != 0);
        post.put("isHighlighted", isHighlighted != 0);
        post.put("isEdited", isEdited != 0);
        post.put("isSpam", isSpam != 0);
        post.put("isDeleted", isDeleted != 0);
        post.put("likes", likes);
        post.put("dislikes", dislikes);
        post.put("points", likes - dislikes);
        return post;
    }

    public void fromJSONObject(JSONObject post) {
        date = post.getString("date");
        message = post.getString("message");
        idThread = post.getLong("thread");

        if(post.has("idParent"))
            idParent = post.getLong("parent");
        else idParent = null;

        if(post.has("isApproved")) {
            isApproved = (post.getBoolean("isApproved") == true) ? 1 : 0;
        }
        else isApproved = 0;

        if(post.has("isHighlighted")) {
            isHighlighted = (post.getBoolean("isHighlighted") == true) ? 1 : 0;
        }
        else isHighlighted = 0;

        if(post.has("isEdited")) {
            isEdited = (post.getBoolean("isEdited") == true) ? 1 : 0;
        }
        else isEdited = 0;

        if(post.has("isSpam")) {
            isSpam = (post.getBoolean("isSpam") == true) ? 1 : 0;
        }
        else isSpam = 0;

        if(post.has("isDeleted")) {
            isDeleted = (post.getBoolean("isDeleted") == true) ? 1 : 0;
        }
        else isDeleted = 0;
    }
}
