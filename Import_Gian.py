# %%===========================================================================
# PREÁMBULO
# =============================================================================
# GIAN: Importar paquetes
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA

# GIAN: Importar datos
df_025 = pd.read_csv('MarcoClim2.5.csv', sep=',')

# GIAN: Exploración inicial ()
#df_025.info()
#df_025.describe()
#df_025.head()
#df_025.tail()
# Ahora pesa 9.8 MB

# %%===========================================================================
# FILTRADO
# =============================================================================
# GIAN: Limpiando los nan
df_025 = df_025.dropna(axis=0)

# GIAN: Descartando la columna 'Unnamed: 0'
df_025 = df_025.drop(['Unnamed: 0'], axis=1)
# GIAN: Esta columna no es más que un índice que corre de 1 a 64512

# GIAN: Sacando la lista con los nombres de todas las columnas: df_025_col_lst
df_025_col_lst = list(df_025)

# GIAN: Pasando todas las columnas a tipo int32
df_025[df_025_col_lst] = df_025[df_025_col_lst].astype('int32')
df_025.info()
# Ahora pesa 3.3 MB

# %%===========================================================================
# 
# =============================================================================
scaler = StandardScaler()
df_025_scld = pd.DataFrame(scaler.fit_transform(df_025), columns=df_025.columns)


pca = PCA()
x_pca = pd.DataFrame(pca.fit_transform(df_025_scld))

ax = sns.regplot(x="total_bill", y="tip", data=tips)

plt.scatter(x_pca[:,0], x_pca[:,1], alpha = 0.1, s = 1, c='darkred')
plt.xlabel('PC1')
plt.ylabel('PC2')
plt.title('df_025_scld')

sns.jointplot(x=x_pca[:,0], y=x_pca[:,1], kind='kde')


