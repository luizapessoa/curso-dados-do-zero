# curso-dados-do-zero  
Repositório criado para armazenar materiais e projetos desenvolvidos durante o curso **"Dados do Zero: Excel, SQL, Python e AWS com Projetos Reais"**, com foco no aprendizado prático em **análise e engenharia de dados**.

---

## 1. Excel  

Plataforma utilizada: **Google Sheets**  

Nesta etapa do curso, foi realizada a **análise inicial dos dados** utilizando planilhas, fórmulas e dashboards para explorar e visualizar as informações de forma prática.  

### Análise inicial dos dados  

- Importação da base de dados em formato `.csv`.  
- Utilização de **tabelas dinâmicas** para resumo das informações por categoria e produto.  
- Aplicação de **filtros automáticos** para segmentar dados de vendas e regiões.  

### Fórmulas e funções aplicadas  
- **SOMA** e **MÉDIA** para cálculos básicos de total de vendas e médias por categoria.  
- **PROCV / XLOOKUP** para cruzar informações entre planilhas (ex.: cliente e produto).  
- **SE** e **SEERRO** para classificações condicionais e tratamento de dados ausentes.  
- **CONT.SE / CONT.SES** para contagem filtrada de produtos e clientes.  

### Visualização de dados  
- Criação de **gráficos de colunas, pizza e linha** para análise visual do desempenho de vendas.  
- Formatação condicional para destacar valores acima ou abaixo da média.  
- Dashboard simples com indicadores de total de vendas, ticket médio e produtos mais vendidos.  

---

**[Veja a planilha utilizada aqui](https://docs.google.com/spreadsheets/d/1E9BhtDrq6_1V_sOv8IzcLy2itej7sawzNNuxwpZw9Vg/edit?usp=sharing)**  

---
## SQL

Plataforma utilizada: **SQLite**  

Nesta etapa, foram aplicados **conceitos de banco de dados e linguagem SQL** para manipulação e análise de dados, utilizando consultas com filtros, junções e agregações.  

- **Filtros** e **queries** utilizados na análise inicial dos dados.

---

### Funções de agregação:

Resumem informações da tabela, como contar categorias distintas e identificar o maior valor de estoque
```
SELECT count(DISTINCT categoria) as total_categorias from produtos;
```

```
SELECT nome_produto, MAX(quantidade_estoque) AS estoque_total from produtos;
```

### Join entre tabelas:

Consulta que realiza junção entre as tabelas vendas, produtos e clientes para combinar informações completas sobre as vendas, produtos e perfis de clientes.
```
SELECT v.data_venda, v.nome_cliente, v.estado,
p.nome_produto, p.categoria, v.quantidade, 
p.preco_unitario, v.total_venda, c.celular, c.email, c.idade
FROM vendas v join produtos p 
on v.produto = p.nome_produto
JOIN clientes c 
ON v.id_cliente = c.id_cliente
WHERE C.idade > 40
order by v.data_venda desc;
```

### Left join:

Consulta que retorna todos os clientes, incluindo aqueles que ainda não realizaram vendas, preservando os registros da tabela principal (clientes).
````
SELECT c.nome_cliente, v.data_venda, v.produto, v.total_venda
From clientes c
LEFT JOIN vendas v
ON c.nome_cliente = v.nome_cliente
ORDER by c.nome_cliente;
````

### Case when:

Consulta que utiliza a estrutura condicional `CASE WHEN` para classificar clientes conforme o valor total da venda, definindo-os como “VIP” ou “COMUM”.
```
SELECT * , 
  CASE 
    WHEN total_venda > 10000 THEN 'VIP'
      ELSE 'COMUM'
    END AS status_cliente
FROM vendas;
```

---

**[Veja o script completo aqui](./analise.sql)**


## 3. Python

Plataforma utilizada: Google Colab

Nesta etapa foram aplicadas **bibliotecas de análise de dados** como **Pandas, NumPy, Matplotlib e Seaborn** para manipulação, visualização e extração de insights.

## importar bibliotecas

``` firstanalysis.py
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
```

### - importar dataframe

```
from google.colab import files
uploaded = files.upload()
```
ps: depois de rodar, adiciona o arquivo csv em 'Escolher arquivos'

### - importar dados

```
df = pd.read_csv('nome_do_dataframe')
```

### - visualizar primeiras linhas do dataframe

```
print(df.head())
```
---

## conhecendo os dados

### - visualizando estrutura do banco

```
print(f"seu dataset tem: {df.shape[0]} linhas e {df.shape[1]} colunas")
```

### - nome das colunas de forma organizadas
```
print(df.columns.tolist())
```

### - verificar dados faltantes

```
dados_faltantes = df.isnull().sum()
print(dados_faltantes)
```

### - verificar valores zerados em colunas numericas

```
df[['quantidade', 'preco_unitario', 'total_venda']].eq(0).sum()
````

### - resumo estatistico simples
```
print(df.describe())
```

---

## operações básicas com python

### - somar coluna
```
print(df['total_venda'].sum())
```

### - multiplicar colunas
```
df['total_venda'] = df['quantidade'] * df['preco_unitario']
print(df['total_venda'])
```

### - media da coluna quantidade
```
print(df['quantidade'].mean())
```

---

## filtros

### - filtrar itens da categoria Eletrônicos
```
print(df[df['categoria'] == 'Eletrônicos'])
```

### - filtro composto ou combinado
```
print(df[(df['categoria'] == 'Eletrônicos') & (df['quantidade'] > 3)])
```

---

## agrupamentos - group by

### - media de quantidade vendida por categoria
```
print(df.groupby('categoria')['quantidade'].mean())
```

### - múltiplas estatisticas por categoria
```
print(df.groupby('categoria')['quantidade'].agg(['mean', 'sum', 'count', 'max', 'min']))
```

---

## gráficos

### - grafico simpes de barras
```
df['categoria'].value_counts().plot(kind= 'bar')
plt.show()
```

### - histograma de distribuição dos valores de venda 'total_venda'
```
df['total_venda'].plot(kind= 'hist', bins = 20)
plt.show()
```

### - versao 2 do histograma
```
plt.figure(figsize =(8,6))
df['total_venda'].hist(bins=20)
plt.title('Distribuição das vendas')
plt.xlabel('Valor das vendass')
plt.ylabel('Frequência')
plt.show()
```

### - gráfico de barras horizontais com o 'total_venda'
```
df['categoria'].value_counts().plot(kind= 'barh')
plt.show()
```

### - gráfico de pizza com o 'total_venda'
```
df['categoria'].value_counts().plot(kind= 'pie')
plt.show()
```

---

## criando nova coluna: cliente vip ou comum

### - criar uma nova coluna status do cliente
```
df['status_cliente'] = np.where(df['total_venda'] > 10000, 'cliente vip', 'cliente comum')
```

---

## trabalhando com datas

### - garantir que as informações de data estão em formato datetime
```
df['data_venda'] = pd.to_datetime(df['data_venda'])
```

### - extraindo informações de datatime
```
df['ano_venda'] = df['data_venda'].dt.year
df['mes_venda'] = df['data_venda'].dt.month
df['dia_venda'] = df['data_venda'].dt.day
df['dia_da_semana'] = df['data_venda'].dt.dayofweek
```

---

**[Veja o script completo aqui, contendo análise de oportunidades e análise final](./firstanalysis_py.ipynb)**
