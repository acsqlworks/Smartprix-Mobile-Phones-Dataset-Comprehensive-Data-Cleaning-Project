USE Smartprix

-- =====================================================
-- COMPREHENSIVE DATA CLEANING QUERY FOR dbo.mobiles
-- =====================================================

-- Step 1: Create a cleaned version of the mobiles table
IF OBJECT_ID('dbo.mobiles_cleaned', 'U') IS NOT NULL 
    DROP TABLE dbo.mobiles_cleaned;

WITH CleanedData AS (
SELECT 
    -- ============================================
    -- GENERAL INFORMATION - Cleaned
    -- ============================================
    LTRIM(RTRIM(Brand)) AS Brand,
    LTRIM(RTRIM(General_Model)) AS Model,
    LTRIM(RTRIM(Name)) AS Product_Name,
    LTRIM(RTRIM(Technical_OS)) AS Operating_System,
    LTRIM(RTRIM(Technical_Custom_UI)) AS Custom_UI,
    
    -- Parse Release Date
    TRY_CONVERT(DATE, General_Release_Date) AS Release_Date,
    YEAR(TRY_CONVERT(DATE, General_Release_Date)) AS Release_Year,
    MONTH(TRY_CONVERT(DATE, General_Release_Date)) AS Release_Month,
    
    LTRIM(RTRIM(General_Device_Type)) AS Device_Type,
    LTRIM(RTRIM(General_Country_of_Origin)) AS Country_Of_Origin,
    
    -- Sim Information
    CASE WHEN General_Dual_Sim = 1 THEN 'Yes' ELSE 'No' END AS Is_Dual_Sim,
    LTRIM(RTRIM(General_Sim_Type)) AS Sim_Type,
    LTRIM(RTRIM(General_Sim_Size)) AS Sim_Size,
    LTRIM(RTRIM(General_Triple_Sim)) AS Triple_Sim,
    
    -- Updates
    LTRIM(RTRIM(General_OS_Updates)) AS OS_Updates,
    LTRIM(RTRIM(General_Security_Updates)) AS Security_Updates,
    
    -- ============================================
    -- DESIGN - Cleaned
    -- ============================================
    LTRIM(RTRIM(Design_Design_Type)) AS Design_Type,
    LTRIM(RTRIM(Design_Colors)) AS Available_Colors,
    LTRIM(RTRIM(Design_Dimensions)) AS Dimensions,
    
    -- Extract numeric weight (remove 'g' or 'grams')
    TRY_CONVERT(DECIMAL(10,2), 
        REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(Design_Weight)), 'g', ''), 'grams', ''), ' ', ''), ',', '.')
    ) AS Weight_Grams,
    
    CASE WHEN Design_Bezel_less = 1 THEN 'Yes' ELSE 'No' END AS Is_Bezel_Less,
    CASE WHEN Design_Qwerty = 1 THEN 'Yes' ELSE 'No' END AS Has_Qwerty_Keyboard,
    
    -- ============================================
    -- DISPLAY - Cleaned
    -- ============================================
    LTRIM(RTRIM(Display_Type)) AS Display_Type,
    
    -- Extract numeric display size (remove inches, ")
    TRY_CONVERT(DECIMAL(10,2), 
        REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(Display_Size)), 'inches', ''), '"', ''), ' ', ''), ',', '.')
    ) AS Display_Size_Inches,
    
    LTRIM(RTRIM(Display_Touch)) AS Touch_Type,
    LTRIM(RTRIM(Display_Aspect_Ratio)) AS Aspect_Ratio,
    
    -- Extract PPI (pixels per inch)
    TRY_CONVERT(INT, 
        REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(Display_PPI)), 'ppi', ''), ' ', ''), ',', '')
    ) AS PPI,
    
    -- Extract Screen to Body Ratio
    TRY_CONVERT(DECIMAL(5,2), 
        REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(Display_Screen_to_Body_Ratio)), '%', ''), ' ', ''), ',', '.')
    ) AS Screen_To_Body_Ratio_Percent,
    
    LTRIM(RTRIM(Display_Brightness)) AS Brightness,
    LTRIM(RTRIM(Display_Glass_Type)) AS Glass_Type,
    LTRIM(RTRIM(Display_Notch)) AS Notch_Type,
    LTRIM(RTRIM(Display_Features)) AS Display_Features,
    
    CASE WHEN Display_Curved_Display = 1 THEN 'Yes' ELSE 'No' END AS Is_Curved_Display,
    CASE WHEN Display_Foldable_Display = 1 THEN 'Yes' ELSE 'No' END AS Is_Foldable_Display,
    LTRIM(RTRIM(Display_Dual_Display)) AS Dual_Display,
    
    -- ============================================
    -- MEMORY - Cleaned
    -- ============================================
    LTRIM(RTRIM(Memory_RAM)) AS RAM,
    
    -- Extract numeric RAM in GB
    TRY_CONVERT(DECIMAL(10,2),
        CASE 
            WHEN Memory_RAM LIKE '%GB%' THEN REPLACE(REPLACE(REPLACE(Memory_RAM, 'GB', ''), ' ', ''), ',', '.')
            WHEN Memory_RAM LIKE '%MB%' THEN CAST(TRY_CONVERT(DECIMAL(10,2), REPLACE(REPLACE(REPLACE(Memory_RAM, 'MB', ''), ' ', ''), ',', '.')) / 1024.0 AS VARCHAR(20))
            ELSE NULL
        END
    ) AS RAM_GB,
    
    LTRIM(RTRIM(Memory_RAM_Type)) AS RAM_Type,
    LTRIM(RTRIM(Memory_Storage)) AS Storage,
    
    -- Extract numeric Storage in GB
    TRY_CONVERT(DECIMAL(10,2),
        CASE 
            WHEN Memory_Storage LIKE '%GB%' THEN REPLACE(REPLACE(REPLACE(Memory_Storage, 'GB', ''), ' ', ''), ',', '.')
            WHEN Memory_Storage LIKE '%MB%' THEN CAST(TRY_CONVERT(DECIMAL(10,2), REPLACE(REPLACE(REPLACE(Memory_Storage, 'MB', ''), ' ', ''), ',', '.')) / 1024.0 AS VARCHAR(20))
            WHEN Memory_Storage LIKE '%TB%' THEN CAST(TRY_CONVERT(DECIMAL(10,2), REPLACE(REPLACE(REPLACE(Memory_Storage, 'TB', ''), ' ', ''), ',', '.')) * 1024.0 AS VARCHAR(20))
            ELSE NULL
        END
    ) AS Storage_GB,
    
    LTRIM(RTRIM(Memory_Storage_Type)) AS Storage_Type,
    LTRIM(RTRIM(Memory_Card_Slot)) AS Card_Slot,
    LTRIM(RTRIM(Memory_Expandable_RAM)) AS Expandable_RAM,
    LTRIM(RTRIM(Memory_Phonebook)) AS Phonebook_Capacity,
    
    -- ============================================
    -- CAMERA - Cleaned
    -- ============================================
    LTRIM(RTRIM(Camera_Rear_Camera)) AS Rear_Camera,
    LTRIM(RTRIM(Camera_Front_Camera)) AS Front_Camera,
    LTRIM(RTRIM(Camera_Video_Recording)) AS Rear_Video_Recording,
    LTRIM(RTRIM(Camera_Front_Video_Recording)) AS Front_Video_Recording,
    LTRIM(RTRIM(Camera_Camera_Sensor)) AS Camera_Sensor,
    LTRIM(RTRIM(Camera_Auto_Focus)) AS Auto_Focus,
    LTRIM(RTRIM(Camera_Flash)) AS Flash_Type,
    LTRIM(RTRIM(Camera_Features)) AS Camera_Features,
    
    CASE WHEN Camera_OIS = 1 THEN 'Yes' ELSE 'No' END AS Has_OIS,
    
    -- ============================================
    -- BATTERY - Cleaned
    -- ============================================
    LTRIM(RTRIM(Battery_Size)) AS Battery_Size,
    
    -- Extract numeric battery capacity in mAh
    TRY_CONVERT(INT, 
        REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(Battery_Size)), 'mAh', ''), 'mah', ''), ' ', ''), ',', '')
    ) AS Battery_Capacity_mAh,
    
    LTRIM(RTRIM(Battery_Type)) AS Battery_Type,
    LTRIM(RTRIM(Battery_Fast_Charging)) AS Fast_Charging,
    
    CASE WHEN Battery_Wireless_Charging = 'Yes' THEN 'Yes' ELSE 'No' END AS Wireless_Charging,
    CASE WHEN Battery_Reverse_Charging = 'Yes' THEN 'Yes' ELSE 'No' END AS Reverse_Charging,
    CASE WHEN Battery_Reverse_Wireless_Charging = 'Yes' THEN 'Yes' ELSE 'No' END AS Reverse_Wireless_Charging,
    
    LTRIM(RTRIM(Battery_Talk_Time)) AS Talk_Time,
    LTRIM(RTRIM(Battery_StandBy_Time)) AS Standby_Time,
    LTRIM(RTRIM(Battery_Music_Playback_Time)) AS Music_Playback_Time,
    LTRIM(RTRIM(Battery_Video_Playback_Time)) AS Video_Playback_Time,
    
    -- ============================================
    -- CONNECTIVITY - Cleaned
    -- ============================================
    CASE WHEN Connectivity_5G = 1 THEN 'Yes' ELSE 'No' END AS Has_5G,
    LTRIM(RTRIM(Connectivity_5G_Bands)) AS Bands_5G,
    CASE WHEN Connectivity_4G = 1 THEN 'Yes' ELSE 'No' END AS Has_4G,
    LTRIM(RTRIM(Connectivity_3G)) AS Has_3G,
    CASE WHEN Connectivity_GPRS = 1 THEN 'Yes' ELSE 'No' END AS Has_GPRS,
    CASE WHEN Connectivity_EDGE = 1 THEN 'Yes' ELSE 'No' END AS Has_EDGE,
    
    LTRIM(RTRIM(Connectivity_VoLTE)) AS VoLTE,
    LTRIM(RTRIM(Connectivity_Vo5G)) AS Vo5G,
    
    LTRIM(RTRIM(Connectivity_Wifi)) AS WiFi,
    LTRIM(RTRIM(Connectivity_Wifi_Version)) AS WiFi_Version,
    LTRIM(RTRIM(Connectivity_Bluetooth)) AS Bluetooth,
    LTRIM(RTRIM(Connectivity_USB)) AS USB_Type,
    LTRIM(RTRIM(Connectivity_USB_Features)) AS USB_Features,
    
    CASE WHEN Connectivity_IR_Blaster = 1 THEN 'Yes' ELSE 'No' END AS Has_IR_Blaster,
    
    -- ============================================
    -- TECHNICAL/PERFORMANCE - Cleaned
    -- ============================================
    LTRIM(RTRIM(Technical_Chipset)) AS Chipset,
    LTRIM(RTRIM(Technical_CPU)) AS CPU,
    LTRIM(RTRIM(Technical_Core_Details)) AS Core_Details,
    LTRIM(RTRIM(Technical_GPU)) AS GPU,
    LTRIM(RTRIM(Technical_NPU)) AS NPU,
    LTRIM(RTRIM(Technical_Fabrication_Node)) AS Fabrication_Node,
    LTRIM(RTRIM(Technical_Browser)) AS Browser,
    LTRIM(RTRIM(Technical_Java)) AS Java_Support,
    
    -- Performance Scores
    TRY_CONVERT(INT, REPLACE(REPLACE(Performance_AnTuTu_Score, ',', ''), ' ', '')) AS AnTuTu_Score,
    TRY_CONVERT(INT, REPLACE(REPLACE(Performance_AnTuTu_Storage_Score, ',', ''), ' ', '')) AS AnTuTu_Storage_Score,
    TRY_CONVERT(INT, REPLACE(REPLACE(Performance_Geekbench_Score, ',', ''), ' ', '')) AS Geekbench_Score,
    TRY_CONVERT(INT, REPLACE(REPLACE(Performance_3DMark_Score, ',', ''), ' ', '')) AS ThreeDMark_Score,
    TRY_CONVERT(INT, REPLACE(REPLACE(Performance_Camera_Score, ',', ''), ' ', '')) AS Camera_Score,
    TRY_CONVERT(INT, REPLACE(REPLACE(Performance_Speaker_Score, ',', ''), ' ', '')) AS Speaker_Score,
    LTRIM(RTRIM(Performance_Battery_Test_Result)) AS Battery_Test_Result,
    
    -- ============================================
    -- MULTIMEDIA - Cleaned
    -- ============================================
    CASE WHEN Multimedia_FM_Radio = 1 THEN 'Yes' ELSE 'No' END AS Has_FM_Radio,
    CASE WHEN Multimedia_Email = 1 THEN 'Yes' ELSE 'No' END AS Has_Email,
    
    LTRIM(RTRIM(Multimedia_Audio_Jack_Type)) AS Audio_Jack_Type,
    LTRIM(RTRIM(Multimedia_Audio_Features)) AS Audio_Features,
    LTRIM(RTRIM(Multimedia_Speaker_Type)) AS Speaker_Type,
    LTRIM(RTRIM(Multimedia_Music)) AS Music_Support,
    LTRIM(RTRIM(Multimedia_Video)) AS Video_Support,
    LTRIM(RTRIM(Multimedia_Document_Reader)) AS Document_Reader,
    LTRIM(RTRIM(Multimedia_Supports)) AS Multimedia_Supports,
    
    -- ============================================
    -- EXTRA FEATURES - Cleaned
    -- ============================================
    CASE WHEN Extra_3_5mm_Headphone_Jack = 1 THEN 'Yes' ELSE 'No' END AS Has_Headphone_Jack,
    CASE WHEN Extra_Face_Unlock = 1 THEN 'Yes' ELSE 'No' END AS Has_Face_Unlock,
    
    LTRIM(RTRIM(Extra_Fingerprint_Sensor)) AS Fingerprint_Sensor,
    LTRIM(RTRIM(Extra_GPS)) AS GPS,
    LTRIM(RTRIM(Extra_NFC)) AS NFC,
    LTRIM(RTRIM(Extra_Sensors)) AS Sensors,
    
    CASE WHEN Extra_Dust_Resistant = 1 THEN 'Yes' ELSE 'No' END AS Is_Dust_Resistant,
    CASE WHEN Extra_Splash_Resistant = 1 THEN 'Yes' ELSE 'No' END AS Is_Splash_Resistant,
    
    LTRIM(RTRIM(Extra_Water_Resistance)) AS Water_Resistance,
    LTRIM(RTRIM(Extra_IP_Rating)) AS IP_Rating,
    LTRIM(RTRIM(Extra_AI_Features)) AS AI_Features,
    LTRIM(RTRIM(Extra_Extra_Features)) AS Extra_Features,
    LTRIM(RTRIM(Extra_Extra)) AS Additional_Info,
    
    -- ============================================
    -- PRICING - Cleaned
    -- ============================================
    Price AS Current_Price,
    Price_Drop AS Price_Drop_Percentage,
    Price_Drop_Amount AS Price_Drop_Amount,
    
    -- Calculate original price if price drop exists
    CASE 
        WHEN Price IS NOT NULL AND Price_Drop_Amount IS NOT NULL 
        THEN Price + Price_Drop_Amount
        ELSE NULL
    END AS Original_Price,
    
    -- ============================================
    -- METADATA
    -- ============================================
    Last_modified AS Last_Modified_Date,
    LTRIM(RTRIM(General_In_The_Box)) AS In_The_Box,
    LTRIM(RTRIM(General_SAR)) AS SAR_Value,
    LTRIM(RTRIM(Related_Items)) AS Related_Items

