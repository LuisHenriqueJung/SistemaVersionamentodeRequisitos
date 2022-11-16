<%-- 
    Document   : usuarios
    Created on : 3 de set. de 2022, 11:37:38
    Author     : luisc
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="dao.PessoaDAO"%>
<%@page import="dao.PessoaDAO"%>
<%@page import="entidade.Pessoa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://www.w3schools.com/lib/w3.js"></script>
        <link rel="stylesheet" href="styles.css">
        <title>SGR - Sistema de versionamento de requisitos</title>
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
                response.sendRedirect("index.jsp");
                //Adicione return para finalizar o método atual              
                return;
            } else {
                
            }
        %>  
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

    %>
        <div w3-include-html="navbar.jsp"></div>

        <div style="display: flex; margin-top: 54px;background-color:#01579B; height: 94vh;padding: 0  25px 25px 0 ;">
            <div w3-include-html="menu.jsp"></div>
            <script>
                w3.includeHTML();
            </script>

            


                    <%
                        ArrayList<Pessoa> pessoas = new PessoaDAO().listarPessoas();
                    %>
                    
                    <div id="page-user">
                <div style="background-color:#01579B ;color: white; margin-left: 10px;padding-left: 20px;display: flex; justify-content: space-between">
                    <h5 style="text-align: left;line-height:45px;"><%= pessoas.size()%> usuários :</h5>
                    <a href="/listagemPessoas.jsp">
                    <button class="btn btn-light " style="margin: 9px">Gerar relátório </button></a>
                </div>
                <div style="display: flex; height:83vh;">
                    <div  id="table-usuarios">

                        <table class="table table-hover">
                            <th scope="col">Id</th>
                            <th scope="col">Nome</th>
                            <th scope="col">CPF</th>
                            <th scope="col">Tipo</th>
                            <th scope="col">E-mail</th>
                            <th scope="col">Login</th>
                            <th scope="col">Situação</th>
                            <th scope="col">Editar</th>
                            <th scope="col">Excluir</th>

                            <%
                                for (int i = 0; i < pessoas.size(); i++) {
                            %>
                            <tr scope="row">
                                <td><%= pessoas.get(i).getId()%></td>
                                <td><%= pessoas.get(i).getNome()%></td>
                                <td><%= pessoas.get(i).getCPF()%></td>
                                <td><%= pessoas.get(i).getTipo()%></td>
                                <td><%= pessoas.get(i).getEmail()%></td>
                                <td><%= pessoas.get(i).getLogin()%></td>
                                <td><%= pessoas.get(i).getSituação()%></td>
                                <%-- Cria um link para o 'acao' por meio de um get com o respectivo 'param' + o Id da pessoa --%>
                                <td><a href="/servlet?param=updatePessoa&id=<%= pessoas.get(i).getId()%>">Editar</a></td>
                                <td><a href="/servlet?param=deletePessoa&id=<%= pessoas.get(i).getId()%>">Excluir</a></td>
                            </tr>
                            <%
                                }
                            %>
                        </table>



                    </div>

                </div>
            </div>
        </div>
    </body>

</html>