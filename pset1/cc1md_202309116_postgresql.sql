-- Script SQL do banco de dados "lojas UVV"    ALUNO: Renan Libardi Rezende  /  TURMA: CC1MD


-- Comandos de criação e exlusão do usuário, sua senha e suas permissões e do banco de dados, esquema e sua conexão.



-- Comando de exclusão do usuário caso ele ja exista:

DROP DATABASE IF EXISTS uvv; 
DROP USER IF EXISTS renan;



-- Comando de criação do usuário e do banco de dados:

CREATE USER RENAN WITH 
createdb 
createrole
encrypted password 'rl97876681';

CREATE DATABASE uvv WITH 
ower              =   renan
encoding          =  "UTF8"
lc_collate        =  'pt_BR.UTF-8'
lc_ctype          =  'pt_BR.UTF-8'
allow_connections =   TRUE;
COMMENT ON DATABASE uvv IS 'Banco de dados que possui o pset1 do profesor Abrantes';



-- Conexão com o usuário e o banco de dados:

\setenv PGPASSWORD rl97876681
\c uvv renan;


-- Comando para criar o esquema:

 CREATE SCHEMA IF NOT EXISTS lojas
 AUTHORIZATION renan;
 COMMENT ON SCHEMA lojas IS 'Esquema  do  banco de dados do pset1';
            
-- Comando do caminho da conexão 
 ALTER USER renan
 SET SEARCH_PATH TO lojas, "$user", public;




-- Criação das Tabelas com suas respectivas colunas e seus comentários.


  -- Tabela dos "produtos" e suas respectivas colunas:

CREATE TABLE lojas.produtos (
                produto_id                   NUMERIC(38)     NOT NULL,
                imagem                       BYTEA           ,
                imagem_arquivo               VARCHAR(512)    ,
                imagem_ultima_atualização    DATE            ,
                nome                         VARCHAR(255)    NOT NULL,
                imagem_mime_type             VARCHAR(512)    ,
                preco_unitario               NUMERIC(10,2)   NOT NULL,
                imagem_charset               VARCHAR(512)    ,
                detalhes                     BYTEA           ,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);



 -- Comentários da tabela e das colunas "produtos" respectivamente:
 
COMMENT ON TABLE  lojas.produtos                           IS 'Tabela com informações dos produtos';       
COMMENT ON COLUMN lojas.produtos.produto_id                IS 'Numero de identificação dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem                    IS 'Imagem dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo            IS 'Arquivo de imagem dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualização IS 'Ultima atualização das imagem dos produtos';
COMMENT ON COLUMN lojas.produtos.nome                      IS 'Nome dos produtos';
COMMENT ON COLUMN lojas.produtos.preco_unitario            IS 'Preço unitário dos produtos';
COMMENT ON COLUMN lojas.produtos.detalhes                  IS 'Detalhes dos Produtos';

-- Tabela das "lojas" e suas respectivas colunas:

CREATE TABLE lojas.lojas (
                loja_id                    NUMERIC(38)  NOT NULL ,
                logo_arquivo               VARCHAR(512) ,
                logo_mime_type             VARCHAR(512) ,
                longitude                  NUMERIC      ,
                logo                       BYTEA        ,
                endereço_web               VARCHAR(100) ,
                logo_ultima_atualizacao    DATE         ,
                logo_charset               VARCHAR(512) ,
                enderço_fisico             VARCHAR(512) ,
                latitude                   NUMERIC      ,
                nome                       VARCHAR(255) NOT NULL,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)                   
);



 -- Comentários da tabela e das colunas "lojas" respectivamente:
 
COMMENT ON TABLE  lojas.lojas                         IS 'Tabela com informações das lojas';
COMMENT ON COLUMN lojas.lojas.loja_id                 IS 'Numero de identificação das lojas (PK)';
COMMENT ON COLUMN lojas.lojas.logo_arquivo            IS 'Arquivos das lojas';
COMMENT ON COLUMN lojas.lojas.longitude               IS 'Longitude das lojas';
COMMENT ON COLUMN lojas.lojas.logo                    IS 'Logo das Lojas';
COMMENT ON COLUMN lojas.lojas.endereço_web            IS 'Endereço WEB das lojas ';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Ultima atualização da logo das lojas ';
COMMENT ON COLUMN lojas.lojas.logo_charset            IS 'charset das logos das lojas ';
COMMENT ON COLUMN lojas.lojas.enderço_fisico          IS 'Endereço fisico das lojas';
COMMENT ON COLUMN lojas.lojas.latitude                IS 'Latitude das lojas';
COMMENT ON COLUMN lojas.lojas.nome                    IS 'Nome das lojas';

-- Tabela dos "estoques" e suas respectivas colunas:

