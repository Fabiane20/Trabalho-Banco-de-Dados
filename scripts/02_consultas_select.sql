-- SELECTS RÁPIDOS
SELECT * FROM cliente;

SELECT * FROM categoria;

SELECT * FROM produto;

SELECT * FROM fornecedor;

SELECT * FROM venda;

SELECT * FROM compra;

SELECT * FROM item_venda;

SELECT * FROM item_compra;

-- CONSULTAS CRIADAS 
--  Crie 10 consultas a serem realizadas sobre o modelo com seu respectivo comando SQL.
-- Coloque no arquivo as linhas resultantes da execução desta consulta. A qualidade das questões será avaliada.

-- Consulta 01: Qual canal de venda gera mais faturamento?
-- Mostra se a loja vende mais no balcão, pelo WhatsApp ou pelo Instagram.
-- Comandos utilizados: (GROUP BY, funções de agregação, ORDER BY)
SELECT canal_venda,
       COUNT(*)               AS quantidade_vendas,
       SUM(valor_total_venda) AS faturamento,
       ROUND(AVG(valor_total_venda), 2) AS ticket_medio
FROM venda
WHERE situacao IN ('Realizada', 'Entregue')
GROUP BY canal_venda
ORDER BY faturamento DESC;

-- Consulta 02: Com quais fornecedores a loja gastou mais de R$ 1.000 em compras recebidas?
-- Ajuda a identificar os fornecedores mais importantes para o negócio.
-- Comandos utilizados: (JOIN, GROUP BY + HAVING, ORDER BY)
SELECT f.nome_fornecedor,
       f.cidade_fornecedor,
       COUNT(c.id_compra)        AS qtd_compras,
       SUM(c.valor_total_compra) AS total_comprado
FROM fornecedor f
JOIN compra c ON f.id_fornecedor = c.id_fornecedor
WHERE c.situacao_compra = 'Recebida'
GROUP BY f.id_fornecedor, f.nome_fornecedor, f.cidade_fornecedor
HAVING SUM(c.valor_total_compra) > 1000
ORDER BY total_comprado DESC;

-- Consulta 03: Quais são os produtos mais vendidos e quanto cada um faturou?
-- Mostra os campeões de venda com a categoria de cada um.
-- Comandos utilizados: (JOIN com 4 tabelas, GROUP BY, agregação, ORDER BY)
SELECT p.nome_produto,
       cat.nome_categoria,
       SUM(iv.quantidade)                    AS unidades_vendidas,
       SUM(iv.quantidade * iv.preco_unitario) AS faturamento_produto
FROM item_venda iv
JOIN venda v      ON iv.id_venda = v.id_venda
JOIN produto p    ON iv.id_produto = p.id_produto
JOIN categoria cat ON p.id_categoria = cat.id_categoria
WHERE v.situacao IN ('Realizada', 'Entregue')
GROUP BY p.id_produto, p.nome_produto, cat.nome_categoria
ORDER BY unidades_vendidas DESC, faturamento_produto DESC;

-- Consulta 04: Qual a margem de lucro de cada produto?
-- Compara o preço de venda com o custo médio pago aos fornecedores (só compras recebidas).
-- Comandos utilizados: (JOIN com 3 tabelas, AVG, GROUP BY, ORDER BY)
SELECT p.nome_produto,
       p.preco_venda,
       ROUND(AVG(ic.preco_unitario), 2) AS custo_medio,
       ROUND(p.preco_venda - AVG(ic.preco_unitario), 2) AS lucro_unitario,
       ROUND((p.preco_venda - AVG(ic.preco_unitario)) / p.preco_venda * 100, 1) AS margem_percentual
FROM produto p
JOIN item_compra ic ON p.id_produto = ic.id_produto
JOIN compra c       ON ic.id_compra = c.id_compra
WHERE c.situacao_compra = 'Recebida'
GROUP BY p.id_produto, p.nome_produto, p.preco_venda
ORDER BY margem_percentual DESC;

-- Consulta 05: Quais produtos estão abaixo do estoque mínimo e ainda não têm compra solicitada?
-- Lista o que precisa ser pedido com urgência, sem duplicar pedidos já feitos.
-- Comandos utilizados: (NATURAL JOIN, NOT IN com subconsulta, ORDER BY)
SELECT p.nome_produto,
       c.nome_categoria,
       p.qtd_estoque,
       p.qtd_minima,
       p.qtd_minima - p.qtd_estoque AS faltam_para_o_minimo
FROM produto p
NATURAL JOIN categoria c
WHERE p.qtd_estoque < p.qtd_minima
  AND p.id_produto NOT IN (
        SELECT ic.id_produto
        FROM item_compra ic
        JOIN compra co ON ic.id_compra = co.id_compra
        WHERE co.situacao_compra = 'Solicitada')