FROM [Smartprix].[dbo].[mobiles]
WHERE Name IS NOT NULL  -- Remove completely empty rows
)

-- Create the cleaned table
SELECT *
INTO dbo.mobiles_cleaned
FROM CleanedData;

-- =====================================================
-- ADD INDEXES FOR BETTER QUERY PERFORMANCE
-- =====================================================
CREATE INDEX IX_Brand ON dbo.mobiles_cleaned(Brand);
CREATE INDEX IX_Price ON dbo.mobiles_cleaned(Current_Price);
CREATE INDEX IX_ReleaseDate ON dbo.mobiles_cleaned(Release_Date);
CREATE INDEX IX_5G ON dbo.mobiles_cleaned(Has_5G);
CREATE INDEX IX_RAM_Storage ON dbo.mobiles_cleaned(RAM_GB, Storage_GB);

-- =====================================================
-- DATA QUALITY REPORT
-- =====================================================
PRINT '============================================';
PRINT 'DATA CLEANING SUMMARY REPORT';
PRINT '============================================';

SELECT 
    'Total Records' AS Metric,
    COUNT(*) AS [Count]
FROM dbo.mobiles_cleaned

UNION ALL

SELECT 
    'Records with Price' AS Metric,
    COUNT(*) AS [Count]
FROM dbo.mobiles_cleaned
WHERE Current_Price IS NOT NULL

