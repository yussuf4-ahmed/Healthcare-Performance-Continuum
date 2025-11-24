-- cleaning.sql:
	-- 1. PATEINT TABLE --

-- 1. Check row counts
SELECT 'patients' AS table_name, COUNT(*) AS rows FROM patients;
SELECT 'hospital_ops' AS table_name, COUNT(*) AS rows FROM hospital_operations;

-- 2. Find missing critical values in patients
SELECT * FROM patients WHERE Admission_Department IS NULL OR Age IS NULL OR Diagnosis_Code IS NULL;

-- 3. Standardize date formats (SQL Server example)
ALTER TABLE patients ADD Admission_Date_dt DATE, Discharge_Date_dt DATE;
UPDATE patients SET Admission_Date_dt = TRY_CONVERT(date, Admission_Date, 23), Discharge_Date_dt = TRY_CONVERT(date, Discharge_Date, 23);

-- 4. Recalculate Length_of_Stay to ensure consistency
ALTER TABLE patients ADD Calculated_LOS INT;
UPDATE patients SET Calculated_LOS = DATEDIFF(day, Admission_Date_dt, Discharge_Date_dt);

-- 5. Create a cleaned patients table
SELECT Patient_ID,
       COALESCE(Age,  (SELECT AVG(CAST(Age AS float)) FROM patients WHERE Age IS NOT NULL)) AS Age,
       Gender,
       Insurance_Type,
       Chronic_Condition,
       Diagnosis_Code,
       ISNULL(Admission_Department, 'Unknown') AS Admission_Department,
       Admission_Date_dt AS Admission_Date,
       Discharge_Date_dt AS Discharge_Date,
       Calculated_LOS AS Length_of_Stay,
       First_Time_Visit
INTO patients_clean
FROM patients;

SELECT * FROM patients_clean;

-- 6. Create risk buckets (example)
SELECT *, 
CASE WHEN Age >= 65 OR Chronic_Condition <> 'None' THEN 'High' 
     WHEN Age BETWEEN 45 AND 64 THEN 'Medium' ELSE 'Low' END AS Risk_Bucket
INTO patients_final
FROM patients_with_readmit;

===============================================================================================================
--  READMISSIONS TABLE CLEANING

-- 0. Inspect raw table
SELECT TOP 20 * FROM readmissions;

-- 1. Remove leading/trailing spaces from Patient_ID
UPDATE readmissions
SET Patient_ID = LTRIM(RTRIM(Patient_ID));

-- Confirm cleanup
SELECT DISTINCT Patient_ID FROM readmissions WHERE Patient_ID LIKE ' %' OR Patient_ID LIKE '% ';

-- 2. Standardize date formats
ALTER TABLE readmissions ADD Readmission_Date_dt DATE;

UPDATE readmissions
SET Readmission_Date_dt = TRY_CONVERT(DATE, Readmission_Date, 23);

-- Check failed conversions
SELECT * FROM readmissions WHERE Readmission_Date_dt IS NULL AND Readmission_Date IS NOT NULL;

-- 3. Fix null or invalid values

-- If Reason_For_Readmission is NULL → label as 'Unknown'
UPDATE readmissions
SET Reason_For_Readmission = 'Unknown'
WHERE Reason_For_Readmission IS NULL OR LTRIM(RTRIM(Reason_For_Readmission)) = '';


-- If Days_Before_Readmission is negative or extremely large → set to NULL to clean later
UPDATE readmissions
SET Days_Before_Readmission = NULL
WHERE Days_Before_Readmission < 0 
   OR Days_Before_Readmission > 365;  -- more than a year = suspicious

-- 4. Remove impossible readmission records

-- Create temp join to check inconsistencies
SELECT r.*
FROM readmissions r
LEFT JOIN patients_clean p ON r.Patient_ID = p.Patient_ID
WHERE r.Readmission_Date_dt < p.Discharge_Date;   -- impossible case

-- 5. Remove duplicate readmission rows

;WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Patient_ID, Readmission_Date_dt ORDER BY Patient_ID) AS rn
    FROM readmissions
)
DELETE FROM cte WHERE rn > 1;

-- 6. Create the final cleaned table

SELECT 
    LTRIM(RTRIM(Patient_ID)) AS Patient_ID,
    Readmitted,
    Readmission_Date_dt AS Readmission_Date,
    Days_Before_Readmission,
    Reason_For_Readmission,
    
    -- Recalculate clean risk score proxy
    CASE 
        WHEN Previous_Risk_Score IS NULL THEN NULL
        WHEN Previous_Risk_Score < 1 THEN 1
        WHEN Previous_Risk_Score > 10 THEN 10
        ELSE Previous_Risk_Score
    END AS Previous_Risk_Score

INTO readmissions_clean
FROM readmissions;

-- 7. Validate final cleaned table

-- Row count
SELECT COUNT(*) AS Cleaned_Rows FROM readmissions_clean;

-- Check for remaining nulls
SELECT * FROM readmissions_clean
WHERE Patient_ID IS NULL 
   OR Readmission_Date IS NULL;

-- Compare match rate with patients_clean
SELECT 
    COUNT(*) AS Total_Readmissions,
    (SELECT COUNT(*) FROM readmissions_clean r
     JOIN patients_clean p ON r.Patient_ID = p.Patient_ID) AS Matching_Patients
FROM readmissions_clean;