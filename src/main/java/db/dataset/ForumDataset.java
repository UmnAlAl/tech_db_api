package db.dataset;

import org.json.JSONObject;

/**
 * Created by Installed on 10.04.2016.
 */
public class ForumDataset {

    public long id;
    public long idUser;
    public String name;
    public String shortName;

    public JSONObject toJSONObject() {
        JSONObject forum = new JSONObject();
        forum.put("id", id);
        forum.put("name", name);
        forum.put("short_name", shortName);
        return forum;
    }

    public void fromJSONObject(JSONObject forum) {
        name = forum.getString("name");
        shortName = forum.getString("short_name");
    }
}
