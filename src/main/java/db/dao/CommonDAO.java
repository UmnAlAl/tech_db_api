package db.dao;

import db.dataset.UserDataset;
import org.json.JSONObject;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by Installed on 23.04.2016.
 */
public class CommonDAO {

    private Connection connection;

    public CommonDAO (Connection connection) {this.connection = connection;}

    public String clear() throws SQLException {
        CallableStatement cs = null;
        try {
            cs = connection.prepareCall("{ call clear() }");
            cs.execute();

            return "OK";
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            if(cs != null)
                cs.close();
        }
    }

    public JSONObject status() throws SQLException {
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            cs = connection.prepareCall("{ call status() }");
            rs = cs.executeQuery();
            rs.next();
            JSONObject res = new JSONObject();
            res.put("user", rs.getLong("u"));
            res.put("thread", rs.getLong("t"));
            res.put("forum", rs.getLong("f"));
            res.put("post", rs.getLong("p"));
            return res;
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

}
