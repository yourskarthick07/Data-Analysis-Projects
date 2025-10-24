import pandas as pd
from sqlalchemy import create_engine
import urllib

# --- 1. EXTRACT ---

df_attributes = pd.read_csv(r'C:\Users\knsma\Desktop\DIM_Dress_Attribute_Cleaned.csv')
df_sales_wide = pd.read_csv(r'C:\Users\knsma\Desktop\FACT_Dress_Sales_Cleaned.csv')
print("Files loaded successfully.")

# --- 2. TRANSFORM ---
all_sales_columns = df_sales_wide.columns
date_columns_to_unpivot = [
    col for col in all_sales_columns 
    if col != 'Dress_ID' and not col.startswith('Unnamed')
]
df_sales_long = pd.melt(
    df_sales_wide,
    id_vars=['Dress_ID'], 
    value_vars=date_columns_to_unpivot, 
    var_name='Sales_Date',   
    value_name='Sales_Amount')
df_sales_long['Sales_Date'] = pd.to_datetime(df_sales_long['Sales_Date'], format='%d/%m/%Y')
df_sales_long['Sales_Amount'] = pd.to_numeric(df_sales_long['Sales_Amount'], errors='coerce')
df_sales_long = df_sales_long.dropna(subset=['Sales_Amount'])
df_attributes = df_attributes.drop_duplicates(subset=['Dress_ID'])
df_attributes['Decoration'] = df_attributes['Decoration'].fillna('None')

print("Data transformed successfully.")
print("\n--- Sales Data Head ---")
print(df_sales_long.head())
print("\n--- Attributes Data Head ---")
print(df_attributes.head())


# --- 3. LOAD ---
server = 'KARTHICK\MSSQLSERVER01'  
database = 'Dress_Att_sales'
driver = '{ODBC Driver 17 for SQL Server}'
params = urllib.parse.quote_plus(
    f"DRIVER={driver};"
    f"SERVER={server};"
    f"DATABASE={database};"
    f"TRUSTED_CONNECTION=yes")
engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}")
print("\nConnecting to SQL Server...")
df_attributes.to_sql(
    'Dim_Dress_Attributes',
    con=engine,
    if_exists='replace',
    index=False)
df_sales_long.to_sql(
    'Fact_Dress_Sales',
    con=engine,
    if_exists='replace',
    index=False)
print(f"Successfully loaded data into SQL Server database '{database}'.")