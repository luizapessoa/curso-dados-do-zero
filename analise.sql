SELECT id_cliente AS cliente, estado AS ESTADO, produto as PRODUTO, quantidade FROM vendas
ORDER BY quantidade DESC
limit 5; 

SELECT nome_produto, categoria, preco_unitario FROM produtos
WHERE  preco_unitario BETWEEN 100 AND 1000
ORDER BY preco_unitario ASC;

SELECT count(*) as total_clientes FROM clientes;

SELECT count(DISTINCT categoria) as total_categorias from produtos;

SELECT nome_produto, MAX(quantidade_estoque) AS estoque_total from produtos;

SELECT v.data_venda, v.nome_cliente, v.estado,
p.nome_produto, p.categoria, v.quantidade, 
p.preco_unitario, v.total_venda, c.celular, c.email, c.idade
FROM vendas v join produtos p 
on v.produto = p.nome_produto
JOIN clientes c 
ON v.id_cliente = c.id_cliente
WHERE C.idade > 40
order by v.data_venda desc;

SELECT c.nome_cliente, v.data_venda, v.produto, v.total_venda
From clientes c
LEFT JOIN vendas v
ON c.nome_cliente = v.nome_cliente
ORDER by c.nome_cliente;

SELECT * , 
  CASE 
    WHEN total_venda > 10000 THEN 'VIP'
      ELSE 'COMUM'
    END AS status_cliente
FROM vendas;




