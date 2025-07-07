
-- BMW Stock Valuation Engine Queries
-- Author: [Your Name]
-- Date: [Today’s Date]
-- Description:
--   A collection of BigQuery SQL queries to analyze BMW's financial data,
--   forecasted cash flows, comparables, and valuation metrics.

-- ======================
-- 📄 Section 1: RAW DATA
-- ======================

-- Query 1: Full raw data
SELECT *
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_rawdata`
ORDER BY Year DESC;

-- Query 2: Free Cash Flow (FCF)
SELECT 
  Year, 
  `Cash from Ops _EUR M_` - `CapEx _EUR M_` AS Free_Cash_Flow_EUR_M
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_rawdata`
ORDER BY Year DESC;

-- Query 3: FCF per Share
SELECT 
  Year,
  (`Cash from Ops _EUR M_` - `CapEx _EUR M_`) / `Shares Outstanding _EUR M_` AS FCF_Per_Share
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_rawdata`
ORDER BY Year DESC;

-- Query 4: Debt to Income Ratio
SELECT 
  Year,
  `Total Debt _EUR M_` / `Net Income _EUR M_` AS Debt_to_Income
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_rawdata`
ORDER BY Year DESC;

-- Query 5: Cash to Debt Ratio
SELECT 
  Year,
  `Cash and Equivalents _EUR M_` / `Total Debt _EUR M_` AS Cash_to_Debt_Ratio
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_rawdata`
ORDER BY Year DESC;

-- Query 6: Future Cash Flow
SELECT 
  Year,
  `Future cash flow`
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_rawdata`
ORDER BY Year DESC;

-- Query 7: YoY Net Income Growth %
SELECT 
  Year,
  `Net Income _EUR M_`,
  LAG(`Net Income _EUR M_`) OVER (ORDER BY Year) AS Prev_Year_Income,
  ROUND(
    ( (`Net Income _EUR M_` - LAG(`Net Income _EUR M_`) OVER (ORDER BY Year)) 
      / LAG(`Net Income _EUR M_`) OVER (ORDER BY Year) ) * 100, 2
  ) AS YoY_Net_Income_Growth_Pct
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_rawdata`
ORDER BY Year DESC;

-- =======================
-- 📄 Section 2: FORECAST
-- =======================

-- Query 1: Present Value of FCF
SELECT 
  SUM(`Discounted FCF _EUR M_`) AS Present_Value_of_FCF
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_forecast`;

-- Query 2: Average WACC
SELECT 
  AVG(`WACC%`) AS Average_WACC
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_forecast`;

-- Query 3: Yearly Forecast & Cumulative Discounted FCF
SELECT 
  Year,
  `Forecasted FCF _EUR M_`,
  `Discount Factor _1 _ _1+WACC__n_`,
  `Discounted FCF _EUR M_`,
  SUM(`Discounted FCF _EUR M_`) OVER (ORDER BY Year) AS Cumulative_Discounted_FCF
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_forecast`
ORDER BY Year ASC;

-- ============================
-- 📄 Section 3: COMPARABLES
-- ============================

-- Query 1: Industry Average Multiples
SELECT 
  AVG(P_E) AS Avg_PE,
  AVG(EV_EBITDA) AS Avg_EV_EBITDA,
  AVG(P_B) AS Avg_PB
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_comparables`;

-- Query 2: Rank Companies by P/E
SELECT 
  Company,
  P_E
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_comparables`
ORDER BY P_E ASC;

-- Query 3: Undervalued Peers (Below Average P/E)
WITH industry_avg AS (
  SELECT AVG(P_E) AS avg_pe
  FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_comparables`
)
SELECT 
  c.Company,
  c.P_E,
  i.avg_pe
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_comparables` c
CROSS JOIN industry_avg i
WHERE c.P_E < i.avg_pe
ORDER BY c.P_E ASC;

-- ============================
-- 📄 Section 4: VALUATION / SENSITIVITY
-- ============================

-- Query 1: Min/Max Implied Price across Growth Rates
SELECT 
  `WACC _ g`,
  LEAST(
    CAST(`growth rate 1` AS FLOAT64), 
    CAST(`growth rate 2` AS FLOAT64), 
    CAST(`growth rate 3` AS FLOAT64)
  ) AS Min_Implied_Price,
  GREATEST(
    CAST(`growth rate 1` AS FLOAT64), 
    CAST(`growth rate 2` AS FLOAT64), 
    CAST(`growth rate 3` AS FLOAT64)
  ) AS Max_Implied_Price
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_sensitivity`
WHERE `WACC _ g` IS NOT NULL
ORDER BY `WACC _ g` ASC;

-- Query 2: Sensitivity Table (Pivoted Growth Rates)
SELECT 
  `WACC _ g`,
  'growth rate 1' AS Growth_Rate,
  `growth rate 1` AS Implied_Price
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_sensitivity`
WHERE `WACC _ g` IS NOT NULL

UNION ALL

SELECT 
  `WACC _ g`,
  'growth rate 2',
  `growth rate 2`
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_sensitivity`
WHERE `WACC _ g` IS NOT NULL

UNION ALL

SELECT 
  `WACC _ g`,
  'growth rate 3',
  `growth rate 3`
FROM `my-project-2-463200.bmw_stock_valuation_engine.bmw_sensitivity`
WHERE `WACC _ g` IS NOT NULL

ORDER BY `WACC _ g`, Growth_Rate;
