<%-- 
    Document   : login
    Created on : 3 de set. de 2022, 11:36:08
    Author     : luisc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SGR - Sistema de versionamento de requisitos</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="login/styles_login.css">
    </head>

    <body>
        <%
            String message = (String) request.getAttribute("alertMsg");
            if (message == null) {
                message = "";
            }
        %>  

        <script type="text/javascript">
            var msg = "<%=message%>";
            if (msg !== "") {
                alert(msg);
            }
        </script>


        <div id="login">
            <form class="needs-validation" method = "post" action="/servlet?param=login">
                <h4>Entrar no sistema:</h4>
                <div class="form-group">
                    <label for="exampleInputEmail1">Login</label>
                    <input name="login" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="loginHelp"
                           placeholder="Digite seu login">

                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Senha</label>
                    <input name="senha" type="password" class="form-control" id="exampleInputPassword1" placeholder="Digite sua senha">
                </div>
                <div class="form-check">


                </div>
                <button type="submit" class="btn btn-primary">Entrar</button>
            </form>
        </div>

    </body>

</html>