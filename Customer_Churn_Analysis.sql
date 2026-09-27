-- ============================================================
-- CUSTOMER CHURN ANALYSIS
-- BUSINESS QUESTIONS & MYSQL QUERIES
-- ============================================================

create database customer_churn;


USE customer_churn;

SHOW TABLES;


-- ============================================================
-- 1. TOTAL CUSTOMERS
-- ============================================================

SELECT
    COUNT(DISTINCT customerid) AS total_customers
FROM customer_churn_cleaned;


-- ============================================================
-- 2. CHURNED CUSTOMERS
-- ============================================================

SELECT
    COUNT(DISTINCT customerid) AS churned_customers
FROM customer_churn_cleaned
WHERE churn_label = 'Yes';


-- ============================================================
-- 3. ACTIVE CUSTOMERS
-- ============================================================

SELECT
    COUNT(DISTINCT customerid) AS active_customers
FROM customer_churn_cleaned
WHERE churn_label = 'No';


-- ============================================================
-- 4. OVERALL CHURN RATE
-- ============================================================

SELECT
    ROUND(
        SUM(CASE
            WHEN churn_label = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn_cleaned;


-- ============================================================
-- 5. CHURN DISTRIBUTION
-- ============================================================

SELECT
    churn_label,
    COUNT(*) AS customer_count
FROM customer_churn_cleaned
GROUP BY churn_label
ORDER BY customer_count DESC;


-- ============================================================
-- 6. CHURN BY GENDER
-- ============================================================

SELECT
    gender,
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN churn_label = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,

    ROUND(
        SUM(CASE
            WHEN churn_label = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn_cleaned
GROUP BY gender
ORDER BY churn_rate DESC;


-- ============================================================
-- 7. CHURN BY CONTRACT
-- ============================================================

SELECT
    contract,
    COUNT(*) AS total_customers,

    SUM(CASE
        WHEN churn_label = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,

    ROUND(
        SUM(CASE
            WHEN churn_label = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn_cleaned
GROUP BY contract
ORDER BY churn_rate DESC;


-- ============================================================
-- 8. CHURN BY INTERNET SERVICE
-- ============================================================

SELECT
    internet_service,
    COUNT(*) AS total_customers,

    SUM(CASE
        WHEN churn_label = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,

    ROUND(
        SUM(CASE
            WHEN churn_label = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn_cleaned
GROUP BY internet_service
ORDER BY churn_rate DESC;


-- ============================================================
-- 9. CHURN BY PAYMENT METHOD
-- ============================================================

SELECT
    payment_method,
    COUNT(*) AS total_customers,

    SUM(CASE
        WHEN churn_label = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,

    ROUND(
        SUM(CASE
            WHEN churn_label = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn_cleaned
GROUP BY payment_method
ORDER BY churn_rate DESC;


-- ============================================================
-- 10. CHURN BY TENURE GROUP
-- ============================================================

SELECT
    tenure_group,
    COUNT(*) AS total_customers,

    SUM(CASE
        WHEN churn_label = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,

    ROUND(
        SUM(CASE
            WHEN churn_label = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn_cleaned
GROUP BY tenure_group

ORDER BY
    CASE
        WHEN tenure_group = '0-12 Months' THEN 1
        WHEN tenure_group = '13-24 Months' THEN 2
        WHEN tenure_group = '25-48 Months' THEN 3
        WHEN tenure_group = '49-72 Months' THEN 4
        ELSE 5
    END;


-- ============================================================
-- 11. CHURN BY ONLINE SECURITY
-- ============================================================

SELECT
    online_security,
    COUNT(*) AS total_customers,

    SUM(CASE
        WHEN churn_label = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,

    ROUND(
        SUM(CASE
            WHEN churn_label = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn_cleaned
GROUP BY online_security
ORDER BY churn_rate DESC;


-- ============================================================
-- 12. CHURN BY TECH SUPPORT
-- ============================================================

SELECT
    tech_support,
    COUNT(*) AS total_customers,

    SUM(CASE
        WHEN churn_label = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,

    ROUND(
        SUM(CASE
            WHEN churn_label = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn_cleaned
GROUP BY tech_support
ORDER BY churn_rate DESC;


-- ============================================================
-- 13. CHURN BY PAPERLESS BILLING
-- ============================================================

SELECT
    paperless_billing,
    COUNT(*) AS total_customers,

    SUM(CASE
        WHEN churn_label = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,

    ROUND(
        SUM(CASE
            WHEN churn_label = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn_cleaned
GROUP BY paperless_billing
ORDER BY churn_rate DESC;


-- ============================================================
-- 14. AVERAGE MONTHLY CHARGES BY CHURN
-- ============================================================

SELECT
    churn_label,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges
FROM customer_churn_cleaned
GROUP BY churn_label;


-- ============================================================
-- 15. AVERAGE TOTAL CHARGES BY CHURN
-- ============================================================

SELECT
    churn_label,
    ROUND(AVG(total_charges), 2) AS avg_total_charges
FROM customer_churn_cleaned
GROUP BY churn_label;


-- ============================================================
-- 16. CUSTOMERS ABOVE AVERAGE MONTHLY CHARGES
-- ============================================================

SELECT
    customerid,
    monthly_charges,
    tenure_months,
    contract,
    internet_service,
    churn_label

FROM customer_churn_cleaned

WHERE monthly_charges >
(
    SELECT AVG(monthly_charges)
    FROM customer_churn_cleaned
)

ORDER BY monthly_charges DESC;


-- ============================================================
-- 17. CHURN REASONS
-- ============================================================

SELECT
    churn_reason,
    COUNT(*) AS churned_customers
FROM customer_churn_cleaned
WHERE churn_label = 'Yes'
AND churn_reason IS NOT NULL
GROUP BY churn_reason
ORDER BY churned_customers DESC;


-- ============================================================
-- 18. HIGH-RISK CUSTOMERS
-- ============================================================

SELECT
    customerid,
    churn_score,
    monthly_charges,
    tenure_months,
    contract,
    churn_label

FROM customer_churn_cleaned

WHERE churn_score >= 80

ORDER BY churn_score DESC;


-- ============================================================
-- 19. CHURN SCORE ANALYSIS
-- ============================================================

SELECT
    churn_label,
    ROUND(AVG(churn_score), 2) AS avg_churn_score,
    MAX(churn_score) AS max_churn_score,
    MIN(churn_score) AS min_churn_score

FROM customer_churn_cleaned

GROUP BY churn_label;


-- ============================================================
-- 20. TOP 3 HIGH-RISK CUSTOMERS BY CONTRACT
-- ============================================================

WITH ranked_customers AS
(
    SELECT
        customerid,
        contract,
        churn_score,
        monthly_charges,
        churn_label,

        RANK() OVER (
            PARTITION BY contract
            ORDER BY churn_score DESC
        ) AS risk_rank

    FROM customer_churn_cleaned
)

SELECT
    customerid,
    contract,
    churn_score,
    monthly_charges,
    churn_label,
    risk_rank

FROM ranked_customers

WHERE risk_rank <= 3

ORDER BY contract, risk_rank;