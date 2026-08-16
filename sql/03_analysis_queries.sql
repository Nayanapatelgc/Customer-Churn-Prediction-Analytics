-- Overall Chrun Analysis-- 
USE customer_churn_db;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS retained_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers;

-- Chrun by contract--
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY Contract
ORDER BY churn_rate DESC;

 -- Churn by Internet Service
 SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY InternetService
ORDER BY churn_rate DESC;
 
 SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

-- Churn by Tech Support
SELECT
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY TechSupport
ORDER BY churn_rate DESC;

-- Churn by Online Security
SELECT
    OnlineSecurity,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY OnlineSecurity
ORDER BY churn_rate DESC;

-- Churn by Tenure Group
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49-72 Months'
    END AS tenure_group,

    COUNT(*) AS total_customers,

    SUM(
        CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END
    ) AS churned_customers,

    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customers

GROUP BY tenure_group

ORDER BY churn_rate DESC;

-- Average Charges by Churn 
SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2) AS avg_total_charges
FROM customers
GROUP BY Churn;

-- Partner and Dependents Analysis
SELECT
    Partner,
    Dependents,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY Partner, Dependents
ORDER BY churn_rate DESC;

-- High-Risk Customer Segment
SELECT
    COUNT(*) AS customer_count,

    SUM(
        CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END
    ) AS churned_customers,

    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customers

WHERE Contract = 'Month-to-month'
  AND PaymentMethod = 'Electronic check'
  AND TechSupport = 'No'
  AND OnlineSecurity = 'No';
  
  -- Find Actual Churned Customers
  SELECT
    customerID,
    tenure,
    Contract,
    InternetService,
    PaymentMethod,
    MonthlyCharges,
    TechSupport,
    OnlineSecurity,
    Churn
FROM customers
WHERE Churn = 'Yes'
ORDER BY MonthlyCharges DESC;

-- 11. Customer Risk Segmentation

WITH customer_risk AS (
    SELECT
        customerID,
        Contract,
        PaymentMethod,
        tenure,
        TechSupport,
        OnlineSecurity,
        MonthlyCharges,
        Churn,

        (
            CASE
                WHEN Contract = 'Month-to-month' THEN 2
                ELSE 0
            END

            +

            CASE
                WHEN PaymentMethod = 'Electronic check' THEN 2
                ELSE 0
            END

            +

            CASE
                WHEN tenure <= 12 THEN 2
                ELSE 0
            END

            +

            CASE
                WHEN TechSupport = 'No' THEN 1
                ELSE 0
            END

            +

            CASE
                WHEN OnlineSecurity = 'No' THEN 1
                ELSE 0
            END

            +

            CASE
                WHEN MonthlyCharges >= 70 THEN 1
                ELSE 0
            END
        ) AS risk_score

    FROM customers
)

SELECT
    customerID,
    Contract,
    PaymentMethod,
    tenure,
    TechSupport,
    OnlineSecurity,
    MonthlyCharges,
    Churn,
    risk_score,

    CASE
        WHEN risk_score >= 7 THEN 'High Risk'
        WHEN risk_score >= 4 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level

FROM customer_risk

ORDER BY risk_score DESC;

-- 12. Risk level summary

WITH customer_risk AS (
    SELECT
        customerID,

        (
            CASE
                WHEN Contract = 'Month-to-month' THEN 2
                ELSE 0
            END
            +
            CASE
                WHEN PaymentMethod = 'Electronic check' THEN 2
                ELSE 0
            END
            +
            CASE
                WHEN tenure <= 12 THEN 2
                ELSE 0
            END
            +
            CASE
                WHEN TechSupport = 'No' THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN OnlineSecurity = 'No' THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN MonthlyCharges >= 70 THEN 1
                ELSE 0
            END
        ) AS risk_score

    FROM customers
)

SELECT
    CASE
        WHEN risk_score >= 7 THEN 'High Risk'
        WHEN risk_score >= 4 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level,

    COUNT(*) AS customer_count

FROM customer_risk

GROUP BY risk_level

ORDER BY customer_count DESC;

-- 13. Churn rate by risk level

WITH customer_risk AS (
    SELECT
        customerID,
        Churn,

        (
            CASE
                WHEN Contract = 'Month-to-month' THEN 2
                ELSE 0
            END
            +
            CASE
                WHEN PaymentMethod = 'Electronic check' THEN 2
                ELSE 0
            END
            +
            CASE
                WHEN tenure <= 12 THEN 2
                ELSE 0
            END
            +
            CASE
                WHEN TechSupport = 'No' THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN OnlineSecurity = 'No' THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN MonthlyCharges >= 70 THEN 1
                ELSE 0
            END
        ) AS risk_score

    FROM customers
)

SELECT

    CASE
        WHEN risk_score >= 7 THEN 'High Risk'
        WHEN risk_score >= 4 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level,

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN Churn = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_risk

GROUP BY risk_level

ORDER BY churn_rate DESC;

-- 14. Top 20 highest-risk customers

WITH customer_risk AS (
    SELECT
        customerID,
        Contract,
        PaymentMethod,
        tenure,
        TechSupport,
        OnlineSecurity,
        MonthlyCharges,
        Churn,

        (
            CASE
                WHEN Contract = 'Month-to-month' THEN 2
                ELSE 0
            END
            +
            CASE
                WHEN PaymentMethod = 'Electronic check' THEN 2
                ELSE 0
            END
            +
            CASE
                WHEN tenure <= 12 THEN 2
                ELSE 0
            END
            +
            CASE
                WHEN TechSupport = 'No' THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN OnlineSecurity = 'No' THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN MonthlyCharges >= 70 THEN 1
                ELSE 0
            END
        ) AS risk_score

    FROM customers
)

SELECT
    customerID,
    Contract,
    PaymentMethod,
    tenure,
    TechSupport,
    OnlineSecurity,
    MonthlyCharges,
    Churn,
    risk_score,

    CASE
        WHEN risk_score >= 7 THEN 'High Risk'
        WHEN risk_score >= 4 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level

FROM customer_risk
ORDER BY risk_score DESC, MonthlyCharges DESC
LIMIT 20;