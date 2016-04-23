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
 * Created by Installed on 24.04.2016.
 */
public class GlobalServlet extends HttpServlet {

    private DbService dbService;

    public GlobalServlet(DbService dbService) {this.dbService = dbService;}

    @Override
    public void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws ServletException, IOException {
        JSONObject jsonReq = RequestParser.parseRequestBody(request.getReader());
        String[] splittedUri = request.getRequestURI().split("/");
        JSONObject jsonRes = handlePost(splittedUri, jsonReq);
        response.getWriter().println(jsonRes.toString(4));
    }

    @Override
    public void doGet(HttpServletRequest request,
                       HttpServletResponse response) throws ServletException, IOException {
        JSONObject result;
        String last = request.getRequestURI();
        last = last.substring(last.lastIndexOf('/') + 1, last.length());


    }


    public JSONObject handleGet(String[] splittedUri, HttpServletRequest request) {
        JSONObject data = new JSONObject();
        if(splittedUri.length == 4) {
            switch (splittedUri[3]) {
                case "status" : return dbService.status(null);
            }
        }
        else if(splittedUri.length > 4) {

            switch (splittedUri[3]) {
                case "forum" : {
                    switch (splittedUri[4]) {
                        case "details" :
                            return  dbService.forumCreate(data);
                        case "listPosts" :
                            return  dbService.forumCreate(data);
                        case "listThreads" :
                            return  dbService.forumCreate(data);
                        case "listUsers" :
                            return  dbService.forumCreate(data);
                    }
                }//case forum
                break;
                case "post" : {
                    switch (splittedUri[4]) {
                        case "details" :
                            return dbService.postCreate(data);
                        case "list" :
                            return dbService.postRemove(data);

                    }
                }//case post
                break;
                case "user" : {
                    switch (splittedUri[4]) {
                        case "details" :
                            return dbService.userCreate(data);
                        case "listFollowers" :
                            return dbService.userFollow(data);
                        case "listFollowing" :
                            return dbService.userUnfollow(data);
                        case "listPosts" :
                            return dbService.userUpdateProfile(data);
                    }
                }//case user
                break;
                case "thread" : {
                    switch (splittedUri[4]) {
                        case "details" :
                            return dbService.threadClose(data);
                        case "list" :
                            return dbService.threadCreate(data);
                        case "listPosts" :
                            return dbService.threadOpen(data);

                    }
                }//case thread
                break;
            }//else-switch


        }

        JSONObject defaultResponse = new JSONObject("{}");
        return defaultResponse;
    }



    public JSONObject handlePost(String[] splittedUri, JSONObject data) {
        if(splittedUri.length == 4) {
            switch (splittedUri[3]) {
                case "clear" : return dbService.clear(data);
            }
        }
        else if (splittedUri.length > 4) {
            switch (splittedUri[3]) {
                case "forum" : {
                    switch (splittedUri[4]) {
                        case "create" :
                            return  dbService.forumCreate(data);
                    }
                }//case forum
                    break;
                case "post" : {
                    switch (splittedUri[4]) {
                        case "create" :
                            return dbService.postCreate(data);
                        case "remove" :
                            return dbService.postRemove(data);
                        case "restore" :
                            return dbService.postRestore(data);
                        case "update" :
                            return dbService.postUpdate(data);
                        case "vote" :
                            return dbService.postVote(data);

                    }
                }//case post
                    break;
                case "user" : {
                    switch (splittedUri[4]) {
                        case "create" :
                            return dbService.userCreate(data);
                        case "follow" :
                            return dbService.userFollow(data);
                        case "unfollow" :
                            return dbService.userUnfollow(data);
                        case "updateProfile" :
                            return dbService.userUpdateProfile(data);
                    }
                }//case user
                    break;
                case "thread" : {
                    switch (splittedUri[4]) {
                        case "close" :
                            return dbService.threadClose(data);
                        case "create" :
                            return dbService.threadCreate(data);
                        case "open" :
                            return dbService.threadOpen(data);
                        case "remove" :
                            return dbService.threadRemove(data);
                        case "restore" :
                            return dbService.threadRestore(data);
                        case "subscribe" :
                            return dbService.threadSubscribe(data);
                        case "unsubscribe" :
                            return dbService.threadUnsubscribe(data);
                        case "update" :
                            return dbService.threadUpdate(data);
                        case "vote" :
                            return dbService.threadVote(data);

                    }
                }//case thread
                    break;
            }//else-switch
        }//else-if
        JSONObject defaultResponse = new JSONObject("{}");
        return defaultResponse;
    }//func

}
