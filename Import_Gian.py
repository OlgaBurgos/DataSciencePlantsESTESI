import pandas as pd

df = pd.read_csv('0022664-180508205500799.csv', sep='\t')

Kingdom = df['kingdom'].unique()
Phylum = df['phylum'].unique()
Class = df['class'].unique()
Order = df['order'].unique()
Family = df['family'].unique()
Species = df['species'].unique()
Genus = df['genus'].unique()
Taxonrank = df['taxonrank'].unique()
Countrycode = df['countrycode'].unique()


# We have 133 genus and 1753 different species within the 'Kingdom, Phylum, Class, Order, Species' classification
#                                           'Plantae, Tracheophyta, Magnoliopsida, Aizoaceae'

df_drp = df[[column for column in list(df) if len(df[column].unique()) > 1]]

# Comparing dataframe size

df.info()       # 35.4+ MB
df_drp.info()   # 31.4+ MB

df_drp['taxonrank'] = df_drp['taxonrank'].astype('category')

df_drp.info()   # 30.7+ MB

df_drp['countrycode'] = df_drp['countrycode'].astype('category')

df_drp.info()   # 30.1+ MB
