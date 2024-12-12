/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.24
 * Generated at: 2024-12-12 06:08:48 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports,
                 org.apache.jasper.runtime.JspSourceDirectives {

  private static final jakarta.servlet.jsp.JspFactory _jspxFactory =
          jakarta.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(3);
    _jspx_imports_packages.add("jakarta.servlet");
    _jspx_imports_packages.add("jakarta.servlet.http");
    _jspx_imports_packages.add("jakarta.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile jakarta.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public boolean getErrorOnELNotFound() {
    return false;
  }

  public jakarta.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final jakarta.servlet.http.HttpServletRequest request, final jakarta.servlet.http.HttpServletResponse response)
      throws java.io.IOException, jakarta.servlet.ServletException {

    if (!jakarta.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final jakarta.servlet.jsp.PageContext pageContext;
    jakarta.servlet.http.HttpSession session = null;
    final jakarta.servlet.ServletContext application;
    final jakarta.servlet.ServletConfig config;
    jakarta.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    jakarta.servlet.jsp.JspWriter _jspx_out = null;
    jakarta.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"vi\">\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <title>Đăng nhập</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/login.css\">\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css\">\r\n");
      out.write("\r\n");
      out.write("    <!-- Google Sign-In Meta -->\r\n");
      out.write("    <meta name=\"google-signin-client_id\"\r\n");
      out.write("          content=\"161137938230-6h6mbfajcfra9avc0762peh4556202hq.apps.googleusercontent.com\">\r\n");
      out.write("\r\n");
      out.write("    <style>\r\n");
      out.write("        .login-form-container {\r\n");
      out.write("            max-width: 500px;\r\n");
      out.write("            margin: auto;\r\n");
      out.write("            padding: 30px;\r\n");
      out.write("            border: 1px solid #ccc;\r\n");
      out.write("            border-radius: 8px;\r\n");
      out.write("            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\r\n");
      out.write("            background: gainsboro;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .login-form {\r\n");
      out.write("            display: flex;\r\n");
      out.write("            flex-direction: column;\r\n");
      out.write("            padding: 20px;\r\n");
      out.write("            border: 1px solid #ccc;\r\n");
      out.write("            border-radius: 8px;\r\n");
      out.write("            background-color: #fff;\r\n");
      out.write("            width: 60%;\r\n");
      out.write("            margin: auto;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .login-form h2 {\r\n");
      out.write("            text-align: center;\r\n");
      out.write("            margin-bottom: 20px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .login-form label {\r\n");
      out.write("            margin-bottom: 5px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .login-form input {\r\n");
      out.write("            padding: 10px;\r\n");
      out.write("            margin-bottom: 15px;\r\n");
      out.write("            border: 1px solid #ccc;\r\n");
      out.write("            border-radius: 4px;\r\n");
      out.write("            font-size: 14px;\r\n");
      out.write("            width: 95%;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .btn {\r\n");
      out.write("            padding: 10px;\r\n");
      out.write("            border-radius: 4px;\r\n");
      out.write("            cursor: pointer;\r\n");
      out.write("            font-size: 14px;\r\n");
      out.write("            display: flex;\r\n");
      out.write("            align-items: center;\r\n");
      out.write("            justify-content: center;\r\n");
      out.write("            border: 1px solid #ccc;\r\n");
      out.write("            width: 100%;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .submit-btn {\r\n");
      out.write("            border-radius: 5px;\r\n");
      out.write("            height: 40px;\r\n");
      out.write("            width: 100%;\r\n");
      out.write("            background-color: red;\r\n");
      out.write("            color: white;\r\n");
      out.write("            border: none;\r\n");
      out.write("            margin-bottom: 10px;\r\n");
      out.write("            font-size: 16px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .submit-btn:hover {\r\n");
      out.write("            background-color: darkred;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .btn-facebook {\r\n");
      out.write("            background-color: white;\r\n");
      out.write("            color: black;\r\n");
      out.write("            margin: 5px 0;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .btn-facebook i {\r\n");
      out.write("            margin-right: 8px;\r\n");
      out.write("            color: #3b5998;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .social-login {\r\n");
      out.write("            text-align: center;\r\n");
      out.write("            margin: 20px 0;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .link {\r\n");
      out.write("            text-align: center;\r\n");
      out.write("            margin-top: 20px;\r\n");
      out.write("        }\r\n");
      out.write("    </style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("<div class=\"login-form-container\">\r\n");
      out.write("    <div class=\"login-form\" style=\"width: 70%\">\r\n");
      out.write("        <h2>Đăng nhập để tiếp tục</h2>\r\n");
      out.write("        <form action=\"login\" method=\"post\">\r\n");
      out.write("            <label for=\"username\">Tên đăng nhập:</label>\r\n");
      out.write("            <input type=\"text\" id=\"username\" name=\"username\" required>\r\n");
      out.write("\r\n");
      out.write("            <label for=\"password\">Mật khẩu:</label>\r\n");
      out.write("            <input type=\"password\" id=\"password\" name=\"password\" required>\r\n");
      out.write("\r\n");
      out.write("            <button type=\"submit\" class=\"submit-btn\">Đăng nhập</button>\r\n");
      out.write("        </form>\r\n");
      out.write("\r\n");
      out.write("        <!-- Error message display -->\r\n");
      out.write("        ");

            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        
      out.write("\r\n");
      out.write("        <p class=\"error-message\" style=\"color: red;\">");
      out.print( errorMessage );
      out.write("\r\n");
      out.write("        </p>\r\n");
      out.write("        ");

            }
        
      out.write("\r\n");
      out.write("\r\n");
      out.write("        <div class=\"social-login\">\r\n");
      out.write("            <p>Hoặc đăng nhập bằng:</p>\r\n");
      out.write("            <button class=\"btn btn-facebook\" onclick=\"checkLoginState()\">\r\n");
      out.write("                <i class=\"fab fa-facebook-f\"></i> Đăng nhập bằng Facebook\r\n");
      out.write("            </button>\r\n");
      out.write("            <div id=\"g_id_onload\"\r\n");
      out.write("                 data-client_id=\"161137938230-6h6mbfajcfra9avc0762peh4556202hq.apps.googleusercontent.com\"\r\n");
      out.write("                 data-login_uri=\"http://localhost:8080/Batdongsan/loginWithGoogle\">\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"g_id_signin\" data-type=\"standard\"></div>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <div class=\"link\">\r\n");
      out.write("            <p>Bạn chưa có tài khoản? <a href=\"register.jsp\">Đăng ký ngay</a> | <a href=\"forgot-password.jsp\">Quên mật\r\n");
      out.write("                khẩu?</a></p>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<script src=\"https://accounts.google.com/gsi/client\" async defer></script>\r\n");
      out.write("<script src=\"https://connect.facebook.net/en_US/sdk.js\"></script>\r\n");
      out.write("<script>\r\n");
      out.write("    window.fbAsyncInit = function () {\r\n");
      out.write("        FB.init({\r\n");
      out.write("            appId: '1773989986680875',\r\n");
      out.write("            cookie: true,\r\n");
      out.write("            xfbml: true,\r\n");
      out.write("            version: 'v15.0'\r\n");
      out.write("        });\r\n");
      out.write("    };\r\n");
      out.write("\r\n");
      out.write("    function checkLoginState() {\r\n");
      out.write("        FB.getLoginStatus(function (response) {\r\n");
      out.write("            statusChangeCallback(response);\r\n");
      out.write("        });\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    function statusChangeCallback(response) {\r\n");
      out.write("        if (response.status === 'connected') {\r\n");
      out.write("            fetchUserData();\r\n");
      out.write("        } else {\r\n");
      out.write("            FB.login(function (response) {\r\n");
      out.write("                if (response.authResponse) {\r\n");
      out.write("                    fetchUserData();\r\n");
      out.write("                }\r\n");
      out.write("            }, {scope: 'public_profile,email'});\r\n");
      out.write("        }\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    function fetchUserData() {\r\n");
      out.write("        FB.api('/me', {fields: 'id,name,email'}, function (response) {\r\n");
      out.write("            const xhr = new XMLHttpRequest();\r\n");
      out.write("            xhr.open(\"POST\", \"/LoginServlet\", true);\r\n");
      out.write("            xhr.setRequestHeader(\"Content-Type\", \"application/x-www-form-urlencoded\");\r\n");
      out.write("            xhr.send(`facebookId=${response.id}&name=${response.name}&email=${response.email}`);\r\n");
      out.write("\r\n");
      out.write("            xhr.onreadystatechange = function () {\r\n");
      out.write("                if (xhr.readyState === 4 && xhr.status === 200) {\r\n");
      out.write("                    window.location.href = \"welcome\";\r\n");
      out.write("                }\r\n");
      out.write("            };\r\n");
      out.write("        });\r\n");
      out.write("    }\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("    // Google Sign-In setup\r\n");
      out.write("    google.accounts.id.initialize({\r\n");
      out.write("        client_id: \"161137938230-6h6mbfajcfra9avc0762peh4556202hq.apps.googleusercontent.com\",\r\n");
      out.write("        callback: handleCredentialResponse\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("    // Handle the response from Google\r\n");
      out.write("    function handleCredentialResponse(response) {\r\n");
      out.write("        fetch('/loginWithGoogle', {\r\n");
      out.write("            method: 'POST',\r\n");
      out.write("            headers: {'Content-Type': 'application/x-www-form-urlencoded'},\r\n");
      out.write("            body: `credential=${response.credential}`\r\n");
      out.write("        })\r\n");
      out.write("            .then(res => res.text())\r\n");
      out.write("            .then(data => {\r\n");
      out.write("                console.log('Login successful', data);\r\n");
      out.write("                window.location.href = \"welcome\"; // Redirect after successful login\r\n");
      out.write("            })\r\n");
      out.write("            .catch(error => console.error(\"Error:\", error));\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    // Render the Google Sign-In button\r\n");
      out.write("    google.accounts.id.renderButton(\r\n");
      out.write("        document.getElementById(\"g_id_onload\"),\r\n");
      out.write("        { theme: \"outline\", size: \"large\" }\r\n");
      out.write("    );\r\n");
      out.write("\r\n");
      out.write("    google.accounts.id.prompt();\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof jakarta.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
