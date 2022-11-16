/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import apoio.ConectionDB;
import entidade.Pessoa;
import entidade.Projeto;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author luisc
 */
public class ProjetoDAO {
    
    //Método salvar - retorna Boolean

    public boolean salvar(Projeto projeto) {
        try {
            //Cria a conexao
            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql = "";

            if (projeto.getId() == 0){

                sql = "INSERT INTO projeto VALUES ("
                        + "default,"
                        + "'" + projeto.getNome()+ "', "
                        + "'" + projeto.getPrazoEntrega()+ "', "
                        + "'" + projeto.getDataCadastro()+ "', "
                        + "'" + projeto.getStatus()+ "', "
                        + "'" + projeto.getResponavel()+ "'); ";
                        
                System.out.println("SQL: " + sql);
            } else {
                sql = "UPDATE projeto "
                        + "SET nome = '" + projeto.getNome() + "', "
                        + " prazo_entrega = '" + projeto.getPrazoEntrega() + "', "
                        + " data_cadastro = '" + projeto.getDataCadastro() + "', "
                        + " responsavel_id = '"+ projeto.getResponavel() + "',  "
                        + " status = '"+ projeto.getStatus()+ "' "
                        + "WHERE id_projeto = "+ projeto.getId()+ ";";
                        
                System.out.println(sql);
            }
            int resultado = st.executeUpdate(sql);

            return true;

        } catch (Exception e) {
            System.out.println("Erro ao salvar projeto: " + e);
            return false;
        }
    }


    public ArrayList<Projeto> listarProjetos() {

        ArrayList<Projeto> projetos = new ArrayList();

        try {

            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql
                    = "SELECT * "
                    + "FROM projeto "
                    + "ORDER BY id_projeto";

            System.out.println("SQL: " + sql);

            //Executa a instrução SQL fornecida e retorna um objeto SQLResultSet                     
            ResultSet resultado = st.executeQuery(sql);

            while (resultado.next()) {
                Projeto projeto = new Projeto();
                projeto.setId(resultado.getInt("id_projeto"));
                projeto.setNome(resultado.getString("nome"));
                projeto.setPrazoEntrega(resultado.getString("prazo_entrega"));
                projeto.setDataCadastro(resultado.getString("data_cadastro"));
                projeto.setResponavel(resultado.getString("responsavel_id"));
                projeto.setStatus(resultado.getString("status"));

                projetos.add(projeto);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar projetos: " + e);
        }

        return projetos;
    }

    //Método consultarProduto - apenas produto com o id informado    
    //Retorna objeto Produto
    public Projeto consultarProjeto(String id) {

        Projeto projeto = new Projeto();

        try {
            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql
                    = "select * "
                    + "from projeto "
                    + "where id_projeto = " + id;

            System.out.println("SQL: " + sql);

            //Executa a instrução SQL fornecida e retorna um objeto SQLResultSet                     
            ResultSet resultado = st.executeQuery(sql);

            while (resultado.next()) {
                projeto.setId(resultado.getInt("id_projeto"));
                projeto.setNome(resultado.getString("nome"));
                projeto.setPrazoEntrega(resultado.getString("prazo_entrega"));
                projeto.setDataCadastro(resultado.getString("data_cadastro"));
                projeto.setResponavel(resultado.getString("responsavel_id"));
                projeto.setStatus(resultado.getString("status"));
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar projeto: " + e);
        }

        return projeto;
    }

    //Método excluir - retorna boolean
    public boolean excluirProjeto(int id) {

        try {
            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql
                    = "delete from projeto "
                    + "where id_projeto = " + id;

            System.out.println("SQL: " + sql);            
            int resultado = st.executeUpdate(sql);

            return true;

        } catch (Exception e) {
            System.out.println("Erro ao excluir projeto: " + e);
            return false;
        }

    }

}

