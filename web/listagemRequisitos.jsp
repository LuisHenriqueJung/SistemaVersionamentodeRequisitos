<%@page import="dao.RequisitoDAO"%>
<%@page import="dao.PessoaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            if ((String)session.getAttribute("usuarioLogado") == null) {            
                response.sendRedirect("login.jsp");
                //Adicione return para finalizar o método atual              
                return;
            } else {
                
            }
        %> 
        <%
           
           byte[] bytes = new RequisitoDAO().gerarRelatorio();

            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
            outStream.flush();
            outStream.close();
            
        %>
        <script>
    document.write('<a href="' + document.referrer + '">Go Back</a>');
</script>
    </body>
</html>