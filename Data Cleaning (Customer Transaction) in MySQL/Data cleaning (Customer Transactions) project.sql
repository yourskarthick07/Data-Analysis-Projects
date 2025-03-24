-- Step 1: Remove duplicate records
DELETE FROM Customer_Transactions 
WHERE Transaction_ID NOT IN (
    SELECT Transaction_ID FROM (
        SELECT MIN(Transaction_ID) AS Transaction_ID 
        FROM Customer_Transactions 
        GROUP BY Customer_Name, Email, Phone_Number, Transaction_Date, Amount, Status, Country
    ) AS subquery
);

-- Step 2: Handle missing values
UPDATE Customer_Transactions
SET Customer_Name = 'Unknown'
WHERE Customer_Name IS NULL OR Customer_Name = '';

UPDATE Customer_Transactions
SET Amount = 0
WHERE Amount IS NULL;

UPDATE Customer_Transactions
SET Country = 'Unknown'
WHERE Country IS NULL OR Country = '';

-- Step 3:Capitalize names properly
UPDATE Customer_Transactions
SET Customer_Name = 
    (SELECT GROUP_CONCAT(CONCAT(UPPER(LEFT(word, 1)), LOWER(SUBSTRING(word, 2))) SEPARATOR ' ')
     FROM (SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Customer_Name, ' ', n.digit+1), ' ', -1) AS word
	 FROM (SELECT 0 digit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS n
	 WHERE n.digit < LENGTH(Customer_Name) - LENGTH(REPLACE(Customer_Name, ' ', ''))) AS words);
           
-- Step 4: Fix email format issues
UPDATE Customer_Transactions
SET Email = REPLACE(Email, '#', '@')
WHERE Email LIKE '%#%';

-- Step 5: Standardize phone numbers 
UPDATE Customer_Transactions
SET Phone_Number = REGEXP_REPLACE(Phone_Number, '[^0-9]', '');

-- Step 6: Convert inconsistent date formats to 'YYYY-MM-DD'
UPDATE Customer_Transactions 
SET Transaction_Date = STR_TO_DATE(Transaction_Date, '%d-%m-%Y')
WHERE Transaction_Date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';


-- Step 7: Handle negative and invalid amounts
UPDATE Customer_Transactions
SET Amount = ABS(Amount)
WHERE Amount < 0;

-- Step 8: Add constraints to prevent future data issues
ALTER TABLE Customer_Transactions 
MODIFY COLUMN Amount DECIMAL(10,2),
ADD CONSTRAINT amount_check CHECK (Amount >= 0);

ALTER TABLE Customer_Transactions
ADD CONSTRAINT chk_email_format CHECK (Email LIKE '%@%.%');

-- Step 9: Remove records with missing critical data
DELETE FROM Customer_Transactions
WHERE Email IS NULL OR Phone_Number IS NULL OR Phone_Number = '';

-- Step 10: Ensure status column contains valid values
UPDATE Customer_Transactions
SET Status = 'Pending'
WHERE Status NOT IN ('Complete', 'Pending', 'Canceled', 'Refunded');

select * from Customer_transactions

