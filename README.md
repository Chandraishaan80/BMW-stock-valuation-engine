# BMW Stock Valuation Engine

This repository contains a **full financial analysis & valuation project** for BMW, combining SQL queries, a consolidated Excel dataset, and Tableau dashboards.  

It showcases:
- BigQuery SQL analytics
- Clean, structured datasets
- Interactive Tableau visualizations  
— making it a strong portfolio project for financial/data analytics roles.

---

## 📄 Files

| File | Description |
|------|-------------|
| `bmw_queries.sql` | SQL file containing all BigQuery queries, organized by section and commented. |
| `BMW_financials_Data.xlsx` | Excel workbook with 5 sheets: Comparables, Raw Data, Forecast, Sensitivity, Valuation. |
| `BMW_raw.twbx` | Tableau workbook: Raw Data analysis. |
| `BMW_forecast.twbx` | Tableau workbook: Forecast & Discounted Cash Flow (DCF) analysis. |
| `BMW_comparables.twbx` | Tableau workbook: Industry peers & comparables multiples. |
| `BMW_sensitivity.twbx` | Tableau workbook: Sensitivity analysis heatmap (WACC vs Growth). |
| `BMW_valuation.twbx` | Tableau workbook: Valuation summary dashboard. |

---

## 📝 Project Sections

### 1️⃣ RAW DATA
- Historical financials
- Free Cash Flow (FCF), Debt Ratios, YoY Income Growth

### 2️⃣ FORECAST
- Forecasted & Discounted FCF (DCF)
- Present Value calculation

### 3️⃣ COMPARABLES
- Industry peers & valuation multiples (P/E, EV/EBITDA, P/B)
- Undervalued peer identification

### 4️⃣ VALUATION / SENSITIVITY
- WACC & Growth Rate sensitivity analysis
- Implied valuation range & heatmap

---

## 📊 Tools Used

- 📈 **Google BigQuery** — SQL queries & analysis
- 📗 **Excel** — Consolidated dataset
- 📊 **Tableau** — Interactive dashboards

---

## 🚀 How to Use

1️⃣ Clone or download this repository.  
2️⃣ Open `BMW_financials_Data.xlsx` to explore the dataset — each sheet corresponds to an analysis section.  
3️⃣ Open `bmw_queries.sql` in your SQL editor or BigQuery console — run queries on respective tables/datasets.  
4️⃣ Open the `.twbx` Tableau workbooks in Tableau Public/Desktop — each file is a dashboard for a specific analysis area.

---

## 📌 Notes

- Table names in SQL assume you’ve loaded the Excel sheets as BigQuery tables.
- Tableau dashboards use the Excel data directly (or can be pointed to BigQuery).

---

## 📧 Author
Ishan Chandra

Feel free to fork, star ⭐, and contribute!

---
