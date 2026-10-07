🌿 Floricultura Divina Planta — Banco de Dados Relacional (Oracle SQL)
Projeto acadêmico desenvolvido para a disciplina de Organização de Banco de Dados. O sistema consiste na modelagem e implementação de um banco de dados relacional para gerenciar o estoque, vendas, fornecedores e compras da Floricultura Divina Planta, localizada em Passa Sete - RS.

📌 Sobre o Projeto
A Divina Planta opera com vendas presenciais e virtuais (WhatsApp, Instagram e Facebook). O gerenciamento é realizado por Dona Maria (atendimento e compras) e Fabi (gestão e marketing).

O objetivo deste projeto é estruturar as operações da empresa em um banco de dados robusto em ambiente Oracle Database Cloud, permitindo o rastreamento preciso de inventário, fluxo de caixa por canal de venda e histórico de fornecimento.

🛠️ Tecnologias Utilizadas
SGBD: Oracle Database (Cloud / Autonomous Database)

Ferramenta de Execução: Oracle Database Actions (SQL Worksheet)

Linguagem SQL: Oracle SQL (DDL e DML com sequências IDENTITY e tipos de dados VARCHAR2)

🗄️ Estrutura do Banco de Dados
O banco de dados é composto por 7 tabelas relacionais:

Tabela	Descrição
CATEGORIA	Categorias de produtos (Flores e Folhagens, Vasos de Cimento, Horta e Jardim, etc.)
PRODUTO	Cadastro de produtos, preços de venda, estoque atual e vínculo com categorias
FORNECEDOR	Registro de fornecedores parceiros organizados por segmento de mercado
FUNCIONARIO	Cadastro da equipe (Dona Maria e Fabi) e suas funções
COMPRA_FORNECEDOR	Registro de ordens de compra efetuadas junto aos fornecedores
ITEM_COMPRA	Tabela associativa com os itens, quantidade e preço de custo de cada compra
VENDA	Registro de vendas realizadas por canal (WhatsApp, Presencial, Instagram, Facebook)
📂 Estrutura do Repositório
Plaintext
├── scripts/
│   ├── 01_criacao_e_dados.sql     # Scripts DDL (CREATE TABLE) e DML (INSERT + COMMIT)
│   └── 02_consultas_select.sql    # 10 Consultas SQL avançadas para relatórios
├── docs/
│   └── modelo_er.png              # Diagrama Entidade-Relacionamento (DER)
└── README.md                      # Documentação do projeto
🚀 Como Executar o Projeto
Acesse o seu ambiente Oracle Database Actions (SQL Worksheet) ou Oracle SQL Developer.

Abra e execute o arquivo scripts/01_criacao_e_dados.sql.

Nota: Certifique-se de executar todo o script para criar as 7 tabelas, popular os dados e realizar o COMMIT. Se o sistema solicitar Variáveis de Substituição devido ao caractere & nos nomes de fornecedores, inclua a instrução SET DEFINE OFF; na primeira linha.

Atualize o painel lateral de objetos para confirmar que todas as tabelas foram criadas.

Abra o arquivo scripts/02_consultas_select.sql para rodar e visualizar os relatórios gerenciais das 10 consultas preparadas.

🔍 Consultas SQL Implementadas (SELECT)
O script de consultas inclui 10 seleções estratégicas para a tomada de decisão no negócio:

Junção Complexa (6 Tabelas): Detalhamento de compras com Fornecedor, Funcionária, Produto, Categoria e Quantidades.

Relatório de Vendas por Canal: Total faturado agrupado por WhatsApp, Instagram, Facebook e Venda Presencial.

Desempenho da Equipe: Total de vendas e compras processadas por funcionária.

Análise de EstoqueCrítico: Filtro de produtos com estoque zerado ou abaixo do limite de segurança.

Gastos por Segmento de Fornecedor: Agrupamento de compras com filtro de valor via cláusula HAVING.

Subconsulta (Subquery): Identificação de produtos com preço de venda acima da média do catálogo.

Detalhamento de Itens Vendidos e Margem de Lucro: Relação do preço de custo vs. preço de venda.

Filtro de Clientes/Canais com LIKE: Pesquisa por canais de venda específicos.

Ordenação Geral (ORDER BY): Listagem de produtos ordenados do maior para o menor preço e disponibilidade.

Funções de Agregação Global: Resumo financeiro de estoque (Soma total em R$, preço médio, menor e maior valor).

👥 Integrantes do Grupo
Fabi - Modelagem, Implementação e Documentação 

Débora - 

Gabi -

Malu -
