/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entidade.Pessoa;
import java.sql.ResultSet;
import java.sql.Statement;
import apoio.ConectionDB;


/**
 *
 * @author luisc
 */
public class LoginDAO {
    
        public boolean logar(Pessoa usuario){
        
        boolean retorno = false;
        
        try {
            //Cria a conexao 
            Statement st = ConectionDB.getInstance().getConnection().createStatement();
            String sql 
                    = "SELECT (nome, senha) FROM pessoa "
                    + "WHERE login='"+usuario.getLogin()+"' "
                    + "AND senha='"+usuario.getSenha()+"'";
                    
            System.out.println("SQL: " + sql);
            
            //Executa a instrução SQL fornecida e retorna um objeto SQLResultSet 
            //ResultSet é uma tabela de dados que representa um conjunto de resultados
            ResultSet resultado = st.executeQuery(sql);
             
            
            
            // O método next move o cursor para a próxima linha 
            //e retorna false quando não há mais linhas no ResultSetobjeto.
            if (resultado.next()) {
                retorno = true;
                
                System.out.println("Login efetuado com sucesso!");
            }            
        
        } catch(Exception e) {
            System.out.println("Erro ao buscar usuario: " + e);
        }
        
        return retorno;        
    }
}
