<%-- 
    Document   : projeto
    Created on : 3 de set. de 2022, 11:37:14
    Author     : luisc
--%>

<%@page import="dao.ProjetoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.PessoaDAO"%>

<%@page import="entidade.Pessoa"%>

<%@page import="entidade.Projeto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://www.w3schools.com/lib/w3.js"></script>
        <link rel="stylesheet" href="styles.css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="styles.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <title>SGR - Sistema de versionamento de requisitos</title>
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
            Projeto p = (Projeto) request.getAttribute("projeto");

            if (p == null) {

                p = new Projeto();
                p.setId(0);
                p.setNome("");
                p.setDataCadastro("");
                p.setPrazoEntrega("");
                p.setResponavel("");
                p.setStatus("");
            }

            ArrayList<Projeto> projetos = new ProjetoDAO().listarProjetos();
        %>
        <jsp:include page="navbar.jsp" />  
        <div style="display: flex; margin-top: 54px;background-color:#01579B; height: 94vh;padding: 0  25px 25px 0 ;">
            <jsp:include page="menu.jsp" />
            <div id="page-project">
                <div style="background-color:#01579B ;color: white; margin-left: 10px;padding-left: 20px;">
                    <h5 style="text-align: left;line-height:45px;">Moderar projetos:</h5>
                </div>
                <div style="display: flex; height:84vh;">
                    <div id="form-projetos">
                        <h4><%= projetos.size()%> projetos cadastrados:</h4>
                        <%
                            for (int i = 0; i < projetos.size(); i++) {
                                Pessoa responsavel = new PessoaDAO().consultarPessoa(projetos.get(i).getResponavel());
                        %>

                        <div class="cartao">
                            <div>
                                <input type="hidden" name="id" value="<%= projetos.get(i).getId()%>">
                                <input type="hidden" name="data_cadastro" value="<%= projetos.get(i).getDataCadastro()%>">
                                <h5> <b><%= projetos.get(i).getNome()%></b></h5>
                                <h6> <b>Responsável: <%= responsavel.getNome()%></b></h6>
                                <p>Status: <%= projetos.get(i).getStatus()%></p>

                            </div>
                            <div>
                                <h6>Data do cadastro: <%= projetos.get(i).getDataCadastro()%></h6>
                                <h6>Prazo de entrega: <%= projetos.get(i).getPrazoEntrega()%></h6>
                                <button style="margin: 2px" type="button" class="btn btn-success btn-block" ><a style="text-decoration: none;color: inherit;" href="/servlet?param=updateProjeto&id=<%= projetos.get(i).getId()%>">Editar</a></button>

                            </div>
                        </div>
                        <%
                            }

                        %>        
                    </div>
                    <div id="form-cadastro-projeto" >
                        <h4>Cadastrar novo projeto:</h4>
                        <form id="cadastrar-projeto" method="post" action="/servlet?param=cadProjeto">
                            <div class="form-group">
                                <input type="hidden" name="id" value="<%= p.getId()%>">
                                <input type="hidden" name="data_cadastro" value="<%= p.getDataCadastro()%>">
                                <label for="formGroupExampleInput">Dê um nome para o projeto: </label>
                                <input type="text" class="form-control" id="formGroupExampleInput"
                                       placeholder="Insira o nome" value="<%= p.getNome()%>"name="nome">
                            </div>

                            <label for="">Alocar um responsável:</label>
                            <select class="custom-select" id="" name="id_responsavel">
                                <%
                                    ArrayList<Pessoa> responsaveis = new PessoaDAO().listarPessoas();
                                    for (int i = 0; i < responsaveis.size(); i++) {
                                %>

                                <option value=" <%= responsaveis.get(i).getId()%>" ><%= responsaveis.get(i).getNome()%></option>

                                <%
                                    }

                                %>
                            </select>
                            <br><br>
                            <label for="">Status:</label>
                            <select class="custom-select" id="" name="status">
                                <option value="Não Iniciado" >Não Iniciado</option>
                                <option value="Em andamento" >Em andamento</option>
                                <option value="Finalizado" >Finalizado</option>
                                <option value="Cancelado" >Cancelado</option>
                                
                            </select>
                            <br><br>
                            <div class="form-group">
                                <label for="data-pagamento">Prazo de entrega para o cliente: </label>
                                <!-- Datepicker as text field -->
                                <div class="input-group date" data-date-format="dd/mm/yyyy">
                                    <input type="text" class="form-control" placeholder="Defina um prazo" value="<%= p.getPrazoEntrega()%>" name="prazo_entrega">
                                    <div class="input-group-addon">
                                        <span class="glyphicon glyphicon-th"></span>
                                    </div>
                                </div>
                            </div>

                            <div style="padding: 80px 10px 20px 200px ;">
                                <button type="submit"class="btn btn-primary btn-block">Salvar </button>
                                <button class="btn btn-danger btn-block">Cancelar </button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>


    </div>
</body>


<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script src='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.1/js/bootstrap-datepicker.min.js'></script>
<script>
    $('.input-group.date').datepicker({format: "dd/mm/yyyy"});
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css"
      rel="stylesheet" />

<script
src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.pt-BR.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
crossorigin="anonymous"></script>

</html>