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
