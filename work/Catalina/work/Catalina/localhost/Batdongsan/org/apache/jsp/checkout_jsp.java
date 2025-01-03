/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.12
 * Generated at: 2024-12-12 15:18:39 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;
import Entity.CartItem;
import java.util.List;
import Dao.CartItemDAO;
import java.sql.SQLException;

public final class checkout_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports,
                 org.apache.jasper.runtime.JspSourceDirectives {

  private static final jakarta.servlet.jsp.JspFactory _jspxFactory =
          jakarta.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("jakarta.servlet");
    _jspx_imports_packages.add("jakarta.servlet.http");
    _jspx_imports_packages.add("jakarta.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.util.List");
    _jspx_imports_classes.add("java.sql.SQLException");
    _jspx_imports_classes.add("Entity.CartItem");
    _jspx_imports_classes.add("Dao.CartItemDAO");
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"vi\">\r\n");
      out.write("<head>\r\n");
      out.write("    \r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <title>Thông tin đặt lịch</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/style.css\">\r\n");
      out.write("    <style>\r\n");
      out.write("        body {\r\n");
      out.write("            font-family: Arial, sans-serif;\r\n");
      out.write("            display: flex;\r\n");
      out.write("            justify-content: center;\r\n");
      out.write("            align-items: center;\r\n");
      out.write("            min-height: 100vh;\r\n");
      out.write("            background-color: antiquewhite;\r\n");
      out.write("            margin: 0;\r\n");
      out.write("            padding: 20px;\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .appointment-form {\r\n");
      out.write("            background: #fff;\r\n");
      out.write("            padding: 30px;\r\n");
      out.write("            border-radius: 10px;\r\n");
      out.write("            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);\r\n");
      out.write("            max-width: 450px;\r\n");
      out.write("            width: 100%;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .appointment-form h2 {\r\n");
      out.write("            text-align: center;\r\n");
      out.write("            margin-bottom: 25px;\r\n");
      out.write("            color: #333;\r\n");
      out.write("            font-size: 24px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .form-group {\r\n");
      out.write("            margin-bottom: 20px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .form-group label {\r\n");
      out.write("            display: block;\r\n");
      out.write("            margin-bottom: 8px;\r\n");
      out.write("            color: #333;\r\n");
      out.write("            font-weight: bold;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .form-group input,\r\n");
      out.write("        .form-group textarea,\r\n");
      out.write("        .form-group select {\r\n");
      out.write("            width: 100%;\r\n");
      out.write("            padding: 12px;\r\n");
      out.write("            border: 1px solid #ddd;\r\n");
      out.write("            border-radius: 5px;\r\n");
      out.write("            font-size: 16px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .form-group textarea {\r\n");
      out.write("            resize: vertical;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .submit-btn {\r\n");
      out.write("            width: 100%;\r\n");
      out.write("            padding: 12px;\r\n");
      out.write("            border: none;\r\n");
      out.write("            background-color: #007bff;\r\n");
      out.write("            color: #fff;\r\n");
      out.write("            font-size: 18px;\r\n");
      out.write("            border-radius: 5px;\r\n");
      out.write("            cursor: pointer;\r\n");
      out.write("            margin-top: 15px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .submit-btn:hover {\r\n");
      out.write("            background-color: #0056b3;\r\n");
      out.write("        }\r\n");
      out.write("    </style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<div class=\"appointment-form\">\r\n");
      out.write("\r\n");
      out.write("    ");

        String username = (String) session.getAttribute("username");
        Integer userId = (Integer) session.getAttribute("userId");
        List<CartItem> cartItems = null;

        if (userId != null) {
            CartItemDAO cartItemDAO = new CartItemDAO();
            try {
                cartItems = cartItemDAO.getCartItemsByUserId(userId);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    
      out.write("\r\n");
      out.write("    <h2>Nhập thông tin đặt lịch</h2>\r\n");
      out.write("\r\n");
      out.write("        <button type=\"submit\" id=\"btn_getinfo\" class=\"submit-btn\">Tải đơn hàng xuống</button>\r\n");
      out.write("    <form id=\"schedule-form\" method=\"post\" action=\"schedule-appointment\">\r\n");
      out.write("\r\n");
      out.write("    </form>\r\n");
      out.write("\r\n");
      out.write("    <form id=\"orderForm\" action=\"createOrder\" method=\"POST\">\r\n");
      out.write("        <input type=\"hidden\" name=\"userId\" value=\"");
      out.print( userId );
      out.write("\">\r\n");
      out.write("        <input type=\"hidden\" name=\"username\" value=\"");
      out.print( username );
      out.write("\">\r\n");
      out.write("\r\n");
      out.write("        ");
 for (CartItem item : cartItems) { 
      out.write("\r\n");
      out.write("        <input type=\"hidden\" name=\"propertyId\" value=\"");
      out.print( item.getPropertyId() );
      out.write("\">\r\n");
      out.write("        <input type=\"hidden\" name=\"title\" value=\"");
      out.print( item.getTitle() );
      out.write("\">\r\n");
      out.write("        <input type=\"hidden\" name=\"price\" value=\"");
      out.print( item.getPrice() );
      out.write("\">\r\n");
      out.write("        <input type=\"hidden\" name=\"area\" value=\"");
      out.print( item.getArea() );
      out.write("\">\r\n");
      out.write("        <input type=\"hidden\" name=\"address\" value=\"");
      out.print( item.getAddress() );
      out.write("\">\r\n");
      out.write("        ");
 } 
      out.write("\r\n");
      out.write("        <input type=\"hidden\" name=\"orderDate\" value=\"");
      out.print( new java.util.Date() );
      out.write("\">\r\n");
      out.write("        <div class=\"form-group\">\r\n");
      out.write("            <label for=\"address\">Nhập chữ kí của đơn hàng:</label>\r\n");
      out.write("            <input type=\"text\" id=\"address\" name=\"signature\" required>\r\n");
      out.write("        </div>\r\n");
      out.write("        <button type=\"submit\" class=\"submit-btn\">Xác nhận đặt lịch</button>\r\n");
      out.write("    </form>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<script src=\"https://code.jquery.com/jquery-3.6.0.min.js\"></script>\r\n");
      out.write("<script>\r\n");
      out.write("    document.getElementById(\"btn_getinfo\").addEventListener('click',(e)=>{\r\n");
      out.write("        $.ajax({\r\n");
      out.write("            url:\"/Batdongsan/get_order_info\",\r\n");
      out.write("            type:\"GET\",\r\n");
      out.write("            success:(resp)=>{\r\n");
      out.write("                $(\".info\").val(resp)\r\n");
      out.write("                // const infoVal = $(\".info\").val();  // Lấy giá trị của input .info\r\n");
      out.write("                const blob = new Blob([resp],{type:'text/plain'});\r\n");
      out.write("                const url = URL.createObjectURL(blob);\r\n");
      out.write("                const link = document.createElement('a');\r\n");
      out.write("                link.href = url;\r\n");
      out.write("                link.download = 'products.txt';\r\n");
      out.write("                link.click();\r\n");
      out.write("\r\n");
      out.write("                URL.revokeObjectURL(url);\r\n");
      out.write("            }\r\n");
      out.write("        })\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    })\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("<script>\r\n");
      out.write("    const cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];\r\n");
      out.write("    const productListDiv = document.getElementById('product-list');\r\n");
      out.write("\r\n");
      out.write("    cartItems.forEach((item, index) => {\r\n");
      out.write("        const productNameInput = document.createElement('input');\r\n");
      out.write("        productNameInput.type = 'hidden';\r\n");
      out.write("        productNameInput.name = 'productName' + index;\r\n");
      out.write("        productNameInput.value = item.name;\r\n");
      out.write("\r\n");
      out.write("        const productQuantityInput = document.createElement('input');\r\n");
      out.write("        productQuantityInput.type = 'hidden';\r\n");
      out.write("        productQuantityInput.name = 'productQuantity' + index;\r\n");
      out.write("        productQuantityInput.value = 1;\r\n");
      out.write("\r\n");
      out.write("        const productPriceInput = document.createElement('input');\r\n");
      out.write("        productPriceInput.type = 'hidden';\r\n");
      out.write("        productPriceInput.name = 'productPrice' + index;\r\n");
      out.write("        productPriceInput.value = item.price;\r\n");
      out.write("\r\n");
      out.write("        productListDiv.appendChild(productNameInput);\r\n");
      out.write("        productListDiv.appendChild(productPriceInput);\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("    const productCountInput = document.createElement('input');\r\n");
      out.write("    productCountInput.type = 'hidden';\r\n");
      out.write("    productCountInput.name = 'productCount';\r\n");
      out.write("    productCountInput.value = cartItems.length;\r\n");
      out.write("    productListDiv.appendChild(productCountInput);\r\n");
      out.write("</script>\r\n");
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
