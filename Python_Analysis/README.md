# Project Update: Python & Advanced Analytics

## Overview
After completing the initial SQL + Power BI phase, I integrated **Python (Pandas)** to automate complex calculations, enhance data processing efficiency, and extend the depth of the analysis with advanced inventory frameworks.

## 🛠 Key Technical Features
- **Efficient Cohort Analysis:** Refactored the original SQL logic into a streamlined Python pipeline. This reduced code complexity and significantly improved execution speed compared to multiple SQL CTEs.
- **Multi-dimensional ABC-XYZ Matrix:** Implemented an advanced inventory classification system to evaluate product performance from two angles: revenue contribution and demand stability.
- **Automated Data Pipeline:** Utilized `SQLAlchemy` and `pyodbc` to establish a direct connection to the SQL Server, fetching data directly into Pandas DataFrames for real-time analysis.

## 📊 Findings and Recommendations

### 1. ABC Analysis (Revenue Contribution)
The analysis revealed a typical but slightly skewed distribution:
- **Category A (High Value):** 29 items (22.5%) — The core revenue drivers.
- **Category B (Medium Value):** 41 items (31.8%).
- **Category C (Low Value):** 59 items (45.7%) — Almost half of the assortment brings the least revenue.

### 2. XYZ Analysis (Demand Stability)
Since the variability coefficient exceeded 1, I used `pd.qcut` to segment products into three equal groups based on demand volatility:
- **Group X:** Top 33% with the highest stability (predictable sales).
- **Group Y:** Middle 33% with moderate fluctuations.
- **Group Z:** Bottom 33% with the highest uncertainty (erratic sales).

### 3. Integrated ABC-XYZ Matrix: Strategic Actions

By combining both metrics into a 9-cell matrix, I identified the following strategic insights:

#### **Group A (The Revenue Drivers)**
*   **AX (14 items) - "The Stars":** Stable high-revenue generators. 
    *   *Action:* Ensure 100% availability. Automate procurement to maintain optimal stock levels.
*   **AY (10 items) - "High Potential":** Important items with moderate volatility.
    *   *Action:* Maintain a higher **safety stock** compared to AX to prevent out-of-stock situations during demand spikes.
*   **AZ (5 items) - "High Risk/High Reward":** Likely expensive bikes with erratic sales.
    *   *Action:* Avoid overstocking to prevent capital freezing. Use individual forecasting or "just-in-time" delivery models.

#### **Group B (The Backbone)**
*   **BX (7 items) & BY (18 items):** Reliable secondary assortment (accessories, consumables).
    *   *Action:* Standard control. For BY, consider marketing activities to stabilize demand and move them into the BX category.
*   **BZ (16 items):** Average revenue with high management effort.
    *   *Action:* Audit these items to ensure they aren't consuming too much warehouse space or management attention.

#### **Group C (The Long Tail)**
*   **CX (22 items):** Stable, low-cost "small-ticket" items (e.g., tubes, lubricants).
    *   *Action:* Bulk purchasing. The cost of managing these orders is often higher than the items themselves; simplify the process.
*   **CY (14 items):** Underperformers or New Arrivals.
    *   *Action:* Monitor closely. If they aren't new products, they may not justify the effort.
*   **CZ (23 items) - "The Deadstock Candidates":** Low revenue and total unpredictability.
    *   *Action:* These are the primary candidates for **liquidation**. Unless they are essential accessories for Category A bikes, they should be phased out to optimize inventory.

## 💡 Final Conclusion
The most striking finding is that **CZ is the most numerous group (23 items)**, while AZ contains 5 high-value but unstable items. This indicates that **nearly 20% of the assortment is either inefficient or introduces logistical chaos.** Streamlining the CZ group could significantly reduce holding costs and improve overall operational efficiency.
