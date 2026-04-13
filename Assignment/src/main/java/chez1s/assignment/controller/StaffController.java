package chez1s.assignment.controller;

import chez1s.assignment.entity.User;
import chez1s.assignment.service.StaffService;
import chez1s.assignment.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/manager/staff", "/manager/staff/form", "/manager/staff/save", "/manager/staff/status", "/manager/staff/delete"})
public class StaffController extends HttpServlet {
    private final StaffService staffService = new StaffService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        
        if (uri.contains("/status")) {
            staffService.updateStatus(ParamUtil.getInt(req, "id"), ParamUtil.getInt(req, "active") == 1);
            resp.sendRedirect(req.getContextPath() + "/employee/pos?tab=users");
            return;
        }

        if (uri.contains("/delete")) {
            int id = ParamUtil.getInt(req, "id");
            chez1s.assignment.entity.User current = chez1s.assignment.util.AuthUtil.getUser(req);
            if (current != null && current.getId() != null && current.getId().equals(id)) {
                req.getSession().setAttribute("error", "Không thể xoá tài khoản đang đăng nhập.");
            } else {
                try {
                    staffService.deleteStaff(id);
                } catch (Exception e) {
                    req.getSession().setAttribute("error", "Không thể xoá nhân viên: " + e.getMessage());
                }
            }
            resp.sendRedirect(req.getContextPath() + "/employee/pos?tab=users");
            return;
        }

        if (uri.contains("/form")) {
            int id = ParamUtil.getInt(req, "id");
            if (id > 0) req.setAttribute("staff", staffService.getStaffById(id));
            req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("staffList", staffService.getAllStaff());
        req.getRequestDispatcher("/views/staff/staff-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = ParamUtil.getInt(req, "id");
        User staff = (id > 0) ? staffService.getStaffById(id) : new User();

        staff.setFullName(ParamUtil.getString(req, "fullName"));
        staff.setPhone(ParamUtil.getString(req, "phone"));
        staff.setActive(ParamUtil.getInt(req, "active") == 1);
        staff.setRole(Boolean.parseBoolean(ParamUtil.getString(req, "role")));

        if (id == 0) {
            staff.setEmail(ParamUtil.getString(req, "email"));
            staff.setPassword(ParamUtil.getString(req, "password"));
            
            if (staffService.getStaffByEmail(staff.getEmail()) != null) {
                req.getSession().setAttribute("error", "Email này đã được sử dụng!");
                resp.sendRedirect(req.getContextPath() + "/employee/pos?tab=users");
                return;
            }
            staffService.createStaff(staff);
        } else {
            staffService.updateStaff(staff);
        }
        
        resp.sendRedirect(req.getContextPath() + "/employee/pos?tab=users");
    }
}
