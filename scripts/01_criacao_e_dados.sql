CREATE TABLE cliente (
  id_cliente NUMBER GENERATED ALWAYS AS IDENTITY,
  nome_cliente VARCHAR2(100) NOT NULL,
  telefone VARCHAR2(20) NOT NULL,
  PRIMARY KEY (id_cliente)
);

CREATE TABLE categoria (
  id_categoria NUMBER GENERATED ALWAYS AS IDENTITY,
  nome_categoria VARCHAR2(60) NOT NULL,
  descricao_categoria VARCHAR2(150),
  PRIMARY KEY (id_categoria)
);

CREATE TABLE produto (
  id_produto NUMBER GENERATED ALWAYS AS IDENTITY,
  nome_produto VARCHAR2(100) NOT NULL,
  descricao_produto VARCHAR2(150),
  preco_venda NUMBER(10,2) NOT NULL,
  qtd_estoque NUMBER,
  qtd_minima NUMBER,
  id_categoria NUMBER NOT NULL,
  PRIMARY KEY (id_produto),
  CONSTRAINT fk_produto_categoria1
    FOREIGN KEY (id_categoria)
    REFERENCES categoria (id_categoria)
);

CREATE TABLE fornecedor (
  id_fornecedor NUMBER GENERATED ALWAYS AS IDENTITY,
  nome_fornecedor VARCHAR2(100) NOT NULL,
  cnpj_fornecedor VARCHAR2(14),
  telefone_fornecedor VARCHAR2(20),
  cidade_fornecedor VARCHAR2(150),
  PRIMARY KEY (id_fornecedor)
);

CREATE TABLE venda (
  id_venda NUMBER GENERATED ALWAYS AS IDENTITY,
  data_venda DATE NOT NULL,
  valor_total_venda NUMBER(10,2) NOT NULL,
  forma_pagamento VARCHAR2(30) NOT NULL,
  canal_venda VARCHAR2(20) NOT NULL,
  situacao VARCHAR2(20) NOT NULL,
  modalidade VARCHAR2(30) NOT NULL,
  taxa_entrega NUMBER(10,2) DEFAULT 0 NOT NULL,
  endereco_entrega VARCHAR2(200),
  data_prevista DATE,
  retirado_por VARCHAR2(100),
  id_cliente NUMBER NOT NULL,
  PRIMARY KEY (id_venda),
  CONSTRAINT fk_venda_cliente1
    FOREIGN KEY (id_cliente)
    REFERENCES cliente (id_cliente),
  CONSTRAINT ck_venda_forma_pagamento
    CHECK (forma_pagamento IN ('Dinheiro', 'PIX', 'Débito', 'Crédito', 'Transferência Bancária')),
  CONSTRAINT ck_venda_canal
    CHECK (canal_venda IN ('Presencial', 'WhatsApp', 'Instagram')),
  CONSTRAINT ck_venda_situacao
    CHECK (situacao IN ('Encomendada', 'Pronta', 'Entregue', 'Realizada', 'Cancelada')),
  CONSTRAINT ck_venda_modalidade
    CHECK (modalidade IN ('Retirada', 'Entrega', 'Serviço no Local'))
);

CREATE TABLE compra (
  id_compra NUMBER GENERATED ALWAYS AS IDENTITY,
  data_compra DATE NOT NULL,
  valor_total_compra NUMBER(10,2) NOT NULL,
  forma_pagamento VARCHAR2(30) NOT NULL,
  situacao_compra VARCHAR2(20) NOT NULL,
  id_fornecedor NUMBER NOT NULL,
  PRIMARY KEY (id_compra),
  CONSTRAINT fk_compra_fornecedor1
    FOREIGN KEY (id_fornecedor)
    REFERENCES fornecedor (id_fornecedor),
  CONSTRAINT ck_compra_forma_pagamento
    CHECK (forma_pagamento IN ('Dinheiro', 'PIX', 'Débito', 'Crédito', 'Transferência Bancária')),
  CONSTRAINT ck_compra_situacao
    CHECK (situacao_compra IN ('Solicitada', 'Recebida', 'Cancelada'))
);

CREATE TABLE item_venda (
  id_venda NUMBER NOT NULL,
  id_produto NUMBER NOT NULL,
  quantidade NUMBER NOT NULL,
  preco_unitario NUMBER(10,2) NOT NULL,
  PRIMARY KEY (id_venda, id_produto),
  CONSTRAINT fk_item_venda_venda
    FOREIGN KEY (id_venda)
    REFERENCES venda (id_venda),
  CONSTRAINT fk_item_venda_produto1
    FOREIGN KEY (id_produto)
    REFERENCES produto (id_produto)
);