ORDER BY faltam_para_o_minimo DESC;

-- Consulta 06: Quanto cada cliente já gastou, incluindo quem ainda não tem compra concluída? (Histórico de gastos por cliente)
-- Permite identificar clientes para contato (ex: encomenda ou pedido pronto aguardando).
-- Comandos utilizados: (LEFT JOIN, COALESCE, GROUP BY, ORDER BY)
SELECT c.nome_cliente,
       c.telefone,
       COUNT(v.id_venda)                      AS compras_concluidas,
       COALESCE(SUM(v.valor_total_venda), 0)  AS total_gasto
FROM cliente c
LEFT JOIN venda v
       ON c.id_cliente = v.id_cliente
      AND v.situacao IN ('Realizada', 'Entregue')
GROUP BY c.id_cliente, c.nome_cliente, c.telefone
ORDER BY total_gasto DESC;

-- Consulta 07: Quais são os 5 produtos ou serviços menos vendidos?
-- Mostra o que está parado no catálogo para revisar ou promover.
-- Comandos utilizados: JOIN, LEFT JOIN, NOT IN (subconsulta), GROUP BY, agregação (SUM), ORDER BY, FETCH FIRST (LIMIT)
SELECT p.nome_produto,
       c.nome_categoria,
       p.qtd_estoque,
       NVL(SUM(vd.quantidade), 0) AS qtd_vendida
FROM produto p
JOIN categoria c ON c.id_categoria = p.id_categoria
LEFT JOIN (SELECT iv.id_produto, iv.quantidade
           FROM item_venda iv
           JOIN venda v ON v.id_venda = iv.id_venda
           WHERE v.situacao IN ('Realizada', 'Entregue')) vd
       ON vd.id_produto = p.id_produto
WHERE p.id_categoria NOT IN (SELECT id_categoria
                             FROM categoria
                             WHERE nome_categoria = 'Embalagens, fitas e materiais de montagem')
GROUP BY p.id_produto, p.nome_produto, c.nome_categoria, p.qtd_estoque
ORDER BY qtd_vendida ASC, p.nome_produto
FETCH FIRST 5 ROWS ONLY;

-- Consulta 08: Quais clientes já compraram orquídeas?
-- Útil para avisar essas pessoas pelo WhatsApp sobre novas orquídeas ou adubos.
-- Comandos utilizados: (DISTINCT, IN com subconsulta, JOIN com 4 tabelas, ORDER BY)
SELECT DISTINCT c.nome_cliente, c.telefone
FROM cliente c
JOIN venda v       ON c.id_cliente = v.id_cliente
JOIN item_venda iv ON v.id_venda = iv.id_venda
WHERE v.situacao IN ('Realizada', 'Entregue')
  AND iv.id_produto IN (
        SELECT p.id_produto
        FROM produto p
        JOIN categoria cat ON p.id_categoria = cat.id_categoria
        WHERE cat.nome_categoria = 'Orquídeas')
ORDER BY c.nome_cliente;

-- Consulta 09: O que a floricultura vendeu em cada dia?
-- Atende ao pedido da dona da floricultura: ver tudo o que foi vendido no dia.
-- Considera todas as vendas, exceto as canceladas.
-- Comandos utilizados: NATURAL JOIN (3 tabelas), GROUP BY, agregação (SUM), ORDER BY
SELECT TO_CHAR(data_venda, 'YYYY-MM-DD')  AS dia,
       nome_produto,
       SUM(quantidade)                    AS qtd_vendida,
       SUM(quantidade * preco_unitario)   AS valor_vendido
FROM venda NATURAL JOIN item_venda NATURAL JOIN produto
WHERE situacao <> 'Cancelada'
GROUP BY TO_CHAR(data_venda, 'YYYY-MM-DD'), nome_produto
ORDER BY dia DESC, valor_vendido DESC;

-- Consulta 10: Quanto a floricultura vendeu em cada mês de cada ano?
-- Atende ao pedido da dona da floricultura: ver tudo o que foi vendido no mês e no ano.
-- Considera todas as vendas, exceto as canceladas.
-- Comandos utilizados: GROUP BY, agregação (COUNT, SUM, AVG), ORDER BY
SELECT EXTRACT(YEAR FROM data_venda)    AS ano,
       EXTRACT(MONTH FROM data_venda)   AS mes,
       COUNT(*)                         AS qtd_vendas,
       SUM(valor_total_venda)           AS faturamento,
       ROUND(AVG(valor_total_venda), 2) AS ticket_medio
FROM venda
WHERE situacao <> 'Cancelada'
GROUP BY EXTRACT(YEAR FROM data_venda), EXTRACT(MONTH FROM data_venda)
ORDER BY ano DESC, mes DESC;
