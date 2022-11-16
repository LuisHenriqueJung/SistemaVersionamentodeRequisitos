<%-- 
    Document   : cadastroUsuario
    Created on : 12 de set. de 2022, 19:37:09
    Author     : luisc
--%>

<%@page import="entidade.Pessoa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://www.w3schools.com/lib/w3.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script
        src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css"
              rel="stylesheet" />
        <link rel="stylesheet" href="styles.css"/>

        <script
        src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.pt-BR.min.js"></script>


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
        <jsp:include page="navbar.jsp" /> 
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
            <% 
        //Recuperando o atributo produto cujo valor é um objeto do tipo produto
        //Se estou em uma edição quero recuperar este valor e mostrar no form pelo 'input value'
        Pessoa p = (Pessoa) request.getAttribute("pessoa");

        if(p == null){
        p = new Pessoa();        
        p.setId(0);
        p.setNome("");
        p.setCPF("");
        p.setTipo("");
        p.setEmail("");
        p.setLogin("");
        p.setSenha("");        
        }

    %>
        

        <div style="display: flex; margin-top: 54px;background-color:#01579B; height: 94vh;padding: 0  25px 25px 0 ;">
            <jsp:include page="menu.jsp" />

            <div id="page-user">
                <div style="background-color:#01579B ;color: white; margin-left: 10px;padding-left: 20px;">
                    <h5 style="text-align: left;line-height:45px;">Cadastro de usuário: </h5>
                </div>
                <div style="display: flex; height:83vh;">
                    <div  id="table-usuarios">
                        <h4>Cadastrar novo usuário:</h4>
                        <form class="form-group" method = "post" action="/servlet?param=cadPessoa" style="padding: 20px">
                            <input type="hidden" name="id" value="<%= p.getId()%>">
                            <label for="nome">Nome</label>
                            <input type="name" class="form-control" id="exampleInputName" aria-describedby="namehelp"
                                   placeholder="Digite seu nome" name="nome" value="<%=p.getNome()%>">
                            <br>
                            <label for="cpf">CPF</label>
                            <input type="number" class="form-control" id="exampleInputName" aria-describedby="CPFhelp"
                                   placeholder="Digite seu CPF" name="cpf" value="<%=p.getCPF()%>">
                            <br>
                            <label for="tipo">Tipo de usuário</label>
                            <select class="custom-select" name="tipo" id="" value="">  
                                <option value="<%=p.getTipo()%>"selected disabled hidden><%=p.getTipo()%></option>
                                <option value="Vizualizador">Vizualizador</option>
                                <option value="Administrador">Administrador</option>
                            </select>
                            <br>

                            <br>
                            <label for="email">Endereço de email</label>
                            <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                                   placeholder="Digite seu melhor e-mail" name="email" value="<%=p.getEmail()%>">
                            <br>
                            <label for="login">Criar login de acesso</label>
                            <input type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                                   placeholder="Defina seu usuário de acesso" name="login" value="<%=p.getLogin()%>">
                            <br>
                            <label for="senha">Criar uma senha</label>
                            <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Digite sua senha" name="senha" value="<%=p.getSenha()%>">

                            <br>
                            <button type="submit" class="btn btn-success">Confirmar cadastro</button>
                        </form>
                    </div>
                </div>
            </div>

        </div>

</body>

</html>