CREATE TABLE item_compra (
  id_compra NUMBER NOT NULL,
  id_produto NUMBER NOT NULL,
  quantidade NUMBER NOT NULL,
  preco_unitario NUMBER(10,2) NOT NULL,
  PRIMARY KEY (id_compra, id_produto),
  CONSTRAINT fk_item_compra_compra1
    FOREIGN KEY (id_compra)
    REFERENCES compra (id_compra),
  CONSTRAINT fk_item_compra_produto1
    FOREIGN KEY (id_produto)
    REFERENCES produto (id_produto)
);


-- INSERTS DA FLORICULTURA 
-- CATEGORIA (ids 1 a 8)
INSERT INTO categoria (nome_categoria, descricao_categoria) VALUES ('Orquídeas', 'Orquídeas de vários tipos');
INSERT INTO categoria (nome_categoria, descricao_categoria) VALUES ('Suculentas', 'Suculentas e cactos');
INSERT INTO categoria (nome_categoria, descricao_categoria) VALUES ('Folhagens', 'Plantas de folhagem para interior');
INSERT INTO categoria (nome_categoria, descricao_categoria) VALUES ('Frutíferas e Árvores', 'Mudas frutíferas e árvores');
INSERT INTO categoria (nome_categoria, descricao_categoria) VALUES ('Vasos e Insumos', 'Vasos, terra e pedras');
INSERT INTO categoria (nome_categoria, descricao_categoria) VALUES ('Bazar e Presentes', 'Itens de bazar, pelúcias e chás');
INSERT INTO categoria (nome_categoria, descricao_categoria) VALUES ('Serviços', 'Jardinagem, arranjos e decoração');
INSERT INTO categoria (nome_categoria, descricao_categoria) VALUES ('Embalagens, fitas e materiais de montagem', 'Materiais de uso interno para embalar presentes e montar arranjos');

-- CLIENTE (ids 1 a 10)
INSERT INTO cliente (nome_cliente, telefone) VALUES ('Maria Silva', '51991110001');
INSERT INTO cliente (nome_cliente, telefone) VALUES ('João Pereira', '51991110002');
INSERT INTO cliente (nome_cliente, telefone) VALUES ('Ana Souza', '51991110003');
INSERT INTO cliente (nome_cliente, telefone) VALUES ('Carlos Mendes', '51991110004');
INSERT INTO cliente (nome_cliente, telefone) VALUES ('Fernanda Lima', '51991110005');
INSERT INTO cliente (nome_cliente, telefone) VALUES ('Paulo Ribeiro', '51991110006');
INSERT INTO cliente (nome_cliente, telefone) VALUES ('Juliana Costa', '51991110007');
INSERT INTO cliente (nome_cliente, telefone) VALUES ('Roberto Alves', '51991110008');
INSERT INTO cliente (nome_cliente, telefone) VALUES ('Patrícia Gomes', '51991110009');
INSERT INTO cliente (nome_cliente, telefone) VALUES ('Luciana Martins', '51991110010');

-- FORNECEDOR (ids 1 a 5)
INSERT INTO fornecedor (nome_fornecedor, cnpj_fornecedor, telefone_fornecedor, cidade_fornecedor) VALUES ('Cerâmica Vale Verde', '11111111000101', '5133330001', 'Santa Cruz do Sul');
INSERT INTO fornecedor (nome_fornecedor, cnpj_fornecedor, telefone_fornecedor, cidade_fornecedor) VALUES ('Viveiro Primavera', '22222222000102', '5133330002', 'Venâncio Aires');
INSERT INTO fornecedor (nome_fornecedor, cnpj_fornecedor, telefone_fornecedor, cidade_fornecedor) VALUES ('Orquidário Flor do Vale', '33333333000103', '5133330003', 'Santa Cruz do Sul');
INSERT INTO fornecedor (nome_fornecedor, cnpj_fornecedor, telefone_fornecedor, cidade_fornecedor) VALUES ('Atacado Presentes Sul', '44444444000104', '5133330004', 'Porto Alegre');
INSERT INTO fornecedor (nome_fornecedor, cnpj_fornecedor, telefone_fornecedor, cidade_fornecedor) VALUES ('Mudas Verde Vida', '55555555000105', '5133330005', 'Rio Pardo');

