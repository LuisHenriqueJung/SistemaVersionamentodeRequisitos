/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import apoio.ConectionDB;
import entidade.Pessoa;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.view.JasperViewer;

/**
 *
 * @author luisc
 */
public class PessoaDAO {
    //Método salvar - retorna Boolean

    public boolean salvar(Pessoa pessoa) {
        try {
            //Cria a conexao
            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql = "";

            if (pessoa.getId() == 0) {

                sql = "INSERT INTO pessoa VALUES ("
                        + "default,"
                        + "'" + pessoa.getNome() + "', "
                        + "'" + pessoa.getCPF() + "', "
                        + "'" + pessoa.getTipo() + "', "
                        + "'" + pessoa.getLogin() + "', "
                        + "'" + pessoa.getEmail() + "', "
                        + "'" + pessoa.getSituação() + "', "
                        + "'" + pessoa.getDataCadastro() + "', "
                        + "'" + pessoa.getSenha() + "'); ";

                System.out.println("SQL: " + sql);
            } else {
                sql = "UPDATE pessoa "
                        + "SET nome = '" + pessoa.getNome() + "', "
                        + " cpf = '" + pessoa.getCPF() + "', "
                        + " tipo = '" + pessoa.getTipo() + "', "
                        + " login = '" + pessoa.getLogin() + "', "
                        + " email = '" + pessoa.getEmail() + "', "
                        + "situacao = '" + pessoa.getSituação() + "', "
                        + "datacadastro = '" + pessoa.getDataCadastro() + "', "
                        + "senha = '" + pessoa.getSenha() + "'"
                        + "WHERE id_pessoa = " + pessoa.getId();
                System.out.println(sql);
            }
            int resultado = st.executeUpdate(sql);

            return true;

        } catch (Exception e) {
            System.out.println("Erro ao salvar pessoa: " + e);
            return false;
        }
    }

    //Método consultarProduto - todos os produtos
    //Retorna arraylist de produtos
    public ArrayList<Pessoa> listarPessoas() {

        ArrayList<Pessoa> pessoas = new ArrayList();

        try {

            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql
                    = "SELECT * "
                    + "FROM pessoa "
                    + "ORDER BY id_pessoa";

            System.out.println("SQL: " + sql);

            //Executa a instrução SQL fornecida e retorna um objeto SQLResultSet                     
            ResultSet resultado = st.executeQuery(sql);

            while (resultado.next()) {
                Pessoa pessoa = new Pessoa();
                pessoa.setId(resultado.getInt("id_pessoa"));
                pessoa.setNome(resultado.getString("nome"));
                pessoa.setCPF(resultado.getString("cpf"));
                pessoa.setTipo(resultado.getString("tipo"));
                pessoa.setLogin(resultado.getString("login"));
                pessoa.setEmail(resultado.getString("email"));
                pessoa.setSituação(resultado.getString("situacao"));
                pessoa.setDataCadastro(resultado.getString("datacadastro"));
                pessoa.setSenha(resultado.getString("senha"));
                pessoas.add(pessoa);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar Pessoas: " + e);
        }

        return pessoas;
    }

    //Método consultarProduto - apenas produto com o id informado    
    //Retorna objeto Produto
    public Pessoa consultarPessoa(String id) {

        Pessoa pessoa = null;

        try {
            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql
                    = "SELECT * "
                    + "FROM pessoa "
                    + "WHERE id_pessoa = " + id;

            System.out.println("SQL: " + sql);

            //Executa a instrução SQL fornecida e retorna um objeto SQLResultSet                     
            ResultSet resultado = st.executeQuery(sql);

            while (resultado.next()) {
                pessoa = new Pessoa();
                pessoa.setId(resultado.getInt("id_pessoa"));
                pessoa.setNome(resultado.getString("nome"));
                pessoa.setCPF(resultado.getString("cpf"));
                pessoa.setTipo(resultado.getString("tipo"));
                pessoa.setLogin(resultado.getString("login"));
                pessoa.setEmail(resultado.getString("email"));
                pessoa.setSituação(resultado.getString("situacao"));
                pessoa.setDataCadastro(resultado.getString("datacadastro"));
                pessoa.setSenha(resultado.getString("senha"));
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar pessoa: " + e);
        }

        return pessoa;
    }

    //Método excluir - retorna boolean
    public boolean excluir(int id) {

        try {
            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql
                    = "delete from pessoa "
                    + "where id_pessoa = " + id;

            System.out.println("SQL: " + sql);

            //Método executeUpdate - Executa a instrução SQL fornecida
            //pode ser uma instrução INSERT, UPDATE ou DELETE
            //Valor de retorno: Um int que indica o número de linhas afetadas             
            int resultado = st.executeUpdate(sql);

            return true;

        } catch (Exception e) {
            System.out.println("Erro ao excluir pessoa: " + e);
            return false;
        }

    }
    public byte[] gerarRelatorio() {
       
      try {    
                Connection conn = ConectionDB.getInstance().getConnection();
                String path="C:\\Users\\luisc\\Documents\\NetBeansProjects\\Sistema_versionamento_Requisitos\\relatorios\\pessoas.jrxml";
                JasperReport jr;
                jr = JasperCompileManager.compileReport(path);        
                JasperPrint  jp = JasperFillManager.fillReport(jr,null,conn);
                byte[] bytes = JasperRunManager.runReportToPdf(jr, null, conn);
                return bytes;
} catch (JRException e) 
{
            JOptionPane.showMessageDialog(null, "error "+e);
}

return null;
}
}
