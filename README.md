# UrbanCart__Analysis
UrbanCart Superstore — End-to-End Data Analyst Portfolio (Excel + SQL + Power BI)




##  Project Overview
This project analyses the **UrbanCart Superstore** sales dataset and delivers insights analytics workflow:

**Excel (cleaning + dashboard) → SQL (business queries) → Power BI (model + DAX + interactive dashboard)**

The aim is to turn raw transactional data into clear, stakeholder-ready reporting and actionable business insights.

---

##  Dataset
**UrbanCart Superstore (Transactional Sales Data)**  
Each row represents an **order line item** (one product within an order).

### Key fields
- **Order & Shipping**: Order Date, Ship Date, Ship Mode, Delivery Days
- **Customer**: Customer ID, Customer Name, Segment, Region
- **Product**: Category, Sub-Category, Product Name
- **Metrics**: Sales, Quantity, Discount, Profit
- **Time**: Year, Month (created for trend analysis)

---

##  Business Questions Answered
- How are **Sales and Profit trending** month by month?
- Which **categories / sub-categories** drive profit, and which are loss-making?
- How does **discount** impact profit and margin?
- Which **regions** and **customer segments** perform best?
- How is **delivery performance** trending (Delivery Days, Ship Mode)?

---

##  Tools & Skills Demonstrated
- **Excel**: Tables, cleaning checks, calculated columns, PivotTables, PivotCharts, Slicers, KPI dashboard
- **SQL**: Data validation checks, KPI aggregation, trends, ranking (top/bottom), profitability analysis
- **Power BI**: Power Query transformations, star schema modelling, DAX measures, interactive dashboard design

---

#  Part 1 — Excel Work (Cleaning + Calculated Columns + Dashboard)

## 1) Data Cleaning Steps (Excel)
1. Converted dataset to an Excel Table (`tblSales`) for structured references and easier refresh.
2. Checked **mandatory columns** for blanks:
   - Order ID, Order Date, Sales, Profit  
   Blank mandatory rows were removed (where applicable).
3. Validated data types:
   - Dates: Order Date, Ship Date
   - Numeric: Sales, Profit, Quantity, Discount, Delivery Days
   - Text: Region, Segment, Category, Sub-Category, etc.
4. Standardised text fields (where required) using TRIM/CLEAN logic.
5. Delivery logic check:
   - **Delivery Days = 0** treated as **Same-day** (flagged, not deleted)
   - Negative delivery days flagged as invalid
6. Basic sanity checks:
   - Discount range (0 to 1)
   - Unusual negative or zero Sales values reviewed

---

## 2) Calculated Columns Created (Excel)
Examples of calculated columns added to support analysis:
- **Order Year** = YEAR(Order Date)
- **Order Month** (YYYY-MM) = TEXT(Order Date, "yyyy-mm")
- **Quarter** = "Q" & ROUNDUP(MONTH(Order Date)/3,0)
- **Discount Band** (0%, 1–10%, 11–20%, 21–30%, 31–40%, >40%)
- **Delivery Status** (Same-day / Fast / Standard / Slow / Invalid)
- **Is Loss** flag (Profit < 0)

---

## 3) Excel Dashboard (Simple & Professional)
### KPIs shown (top row)
- Total Sales
- Total Profit
- Profit Margin %
- Total Orders
- Average Discount %
- Average Delivery Days

### Charts used
- Monthly Sales trend (line chart)
- Profit by Category (column chart)
- Profit by Region (bar chart)
- Bottom 5 loss-making sub-categories (bar chart)
- Discount band vs Profit (strong insight)

### Interactivity
- Slicers for Year, Region, Segment, Category

---

# Part 2 — SQL Work (Business Queries)

## SQL Focus Areas
The SQL analysis was designed to replicate what UK employers expect in reporting and ad-hoc analysis:

### 1) Data Quality Checks
- Null checks for mandatory columns (Order ID, Order Date, Sales, Profit)
- Duplicate checks (Row ID uniqueness)
- Range checks:
  - Discount between 0 and 1
  - Delivery Days not negative

### 2) KPI Summary Queries
- Total Sales, Total Profit, Profit Margin
- Total Orders (distinct Order ID)
- Average Order Value (AOV)
- Average Discount
- Average Delivery Days

### 3) Trend Analysis
- Monthly sales & profit trend (Order Month)
- Year-over-year performance (Order Year)

### 4) Profitability & Ranking
- Profit by Category / Sub-Category
- Top products by Profit
- Bottom loss-making Sub-Categories (key risk drivers)

### 5) Discount Impact
- Profitability by Discount Band (0%, 1–10%, 11–20%, etc.)
- Identify discount thresholds where margin turns negative

---

# Part 3 — Power BI Work (Model + DAX + Dashboard)

## 1) Data Preparation (Power Query)
Transformations applied:
- Corrected data types (Date, Text, Decimal, Whole Number)
- Trimmed and cleaned text columns
- Removed duplicates and error rows
- Created a **GeoKey** for consistent geography relationships
- Built a dynamic **Date table** based on Order Date range

---

## 2) Data Model (Star Schema)
A professional star schema was implemented:

### Fact Table
- **Fact_Sales**
  - Sales, Profit, Quantity, Discount
  - Order Date, Customer ID, Product ID, GeoKey

### Dimension Tables
- **Dim_Date** – Date, Year, Month, Quarter
- **Dim_Customer** – Customer ID, Customer Name, Segment
- **Dim_Product** – Product ID, Category, Sub-Category
- **Dim_Geography** – Country, Region, State, City

Relationships:
- One-to-Many (1:*)
- Single direction
- Optimised for time intelligence and performance

---

## 3) DAX Measures Created
Core measures:

```DAX
Total Sales = SUM ( Fact_sales[Sales] )

Total Profit = SUM ( Fact_sales[Profit] )

Total Quantity = SUM ( Fact_sales[Quantity] )

Total Orders = DISTINCTCOUNT ( Fact_sales[Order ID] )

Profit Margin % = DIVIDE ( [Total Profit], [Total Sales] )

Average Order Value = DIVIDE ( [Total Sales], [Total Orders] )

Average Discount % = AVERAGE ( Fact_sales[Discount] )

Average Delivery Days = AVERAGE ( Fact_sales[Delivery Days] )
