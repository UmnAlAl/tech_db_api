package frontend;

import db.DbService;
import frontend.utils.RequestParser;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Installed on 23.04.2016.
 */
public class CommonServlet extends HttpServlet {

    private DbService dbService;

    public CommonServlet(DbService dbService) {this.dbService = dbService;}

    @Override
    public void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws ServletException, IOException {
        JSONObject jsonBody = RequestParser.parseRequestBody(request.getReader());

    }

}