UNION ALL

SELECT 
    'Records with 5G' AS Metric,
    COUNT(*) AS [Count]
FROM dbo.mobiles_cleaned
WHERE Has_5G = 'Yes'

UNION ALL

SELECT 
    'Records with Release Date' AS Metric,
    COUNT(*) AS [Count]
FROM dbo.mobiles_cleaned
WHERE Release_Date IS NOT NULL

UNION ALL

SELECT 
    'Unique Brands' AS Metric,
    COUNT(DISTINCT Brand) AS [Count]
FROM dbo.mobiles_cleaned

UNION ALL

SELECT 
    'Records with Battery Info' AS Metric,
    COUNT(*) AS [Count]
FROM dbo.mobiles_cleaned
WHERE Battery_Capacity_mAh IS NOT NULL;

-- =====================================================
-- ADDITIONAL ANALYSIS VIEWS
-- =====================================================

-- View 1: Price Analysis by Brand
IF OBJECT_ID('dbo.vw_PriceByBrand', 'V') IS NOT NULL 
    DROP VIEW dbo.vw_PriceByBrand;
GO

CREATE VIEW dbo.vw_PriceByBrand AS
SELECT 
    Brand,
    COUNT(*) AS Model_Count,
    AVG(Current_Price) AS Avg_Price,
    MIN(Current_Price) AS Min_Price,
    MAX(Current_Price) AS Max_Price,
    AVG(RAM_GB) AS Avg_RAM_GB,
    AVG(Storage_GB) AS Avg_Storage_GB,
    AVG(Battery_Capacity_mAh) AS Avg_Battery_mAh