CREATE TABLE lojas.estoques (
                estoques_id   NUMERIC(38)    NOT NULL,
                quantidade    NUMERIC(38)    NOT NULL,
                loja_id       NUMERIC(38)    NOT NULL,
                produto_id    NUMERIC(38)    NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);



 -- Comentários da tabela e das colunas "lojas" respectivamente:
 
COMMENT ON TABLE  lojas.estoques              IS 'Tabela com informçôes dos estoques';
COMMENT ON COLUMN lojas.estoques.estoques_id  IS 'Numuero de identificação dos estoques';
COMMENT ON COLUMN lojas.estoques.quantidade   IS 'Quantidade de estoques';
COMMENT ON COLUMN lojas.estoques.loja_id      IS 'Em qual loja esta o estoque (FK -> loja)';
COMMENT ON COLUMN lojas.estoques.produto_id   IS 'Produtos que estão nos determinados estoques';



-- Tabela dos "clientes" e suas respectivas colunas:

CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38)   NOT NULL ,
                email      VARCHAR(255)  NOT NULL,
                nome       VARCHAR(255)  NOT NULL,
                telefone1  VARCHAR(20) ,
                telefone2  VARCHAR(20) ,
                telefone3  VARCHAR(20) ,
                CONSTRAINT cliente_pk PRIMARY KEY (cliente_id)
);

 -- Comentários da tabela e das colunas "clientes" respectivamente:
 
COMMENT ON TABLE lojas.clientes IS       'Tabela com informações dos clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'Identificação dos clientes (PK)';
COMMENT ON COLUMN clientes.email IS      'Email dos clientes';
COMMENT ON COLUMN clientes.nome IS       'Nome dos clientes';
COMMENT ON COLUMN clientes.telefone1 IS  'Telefone 1 dos clintes';
COMMENT ON COLUMN clientes.telefone2 IS  'Telefone 2 dos clientes';
COMMENT ON COLUMN clientes.telefone3 IS  'Telefone 3 dos clientes';



-- Tabela dos "envios" e suas respectivas colunas:

CREATE TABLE lojas.envios (
                envio_id              NUMERIC(38)      NOT NULL,
                loja_id               NUMERIC(38)      NOT NULL,
                cliente_id            NUMERIC(38)      NOT NULL,
                endereco_de_entrega   VARCHAR(512)     NOT NULL,
                status                VARCHAR(15)      NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
                    
);

 -- Comentários da tabela e das colunas "envios" respectivamente:
 
COMMENT ON TABLE  lojas.envios                     IS 'Tabela com  informações dos envios';
COMMENT ON COLUMN lojas.envios.envio_id            IS 'Numero de identificação dos envios';
COMMENT ON COLUMN lojas.envios.loja_id             IS 'Loja que fara o envio (FK -> loja)';
COMMENT ON COLUMN lojas.envios.cliente_id          IS 'cleinte que receberá o envio (FK -> cleinte) ';
COMMENT ON COLUMN lojas.envios.endereco_de_entrega IS 'endereço da entrega';
COMMENT ON COLUMN lojas.envios.status              IS 'Status da entrega';



-- Tabela dos "pedidos" e suas respectivas colunas:

CREATE TABLE lojas.pedidos (
                pedidos_id                NUMERIC(38)   NOT NULL,
                data_hora                 TIMESTAMP     NOT NULL,
                loja_id                   NUMERIC(38)   NOT NULL,
                cliente_id                NUMERIC(38)   NOT NULL,
                status                    VARCHAR(15)   NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
                    
);

 -- Comentários da tabela e das colunas "pedidos" respectivamente:

COMMENT ON TABLE  lojas.pedidos             IS 'Tabela com informações dos pedidos';
COMMENT ON COLUMN lojas.pedidos.pedidos_id  IS ' Numero de identificação do pedidos (PK)';
COMMENT ON COLUMN lojas.pedidos.data_hora   IS 'Data e horas dos pedidos';
COMMENT ON COLUMN lojas.pedidos.loja_id     IS 'Lojas que receberam os pedidos (FK -> lojas)';
COMMENT ON COLUMN lojas.pedidos.cliente_id  IS 'clientes que fizeram os pedidos ( FK -> clientes)';
COMMENT ON COLUMN lojas.pedidos.status      IS 'Status dos pedidos';



-- Tabela dos "pedidos_itens" e suas respectivas colunas:

