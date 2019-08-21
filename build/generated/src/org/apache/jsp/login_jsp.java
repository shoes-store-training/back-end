package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("\n");
      out.write("<head>\n");
      out.write("  <!--Required meta tags-->\n");
      out.write("  <meta charset=\"UTF-8\">\n");
      out.write("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">\n");
      out.write("  <!-- Title Page-->\n");
      out.write("  <title>Login Shoes Shop</title>\n");
      out.write("  <!-- Font special for pages-->\n");
      out.write("  <link\n");
      out.write("    href=\"https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i\"\n");
      out.write("    rel=\"stylesheet\">\n");
      out.write("  <!-- Main CSS-->\n");
      out.write("  <link href=\"../css/login&register.css\" rel=\"stylesheet\" media=\"all\">\n");
      out.write("</head>\n");
      out.write("\n");
      out.write("<body>\n");
      out.write("  <div class=\"page-wrapper bg-gra-02 p-t-130 p-b-100 font-poppins\">\n");
      out.write("    <div class=\"wrapper wrapper--w500\">\n");
      out.write("      <div class=\"card card-4\">\n");
      out.write("        <div class=\"card-body\">\n");
      out.write("          <div class=\"row row-space\">\n");
      out.write("            <div class=\"logo\">\n");
      out.write("              <img src=\"../img/anhs.png\" alt=\"logo\" style=\"height: 100px; width: auto\">\n");
      out.write("            </div>\n");
      out.write("          </div>    \n");
      out.write("          <form name=\"loginForm\" action=\"login\" method=\"post\">\n");
      out.write("            <div class=\"input-group\">\n");
      out.write("              <input class=\"input--style-4\" type=\"text\" id=\"username\" name=\"username\" placeholder=\"Username\">\n");
      out.write("            </div>\n");
      out.write("            <div class=\"input-group\">\n");
      out.write("              <input class=\"input--style-4\" type=\"password\" id=\"password\" name=\"password\" placeholder=\"Password\">\n");
      out.write("            </div>\n");
      out.write("            <div class=\"row row-space\">\n");
      out.write("              <button id=\"loginButton\" class=\"btn btn--radius-2 btn--blue\" style=\"width: 100%\"\n");
      out.write("                type=\"submit\">Login</button>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"input-group\">\n");
      out.write("              <a class=\"suport-login\" href=\"\">Forgot password?</a>\n");
      out.write("              <a class=\"suport-login\" href=\"register.html\">Sign up!</a>\n");
      out.write("            </div>\n");
      out.write("          </form>\n");
      out.write("        </div>\n");
      out.write("      </div>\n");
      out.write("    </div>\n");
      out.write("  </div>\n");
      out.write("  <div id=\"snackbar\">This is snackbar</div>\n");
      out.write("\n");
      out.write("  <!-- Main JS-->\n");
      out.write("  <script src=\"../js/login.js\"></script>\n");
      out.write("</body>\n");
      out.write("\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
