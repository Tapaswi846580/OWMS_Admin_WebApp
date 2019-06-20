package com.Controller;

import java.io.Console;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Model.Admin;

@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	PreparedStatement ps;
	Connection con;
	ResultSet rs;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	void doConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://remotemysql.com:3306/kgJukQ0geQ", "kgJukQ0geQ",
					"haebUrLDc8");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	void doConnectionDb4free() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://db4free.net:3306/orientation_week", "tapaswi", "9c01735b");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		String btn = request.getParameter("btn");
		if (btn == null) {
			request.getRequestDispatcher("Login.jsp").forward(request, response);
			request.getSession().invalidate();
		} else if (btn.equals("Login")) {
			String emailId = request.getParameter("txtemail");
			String password = request.getParameter("txtpass");
			if (emailId.length() != 0 && password.length() != 0) {
				try {
					doConnection();
					ps = con.prepareStatement("Select * from tbl_admin_details where Email_Id=? and Password=?");
					ps.setString(1, emailId);
					ps.setString(2, password);
					rs = ps.executeQuery();
					if (rs.next()) {
						request.setAttribute("user",emailId);
						request.getRequestDispatcher("HomePage.jsp").forward(request, response);
					} else {
//						request.getRequestDispatcher("/Login.jsp").forward(request, response);
						response.getWriter().println("<script>alert('Invalid Login credentials'); "
								+ "window.location.href = \"Login.jsp\" </script>");
					}
					con.close();
				} catch (Exception e) {
					try {
						con.close();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					e.printStackTrace();					
				}
			} else {
				response.getWriter().println("<script>alert('All fields are mandatory'); "
						+ "window.location.href = \"Login.jsp\" </script>");
			}

		} else if (btn.equals("Insert")) {
			String data = request.getParameter("data");
			String group = request.getParameter("group");
			if (data.length() == 0) {
				response.setContentType("text/plain");
				response.getWriter().write("Please enter values into the textbox");
			} else {
				doConnection();
				try {
					String[] emails = data.split("\n");
					System.out.println(emails[0]);
					doConnection();
					String query = "INSERT INTO tbl_group_details (Email_Id, Grp, Batch) SELECT * FROM"
							+ " (SELECT ?, ?, ?) AS tmp WHERE NOT EXISTS "
							+ "(SELECT Email_Id FROM tbl_group_details WHERE Email_Id = ?) LIMIT 1;";
					// String query2 = "INSERT INTO tbl_group_details values(?,?)";
					con.setAutoCommit(false);
					ps = con.prepareStatement(query);
					StringBuilder rejectedEmails = new StringBuilder();
					
					for (String str : emails) {
						if (str.contains("@ahduni.edu.in")) {
							ps.setString(1, str);
							ps.setString(2, group);
							ps.setString(3, "Batch1");   //Set the batch here
							ps.setString(4, str);
							ps.addBatch();
						} else {
							rejectedEmails.append(str + "\n");
						}
					}
					if (ps.executeBatch().length > 0) {
						if (rejectedEmails.length() == 0) {
							response.setContentType("text/plain");
							response.getWriter().write("Inserted.....");
						}else {
							response.setContentType("text/plain");
							response.getWriter().write("Inserted except following email ID(s):\n"+rejectedEmails.toString());
						}
					} else {
						response.setContentType("text/plain");
						response.getWriter().write("Error while inserting records, please try again");
					}
					con.commit();
					con.close();
				} catch (SQLException e) {
					try {
						con.rollback();
						con.close();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				} catch (Exception e) {
					try {
						con.close();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					e.printStackTrace();
					response.setContentType("text/plain");
					response.getWriter().write("Error while inserting records, please try again");
				}
			}
		}else if (btn.equals("LogOut")) {
			request.setAttribute("user", null);
			response.getWriter().write("done");
		}
	}

	@Override
	protected void finalize() throws Throwable {
		// TODO Auto-generated method stub
		super.finalize();
		con.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

}
