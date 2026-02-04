
# 📊 Sales Performance & Exploratory Pricing Analysis

A multi-tool data analytics project using Excel, SQL, Python, and Power BI

# 📁 Project Overview

This project combines descriptive business analytics with exploratory pricing analysis to evaluate sales performance, profitability, and demand behavior across products and sub-categories.

The primary objective is twofold:

1. To highlight key sales and profitability patterns over time, including regional performance, loss-making orders, and sub-category contributions.
2. To explore whether the available data supports meaningful estimation of demand elasticity and revenue response to price changes.

Rather than assuming price is a key demand driver, the project explicitly tests this hypothesis and documents the limitations encountered.

The project includes:

- Data cleaning and structuring (Excel, SQL)
- KPI construction and dimensional modeling
- Exploratory elasticity analysis (Python)
- Stakeholder-facing reporting and dashboards (Power BI)

# 🛠 Tools & Technologies

**Excel:** initial cleaning, validation, data organization

**SQL:** fact and dimension table creation, joins, CTEs, aggregations

**Python:** pandas, numpy, statsmodels, matplotlib (exploratory elasticity analysis)

**Power BI:** KPI reporting, profitability analysis, dashboard storytelling

**Git / GitHub:** version control and documentation

# 📑 Key Features

**1. Sales & Profitability KPIs**

The project highlights core business metrics, including:

- Total sales and profit trends over time
- Profit margins by sub-category and region
- Identification of loss-making orders
- Geographic and regional performance comparisons

These KPIs provide a high-level understanding of where gains and losses originate across the business.

**2. Dimensional Data Modeling (SQL)**

Raw data was cleaned and structured into fact and dimension tables to support analysis:

- Product, sub-category, and geographic dimensions
- Aggregated sales, quantity, price, and profit measures
- Export-ready datasets for Python analysis and Power BI reporting

This structure ensures consistency across tools and reproducibility of results.

**3. Exploratory Pricing & Elasticity Analysis (Python)**

An exploratory analysis was conducted to assess whether price changes meaningfully explain demand variation:

- Product-level and sub-category-level elasticity estimation
- Examination of price variation and noise in observed sales
- Diagnostic checks for model stability and interpretability

This analysis was intentionally exploratory, aimed at testing feasibility rather than forcing conclusions.

**4. Power BI Dashboard**

The final dashboard combines KPI reporting with analytical context:

- Sales and profit trends over time
- Regional and geographic breakdowns
- Sub-category contribution analysis
- Summary views linking KPI findings with pricing analysis results

The dashboard is designed for business stakeholders rather than technical users.

# 🚀 How to Run the Project

**Python**

-     pip install -r requirements.txt

Run notebooks in the `notebooks/` directory.

**SQL**

Scripts are written in T-SQL and stored in the `sql/` folder.

SQL Server or a compatible engine is recommended.

**Power BI**

Open the `.pbix` file in Power BI Desktop.

Data sources are linked to cleaned outputs from SQL / Excel.

# 📈 Results & Key Findings

Key findings from the analysis include:

- No strong evidence that price changes are a primary driver of demand within the available data.

- Product-level elasticity estimates are unreliable due to limited price variation and high noise.

- Sub-category level analysis, where sufficient variation exists, shows demand to be broadly inelastic (|ε| < 1) across all segments.

- Positive and near-zero price coefficients suggest that observed differences in sales volumes are better explained by structural factors such as sub-category characteristics, seasonality, and product mix rather than price movements.

- As a result, uniform price changes are unlikely to meaningfully influence demand based on this dataset alone.

# 📌 Implications & Business Takeaways

Based on the findings, the analysis suggests:

- Pricing decisions should not rely solely on historical price–quantity relationships derived from this data.

- Uniform price increases or discounts are unlikely to materially shift demand and should be evaluated cautiously.

- Greater impact may come from non-price levers such as product mix optimization, category strategy, timing, and regional focus.

- More granular data (e.g., promotions, cost changes, competitive pricing, seasonality indicators) would be required to reliably estimate demand elasticity and optimize pricing decisions.

# 📬 Contact

If you'd like feedback or suggestions, feel free to reach out through GitHub or open an issue.

# 📁 Data Source

This project uses the “Superstore Dataset, publicly available on Kaggle:

- [Superstore Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final?select=Sample+-+Superstore.csv)