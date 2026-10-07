# 🌿 Floricultura Divina Planta — Banco de Dados Relacional (Oracle SQL)

Projeto acadêmico desenvolvido para a disciplina de **Organização de Banco de Dados**. O sistema consiste na modelagem e implementação de um banco de dados relacional para gerenciar o estoque, vendas, fornecedores e compras da **Floricultura Divina Planta**, localizada em Passa Sete - RS.

---

## 📌 Sobre o Projeto

A **Divina Planta** opera com vendas presenciais e virtuais (WhatsApp, Instagram e Facebook). O gerenciamento é realizado por Dona Maria (atendimento e compras) e Fabi (gestão e marketing). 

O objetivo deste projeto é estruturar as operações da empresa em um banco de dados robusto em ambiente **Oracle Database Cloud**, permitindo o rastreamento preciso de inventário, fluxo de caixa por canal de venda e histórico de fornecimento.

---

## 🛠️ Tecnologias Utilizadas

* **SGBD:** Oracle Database (Cloud / Autonomous Database)
* **Ferramenta de Execução:** Oracle Database Actions (SQL Worksheet)
* **Linguagem SQL:** Oracle SQL (DDL e DML com sequências `IDENTITY` e tipos de dados `VARCHAR2`)

---

## 🗄️ Estrutura do Banco de Dados

O banco de dados é composto por **7 tabelas relacionais**:

| Tabela | Descrição |
| :--- | :--- |
| **`CATEGORIA`** | Categorias de produtos (Flores e Folhagens, Vasos de Cimento, Horta e Jardim, etc.) |
| **`PRODUTO`** | Cadastro de produtos, preços de venda, estoque atual e vínculo com categorias |
| **`FORNECEDOR`** | Registro de fornecedores parceiros organizados por segmento de mercado |
| **`FUNCIONARIO`** | Cadastro da equipe (Dona Maria e Fabi) e suas funções |
| **`COMPRA_FORNECEDOR`** | Registro de ordens de compra efetuadas junto aos fornecedores |
| **`ITEM_COMPRA`** | Tabela associativa com os itens, quantidade e preço de custo de cada compra |
| **`VENDA`** | Registro de vendas realizadas por canal (WhatsApp, Presencial, Instagram, Facebook) |

---

## 📂 Estrutura do Repositório

```text
├── scripts/
│   ├── 01_criacao_e_dados.sql     # Scripts DDL (CREATE TABLE) e DML (INSERT + COMMIT)
│   └── 02_consultas_select.sql    # 10 Consultas SQL avançadas para relatórios
├── docs/
│   └── modelo_er.png              # Diagrama Entidade-Relacionamento (DER)
└── README.md                      # Documentação do projeto
