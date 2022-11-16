/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

import apoio.ConectionDB;
import entidade.Projeto;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import entidade.Requisito;

import entidade.Requisito;
import java.sql.Connection;
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
public class RequisitoDAO {
    
    //Método salvar - retorna Boolean

    public boolean salvar(Requisito requisito) {
        try {
            //Cria a conexao
            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql = "";

            if (requisito.getId() == 0){

                sql = "INSERT INTO requisito VALUES ("
                        + "default,"
                        + "'" + requisito.getReferencia()+ "', "
                        + "'" + requisito.getRequisito()+ "', "
                        + "'" + requisito.getDescricao()+ "', "
                        + "'" + requisito.getVersao()+ "', "
                        + "'" + requisito.getStatus()+ "', "
                        + "'" + requisito.getPrioridade()+ "', "
                        + "'" + requisito.getComplexidade()+ "', "
                        + "'" + requisito.getTipo()+ "', "
                        + "'" + requisito.getProjeto()+ "', "
                        + "" + requisito.getResponsavel()+ "); ";
                        
                System.out.println("SQL: " + sql);
            } else {
                sql = "UPDATE requisito "
                        + "SET referencia = '" + requisito.getReferencia()+ "', "
                        + "SET requisito = '" + requisito.getRequisito()+ "', "
                        + "SET descricao = '" + requisito.getDescricao()+ "', "
                        + "SET versao = '" + requisito.getVersao()+ "', "
                        + "SET status = '" + requisito.getStatus()+ "', "
                        + "SET prioridade = '" + requisito.getPrioridade()+ "', "
                        + "SET complexidade = '" + requisito.getComplexidade()+ "', "
                        + "SET tipo = '" + requisito.getTipo()+ "', "
                        + "SET projeto_id = '" + requisito.getProjeto()+ "', "
                        + "SET responsavel_id = '" + requisito.getResponsavel()+ ");";
                        
                System.out.println(sql);
            }
            int resultado = st.executeUpdate(sql);

            return true;

        } catch (Exception e) {
            System.out.println("Erro ao salvar projeto: " + e);
            return false;
        }
    }


    public ArrayList<Requisito> listarRequisitos(String tipo) {

        ArrayList<Requisito> requisitos = new ArrayList();

        try {

            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql
                    = "SELECT * "
                    + "FROM requisito "
                    + "WHERE tipo = '"+ tipo +"';";

            System.out.println("SQL: " + sql);

            //Executa a instrução SQL fornecida e retorna um objeto SQLResultSet                     
            ResultSet resultado = st.executeQuery(sql);

            while (resultado.next()) {
                Requisito requisito = new Requisito();
                requisito.setId(resultado.getInt("id_requisito"));
                requisito.setReferencia(resultado.getString("referencia"));
                requisito.setRequisito(resultado.getString("requisito"));
                requisito.setDescricao(resultado.getString("descricao"));
                requisito.setVersao(resultado.getString("versao"));
                requisito.setStatus(resultado.getString("status"));
                requisito.setPrioridade(resultado.getString("prioridade"));
                requisito.setComplexidade(resultado.getString("complexidade"));
                requisito.setTipo(resultado.getString("tipo"));
                requisito.setProjeto(resultado.getString("projeto_id"));
                requisito.setResponsavel(resultado.getString("responsavel_id"));

                requisitos.add(requisito);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar requisitos: " + e);
        }

        return requisitos;
    }

    //Método consultarProduto - apenas produto com o id informado    
    //Retorna objeto Produto
    public Requisito consultarRequisito(int id) {

        Requisito requisito = new Requisito();

        try {
            Statement st = ConectionDB.getInstance().getConnection().createStatement();

            String sql
                    = "SELECT * "
                    + "FROM requisito "
                    + "WHERE id_requisito = " + id;

            System.out.println("SQL: " + sql);

            //Executa a instrução SQL fornecida e retorna um objeto SQLResultSet                     
            ResultSet resultado = st.executeQuery(sql);

            while (resultado.next()) {
                requisito.setId(resultado.getInt("id_requisito"));
                requisito.setReferencia(resultado.getString("referencia"));
                requisito.setRequisito(resultado.getString("requisito"));
                requisito.setDescricao(resultado.getString("descricao"));
                requisito.setVersao(resultado.getString("versao"));
                requisito.setStatus(resultado.getString("status"));
                requisito.setPrioridade(resultado.getString("prioridade"));
                requisito.setComplexidade(resultado.getString("complexidade"));
                requisito.setTipo(resultado.getString("tipo"));
                requisito.setProjeto(resultado.getString("projeto_id"));
                requisito.setResponsavel(resultado.getString("responsavel_id"));
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar projeto: " + e);
        }

        return requisito;
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
        public byte[] gerarRelatorio() {
       
      try {    
                Connection conn = ConectionDB.getInstance().getConnection();
                String path="C:\\Users\\luisc\\Documents\\NetBeansProjects\\Sistema_versionamento_Requisitos\\relatorios\\requisitos.jrxml";
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

