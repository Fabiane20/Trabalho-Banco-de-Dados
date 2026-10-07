-- 1. CRIAÇÃO DAS TABELAS (DDL)

CREATE TABLE categoria (
    id_categoria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(50) NOT NULL,
    descricao VARCHAR2(500)
);

CREATE TABLE produto (
    id_produto NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    preco_venda NUMBER(10,2) NOT NULL,
    estoque_atual NUMBER DEFAULT 0 NOT NULL,
    id_categoria NUMBER NOT NULL,
    CONSTRAINT fk_prod_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE fornecedor (
    id_fornecedor NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    razao_social VARCHAR2(100) NOT NULL,
    cnpj VARCHAR2(18) NOT NULL UNIQUE,
    telefone VARCHAR2(15),
    segmento VARCHAR2(80) NOT NULL
);

CREATE TABLE funcionario (
    id_funcionario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    cargo VARCHAR2(50) NOT NULL,
    funcao_principal VARCHAR2(100) NOT NULL
);

CREATE TABLE compra_fornecedor (
    id_compra NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_compra DATE NOT NULL,
    valor_total NUMBER(10,2) DEFAULT 0.00 NOT NULL,
    id_fornecedor NUMBER NOT NULL,
    id_funcionario NUMBER NOT NULL,
    CONSTRAINT fk_compra_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor),
    CONSTRAINT fk_compra_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE item_compra (
    id_compra NUMBER NOT NULL,
    id_produto NUMBER NOT NULL,
    quantidade NUMBER NOT NULL,
    preco_custo_unitario NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_item_compra PRIMARY KEY (id_compra, id_produto),
    CONSTRAINT fk_item_compra FOREIGN KEY (id_compra) REFERENCES compra_fornecedor(id_compra),
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE venda (
    id_venda NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_venda DATE NOT NULL,
    canal_venda VARCHAR2(30) NOT NULL,
    valor_total NUMBER(10,2) NOT NULL,
    id_funcionario NUMBER NOT NULL,
    CONSTRAINT fk_venda_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

-- 2. INSERÇÃO DE DADOS (DML)

INSERT INTO categoria (nome, descricao) VALUES ('Flores e Folhagens', 'Flores cortadas, buquês e arranjos folhosos');
INSERT INTO categoria (nome, descricao) VALUES ('Mudas de Flores', 'Mudas floridas para plantio direto e vasos');
INSERT INTO categoria (nome, descricao) VALUES ('Vasos de Cimento', 'Vasos artesanais e reforçados de cimento');
INSERT INTO categoria (nome, descricao) VALUES ('Fitas e Cachepôs', 'Fitas decorativas, laços e cachepôs de presente');
INSERT INTO categoria (nome, descricao) VALUES ('Utensílios e Bazar', 'Tesouras de poda, regadores e artigos de decoração');
INSERT INTO categoria (nome, descricao) VALUES ('Horta e Jardim', 'Sementes, mudas de hortaliças e insumos para jardim');

INSERT INTO produto (nome, preco_venda, estoque_atual, id_categoria) VALUES ('Arranjo de Rosas Vermelhas', 110.00, 12, 1);
INSERT INTO produto (nome, preco_venda, estoque_atual, id_categoria) VALUES ('Muda de Amor-Perfeito', 8.00, 45, 2);
INSERT INTO produto (nome, preco_venda, estoque_atual, id_categoria) VALUES ('Vaso de Cimento Rústico M', 55.00, 10, 3);
INSERT INTO produto (nome, preco_venda, estoque_atual, id_categoria) VALUES ('Fita Acetinada Decorativa 50m', 25.00, 30, 4);
INSERT INTO produto (nome, preco_venda, estoque_atual, id_categoria) VALUES ('Regador Plástico 5L', 38.00, 15, 5);
INSERT INTO produto (nome, preco_venda, estoque_atual, id_categoria) VALUES ('Semente de Alface Crespa', 6.00, 60, 6);
INSERT INTO produto (nome, preco_venda, estoque_atual, id_categoria) VALUES ('Muda de Hortelã', 5.00, 25, 6);
INSERT INTO produto (nome, preco_venda, estoque_atual, id_categoria) VALUES ('Cachepô de Madeira P', 18.00, 0, 4);

INSERT INTO fornecedor (razao_social, cnpj, telefone, segmento) VALUES ('Ateliê das Fitas e Laços', '12.345.678/0001-01', '(51) 99111-1001', 'Fitas e Cachepôs');
INSERT INTO fornecedor (razao_social, cnpj, telefone, segmento) VALUES ('Sul Embalagens & Cachepôs', '12.345.678/0001-02', '(51) 99111-1002', 'Fitas e Cachepôs');
INSERT INTO fornecedor (razao_social, cnpj, telefone, segmento) VALUES ('Bazar & Utensílios Flores Ltda', '23.456.789/0001-03', '(51) 99222-2001', 'Utensílios e Bazar');
INSERT INTO fornecedor (razao_social, cnpj, telefone, segmento) VALUES ('Viveiro Central Mudas', '34.567.890/0001-04', '(51) 99333-3001', 'Mudas de Flores');
INSERT INTO fornecedor (razao_social, cnpj, telefone, segmento) VALUES ('Holambra Distribuidora de Flores', '45.678.901/0001-05', '(19) 3802-9000', 'Flores e Folhagens');
INSERT INTO fornecedor (razao_social, cnpj, telefone, segmento) VALUES ('Verde Vida Folhagens', '45.678.901/0001-06', '(51) 99444-4001', 'Flores e Folhagens');
INSERT INTO fornecedor (razao_social, cnpj, telefone, segmento) VALUES ('Arte Cimento Vasos Rústicos', '56.789.012/0001-07', '(51) 99555-5001', 'Vasos de Cimento');
INSERT INTO fornecedor (razao_social, cnpj, telefone, segmento) VALUES ('Pedra & Cimento Decor', '56.789.012/0001-08', '(51) 99555-5002', 'Vasos de Cimento');
INSERT INTO fornecedor (razao_social, cnpj, telefone, segmento) VALUES ('AgroHorta Sementes e Mudas', '67.890.123/0001-09', '(51) 99666-6001', 'Horta, Jardim e Sementes');

INSERT INTO funcionario (nome, cargo, funcao_principal) VALUES ('Dona Maria (Mãe)', 'Sócia / Vendedora', 'Atendimento Presencial/WhatsApp e Compras de Estoque');
INSERT INTO funcionario (nome, cargo, funcao_principal) VALUES ('Fabi (Filha)', 'Sócia / Gestora', 'Gestão Organizacional, Contábil e Marketing');

INSERT INTO compra_fornecedor (data_compra, valor_total, id_fornecedor, id_funcionario) VALUES (DATE '2026-09-05', 850.00, 5, 1);
INSERT INTO compra_fornecedor (data_compra, valor_total, id_fornecedor, id_funcionario) VALUES (DATE '2026-09-12', 300.00, 1, 2);
INSERT INTO compra_fornecedor (data_compra, valor_total, id_fornecedor, id_funcionario) VALUES (DATE '2026-09-18', 400.00, 7, 1);
INSERT INTO compra_fornecedor (data_compra, valor_total, id_fornecedor, id_funcionario) VALUES (DATE '2026-09-25', 520.00, 9, 2);

INSERT INTO item_compra (id_compra, id_produto, quantidade, preco_custo_unitario) VALUES (1, 1, 15, 45.00);
INSERT INTO item_compra (id_compra, id_produto, quantidade, preco_custo_unitario) VALUES (1, 2, 25, 4.00);
INSERT INTO item_compra (id_compra, id_produto, quantidade, preco_custo_unitario) VALUES (2, 4, 20, 15.00);
INSERT INTO item_compra (id_compra, id_produto, quantidade, preco_custo_unitario) VALUES (3, 3, 10, 28.00);
INSERT INTO item_compra (id_compra, id_produto, quantidade, preco_custo_unitario) VALUES (4, 6, 50, 2.50);
INSERT INTO item_compra (id_compra, id_produto, quantidade, preco_custo_unitario) VALUES (4, 7, 30, 2.00);

INSERT INTO venda (data_venda, canal_venda, valor_total, id_funcionario) VALUES (DATE '2026-10-01', 'WhatsApp', 110.00, 1);
INSERT INTO venda (data_venda, canal_venda, valor_total, id_funcionario) VALUES (DATE '2026-10-01', 'Presencial', 63.00, 1);
INSERT INTO venda (data_venda, canal_venda, valor_total, id_funcionario) VALUES (DATE '2026-10-02', 'WhatsApp', 165.00, 1);
INSERT INTO venda (data_venda, canal_venda, valor_total, id_funcionario) VALUES (DATE '2026-10-02', 'Instagram', 55.00, 2);
INSERT INTO venda (data_venda, canal_venda, valor_total, id_funcionario) VALUES (DATE '2026-10-03', 'WhatsApp', 88.00, 1);
INSERT INTO venda (data_venda, canal_venda, valor_total, id_funcionario) VALUES (DATE '2026-10-03', 'Facebook', 38.00, 2);
INSERT INTO venda (data_venda, canal_venda, valor_total, id_funcionario) VALUES (DATE '2026-10-04', 'Presencial', 120.00, 1);

COMMIT;