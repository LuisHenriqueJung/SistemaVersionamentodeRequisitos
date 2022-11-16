<%-- 
    Document   : novorequisito
    Created on : 3 de set. de 2022, 11:36:41
    Author     : luisc
--%>

<%@page import="dao.PessoaDAO"%>
<%@page import="entidade.Pessoa"%>
<%@page import="dao.ProjetoDAO"%>
<%@page import="dao.RequisitoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Requisito"%>
<%@page import="entidade.Projeto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SGR - Sistema de versionamento de requisitos</title>

        <script src="https://www.w3schools.com/lib/w3.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="styles.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


        <link rel="stylesheet" href="/styles.css">
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
            Requisito r = (Requisito) request.getAttribute("requisito");

            if (r == null) {
                r = new Requisito();
                r.setId(0);
                r.setReferencia("");
                r.setDescricao("");
                r.setProjeto("");
                r.setRequisito("");

                r.setPrazo("");

                r.setVersao("");
                r.setStatus("");
                r.setTipo("");
                r.setPrioridade("");
                r.setComplexidade("");
                r.setResponsavel("");
            }
        %>

        <jsp:include page="navbar.jsp" /> 
        <div id="page">

            <jsp:include page="menu.jsp" />


            <div id="novo-requisito">
                <div style="background-color:#01579B ;color: white; margin-left: 10px;padding-left: 20px;">
                    <h5 style="text-align: left;line-height:45px;">Cadastro de requisitos:</h5>
                </div>
                <div style="display: flex; background-color: white; border: 1px solid #01579B; margin: 10px;">
                    <form style="display: contents" action="/servlet?param=cadRequisito" method="post">
                        <div style="flex-grow: 1; margin: 30px 10px; border-right:1px solid rgb(199, 186, 186) ; padding-right: 30px;">
                            <h5>Preencha o formulário de cadastro:</h5>
                            <label for="projeto">Referência:</label>
                            <input class="form-control" type="text" name="referencia" placeholder="Referência" value="<%= r.getReferencia()%>">
                             <br>
                            <label for="projeto">Selecione o projeto para adicionar o requisito:</label>
                            <br>
                            <input type="hidden" name="id" value="<%= r.getId()%>">
                            <select class="custom-select" name="id_projeto" >
                                <%
                                    ArrayList<Projeto> projetos = new ProjetoDAO().listarProjetos();
                                    for (int i = 0; i < projetos.size(); i++) {
                                %>
                                <option value="<%=projetos.get(i).getId()%>"><%=projetos.get(i).getNome()%></option>
                                <%
                                    }

                                %>
                            </select>
                            <br> <br>
                            <label for="requisito">Requisito</label>
                            <input class="form-control" type="text" name="requisito" placeholder="Resquisito" value="<%= r.getRequisito()%>">
                             <br>
                            <label for="projeto">Versão:</label>
                            <input class="form-control" type="text" name="versao" placeholder="Versão" value="<%= r.getVersao()%>">
                             <br>
                            <label for="">Status:</label>
                            <select class="custom-select" id="" name="status">
                                <option value="Não Iniciado" >Não Iniciado</option>
                                <option value="Em andamento" >Em andamento</option>
                                <option value="Finalizado" >Finalizado</option>
                                <option value="Cancelado" >Cancelado</option>
                                
                            </select>

                             <br> <br>
                            <label for="cliente">Selecione o responsável pelo requisito:</label>
                            <br>
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
                        </div>

                        <div style="flex-grow: 1; margin: 20px; display: flex; flex-direction: column; height: 79vh;">
                            <label for="exampleFormControlTextarea1">Descrição:</label>
                            <textarea class="form-control" name="descricao" rows="10" value="<%= r.getDescricao()%>"><%= r.getDescricao()%></textarea>
                             <br>
                            <div style="padding: 10px 20px 20px 20px; display: flex; justify-content: initial; ">

                                <span> <b>Tipo: </b>  </span>
                                <div style="margin: 6px"></div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="radio-funcional" name="tipo" class="custom-control-input" value="funcional">
                                    <label class="custom-control-label" for="radio-funcional"> Funcional</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="radio-naoFuncional" name="tipo" value="naofuncional"class="custom-control-input">
                                    <label class="custom-control-label" for="radio-naoFuncional">Não-Funcional</label>
                                </div>
                            </div>
                             <br>
                            <div style="padding: 10px 20px 20px 20px; display: flex; justify-content: initial; ">

                                <span><b>Prioridade:</b></span>
                                <div style="margin: 6px"></div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="radio-essencial" name="radio_prioridade"
                                           class="custom-control-input" value="Essencial">
                                    <label class="custom-control-label" for="radio-essencial">Essencial</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="radio-importante" name="radio_prioridade"
                                           class="custom-control-input" value="Importante">
                                    <label class="custom-control-label" for="radio-importante">Importante</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="radio-desejavel" name="radio_prioridade"
                                           class="custom-control-input" value="Desejável">
                                    <label class="custom-control-label" for="radio-desejavel">Desejável</label>
                                </div>
                            </div>

                              <br>
                            <div style="padding: 10px 20px 20px 20px ; display: flex; justify-content: initial; ">
                                <span><b> Complexidade:</b></span>
                                <div style="margin: 6px"></div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="radio-simples" name="radio_complexidade"
                                           class="custom-control-input" value="Simples">
                                    <label class="custom-control-label" for="radio-simples">Simples</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="radio-razoavel" name="radio_complexidade"
                                           class="custom-control-input" value="Razoavelmente Complexo">
                                    <label class="custom-control-label" for="radio-razoavel">Razoavelmente Complexo</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="radio-complexo" name="radio_complexidade"
                                           class="custom-control-input" value="Complexo">
                                    <label class="custom-control-label" for="radio-complexo">Complexo</label>
                                </div>
                            </div>
                               <br>
                            <div style="padding:10px 20px 20px 20px ;">
                                <div class="form-group">
                                    <label for="data-pagamento">Você pode definir um prazo para este requisito: </label>
                                    <!-- Datepicker as text field -->
                                    <div class="input-group date" data-date-format="dd/mm/yyyy">
                                        <input type="text" class="form-control" placeholder="Defina um prazo" name="prazo">
                                        <div class="input-group-addon">
                                            <span class="glyphicon glyphicon-th"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="padding:10px 20px 20px 200px ;">
                                <button class="btn btn-primary btn-block">Salvar </button>
                                <button class="btn btn-danger btn-block">Cancelar </button>
                            </div>

                        </div>
                    </form>
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