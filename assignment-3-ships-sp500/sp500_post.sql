-- Author: Sahil Sanghvi


-- Create the tables for the S&P 500 database
-- by importing the data from the csv files provided.
-- They contain information about the companies
-- in the S&P 500 stock market index
-- during some interval of time in 2014-2015.
-- https://en.wikipedia.org/wiki/S%26P_500

-- Change the type of the day column to DATE.
-- Only run this if the column is not already DATE type
--ALTER TABLE history ALTER COLUMN day TYPE DATE
--USING day::DATE;


-- Exercise 1 (3 pts)

-- 1. (1 pts) Find the number of companies for each state, sort descending by the number.

-- Exercise 1 part 1

SELECT state, COUNT(*) AS num_companies
FROM sp500
GROUP BY state
ORDER BY num_companies DESC;


-- 2. (1 pts) Find the number of companies for each sector, sort descending by the number.

-- Exercise 1 part 2

SELECT sector, COUNT(*) AS num_companies
FROM sp500
GROUP BY sector
ORDER BY num_companies DESC;


-- 3. (1 pts) Order the days of the week by their average volatility.
-- Sort descending by the average volatility.
-- Use 100*abs(high-low)/low to measure daily volatility.

-- Exercise 1 part 3

SELECT EXTRACT(DOW FROM day) AS day_of_week,
       TO_CHAR(day, 'Day') AS day_name,
       AVG(100 * ABS(high - low) / low) AS avg_volatility
FROM history
GROUP BY EXTRACT(DOW FROM day), TO_CHAR(day, 'Day')
ORDER BY avg_volatility DESC;




-- Exercise 2 (4 pts)

-- 1. (2 pts) Find for each symbol and day the pct change from the previous business day.
-- Order descending by pct change. Use adjclose.

-- Exercise 2 part 1

SELECT symbol,
       day,
       100.0 * (adjclose - LAG(adjclose) OVER (PARTITION BY symbol ORDER BY day))
             / LAG(adjclose) OVER (PARTITION BY symbol ORDER BY day) AS pct_change
FROM history
ORDER BY pct_change DESC NULLS LAST;


-- 2. (2 pts)
-- Many traders believe in buying stocks in uptrend
-- in order to maximize their chance of profit.
-- Let us check this strategy.
-- Find for each symbol on Oct 1, 2015
-- the pct change 20 trading days earlier and 20 trading days later.
-- Order descending by pct change with respect to 20 trading days earlier.
-- Use adjclose.

-- Expected result
--symbol,pct_change,pct_change2
--TE,26.0661102331371252,3.0406725557250169
--TAP,24.6107784431137725,5.1057184046131667
--CVC,24.4688922610015175,-0.67052727826882048156
--...

-- Exercise 2 part 2

WITH ranked_data AS (
    SELECT symbol,
           day,
           adjclose,
           ROW_NUMBER() OVER (PARTITION BY symbol ORDER BY day) AS rn
    FROM history
),
oct1_data AS (
    SELECT symbol, adjclose, rn
    FROM ranked_data
    WHERE day = DATE '2015-10-01'
)
SELECT o.symbol AS symbol,
       100.0 * (o.adjclose - prev.adjclose) / prev.adjclose AS pct_change,
       100.0 * (next.adjclose - o.adjclose) / o.adjclose AS pct_change2
FROM oct1_data o
JOIN ranked_data prev ON o.symbol = prev.symbol AND prev.rn = o.rn - 20
JOIN ranked_data next ON o.symbol = next.symbol AND next.rn = o.rn + 20
ORDER BY pct_change DESC;




-- Exercise 3 (3 pts)
-- Find the top 10 symbols with respect to their average money volume AVG(volume*adjclose).
-- Use round(..., -8) on the average money volume.
-- Give three versions of your query, using ROW_NUMBER(), RANK(), and DENSE_RANK().

-- Ex3: Version 1: Using ROW_NUMBER()
SELECT symbol, avg_money_volume
FROM (
    SELECT symbol,
           ROUND(AVG(volume::NUMERIC * adjclose), -8) AS avg_money_volume,
           ROW_NUMBER() OVER (ORDER BY AVG(volume::NUMERIC * adjclose) DESC) AS rn
    FROM history
    GROUP BY symbol
) ranked
WHERE rn <= 10;

-- Ex3: Version 2: Using RANK()
SELECT symbol, avg_money_volume
FROM (
    SELECT symbol,
           ROUND(AVG(volume::NUMERIC * adjclose), -8) AS avg_money_volume,
           RANK() OVER (ORDER BY AVG(volume::NUMERIC * adjclose) DESC) AS rnk
    FROM history
    GROUP BY symbol
) ranked
WHERE rnk <= 10;

-- Ex3: Version 3: Using DENSE_RANK()
SELECT symbol, avg_money_volume
FROM (
    SELECT symbol,
           ROUND(AVG(volume::NUMERIC * adjclose), -8) AS avg_money_volume,
           DENSE_RANK() OVER (ORDER BY AVG(volume::NUMERIC * adjclose) DESC) AS drnk
    FROM history
    GROUP BY symbol
) ranked
WHERE drnk <= 10;
