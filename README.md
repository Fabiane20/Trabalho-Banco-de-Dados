# 🌿 Floricultura Divina Planta — Banco de Dados Relacional (Oracle SQL)

Projeto acadêmico desenvolvido para a disciplina de **Organização de Banco de Dados**. O sistema consiste na modelagem e implementação de um banco de dados relacional para substituir registros manuais em papel e gerenciar o estoque, vendas, fornecedores e compras de uma floricultura de pequeno porte.

---

## 📌 Sobre o Projeto

A **Divina Planta** opera com vendas presenciais e virtuais (WhatsApp e Instagram) e presta serviços de jardinagem e montagem de presentes sob medida. O gerenciamento é realizado por uma única pessoa.

O objetivo deste projeto é estruturar as operações da empresa em um banco de dados relacional em ambiente **Oracle Database Cloud**, permitindo o rastreamento preciso de inventário, alertas de reposição, histórico de compras de clientes, controle de faturamento por canal de venda e gestão de custos com fornecedores.

---

## 👥 Integrantes do Projeto

- **Gabriele da Rosa Schwengber**
- **Débora Aline Müller**
- **Fabiane Paulus**
- **Maria Luiza Fonseca**

---

## 🛠️ Tecnologias Utilizadas

- **SGBD:** Oracle Database (Cloud / Autonomous Database)
- **Ferramenta de Execução:** Oracle Database Actions (SQL Worksheet) / SQL Developer
- **Linguagem SQL:** Oracle SQL (DDL e DML com sequências `IDENTITY` e tipos de dados `VARCHAR2`)

---

## 🗄️ Estrutura do Banco de Dados

O banco de dados é composto por **8 tabelas relacionais**:

| Tabela | Descrição |
| :--- | :--- |
| **`CLIENTE`** | Cadastro dos clientes com nome e telefone (utilizado para contato/WhatsApp). |
| **`CATEGORIA`** | Categorias para agrupamento de produtos e serviços (plantas, vasos, insumos, serviços, etc.). |
| **`PRODUTO`** | Cadastro de produtos e serviços, preços de venda, estoque atual e estoque mínimo. |
| **`FORNECEDOR`** | Registro de fornecedores parceiros (nome/razão social, CNPJ, telefone e cidade). |
| **`VENDA`** | Registro de vendas contendo data, valor, canal, modalidade, status e cliente. |
| **`ITEM_VENDA`** | Tabela associativa com os produtos/serviços, quantidade e preço unitário praticado na venda. |
| **`COMPRA`** | Registro de ordens de compra de produtos efetuadas junto aos fornecedores. |
| **`ITEM_COMPRA`** | Tabela associativa com os itens, quantidade e preço de custo de cada compra. |

---

## ⚙️ Principais Regras de Negócio

1. **Serviços Prestados:** Os serviços de jardinagem são cadastrados na categoria "Serviços" com preço de referência, porém não possuem controle de estoque (`qtd_estoque` e `qtd_minima` permanecem nulos).
2. **Insumos e Presentes Sob Medida:** Insumos usados na execução de serviços (plantas, terra, vasos) e itens de presentes montados sob medida são registrados como itens normais na mesma venda.
3. **Canais e Modalidades:** Suporte a vendas por canais presenciais, WhatsApp e Instagram. As modalidades de recebimento incluem *retirada na loja* (com registro de quem retirou), *entrega* (com endereço e taxa) e *serviço no local*.
4. **Escopo Operacional:** O sistema atende exclusivamente uma operação de uma única pessoa, não incluindo cadastro de funcionários nem cálculo de taxas de cartão.

---

## 📂 Estrutura do Repositório

```text
├── scripts/
│   ├── 01_criacao_e_dados.sql     # Scripts DDL (CREATE TABLE) e DML (INSERT + COMMIT)
│   └── 02_consultas_select.sql    # Consultas SQL para relatórios e faturamento
├── docs/
│   └── modelo_er.png              # Diagrama Entidade-Relacionamento (DER)
└── README.md                      # Documentação do projeto
