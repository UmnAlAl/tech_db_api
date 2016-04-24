package frontend;

import db.DbService;
import frontend.utils.RequestParser;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

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
        response.setContentType("text/html;charset=utf-8");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().println(jsonRes.toString(4));
    }

    @Override
    public void doGet(HttpServletRequest request,
                       HttpServletResponse response) throws ServletException, IOException {
        String[] splittedUri = request.getRequestURI().split("/");
        JSONObject jsonRes = handleGet(splittedUri, request);
        response.setContentType("text/html;charset=utf-8");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().println(jsonRes.toString(4));
    }


    public JSONObject handleGet(String[] splittedUri, HttpServletRequest request) {
        JSONObject data = parseHttpGetRequest(request);
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
                            return  dbService.forumDetails(data);
                        case "listPosts" :
                            return  dbService.forumListPosts(data);
                        case "listThreads" :
                            return  dbService.forumListThreads(data);
                        case "listUsers" :
                            return  dbService.forumListUsers(data);
                    }
                }//case forum
                break;
                case "post" : {
                    switch (splittedUri[4]) {
                        case "details" :
                            return dbService.postDetails(data);
                        case "list" :
                            return dbService.postList(data);

                    }
                }//case post
                break;
                case "user" : {
                    switch (splittedUri[4]) {
                        case "details" :
                            return dbService.userDetails(data);
                        case "listFollowers" :
                            return dbService.userListFollowers(data);
                        case "listFollowing" :
                            return dbService.userListFollowing(data);
                        case "listPosts" :
                            return dbService.userListPosts(data);
                    }
                }//case user
                break;
                case "thread" : {
                    switch (splittedUri[4]) {
                        case "details" :
                            return dbService.threadDetails(data);
                        case "list" :
                            return dbService.threadList(data);
                        case "listPosts" :
                            return dbService.threadListPosts(data);

                    }
                }//case thread
                break;
            }//else-switch


        }

        JSONObject defaultResponse = new JSONObject("{}");
        return defaultResponse;
    }

    public JSONObject parseHttpGetRequest(HttpServletRequest request) {
        Map<String, String> paramsNamesAndVals = new HashMap<>();
        Enumeration<String> paramsNames =  request.getParameterNames();
        JSONArray related = new JSONArray();
        for (String s : Collections.list(paramsNames)) {
            if(!s.equals("related")) {
                paramsNamesAndVals.put(s, request.getParameter(s));
            }
            else {
                String[] relatedStrArr = request.getParameterValues(s);
                related = new JSONArray(relatedStrArr);
            }
        }
        JSONObject result = new JSONObject(paramsNamesAndVals);
        result.put("related", related);
        return result;
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
