# curso-dados-do-zero
Repositório criado para armazenar materiais e projetos desenvolvidos durante o curso "Dados do Zero: Excel, SQL, Python e AWS com Projetos Reais", com foco no aprendizado prático em análise e engenharia de dados.


## 1. Excel

## 2. SQL

## 3. Python

Plataforma utilizada: Google Colab | **[Veja o script completo aqui](./firstanalysis.py)**

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

### - # filtro composto ou combinado
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


