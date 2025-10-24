# 👗 Dress Attributes Sales ETL Pipeline

Welcome to my Dress Attributes Sales ETL Pipeline Project — showcasing my ability to build an end-to-end ETL (Extract, Transform, Load) process integrating Python, SQL, Excel, and Power BI for insightful data analytics.

---

## 🎯 Objective
To analyze dress sales performance and customer preferences by building an automated ETL pipeline that extracts raw data, cleans and transforms it, and visualizes the insights using Power BI.
---

## 📈 ETL Workflow

### 🧩 **1️⃣ Extract**
Data is extracted from two source CSV files using **Pandas**:
   - **DIM_Dress_Attribute_Cleaned.csv**: Contains descriptive attributes for each dress (Style, Price, Season, etc.).
   - **FACT_Dress_Sales_Cleaned.csv**: Contains daily sales figures in a "wide" (pivoted) format, where each column represents a different date.
---

### 🧪 **2️⃣ Transform**
The transformation phase cleans, reshapes, and validates the data using **Pandas**:
- 🔄 **Unpivoting:** Transformed wide-format sales data into a normalized “long” format using `pd.melt()`.  
  Structure changes from `(Dress_ID, Date1, Date2, ...)` → `(Dress_ID, Sales_Date, Sales_Amount)`.
- 🧹 **Data Cleaning:**
  - Converted date columns to `datetime` format.  
  - Converted sales figures to numeric types.  
- 🧩 **Imputation:** Replaced missing values in columns like `Material` or `Decoration` with `"Unknown"` or `"None"` using `.fillna()`.  
- 🚫 **Duplicates:** Removed duplicate `Dress_ID` entries to ensure clean dimension data.

---

### 🗄️ **3️⃣ Load**
After transformation, clean DataFrames are loaded into an **MS SQL Server** database using **SQLAlchemy** and **pyodbc**:
1. 🧱 `Dim_Dress_Attributes` → Dimension table  
2. 📊 `Fact_Dress_Sales` → Fact table  

---

## 🛠️ Tech Stack
- 🐍 **Python** – For automation, extraction, and transformation  
- 🧮 **Pandas** – Data cleaning and reshaping  
- 🧩 **SQLAlchemy & pyodbc** – For SQL Server integration  
- 🗄️ **MS SQL Server** – Final data warehouse for analysis  

---

## 📂 Files Included
- **Dress_Attributes.xlsx**: Raw dataset used for extraction
- **ETL_Pipeline.py**: Python script for ETL workflow, cleaning and transforming data
- **DressSales_SQL_Script**.sql:	SQL script for creating tables and loading data
- **Dress_Attributes_Dashboard.pbix**:	Power BI dashboard showcasing final insights

---
## 🧠 Key Learnings
- Developed a complete ETL workflow integrating Python, SQL, and Power BI
- Gained expertise in data cleaning, transformation, and modeling
- Improved ability to create data-driven dashboards and business reports
- Enhanced understanding of data relationships and SQL queries for analysis
---
## 💬 About Me
I’m **Karthick M**, an aspiring **Data Analyst** skilled in transforming raw data into meaningful insights using tools like **Python, SQL, Excel, and Power BI**.

📧 Email: karthicksundaram0802@gmail.com  
🔗 LinkedIn: [linkedin.com/in/your-karthick-m07](https://linkedin.com/in/karthick-m07)
