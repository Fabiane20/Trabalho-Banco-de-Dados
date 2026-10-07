

-- ============================================================
-- 10 CONSULTAS SQL (SELECT) - ORACLE SQL
-- FLORICULTURA DIVINA PLANTA
-- ============================================================

-- 1. JOIN COM MAIS DE 3 TABELAS (6 Tabelas)
-- Detalha as compras realizadas: Fornecedor, Funcionária, Produto, Categoria e Quantidades
SELECT 
    f.razao_social AS fornecedor,
    func.nome AS funcionaria_compradora,
    p.nome AS produto,
    c.nome AS categoria,
    ic.quantidade,
    ic.preco_custo_unitario
FROM compra_fornecedor cf
JOIN fornecedor f ON cf.id_fornecedor = f.id_fornecedor
JOIN funcionario func ON cf.id_funcionario = func.id_funcionario
JOIN item_compra ic ON cf.id_compra = ic.id_compra
JOIN produto p ON ic.id_produto = p.id_produto
JOIN categoria c ON p.id_categoria = c.id_categoria;


-- 2. GROUP BY E FUNÇÕES DE AGREGAÇÃO (SUM, COUNT, AVG)
-- Totaliza faturamento, quantidade de vendas e ticket médio agrupado por canal de venda
SELECT 
    canal_venda,
    COUNT(id_venda) AS total_vendas,
    SUM(valor_total) AS faturamento_total,
    ROUND(AVG(valor_total), 2) AS ticket_medio
FROM venda
GROUP BY canal_venda;


-- 3. GROUP BY + HAVING
-- Filtra categorias que possuem mais de 1 produto cadastrado e preço médio acima de R$ 10,00
SELECT 
    c.nome AS categoria,
    COUNT(p.id_produto) AS quantidade_produtos,
    ROUND(AVG(p.preco_venda), 2) AS preco_medio
FROM categoria c
JOIN produto p ON c.id_categoria = p.id_categoria
GROUP BY c.nome
HAVING COUNT(p.id_produto) > 1 AND AVG(p.preco_venda) > 10.00;


-- 4. LEFT JOIN
-- Lista todos os 9 fornecedores, inclusive aqueles sem nenhuma compra efetuada
SELECT 
    f.razao_social,
    f.segmento,
    COUNT(cf.id_compra) AS total_pedidos,
    NVL(SUM(cf.valor_total), 0) AS valor_total_comprado
FROM fornecedor f
LEFT JOIN compra_fornecedor cf ON f.id_fornecedor = cf.id_fornecedor
GROUP BY f.razao_social, f.segmento;


-- 5. NOT EXISTS
-- Identifica produtos cadastrados no sistema que nunca foram comprados de fornecedores
SELECT 
    p.nome AS produto,
    p.preco_venda,
    p.estoque_atual
FROM produto p
WHERE NOT EXISTS (
    SELECT 1 
    FROM item_compra ic 
    WHERE ic.id_produto = p.id_produto
);


-- 6. NOT IN
-- Lista fornecedores com os quais a gestora Fabi (id_funcionario = 2) ainda não comprou diretamente
SELECT 
    razao_social, 
    segmento, 
    telefone
FROM fornecedor
WHERE id_fornecedor NOT IN (
    SELECT id_fornecedor 
    FROM compra_fornecedor 
    WHERE id_funcionario = 2
);


-- 7. UNION
-- Consolida as movimentações de saída de caixa (Compras) e entrada (Vendas)
SELECT 
    'Compra de Fornecedor' AS tipo_operacao,
    data_compra AS data_movimentacao,
    valor_total
FROM compra_fornecedor
UNION
SELECT 
    'Venda de Produto' AS tipo_operacao,
    data_venda AS data_movimentacao,
    valor_total
FROM venda;


-- 8. DISTINCT
-- Exibe os canais de atendimento únicos utilizados por cada funcionária
SELECT DISTINCT 
    f.nome AS funcionaria,
    v.canal_venda
FROM funcionario f
JOIN venda v ON f.id_funcionario = v.id_funcionario;


-- 9. ORDER BY
-- Tabela de produtos ordenada do maior preço para o menor e por estoque
SELECT 
    p.nome AS produto,
    c.nome AS categoria,
    p.preco_venda,
    p.estoque_atual
FROM produto p
JOIN categoria c ON p.id_categoria = c.id_categoria
ORDER BY p.preco_venda DESC, p.estoque_atual ASC;


-- 10. FUNÇÕES DE AGREGAÇÃO GLOBAIS (COUNT, SUM, AVG, MAX, MIN)
-- Resumo financeiro global de vendas efetuadas na loja
SELECT 
    COUNT(*) AS qtd_vendas_realizadas,
    SUM(valor_total) AS faturamento_total,
    ROUND(AVG(valor_total), 2) AS valor_medio_venda,
    MAX(valor_total) AS maior_venda_registrada,
    MIN(valor_total) AS menor_venda_registrada
FROM venda;
