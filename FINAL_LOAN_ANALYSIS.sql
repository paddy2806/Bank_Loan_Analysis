-- Create database and table
CREATE TABLE loan_data (
    id INT PRIMARY KEY,
    address_state VARCHAR(50),
    application_type VARCHAR(50),
    emp_length VARCHAR(50),
    emp_title VARCHAR(100),
    grade VARCHAR(50),
    home_ownership VARCHAR(50),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(50),
    next_payment_date DATE,
    member_id INT,
    purpose VARCHAR(50),
    sub_grade VARCHAR(50),
    term VARCHAR(50),
    verification_status VARCHAR(50),
    annual_income FLOAT,
    dti FLOAT,
    installment FLOAT,
    int_rate FLOAT,
    loan_amount INT,
    total_acc INT,
    total_payment INT
);

SELECT * FROM loan_data;

-- Q1) Total Loan Applications
SELECT COUNT(*) AS Total_Loan_Applications
FROM loan_data;

-- Q2) MTD Total Loan Applications
SELECT COUNT(*) AS MTM_Total_Loan_Applications
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- Q3) Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Loan
FROM loan_data;

-- Q4) 

-- a)MTD Funded Amount 
SELECT SUM(loan_amount) AS MTD_Funded_Loan
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

--b)PMTD Total Funded Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- Q5) Total Amount Received
SELECT SUM(total_payment) AS Total_Payment_Received
FROM loan_data;

-- Q6) MTD Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Payment_Received
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- Q7) Average Interest Rate
SELECT AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM loan_data;

-- Q8) MTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS MTD_Avg_Interest_Rate
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- Q9) PMTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS PMTD_Avg_Interest_Rate
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- Q10) Average DTI Ratio
SELECT AVG(dti) * 100 AS Avg_DTI
FROM loan_data;

-- Q11) MTD Average DTI
SELECT AVG(dti) * 100 AS MTD_Avg_DTI
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- Q12) PMTD Average DTI
SELECT AVG(dti) * 100 AS PMTD_Avg_DTI
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- Q13) Good Loan Percentage
SELECT 
    COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) * 100.0 / COUNT(id) AS Good_Loan_Percentage
FROM loan_data;

-- Q14) Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications
FROM loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Q15) Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Q16) Good Loan Total Amount Received
SELECT SUM(total_payment) AS Good_Loan_Amount_Received
FROM loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Q17) Bad Loan Percentage
SELECT 
    COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0 / COUNT(id) AS Bad_Loan_Percentage
FROM loan_data;

-- Q18) Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications
FROM loan_data
WHERE loan_status = 'Charged Off';

-- Q19) Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM loan_data
WHERE loan_status = 'Charged Off';

-- Q20) Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received
FROM loan_data
WHERE loan_status = 'Charged Off';

-- Q21) Summary by Loan Status
SELECT
    loan_status,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate) * 100 AS Avg_Interest_Rate,
    AVG(dti) * 100 AS Avg_DTI
FROM loan_data
GROUP BY loan_status;

-- Q22) MTD Summary by Loan Status 
SELECT 
    loan_status,
    SUM(total_payment) AS MTD_Total_Amount_Received, 
    SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
GROUP BY loan_status;

-- Dashboard 2 Analysis --

-- Q23) MONTH
SELECT 
    EXTRACT(MONTH FROM issue_date) AS Month,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY Month
ORDER BY Month;

-- Q24) STATE
SELECT 
    address_state,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY address_state
ORDER BY address_state;

-- Q25) LOAN TERM
SELECT 
    term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY term
ORDER BY term;

-- Q26) EMPLOYEE LENGTH 
SELECT 
    emp_length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY emp_length
ORDER BY emp_length;

-- Q27) PURPOSE 
SELECT 
    purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC;

-- Q28) HOME OWNERSHIP 
SELECT 
    home_ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;
