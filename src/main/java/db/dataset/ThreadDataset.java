package db.dataset;

import org.json.JSONObject;

/**
 * Created by Installed on 10.04.2016.
 */
public class ThreadDataset {

    public long id;
    public long idForum;
    public long idUser;
    public String title;
    public String date;
    public String message;
    public String slug;
    public int isClosed;
    public int isDeleted;
    public long likes;
    public long dislikes;

    public JSONObject toJSONObject() {
        JSONObject thread = new JSONObject();
        thread.put("id", id);
        thread.put("date", date);
        thread.put("message", message);
        thread.put("title", title);
        thread.put("slug", slug);
        thread.put("isClosed", isClosed != 0);
        thread.put("isDeleted", isDeleted != 0);
        thread.put("likes", likes);
        thread.put("dislikes", dislikes);
        thread.put("points", likes - dislikes);
        return thread;
    }

    public void fromJSONObject(JSONObject thread) {
        date = thread.getString("date");
        title = thread.getString("title");
        message = thread.getString("message");
        slug = thread.getString("slug");

        if(thread.has("isClosed")) {
            isClosed = (thread.getBoolean("isClosed") == true) ? 1 : 0;
        }
        else isClosed = 0;

        if(thread.has("isDeleted")) {
            isDeleted = (thread.getBoolean("isDeleted") == true) ? 1 : 0;
        }
        else isDeleted = 0;
    }
    
}
