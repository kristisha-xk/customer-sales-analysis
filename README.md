# Customer Sales & Retention Analysis (AdventureWorks)
## Project Overview
This educational project aims to demonstrate the integration of **SQL** and **Power BI** in a real-world business analytics workflow.
The primary goal was to analyze customer purchasing behavior, sales dynamics, and retention patterns for a bicycle retailer to provide actionable growth strategies.
## Tech Stack & Skills
- **SQL (MS SQL Server):** Data Extraction, Data Cleaning, CTEs, Joins, Window Functions, Pivot Tables.
- **Power BI:** Data Visualization, DAX, Interactive Dashboarding.
## Project Workflow
### 1. Data Transformation (SQL)
I used the 'AdventureWorksDW2025' database to prepare the analytical datasets. Key technical implementations include:
- **CTEs & Joins:** Heavily utilized to structure complex queries, especially for **RFM** and **Cohort Analysis**.
- **CASE WHEN:** Applied for rule-based customer segmentation (categorizing users by purchase frequency and value).
- **PIVOT:** Used to transform data into a matrix format for the Cohort Analysis table.
- **Window Functions:** Implemented `SUM() OVER()` to calculate the revenue contribution of the **Top 10 products**.
- **Data Cleaning:** Handled date formatting and filtered out irrelevant records for a clean analysis.
- 🔗 **[View SQL Script](./SQL)**
### 2. Visualization & DAX (Power BI)
Built an interactive dashboard to translate raw data into business insights:
- **DAX Measures:** Developed custom calculations, specifically for tracking the **Retention Rate %** over time.
- **Data Storytelling:** Designed visual layouts to highlight key performance indicators (KPIs) like Revenue Growth and Customer Loss.
- 🔗 **[Download Power BI Dashboard (.pbix)](./Dashboard/BI_dashboards.pbix)**
### 3. Advanced Analytics (Python)
Extended the project with Python to automate and deepen the analysis:
- **ABC-XYZ Matrix:** Performed multi-dimensional inventory classification (Revenue vs. Demand Stability).
- **Refactored Cohort Analysis:** Implemented the logic in Pandas for better scalability and execution speed.
- **Direct DB Connection:** Integrated `SQLAlchemy` for a seamless SQL-to-Python pipeline.
- 🔗 **[View Python Module & Findings](./Python_Analysis)**
---
## Business Analysis & Insights
The analysis focused on a critical issue: **low customer retention** despite a significant increase in total orders.
### Key Findings:
- **The "Growth Trap":** While orders and revenue are growing, the focus is heavily shifted toward new customer acquisition rather than retention.
- **High Churn:** Over **50% of the customer base** falls into the "Lost Customers" category.
- **Low Retention:** Cohort analysis reveals that long-term customer loyalty remains extremely low across almost all periods.
### Recommendations:
- **Loyalty Programs:** Implement reward systems to incentivize repeat purchases.
- **Personalization:** Use RFM segments for targeted email marketing.
- **Focus on "Big Spenders":** Prioritize high-value segments to increase Customer Lifetime Value (CLV).
- **Cross-Sell Strategies:** Introduce related products (accessories, maintenance) to boost revenue per customer.
---
## Final Report
A comprehensive PDF report with detailed findings and business recommendations:
- 🔗 **[Read Full Analysis (PDF)](./Report/Business_Analysis_Report.pdf)**

## Dashboard Preview
![Dashboard Screenshots](./Images)
