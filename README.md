# 📱 Smartprix Mobile Phones Dataset - Comprehensive Data Cleaning Project

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![SQL](https://img.shields.io/badge/SQL-Server-blue)](https://www.microsoft.com/en-us/sql-server)
[![Kaggle](https://img.shields.io/badge/Kaggle-Dataset-20BEFF)](https://www.kaggle.com/)

A professional data cleaning and transformation project that converts raw, messy mobile phone data from Smartprix into an analysis-ready dataset with proper data types, extracted values, and calculated metrics.

## 🎯 Project Overview

This project demonstrates comprehensive data cleaning techniques on a real-world dataset containing mobile phone specifications. The raw data includes mixed data types, embedded text values, inconsistent formats, and requires extensive transformation to be useful for analysis or machine learning.

### What Makes This Special?

- ✅ **Production-Ready SQL**: Enterprise-grade SQL query with proper error handling
- ✅ **Comprehensive Transformations**: 100+ columns cleaned and standardized
- ✅ **Type Conversions**: Text to numeric, boolean standardization, date parsing
- ✅ **Value Extraction**: Intelligent parsing of embedded values (weights, capacities, sizes)
- ✅ **Calculated Fields**: Derived metrics like original prices and percentages
- ✅ **Performance Optimized**: Includes indexes for common query patterns
- ✅ **Analysis Views**: Pre-built views for common analytical queries

## 📊 Dataset Information

**Source**: Smartprix Mobile Phones Dataset (Raw & Uncleaned)  
**Original Data**: [Kaggle Dataset Link](https://www.kaggle.com/datasets/mayankkumarpoddar/smartprix-mobiles-dataset)  
**Cleaned Data**: [Kaggle Dataset Link](https://www.kaggle.com/datasets/allenclose/cleaned-and-analyzed-phone-dataset-from-smartprix)]

### Statistics
- **Total Records**: ~10,000+ mobile phones
- **Columns**: 120+ specifications
- **Time Period**: Multiple years of device releases
- **Brands**: 50+ manufacturers

## 🚀 Key Features

### Data Cleaning Transformations

#### 1. **Numeric Extraction**
```sql
-- Weight: "185g" → 185.00 (decimal)
-- Display: "6.7 inches" → 6.70 (decimal)
-- Battery: "5000 mAh" → 5000 (integer)
-- RAM/Storage: "8GB", "512MB" → 8.00, 0.50 (standardized to GB)
```

#### 2. **Boolean Standardization**
```sql
-- BIT values → 'Yes'/'No'
-- Features: 5G, NFC, Face Unlock, IR Blaster, etc.
```

#### 3. **Date Parsing**
```sql
-- Release Date → Structured DATE type
-- Extracted: Release_Year, Release_Month (named)
```

#### 4. **Calculated Fields**
```sql
-- Original_Price = Current_Price + Price_Drop_Amount
-- Screen_To_Body_Ratio_Percent (extracted from text)
-- Performance scores (cleaned numeric values)
```

#### 5. **Text Standardization**
```sql
-- LTRIM/RTRIM on all text fields
-- Consistent formatting across brands, models, features
```

## 📁 Repository Structure

```
smartprix-mobile-cleaning/
│
├── sql/
│   ├── comprehensive_cleaning.sql      # Main cleaning query
│   ├── create_views.sql                # Analysis views
│   └── data_quality_checks.sql         # Validation queries
│
├── data/
│   ├── sample_raw_data.csv             # Sample of raw data
│   └── sample_cleaned_data.csv         # Sample of cleaned data
│
├── notebooks/
│   ├── 01_data_exploration.ipynb       # Initial EDA
│   ├── 02_cleaning_validation.ipynb    # Validation & QA
│   └── 03_analysis_examples.ipynb      # Usage examples
│
├── docs/
│   ├── data_dictionary.md              # Column descriptions
│   ├── transformation_guide.md         # Detailed transformation logic
│   └── cleaning_methodology.md         # Step-by-step process
│
├── README.md                            # This file
├── LICENSE                              # MIT License
└── requirements.txt                     # Python dependencies
```

## 🛠️ Technologies Used

- **SQL Server**: Primary data cleaning engine
- **T-SQL**: Advanced query features (CTEs, CASE statements, TRY_CONVERT)
- **Python** (optional): For validation and analysis
- **Pandas**: For working with the cleaned CSV

## 📖 How to Use

### Option 1: Run the SQL Script

```sql
-- 1. Import raw data into SQL Server
-- 2. Execute the comprehensive cleaning script
USE Smartprix
GO

-- Run comprehensive_cleaning.sql
-- This will create: dbo.mobiles_cleaned table
```

### Option 2: Use the Cleaned CSV

```python
import pandas as pd

# Load the cleaned dataset
df = pd.read_csv('cleaned_mobiles.csv')

# Ready for immediate analysis!
print(df.info())
print(df.describe())

# Example: Top brands by average price
top_brands = df.groupby('Brand')['Current_Price'].mean().sort_values(ascending=False).head(10)
```

## 🎓 Learning Highlights

### SQL Techniques Demonstrated

1. **Common Table Expressions (CTEs)**
   ```sql
   WITH CleanedData AS (
       SELECT ... FROM source
   )
   SELECT * INTO destination FROM CleanedData;
   ```

2. **Type Conversion with Error Handling**
   ```sql
   TRY_CONVERT(DECIMAL(10,2), cleaned_value)
   ```

3. **Complex String Manipulation**
   ```sql
   REPLACE(REPLACE(REPLACE(field, 'unit', ''), ' ', ''), ',', '.')
   ```

4. **Conditional Logic**
   ```sql
   CASE WHEN condition THEN 'Yes' ELSE 'No' END
   ```

5. **View Creation for Reusable Queries**
   ```sql
   CREATE VIEW vw_PriceByBrand AS ...
   ```

6. **Performance Optimization**
   ```sql
   CREATE INDEX IX_Brand ON mobiles_cleaned(Brand);
   ```

## 📊 Cleaned Data Schema

### Key Columns

| Column Name | Type | Description | Example |
|-------------|------|-------------|---------|
| Brand | VARCHAR | Manufacturer name | "Samsung", "Apple" |
| Model | VARCHAR | Model number/name | "Galaxy S23", "iPhone 15" |
| Current_Price | DECIMAL | Current market price | 49999.00 |
| Original_Price | DECIMAL | Launch price (calculated) | 59999.00 |
| RAM_GB | DECIMAL | RAM in gigabytes | 8.00, 12.00 |
| Storage_GB | DECIMAL | Storage in gigabytes | 128.00, 256.00 |
| Battery_Capacity_mAh | INT | Battery capacity | 5000, 4500 |
| Display_Size_Inches | DECIMAL | Screen size | 6.7 |
| Has_5G | VARCHAR | 5G support | "Yes", "No" |
| Release_Date | DATE | Launch date | 2024-01-15 |

[See full data dictionary →](docs/data_dictionary.md)

## 🎯 Use Cases

This cleaned dataset is perfect for:

- 📈 **Price Prediction Models**: Predict phone prices based on specifications
- 🔍 **Market Analysis**: Analyze trends in mobile phone features and pricing
- 🏆 **Comparative Studies**: Compare brands, models, and specifications
- 🤖 **Recommendation Systems**: Build phone recommendation engines
- 📊 **Business Intelligence**: Market positioning and competitive analysis
- 🎓 **Data Science Education**: Real-world data cleaning examples

## 📈 Sample Analysis

### Price Distribution by Brand
```sql
SELECT 
    Brand,
    COUNT(*) AS Model_Count,
    AVG(Current_Price) AS Avg_Price,
    MIN(Current_Price) AS Min_Price,
    MAX(Current_Price) AS Max_Price
FROM dbo.mobiles_cleaned
WHERE Current_Price IS NOT NULL
GROUP BY Brand
ORDER BY Avg_Price DESC;
```

### 5G Adoption Analysis
```sql
SELECT 
    Release_Year,
    COUNT(*) AS Total_Phones,
    SUM(CASE WHEN Has_5G = 'Yes' THEN 1 ELSE 0 END) AS Phones_With_5G,
    CAST(SUM(CASE WHEN Has_5G = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Percentage_5G
FROM dbo.mobiles_cleaned
WHERE Release_Year IS NOT NULL
GROUP BY Release_Year
ORDER BY Release_Year;
```

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. 🐛 **Report bugs**: Found an issue? Open a GitHub issue
2. 💡 **Suggest enhancements**: Have ideas? Let's discuss them
3. 🔧 **Submit pull requests**: Improvements to SQL queries, documentation, or analysis
4. 📚 **Share use cases**: Show us what you built with this dataset

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Data Attribution**: Original data sourced from Smartprix.com via the Kaggle dataset by Allen Close.

## 🙏 Acknowledgments

- **Smartprix**: For providing the original dataset
- **Allen Close**: For creating the raw dataset on Kaggle
- **Data Science Community**: For inspiration and best practices

## 📧 Contact

**Allen Close** - [@yourusername](https://twitter.com/yourusername)  
**Project Link**: [https://github.com/acsqlworks/smartprix-mobile-cleaning]([https://github.com/yourusername/repo-name](https://github.com/acsqlworks/Smartprix-Mobile-Phones-Dataset---Comprehensive-Data-Cleaning-Project/))  
**Kaggle Dataset**: [[Your Kaggle Dataset Link](https://www.kaggle.com/datasets/allenclose/cleaned-and-analyzed-phone-dataset-from-smartprix)]

---

⭐ If you found this project helpful, please consider giving it a star!

**Tags**: `data-cleaning` `sql` `data-transformation` `mobile-phones` `kaggle-dataset` `data-analysis` `etl` `sql-server`