CREATE TABLE lojas.pedidos_itens (
                pedido_id          NUMERIC(38)     NOT NULL,
                produto_id         NUMERIC(38)     NOT NULL,               
                envio_id           NUMERIC(38)     NOT NULL,
                preco_unitario     NUMERIC(10,2)   NOT NULL,
                quantidade         NUMERIC(38)     NOT NULL,
                numero_da_linha    NUMERIC(38)     NOT NULL,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

-- Comentários da tabela e das colunas "pedidos_itens" respectivamente:

COMMENT ON TABLE  lojas.pedidos_itens                  IS 'Tabela com informações dos itens dos pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id        IS 'Identificação dos pedidos (PK)';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id       IS 'identificação dos produtos que tambem é uma identificação dos pedidos_itens (PK) e (FK)';
COMMENT ON COLUMN lojas.pedidos_itens.pedidos_id       IS 'identifcação do pedido que tambem é uma identificação do pedido_itens (PK) e (FK)';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id         IS 'identificação do envio(FK)';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario   IS 'Preço de cada item dos pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade       IS 'Quantidade de itens dos pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha  IS 'Numero da linha dos pedidos';





-- Relacionamentos entre tabelas:
  
  
        -- Relacionamento não identificado entre tabelas "clientes" e "pedidos":
        
   ALTER TABLE lojas.pedidos ADD CONSTRAINT fk_clientes_pedidos
   FOREIGN KEY (cliente_id)
   REFERENCES lojas.clientes (cliente_id)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION
   NOT DEFERRABLE;


        -- Relacionamento não identificado entre as tabelas "clientes" e "envios":
        
   ALTER TABLE lojas.envios ADD CONSTRAINT fk_clientes_envios
   FOREIGN KEY (cliente_id)
   REFERENCES lojas.clientes (cliente_id)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION
   NOT DEFERRABLE;


        -- Relacionamento não identificado entre as tabelas "produtos" e "estoques":
        
   ALTER TABLE lojas.estoques ADD CONSTRAINT fk_produtos_estoques
   FOREIGN KEY (produto_id)
   REFERENCES lojas.produtos (produto_id)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION
   NOT DEFERRABLE;


        -- Relacionamento não identificado entre as tabelas "lojas" e "estoques":
        
    ALTER TABLE lojas.estoques ADD CONSTRAINT fk_lojas_estoques
    FOREIGN KEY (loja_id)
    REFERENCES lojas.lojas (loja_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


        -- Relacionamento não identificado entre as tabelas "lojas" e "envios":
        
    ALTER TABLE lojas.envios ADD CONSTRAINT fk_lojas_envios
    FOREIGN KEY (loja_id)
    REFERENCES lojas.lojas (loja_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


        -- Relacionamento não identificado entre as tabelas "lojas" e "pedidos":
        
    ALTER TABLE lojas.pedidos ADD CONSTRAINT fk_lojas_pedidos
    FOREIGN KEY (loja_id)
    REFERENCES lojas.lojas (loja_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

        -- Relacionamento não identificado entre as tabelas "envios" e "pedidos_itens":
        
    ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT fk_envios_pedidos_itens
    FOREIGN KEY (envio_id)
    REFERENCES lojas.envios (envio_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


        -- Relacionamento identificado entre as tabelas "pedidos" e "pedidos_itens":
        
    ALTER TABLE lojas.pedidos_itens  ADD CONSTRAINT fk_pedidos_pedidos_itens
    FOREIGN KEY (pedido_id)
    REFERENCES lojas.pedidos (pedido_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


        -- Relacionamento identificado entre as tabelas "produtos" e "pedidos_itens":
        
    ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT fk_produtos_pedidos_itens
    FOREIGN KEY (produto_id)
    REFERENCES lojas.produtos (produto_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
    
    
    
   -- Cntraints definindo os dados que serão permitidos em cada coluna:
    
  -- Constraints que impedem quantidades negativas:
     ALTER TABLE lojas.pedidos_itens
     ADD CONSTRAINT cc_pedidos_itens_quantidade
     CHECK( quantidade > 0 );

     ALTER TABLE lojas.estoques
     ADD CONSTRAINT cc_estoques_quantidade
     CHECK( quantidade > 0 );
            
   -- Constraint que impede preço unitario negativo:
     ALTER TABLE lojas.produtos
     ADD CONSTRAINT cc_produtos_preco_unitario
     CHECK( preco_unitario > 0 );

     ALTER TABLE lojas.pedidos_itens
     ADD CONSTRAINT cc_pedidos_itens_preco_unitario
     CHECK( preco_unitario > 0 );    
     
   -- Constraints que determina parâmetros obrigatorios em colunas de status:
      ALTER TABLE  lojas.pedidos
      ADD CONSTRAINT cc_pedidos_status
      CHECK( status in('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO') );

      ALTER TABLE  lojas.envios
      ADD CONSTRAINT cc_envios_status
      CHECK( status in('CRIADO','ENVIADO','TRANSITO','ENTREGUE') );

  
            
            
            
            
            
            
            
            
    