-- PRODUTO (ids 1 a 19)
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Orquídea Phalaenopsis', 'Orquídea branca em vaso', 89.90, 15, 5, 1);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Orquídea Cattleya', 'Orquídea roxa em vaso', 120.00, 8, 3, 1);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Echeveria', 'Suculenta em vaso pequeno', 12.00, 40, 10, 2);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Haworthia', 'Suculenta em vaso pequeno', 15.00, 30, 10, 2);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Samambaia', 'Samambaia em vaso médio', 35.00, 20, 5, 3);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Jiboia', 'Jiboia em vaso pequeno', 25.00, 25, 8, 3);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Muda de Limoeiro', 'Muda frutífera de limão', 65.00, 10, 3, 4);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Muda de Pitangueira', 'Muda frutífera de pitanga', 55.00, 4, 5, 4);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Vaso de cerâmica M', 'Vaso de cerâmica tamanho médio', 38.00, 30, 10, 5);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Terra adubada 5kg', 'Saco de terra adubada', 18.00, 50, 15, 5);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Pedra decorativa 1kg', 'Pedra branca para decoração', 14.00, 3, 10, 5);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Urso de pelúcia', 'Urso de pelúcia para presente', 45.00, 12, 4, 6);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Xícara decorada', 'Xícara de porcelana decorada', 29.90, 18, 5, 6);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Chá aromático', 'Caixa de chá aromático', 22.00, 25, 8, 6);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Arranjo personalizado', 'Montagem de arranjo conforme o valor do cliente', 80.00, NULL, NULL, 7);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Jardinagem e manutenção', 'Serviço de jardinagem no local', 150.00, NULL, NULL, 7);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Fita de cetim 10m', 'Rolo de fita de cetim para laços e arranjos', 8.00, 40, 10, 8);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Papel celofane', 'Folha de papel celofane para embrulho', 3.50, 60, 20, 8);
INSERT INTO produto (nome_produto, descricao_produto, preco_venda, qtd_estoque, qtd_minima, id_categoria) VALUES ('Caixa para presente', 'Caixa de papelão para montagem de cestas e presentes', 12.00, 25, 8, 8);

-- VENDA (ids 1 a 12; valor_total_venda = itens + taxa de entrega)
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-09-05', 127.90, 'Dinheiro', 'Presencial', 'Realizada', 'Retirada', 0, NULL, NULL, 'Maria Silva', 1);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-09-12', 134.00, 'PIX', 'WhatsApp', 'Entregue', 'Entrega', 10.00, 'Rua Marechal Floriano, 450', NULL, NULL, 2);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-09-18', 81.80, 'Débito', 'Presencial', 'Realizada', 'Retirada', 0, NULL, NULL, 'Ana Souza', 3);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-09-25', 116.00, 'Crédito', 'WhatsApp', 'Entregue', 'Entrega', 15.00, 'Av. Independência, 1200', NULL, NULL, 4);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-10-02', 158.00, 'PIX', 'Presencial', 'Realizada', 'Retirada', 0, NULL, NULL, 'Marido da cliente', 5);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-10-05', 120.00, 'PIX', 'WhatsApp', 'Realizada', 'Retirada', 0, NULL, NULL, 'Maria Silva', 1);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-10-08', 130.90, 'Transferência Bancária', 'Instagram', 'Entregue', 'Entrega', 12.00, 'Rua Tiradentes, 89', NULL, NULL, 6);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-10-14', 150.00, 'Dinheiro', 'Presencial', 'Realizada', 'Serviço no Local', 0, 'Rua das Acácias, 77', NULL, NULL, 7);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-10-16', 169.90, 'PIX', 'WhatsApp', 'Encomendada', 'Retirada', 0, NULL, DATE '2026-10-30', NULL, 8);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-10-20', 83.00, 'Crédito', 'Presencial', 'Realizada', 'Retirada', 0, NULL, NULL, 'Patrícia Gomes', 9);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-10-22', 135.00, 'Débito', 'WhatsApp', 'Pronta', 'Entrega', 10.00, 'Rua Júlio de Castilhos, 310', DATE '2026-10-27', NULL, 10);
INSERT INTO venda (data_venda, valor_total_venda, forma_pagamento, canal_venda, situacao, modalidade, taxa_entrega, endereco_entrega, data_prevista, retirado_por, id_cliente)
VALUES (DATE '2026-10-24', 55.00, 'PIX', 'WhatsApp', 'Cancelada', 'Retirada', 0, NULL, NULL, NULL, 2);

