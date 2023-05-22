CREATE SEQUENCE produtos_produto_id_seq;

CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL DEFAULT nextval('produtos_produto_id_seq'),
                imagem BYTEA NOT NULL,
                imagem_arquivo VARCHAR(512) NOT NULL,
                imagem_ultima_atualização DATE NOT NULL,
                nome VARCHAR(255) NOT NULL,
                imagem_mime_type VARCHAR(512) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                imagem_charset VARCHAR(512) NOT NULL,
                detalhes BYTEA NOT NULL,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);
COMMENT ON COLUMN produtos.produto_id IS 'Numero de identificação dos produtos';
COMMENT ON COLUMN produtos.imagem IS 'Imagem dos produtos';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Arquivo de imagem dos produtos';
COMMENT ON COLUMN produtos.imagem_ultima_atualização IS 'Ultima atualização das imagem dos produtos';
COMMENT ON COLUMN produtos.nome IS 'Nome dos produtos';
COMMENT ON COLUMN produtos.preco_unitario IS 'Preço unitário dos produtos';
COMMENT ON COLUMN produtos.detalhes IS 'Detalhes dos Produtos';


ALTER SEQUENCE produtos_produto_id_seq OWNED BY produtos.produto_id;

CREATE SEQUENCE lojas_loja_id_seq;

CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL DEFAULT nextval('lojas_loja_id_seq'),
                logo_arquivo VARCHAR(512) NOT NULL,
                logo_mime_type VARCHAR(512) NOT NULL,
                longitude NUMERIC NOT NULL,
                logo BYTEA NOT NULL,
                endereço_web VARCHAR(100) NOT NULL,
                logo_ultima_atualizacao DATE NOT NULL,
                logo_charset VARCHAR(512) NOT NULL,
                enderço_fisico VARCHAR(512) NOT NULL,
                latitude NUMERIC NOT NULL,
                nome VARCHAR(255) NOT NULL,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas IS '* Tabela com informações das lojas *';
COMMENT ON COLUMN lojas.loja_id IS 'Numero de identificação das lojas (PK)';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Arquivos das lojas';
COMMENT ON COLUMN lojas.longitude IS 'Longitude das lojas';
COMMENT ON COLUMN lojas.logo IS 'Logo das Lojas';
COMMENT ON COLUMN lojas.endereço_web IS 'Endereço WEB das lojas ';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Ultima atualização da logo das lojas ';
COMMENT ON COLUMN lojas.logo_charset IS 'charset das logos das lojas ';
COMMENT ON COLUMN lojas.enderço_fisico IS 'Endereço fisico das lojas';
COMMENT ON COLUMN lojas.latitude IS 'Latitude das lojas';
COMMENT ON COLUMN lojas.nome IS 'Nome das lojas';


ALTER SEQUENCE lojas_loja_id_seq OWNED BY lojas.loja_id;

CREATE SEQUENCE estoques_estoques_id_seq;

CREATE TABLE estoques (
                estoques_id NUMERIC(38) NOT NULL DEFAULT nextval('estoques_estoques_id_seq'),
                quantidade NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoques_id)
);
COMMENT ON COLUMN estoques.estoques_id IS 'Numuero de identificação dos estoques';
COMMENT ON COLUMN estoques.quantidade IS 'Quantidade de estoques';
COMMENT ON COLUMN estoques.loja_id IS 'Em qual loja esta o estoque (FK -> loja)';
COMMENT ON COLUMN estoques.produto_id IS 'Produtos que estão nos determinados estoques';


ALTER SEQUENCE estoques_estoques_id_seq OWNED BY estoques.estoques_id;

CREATE SEQUENCE cliente_cliente_id_seq;

CREATE TABLE cliente (
                cliente_id NUMERIC(38) NOT NULL DEFAULT nextval('cliente_cliente_id_seq'),
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20) NOT NULL,
                telefone2 VARCHAR(20) NOT NULL,
                telefone3 VARCHAR(20) NOT NULL,
                CONSTRAINT cliente_pk PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE cliente IS '* Tabela com informações dos clientes *';
COMMENT ON COLUMN cliente.cliente_id IS 'Identificação dos clientes (PK)';
COMMENT ON COLUMN cliente.email IS 'Email dos clientes';
COMMENT ON COLUMN cliente.nome IS 'Nome dos clientes';
COMMENT ON COLUMN cliente.telefone1 IS 'Telefone 1 dos clintes';
COMMENT ON COLUMN cliente.telefone2 IS 'Telefone 2 dos clientes';
COMMENT ON COLUMN cliente.telefone3 IS 'Telefone 3 dos clientes';


ALTER SEQUENCE cliente_cliente_id_seq OWNED BY cliente.cliente_id;

CREATE SEQUENCE envios_envio_id_seq;

CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL DEFAULT nextval('envios_envio_id_seq'),
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_de_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);
COMMENT ON COLUMN envios.envio_id IS 'Numero de identificação dos envios';
COMMENT ON COLUMN envios.loja_id IS 'Loja que fara o envio (FK -> loja)';
COMMENT ON COLUMN envios.cliente_id IS 'cleinte que receberá o envio (FK -> cleinte) ';
COMMENT ON COLUMN envios.endereco_de_entrega IS 'endereço da entrega';
COMMENT ON COLUMN envios.status IS 'Status da entrega';


ALTER SEQUENCE envios_envio_id_seq OWNED BY envios.envio_id;

CREATE SEQUENCE pedidos_pedidos_id_seq;

CREATE TABLE pedidos (
                pedidos_id NUMERIC(38) NOT NULL DEFAULT nextval('pedidos_pedidos_id_seq'),
                data_hora TIMESTAMP NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedidos_id)
);
COMMENT ON COLUMN pedidos.pedidos_id IS ' Numero de identificação do pedidos (PK)';
COMMENT ON COLUMN pedidos.data_hora IS 'Data e horas dos pedidos';
COMMENT ON COLUMN pedidos.loja_id IS 'Lojas que receberam os pedidos (FK -> lojas)';
COMMENT ON COLUMN pedidos.cliente_id IS 'clientes que fizeram os pedidos ( FK -> clientes)';
COMMENT ON COLUMN pedidos.status IS 'Status dos pedidos';


ALTER SEQUENCE pedidos_pedidos_id_seq OWNED BY pedidos.pedidos_id;

CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                pedidos_id NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id, pedidos_id)
);
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Identificação dos pedidos (PK)';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'identificação dos produtos que tambem é uma identificação dos pedidos_itens (PK) e (FK)';
COMMENT ON COLUMN pedidos_itens.pedidos_id IS 'identifcação do pedido que tambem é uma identificação do pedido_itens (PK) e (FK)';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'identificação do envio(FK)';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Preço de cada item dos pedidos';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Quantidade de itens dos pedidos';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Numero da linha dos pedidos';


ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT cliente_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES cliente (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT cliente_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES cliente (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedidos_id)
REFERENCES pedidos (pedidos_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
