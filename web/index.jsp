<%-- 
    Document   : index
    Created on : 3 de set. de 2022, 11:27:33
    Author     : luisc
--%>

<%@page import="dao.ProjetoDAO"%>
<%@page import="entidade.Projeto"%>
<%@page import="dao.PessoaDAO"%>
<%@page import="entidade.Pessoa"%>
<%@page import="dao.RequisitoDAO"%>
<%@page import="entidade.Requisito"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="pt-BR">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
        <%      
            Requisito p = (Requisito) request.getAttribute("requisito");

            if (p == null) {

                p = new Requisito();
                p.setId(0);
                p.setReferencia("");
                p.setRequisito("");
                p.setDescricao("");
                p.setProjeto("");
                p.setPrazo("");
                p.setVersao("");
                p.setStatus("");
                p.setTipo("");
                p.setPrioridade("");
                p.setComplexidade("");
                p.setResponsavel("");
            }

            ArrayList<Requisito> projetos = new RequisitoDAO().listarRequisitos("funcional' OR tipo = 'naofuncional");
        %>
        <div style="background-color:#01579B ;">

            <jsp:include page="navbar.jsp" />


            <div id="page">
                <jsp:include page="menu.jsp" />

                <div id="conteudo-requisitos">
                    <div style="background-color:#01579B ;color: white; margin-left: 10px;padding-left: 20px;display: flex; justify-content: space-between">
                        <h5 style="text-align: left;line-height:45px;">Pesquisa por requisitos:</h5>
                        <a href="/listagemRequisitos.jsp">
                    <button class="btn btn-light " style="margin: 9px">Gerar relátório </button></a>
                    </div>
                    <div id="pesquisa">

                        <div style="flex-grow: 1; margin: 10px;">
                            <label for="projeto">Projeto:</label>
                            <br>
                            <select class="custom-select" name="projeto" id="">
                                <option selected>Selecione...</option>
                                <option value="ERP">ERP</option>
                                <option value="CRM">CRM</option>
                            </select>
                            <br>
                            <label for="versao">Versão:</label>
                            <br>
                            <select class="custom-select" name="versao" id="">
                                <option selected>Selecione...</option>
                                <option value="10.1">10.1</option>
                                <option value="11.0">11.0</option>
                            </select>
                        </div>
                        <div style="flex-grow: 1; margin: 10px;">
                            <label for="responsavel">Responsável:</label>
                            <br>
                            <select class="custom-select" name="responsavel" id="">
                                <option selected>Selecione...</option>
                                <option value="anderson">anderson</option>
                                <option value="maria">maria</option>
                            </select>
                            <br>
                            <label for="prioridade">Prioridade:</label>
                            <br>
                            <select class="custom-select" name="prioridade" id="">
                                <option selected>Selecione...</option>
                                <option value="urgente">urgente</option>
                                <option value="importante">importante</option>
                            </select>
                        </div>

                        <div style="flex-grow: 1; margin: 10px;">

                            <br>
                            <label for="datainclusao">Data Inclusão:</label>
                            <br>
                            <select  class="custom-select" name="datainclusao" id="">
                                <option selected>Selecione...</option>
                                <option value="10/10/2010">10/10/2010</option>
                                <option value="maria">maria</option>
                            </select>
                            <div class="align-self-end" style="flex-grow: 1; ">
                                <input class=" btn btn-primary btn-block" type="submit" value="Aplicar filtros">
                            </div>
                        </div>


                    </div> 
                    <div id="panels">
                        <div class="panel_requisitos">
                            <h4>Requisitos funcionais</h4>
                            <% ArrayList<Requisito> requisitos = new RequisitoDAO().listarRequisitos("funcional");

                                for (int i = 0; i < requisitos.size(); i++) {
                                    Pessoa responsavel = new PessoaDAO().consultarPessoa(requisitos.get(i).getResponsavel());
                                    Projeto projeto = new ProjetoDAO().consultarProjeto(requisitos.get(i).getProjeto());

                            %>

                            <div class="cartao">
                                <div style="display: flex;flex-direction: column;justify-content: space-between">
                                    <h5> <b>Referência: <%=requisitos.get(i).getReferencia()%></b></h5>
                                    <h6> <b>Projeto: <%= projeto.getNome()%></b></h6>
                                    <p>Status: <%= requisitos.get(i).getStatus()%></p>
                                    <button type="button" class="btn btn-primary btn-block" data-toggle="modal"
                                            data-target="#<%=requisitos.get(i).getReferencia()%>">Detalhes</button>
                                </div>
                                <div style="display: flex;flex-direction: column;justify-content: space-between">
                                    <h6>Versão: <%=requisitos.get(i).getVersao()%></h6>
                                    <h6>Prioridade: <%=requisitos.get(i).getPrioridade()%></h6>
                                    <h6>Responsável: <%= responsavel.getNome()%></h6>

                                    <button  style="margin: 2px"type="button" class="btn btn-success btn-block" ><a style="text-decoration: none;color: inherit;" href="/servlet?param=updateRequisito&id=<%= requisitos.get(i).getId()%>">Editar</a></button>

                                </div>

                            </div>
                            <div id="<%=requisitos.get(i).getReferencia()%>" class="modal fade" role="dialog">
                                <div class="modal-dialog">

                                    <!-- Conteúdo do modal-->
                                    <div class="modal-content">

                                        <!-- Cabeçalho do modal -->
                                        <div class="modal-header">
                                            <h2 class="modal-title"><%=requisitos.get(i).getReferencia()%></h2>
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>

                                        <!-- Corpo do modal -->
                                        <div class="modal-body">
                                            <h6>Requisito: </h6>
                                            <p><%=requisitos.get(i).getRequisito()%></p>
                                            <h6>Descrição:</h6>
                                            <p><%=requisitos.get(i).getDescricao()%></p>

                                        </div>

                                        <!-- Rodapé do modal-->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">Fechar</button>

                                        </div>

                                    </div>
                                </div>
                            </div>
                            <%
                                }

                            %>  



                        </div>
                        <div class="panel_requisitos">
                            <h4>Requisitos não funcionais</h4>
                            <% ArrayList<Requisito> reqNaoFunci = new RequisitoDAO().listarRequisitos("naofuncional");

                                for (int i = 0; i < reqNaoFunci.size(); i++) {
                                    Pessoa responsavel = new PessoaDAO().consultarPessoa(reqNaoFunci.get(i).getResponsavel());
                                    Projeto projeto = new ProjetoDAO().consultarProjeto(reqNaoFunci.get(i).getProjeto());

                            %>

                            <div class="cartao">
                                <div style="display: flex;flex-direction: column;justify-content: space-between">
                                    <h5> <b>Referência:<%=reqNaoFunci.get(i).getReferencia()%></b></h5>
                                    <h6> <b>Projeto: <%= projeto.getNome()%></b></h6>
                                    <p>Status: <%= reqNaoFunci.get(i).getStatus()%></p>
                                    <button type="button" class="btn btn-primary btn-block" data-toggle="modal"
                                            data-target="#<%=reqNaoFunci.get(i).getReferencia()%>">Detalhes</button>
                                </div>
                                <div style="display: flex;flex-direction: column;justify-content: space-between">
                                    <h6>Versão: <%=reqNaoFunci.get(i).getVersao()%></h6>
                                    <h6>Prioridade: <%=reqNaoFunci.get(i).getPrioridade()%></h6>
                                    <h6>Responsável: <%= responsavel.getNome()%></h6>

                                    <button  style="margin: 2px"type="button" class="btn btn-success btn-block" data-toggle="modal"
                                             data-target="#<%=requisitos.get(i).getReferencia()%>">Editar</button>

                                </div>

                            </div>
                            <div id="<%=reqNaoFunci.get(i).getReferencia()%>" class="modal fade" role="dialog">
                                <div class="modal-dialog">

                                    <!-- Conteúdo do modal-->
                                    <div class="modal-content">

                                        <!-- Cabeçalho do modal -->
                                        <div class="modal-header">
                                            <h2 class="modal-title"><%=reqNaoFunci.get(i).getReferencia()%></h2>
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>

                                        <!-- Corpo do modal -->
                                        <div class="modal-body">
                                            <h6>Requisito: </h6>
                                            <p><%=reqNaoFunci.get(i).getRequisito()%></p>
                                            <h6>Descrição:</h6>
                                            <p><%=reqNaoFunci.get(i).getDescricao()%></p>

                                        </div>

                                        <!-- Rodapé do modal-->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">Fechar</button>

                                        </div>

                                    </div>
                                </div>
                            </div>
                            <%
                                }

                            %> 
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!–---------------------- MODAL------------------ –>



</div>
</body>
<footer>

</footer>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Plugin pro Datapicker novo -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.1/js/bootstrap-datepicker.min.js'></script>
<script>
    $('.input-group.date').datepicker({format: "dd/mm/yyyy"});
</script>


</html>
