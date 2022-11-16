/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet;

import dao.LoginDAO;
import dao.PessoaDAO;
import dao.ProjetoDAO;
import dao.RequisitoDAO;
import entidade.Pessoa;
import entidade.Projeto;
import entidade.Requisito;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author luisc
 */
public class servlet extends HttpServlet {

    //Declaração variáveis requisicao e resposta que vão ser usados mais abaixo
    //com visibilidade na classe toda
    HttpServletRequest requisicao;
    HttpServletResponse resposta;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet acao</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet acao at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        requisicao = request;
        resposta = response;

        String parametro = request.getParameter("param");

        if (parametro.equals("updatePessoa")) {
            String id = requisicao.getParameter("id");

            Pessoa pessoa = new PessoaDAO().consultarPessoa(id);

            requisicao.setAttribute("pessoa", pessoa);

            encaminharPagina("/cadastroUsuario.jsp");

        } else if (parametro.equals("deletePessoa")) {
            int id = Integer.parseInt(request.getParameter("id"));

            if (new PessoaDAO().excluir(id)) {
                request.setAttribute("alertMsg", " Excluído com sucesso!");
                RequestDispatcher rd = request.getRequestDispatcher("/usuarios.jsp");
                rd.include(request, response);
            } else {
                request.setAttribute("alertMsg", " Falha ao excluir Pessoa");
                RequestDispatcher rd = request.getRequestDispatcher("/usuarios.jsp");
                rd.include(request, response);
            }
        }
        if (parametro.equals("updateProjeto")) {
            String id = requisicao.getParameter("id");

            Projeto projeto = new ProjetoDAO().consultarProjeto(id);

            requisicao.setAttribute("projeto", projeto);

            encaminharPagina("/projeto.jsp");

        }
        if (parametro.equals("updateRequisito")) {
            int id = Integer.parseInt(requisicao.getParameter("id"));

            Requisito requisito = new RequisitoDAO().consultarRequisito(id);

            requisicao.setAttribute("requisito", requisito);

            encaminharPagina("/novorequisito.jsp");

        } 

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        requisicao = request;
        resposta = response;

        String parametro = requisicao.getParameter("param");

        if (parametro.equals("login")) {
            String login = request.getParameter("login");
            String senha = request.getParameter("senha");
            
            Pessoa usuario = new Pessoa();
            usuario.setLogin(login);
            usuario.setSenha(senha);
                                       
            if (new LoginDAO().logar(usuario)) {
                HttpSession sessao = requisicao.getSession();
                sessao.setAttribute("usuarioLogado", login);     
//                String usuario = (String) session.getAttribute("usuarioLogado");                
//                System.out.println("Usuário logado: " + usuario);
                encaminharPagina("index.jsp");                
            } else {
                //Vamos definir um atributo 'alertMsg' para utilizar index.jsp
                request.setAttribute("alertMsg", "Login invalido! Tente novamente.");                
                RequestDispatcher rd=request.getRequestDispatcher("login.jsp");  
                //O método include inclui o conteúdo na resposta.                
                rd.include(request, response);                
                //encaminharPagina("index.jsp");
            }
        }    
        if (parametro.equals("cadPessoa")) {
            int id = Integer.parseInt(requisicao.getParameter("id"));
            String nome = requisicao.getParameter("nome");
            String cpf = requisicao.getParameter("cpf");
            String tipo = requisicao.getParameter("tipo");
            String login = requisicao.getParameter("login");
            String email = requisicao.getParameter("email");
            String senha = requisicao.getParameter("senha");
            Date data = new Date(System.currentTimeMillis());
            SimpleDateFormat formatarDate = new SimpleDateFormat("yyyy-MM-dd");

            Pessoa pessoa = new Pessoa();
            pessoa.setId(id);
            pessoa.setNome(nome);
            pessoa.setCPF(cpf);
            pessoa.setTipo(tipo);
            pessoa.setLogin(login);
            pessoa.setEmail(email);
            pessoa.setSituação("Ativo");
            pessoa.setDataCadastro(formatarDate.format(data));
            pessoa.setSenha(senha);

            if (new PessoaDAO().salvar(pessoa)) {
                requisicao.setAttribute("alertMsg", pessoa.getNome() + " cadastrado com sucesso!");
                RequestDispatcher rd = requisicao.getRequestDispatcher("/usuarios.jsp");
                rd.include(requisicao, resposta);
            } else {
                requisicao.setAttribute("alertMsg", " Erro ao cadastrar " + pessoa.getNome() + "!");
                encaminharPagina("/usuarios.jsp");
            }
        }
        if (parametro.equals("cadProjeto")) {
            int id = Integer.parseInt(requisicao.getParameter("id"));
            String nome = requisicao.getParameter("nome");
            String responsavel = requisicao.getParameter("id_responsavel");
            String prazoEntrega = requisicao.getParameter("prazo_entrega");
            String status = requisicao.getParameter("status");
            Date data = new Date(System.currentTimeMillis());
            SimpleDateFormat formatarDate = new SimpleDateFormat("yyyy-MM-dd");
            
            Projeto projeto = new Projeto();
            projeto.setId(id);
            projeto.setNome(nome);
            projeto.setResponavel(responsavel);
            projeto.setDataCadastro(formatarDate.format(data));
            projeto.setPrazoEntrega(prazoEntrega);
            projeto.setStatus(status);
            
            if (new ProjetoDAO().salvar(projeto)) {
                requisicao.setAttribute("alertMsg", projeto.getNome() + " cadastrado com sucesso!");
                RequestDispatcher rd = requisicao.getRequestDispatcher("/projeto.jsp");
                rd.include(requisicao, resposta);
                projeto = new Projeto();
            } else {
                requisicao.setAttribute("alertMsg", " Erro ao cadastrar " + projeto.getNome() + "!");
                encaminharPagina("/projeto.jsp");
            }
        }
        
        
        
