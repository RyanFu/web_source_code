/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet.album;

/**
 *
 * @author voenix
 */
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logic.IUser;
import logic.EntityFactory;
import logic.datatype.PostEvent;

@WebServlet(name = "AlbumPostServlet", urlPatterns = {"/albumpost"})
public class AlbumPostServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int vid = Integer.parseInt(request.getParameter("vid"));
       
        int cid = Integer.parseInt(request.getParameter("cid"));
       
        int uid = Integer.parseInt(request.getParameter("uid"));
        IUser user = EntityFactory.getUser(uid);

        PostEvent post = new PostEvent();
        post.setVideoid(vid);
        post.setGroupid(cid);
        post.setUserid(uid);

        user.postToChannel(post);
        Integer result = user.commit();

        response.setContentType("text/xml");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        StringBuilder sb = new StringBuilder();
        PrintWriter out = response.getWriter();

        try {
            if (result > 0) {
                sb.append("已成功添加到我的专辑!");
            }
            else
            {
                sb.append("很遗憾，添加视频到我的专辑失败!");
            }
        } finally {
            out.write("<postreply>" + sb + "</postreply>");
            out.close();
        }
    }

       // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "This servlet is used for user creating album";
    }// </editor-fold>

}
