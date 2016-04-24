package db.dataset;

import org.json.JSONObject;

/**
 * Created by Installed on 10.04.2016.
 */
public class UserDataset {
    public long id;
    public String email;
    public String username;
    public String name;
    public String about;
    public int isAnonymous;

    public JSONObject toJSONObject() {
        JSONObject user = new JSONObject();
        user.put("id", id);
        user.put("email", email);
        user.put("username", username == null ? JSONObject.NULL : username);
        user.put("name", name == null ? JSONObject.NULL : name);
        user.put("about", about == null ? JSONObject.NULL : about);
        user.put("isAnonymous", isAnonymous != 0);
        return user;
    }

    public void fromJSONObject(JSONObject user) {
        if(user.has("id")) {
            id = user.getLong("id");
        }
        email = user.getString("email");
        username = user.getString("username");
        name = user.getString("name");
        about = user.getString("about");
        if(user.has("isAnonymous")) {
            isAnonymous = (user.getBoolean("isAnonymous") == true) ? 1 : 0;
        }
        else isAnonymous = 0;
    }
}