FROM dbo.mobiles_cleaned
WHERE Current_Price IS NOT NULL
GROUP BY Brand;
GO

-- View 2: 5G Phones Summary
IF OBJECT_ID('dbo.vw_5G_Phones', 'V') IS NOT NULL 
    DROP VIEW dbo.vw_5G_Phones;
GO

CREATE VIEW dbo.vw_5G_Phones AS
SELECT 
    Brand,
    Model,
    Product_Name,
    Current_Price,
    RAM_GB,
    Storage_GB,
    Battery_Capacity_mAh,
    Display_Size_Inches,
    Chipset,
    Release_Date
FROM dbo.mobiles_cleaned
WHERE Has_5G = 'Yes';
GO

-- View 3: Latest Releases
IF OBJECT_ID('dbo.vw_LatestReleases', 'V') IS NOT NULL 
    DROP VIEW dbo.vw_LatestReleases;
GO

CREATE VIEW dbo.vw_LatestReleases AS
SELECT TOP 100
    Brand,
    Model,
    Product_Name,
    Current_Price,
    Release_Date,
    RAM_GB,
    Storage_GB,
    Battery_Capacity_mAh,
    Has_5G,
    Chipset
FROM dbo.mobiles_cleaned
WHERE Release_Date IS NOT NULL
ORDER BY Release_Date DESC;
GO

PRINT '============================================';
PRINT 'DATA CLEANING COMPLETED SUCCESSFULLY!';
PRINT 'New table created: dbo.mobiles_cleaned';
PRINT 'Views created: vw_PriceByBrand, vw_5G_Phones, vw_LatestReleases';
PRINT '============================================';

-- Change the data type to VARCHAR
ALTER TABLE [Smartprix].[dbo].[mobiles_cleaned]
ALTER COLUMN Release_Month VARCHAR(20);

-- Now run your UPDATE statement
UPDATE [Smartprix].[dbo].[mobiles_cleaned]
SET Release_Month = CASE Release_Month
    WHEN '1' THEN 'January'
    WHEN '2' THEN 'February'
    WHEN '3' THEN 'March'
    WHEN '4' THEN 'April'
    WHEN '5' THEN 'May'
    WHEN '6' THEN 'June'
    WHEN '7' THEN 'July'
    WHEN '8' THEN 'August'
    WHEN '9' THEN 'September'
    WHEN '10' THEN 'October'
    WHEN '11' THEN 'November'
    WHEN '12' THEN 'December'
    ELSE NULL
END
WHERE Release_Month IS NOT NULL;