-- COMPRA (ids 1 a 6)
INSERT INTO compra (data_compra, valor_total_compra, forma_pagamento, situacao_compra, id_fornecedor) VALUES (DATE '2026-09-01', 880.00, 'Transferência Bancária', 'Recebida', 1);
INSERT INTO compra (data_compra, valor_total_compra, forma_pagamento, situacao_compra, id_fornecedor) VALUES (DATE '2026-09-08', 1900.00, 'PIX', 'Recebida', 3);
INSERT INTO compra (data_compra, valor_total_compra, forma_pagamento, situacao_compra, id_fornecedor) VALUES (DATE '2026-09-15', 1540.00, 'PIX', 'Recebida', 2);
INSERT INTO compra (data_compra, valor_total_compra, forma_pagamento, situacao_compra, id_fornecedor) VALUES (DATE '2026-10-01', 830.00, 'Crédito', 'Recebida', 5);
INSERT INTO compra (data_compra, valor_total_compra, forma_pagamento, situacao_compra, id_fornecedor) VALUES (DATE '2026-10-10', 740.00, 'Dinheiro', 'Recebida', 1);
INSERT INTO compra (data_compra, valor_total_compra, forma_pagamento, situacao_compra, id_fornecedor) VALUES (DATE '2026-10-20', 1070.00, 'Transferência Bancária', 'Solicitada', 4);

-- ITEM_VENDA (id_venda, id_produto, quantidade, preco_unitario)
INSERT INTO item_venda VALUES (1, 1, 1, 89.90);
INSERT INTO item_venda VALUES (1, 9, 1, 38.00);
INSERT INTO item_venda VALUES (2, 3, 4, 12.00);
INSERT INTO item_venda VALUES (2, 9, 2, 38.00);
INSERT INTO item_venda VALUES (3, 13, 2, 29.90);
INSERT INTO item_venda VALUES (3, 14, 1, 22.00);
INSERT INTO item_venda VALUES (4, 7, 1, 65.00);
INSERT INTO item_venda VALUES (4, 10, 2, 18.00);
INSERT INTO item_venda VALUES (5, 2, 1, 120.00);
INSERT INTO item_venda VALUES (5, 9, 1, 38.00);
INSERT INTO item_venda VALUES (6, 5, 2, 35.00);
INSERT INTO item_venda VALUES (6, 6, 2, 25.00);
INSERT INTO item_venda VALUES (7, 12, 1, 45.00);
INSERT INTO item_venda VALUES (7, 13, 1, 29.90);
INSERT INTO item_venda VALUES (7, 14, 2, 22.00);
INSERT INTO item_venda VALUES (8, 16, 1, 150.00);
INSERT INTO item_venda VALUES (9, 15, 1, 80.00);
INSERT INTO item_venda VALUES (9, 1, 1, 89.90);
INSERT INTO item_venda VALUES (10, 4, 3, 15.00);
INSERT INTO item_venda VALUES (10, 3, 2, 12.00);
INSERT INTO item_venda VALUES (10, 11, 1, 14.00);
INSERT INTO item_venda VALUES (11, 15, 1, 80.00);
INSERT INTO item_venda VALUES (11, 12, 1, 45.00);
INSERT INTO item_venda VALUES (12, 8, 1, 55.00);

-- ITEM_COMPRA (id_compra, id_produto, quantidade, preco_unitario = custo)
INSERT INTO item_compra VALUES (1, 9, 40, 22.00);
INSERT INTO item_compra VALUES (2, 1, 20, 55.00);
INSERT INTO item_compra VALUES (2, 2, 10, 80.00);
INSERT INTO item_compra VALUES (3, 3, 50, 6.00);
INSERT INTO item_compra VALUES (3, 4, 40, 8.00);
INSERT INTO item_compra VALUES (3, 5, 25, 20.00);
INSERT INTO item_compra VALUES (3, 6, 30, 14.00);
INSERT INTO item_compra VALUES (4, 7, 12, 40.00);
INSERT INTO item_compra VALUES (4, 8, 10, 35.00);
INSERT INTO item_compra VALUES (5, 10, 60, 10.00);
INSERT INTO item_compra VALUES (5, 11, 20, 7.00);
INSERT INTO item_compra VALUES (6, 12, 15, 28.00);
INSERT INTO item_compra VALUES (6, 13, 20, 16.00);
INSERT INTO item_compra VALUES (6, 14, 30, 11.00);

COMMIT;