        if (parametro.equals("cadRequisito")) {
            int id = Integer.parseInt(requisicao.getParameter("id"));
            String referencia = requisicao.getParameter("referencia");
            String requisito = requisicao.getParameter("requisito");
            String descricao = requisicao.getParameter("descricao");
            String projeto = requisicao.getParameter("id_projeto");
            String prazo = requisicao.getParameter("prazo");
            String versao = requisicao.getParameter("versao");
            String status = requisicao.getParameter("status");
            String tipo = requisicao.getParameter("tipo");
            String prioridade = requisicao.getParameter("radio_prioridade");
            String radio_complexidade = requisicao.getParameter("radio_complexidade");
            String responsavel = requisicao.getParameter("id_responsavel");
            //String conclusao = requisicao.getParameter("conclusao");
            
            
            Requisito newRequisito = new Requisito();
            newRequisito.setId(id);
            newRequisito.setRequisito(requisito);
            newRequisito.setReferencia(referencia);
            newRequisito.setDescricao(descricao);
            newRequisito.setProjeto(projeto);
            newRequisito.setPrazo(prazo);
            newRequisito.setVersao(versao);
            newRequisito.setStatus(status);
            newRequisito.setTipo(tipo);
            newRequisito.setPrioridade(prioridade);
            newRequisito.setComplexidade(radio_complexidade);
            newRequisito.setResponsavel(responsavel);

            if (new RequisitoDAO().salvar(newRequisito)) {
                requisicao.setAttribute("alertMsg", newRequisito.getReferencia()+ " cadastrado com sucesso!");
                RequestDispatcher rd = requisicao.getRequestDispatcher("/index.jsp");
                rd.include(requisicao, resposta);
                newRequisito = new Requisito();
            } else {
                requisicao.setAttribute("alertMsg", " Erro ao cadastrar " + newRequisito.getReferencia() + "!");
                encaminharPagina("/index.jsp");
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void encaminharPagina(String pagina) {
        try {
            RequestDispatcher rd = requisicao.getRequestDispatcher(pagina);
            rd.forward(requisicao, resposta);
        } catch (Exception e) {
            System.out.println("Erro no encaminhamento: " + e);
        }
    }

}
