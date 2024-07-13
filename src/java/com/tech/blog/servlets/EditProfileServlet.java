package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@MultipartConfig
public class EditProfileServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String about = request.getParameter("about");
        Part part = request.getPart("profile_picture");
        String imageName = part.getSubmittedFileName();

        // GET HTTP SESSION

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setAbout(about);
        String oldImage = user.getProfilePicture();
        user.setProfilePicture(imageName);


        UserDao dao = new UserDao(ConnectionProvider.getConnection());
        if (dao.updateUser(user)) {
            String path = request.getServletContext().getRealPath("/") + "profile-picture" + File.separator + user.getProfilePicture();
            String oldImagePath = request.getServletContext().getRealPath("/") + "profile-picture" + File.separator + oldImage;

            if (!oldImage.equals("default.jpg"))
                Helper.deleteFile(oldImagePath);

            if (Helper.uploadFile(part.getInputStream(), path)) {
                Message message = new Message("Profile Updated", "success", "alert-success");
                session.setAttribute("msg", message);
            } else {
                Message message = new Message("Unable to upload file!", "success", "alert-success");
                session.setAttribute("msg", message);
            }
        } else {
            Message message = new Message("Unable to update profile!", "success", "alert-success");
            session.setAttribute("msg", message);
        }

        response.sendRedirect("profile.jsp");
    }


// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
