CREATE DATABASE SVR-VersionamentoRequisitos;
CREATE TABLE IF NOT EXISTS pessoa 
(
	id_pessoa SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	tipo VARCHAR(20) NOT NULL,
	login VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	situacao VARCHAR(10) NOT NULL,
	dataCadastro DATE,
	senha VARCHAR(200)
);
CREATE TABLE IF NOT EXISTS projeto
(
	id_projeto SERIAL PRIMARY KEY,
        nome VARCHAR(100) NOT NULL,
	prazo_entrega DATE NOT NULL,
	data_cadastro DATE,
        status VARCHAR(30) NOT NULL,
	responsavel_id INTEGER NOT NULL,
	CONSTRAINT fk_responsavel 
		FOREIGN KEY (responsavel_id) 
		REFERENCES pessoa(id_pessoa)
);
CREATE TABLE IF NOT EXISTS requisito
(
	id_requisito SERIAL PRIMARY KEY,
	referencia VARCHAR(100) NOT NULL,
	requisito VARCHAR(100) NOT NULL,
	descricao VARCHAR(300) NOT NULL,
	versao DECIMAL NOT NULL,
	status VARCHAR(40) NOT NULL,
	prioridade VARCHAR(40) NOT NULL,
	complexidade VARCHAR(40) NOT NULL,
	tipo VARCHAR(40) NOT NULL,
	projeto_id INTEGER NOT NULL,
	responsavel_id INTEGER NOT NULL
);
ALTER TABLE projeto
	ADD CONSTRAINT fk_responsavel_projeto
	FOREIGN KEY (responsavel_id) 
	REFERENCES pessoa(id_pessoa);

ALTER TABLE requisito
	ADD CONSTRAINT fk_responsavel_requisito
	FOREIGN KEY (responsavel_id) 
	REFERENCES pessoa(id_pessoa);
	
ALTER TABLE requisito
	ADD CONSTRAINT fk_projeto
	FOREIGN KEY (projeto_id) 
	REFERENCES projeto(id_projeto);