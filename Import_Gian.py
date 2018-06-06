import pandas as pd

df = pd.read_csv('0022664-180508205500799.csv', sep='\t')

Kingdom = df['kingdom'].unique()
Phylum = df['phylum'].unique()
Class = df['class'].unique()
Order = df['order'].unique()
Family = df['family'].unique()
Species = df['species'].unique()

# We have 1753 different species within the 'Kingdom, Phylum, Class, Order, Species' classification
#                                           'Plantae, Tracheophyta, Magnoliopsida, Aizoaceae'


df_drp = df[[column for column in list(df) if len(df[column].unique()) > 1]]