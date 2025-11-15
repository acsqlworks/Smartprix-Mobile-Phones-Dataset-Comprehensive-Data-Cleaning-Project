# 📖 Data Dictionary - Cleaned Mobiles Dataset

Complete reference guide for all columns in the cleaned Smartprix mobile phones dataset.

---

## Table of Contents
- [General Information](#general-information)
- [SIM Information](#sim-information)
- [Design Specifications](#design-specifications)
- [Display Specifications](#display-specifications)
- [Memory Specifications](#memory-specifications)
- [Camera Specifications](#camera-specifications)
- [Battery & Charging](#battery--charging)
- [Connectivity](#connectivity)
- [Performance & Technical](#performance--technical)
- [Multimedia](#multimedia)
- [Extra Features](#extra-features)
- [Pricing Information](#pricing-information)
- [Metadata](#metadata)

---

## General Information

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Brand | VARCHAR(255) | Manufacturer/brand name | Samsung, Apple, Xiaomi, OnePlus | LTRIM/RTRIM applied |
| Model | VARCHAR(255) | Official model designation | Galaxy S23, iPhone 15 Pro, 13 Pro | LTRIM/RTRIM applied |
| Product_Name | VARCHAR(500) | Complete marketing name | Samsung Galaxy S23 Ultra 5G | LTRIM/RTRIM applied |
| Operating_System | VARCHAR(255) | OS name and version | Android 14, iOS 17, ColorOS 14 | LTRIM/RTRIM applied |
| Custom_UI | VARCHAR(255) | Manufacturer UI overlay | One UI 6, MIUI 14, OxygenOS 14 | LTRIM/RTRIM applied |
| Release_Date | DATE | Official market release date | 2024-01-15, 2023-12-20 | TRY_CONVERT to DATE |
| Release_Year | INT | Year of device release | 2024, 2023, 2022 | YEAR() extracted |
| Release_Month | VARCHAR(20) | Month name of release | January, February, December | Converted from month number |
| Device_Type | VARCHAR(100) | Category of device | Smartphone, Tablet, Feature Phone | LTRIM/RTRIM applied |
| Country_Of_Origin | VARCHAR(100) | Manufacturing country | China, India, South Korea, Vietnam | LTRIM/RTRIM applied |
| OS_Updates | VARCHAR(255) | Guaranteed OS updates | 4 years, 3 major updates | Original text preserved |
| Security_Updates | VARCHAR(255) | Security patch duration | 5 years, Monthly for 3 years | Original text preserved |

**Notes:**
- NULL values indicate information not available for that device
- Release_Date parsed from various text formats to standardized DATE type
- Release_Month converted from numeric (1-12) to month names for readability

---

## SIM Information

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Is_Dual_Sim | VARCHAR(3) | Dual SIM card support | Yes, No | BIT converted to Yes/No |
| Sim_Type | VARCHAR(100) | Physical SIM technology | Nano-SIM, eSIM, Hybrid | LTRIM/RTRIM applied |
| Sim_Size | VARCHAR(50) | SIM card physical size | Nano, Micro, Standard | LTRIM/RTRIM applied |
| Triple_Sim | VARCHAR(100) | Three SIM support details | Yes, Dual + eSIM, NULL | Original text preserved |

**Notes:**
- Is_Dual_Sim standardized to Yes/No for consistency
- Triple_Sim may describe hybrid configurations (e.g., "Dual + eSIM")

---

## Design Specifications

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Design_Type | VARCHAR(100) | Physical form factor | Bar, Foldable, Flip | LTRIM/RTRIM applied |
| Available_Colors | VARCHAR(500) | Color variants available | Black, Blue, Silver, Phantom Black | LTRIM/RTRIM applied |
| Dimensions | VARCHAR(100) | Physical dimensions | 163.3 x 78.1 x 8.9 mm | Original format preserved |
| Weight_Grams | DECIMAL(10,2) | Device weight | 185.00, 238.50, 195.75 | Extracted from "185g", "238.5 grams" |
| Is_Bezel_Less | VARCHAR(3) | Minimal bezel design | Yes, No | BIT converted to Yes/No |
| Has_Qwerty_Keyboard | VARCHAR(3) | Physical keyboard present | Yes, No | BIT converted to Yes/No |

**Notes:**
- Weight_Grams: Removed "g", "grams", spaces, and converted to decimal
- Dimensions kept in original format (H x W x D in mm) for reference
- Available_Colors may be comma-separated list

---

## Display Specifications

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Display_Type | VARCHAR(255) | Screen technology | AMOLED, Dynamic AMOLED 2X, IPS LCD | LTRIM/RTRIM applied |
| Display_Size_Inches | DECIMAL(10,2) | Screen diagonal size | 6.70, 6.10, 6.78 | Extracted from "6.7 inches", "6.7\"" |
| Touch_Type | VARCHAR(100) | Touch input technology | Capacitive, Multi-touch | LTRIM/RTRIM applied |
| Aspect_Ratio | VARCHAR(50) | Screen aspect ratio | 20:9, 19.5:9, 21:9 | Original format preserved |
| PPI | INT | Pixels per inch density | 516, 460, 395 | Extracted from "516 ppi" |
| Screen_To_Body_Ratio_Percent | DECIMAL(5,2) | Screen coverage % | 89.50, 91.20, 87.30 | Extracted from "89.5%" |
| Brightness | VARCHAR(100) | Maximum brightness | 1200 nits, 1000 nits peak | Original text preserved |
| Glass_Type | VARCHAR(255) | Screen protection | Gorilla Glass Victus 2, Ceramic Shield | LTRIM/RTRIM applied |
| Notch_Type | VARCHAR(100) | Cutout style | Punch Hole, Waterdrop, Dynamic Island | LTRIM/RTRIM applied |
| Display_Features | VARCHAR(1000) | Additional capabilities | HDR10+, Always-on display, 120Hz | LTRIM/RTRIM applied |
| Is_Curved_Display | VARCHAR(3) | Curved screen edges | Yes, No | BIT converted to Yes/No |
| Is_Foldable_Display | VARCHAR(3) | Foldable screen | Yes, No | BIT converted to Yes/No |
| Dual_Display | VARCHAR(100) | Secondary display info | Yes, Cover Display | Original text preserved |

**Notes:**
- Display_Size_Inches: Removed "inches", quotes, spaces; converted to decimal
- PPI: Removed "ppi" suffix and converted to integer
- Screen_To_Body_Ratio_Percent: Removed "%" and converted to decimal
- Display_Features may contain multiple comma-separated features

---

## Memory Specifications

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| RAM | VARCHAR(50) | RAM specification (original) | 8GB, 12GB, 6GB | Original text preserved |
| RAM_GB | DECIMAL(10,2) | RAM in gigabytes | 8.00, 12.00, 0.50 | Converted MB→GB, standardized |
| RAM_Type | VARCHAR(50) | RAM technology | LPDDR5, LPDDR5X, LPDDR4X | LTRIM/RTRIM applied |
| Storage | VARCHAR(50) | Storage specification (original) | 256GB, 512GB, 1TB | Original text preserved |
| Storage_GB | DECIMAL(10,2) | Storage in gigabytes | 256.00, 512.00, 1024.00 | Converted MB→GB, TB→GB |
| Storage_Type | VARCHAR(50) | Storage technology | UFS 3.1, UFS 4.0, eMMC 5.1 | LTRIM/RTRIM applied |
| Card_Slot | VARCHAR(255) | Expandable storage support | microSD up to 1TB, No, Hybrid | LTRIM/RTRIM applied |
| Expandable_RAM | VARCHAR(100) | Virtual RAM expansion | Yes, Up to 5GB, 3GB via storage | Original text preserved |
| Phonebook_Capacity | VARCHAR(100) | Contact storage limit | Unlimited, 1000 contacts | Original text preserved |

**Notes:**
- RAM_GB conversion: "512MB" → 0.50, "8GB" → 8.00
- Storage_GB conversion: "256GB" → 256.00, "1TB" → 1024.00
- Both original text (RAM, Storage) and numeric values (RAM_GB, Storage_GB) preserved

---

## Camera Specifications

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Rear_Camera | VARCHAR(500) | Rear camera configuration | 50MP + 12MP + 10MP, Triple Camera | LTRIM/RTRIM applied |
| Front_Camera | VARCHAR(255) | Front-facing camera | 12MP, 32MP, Dual 12MP + 8MP | LTRIM/RTRIM applied |
| Rear_Video_Recording | VARCHAR(255) | Rear video capabilities | 8K@30fps, 4K@60fps, 1080p@30fps | LTRIM/RTRIM applied |
| Front_Video_Recording | VARCHAR(255) | Front video capabilities | 4K@60fps, 1080p@30fps | LTRIM/RTRIM applied |
| Camera_Sensor | VARCHAR(255) | Image sensor details | Sony IMX890, Samsung ISOCELL GN2 | LTRIM/RTRIM applied |
| Auto_Focus | VARCHAR(100) | Autofocus technology | PDAF, Laser AF, Dual Pixel AF | LTRIM/RTRIM applied |
| Flash_Type | VARCHAR(100) | Flash technology | LED flash, Dual LED, Ring flash | LTRIM/RTRIM applied |
| Camera_Features | VARCHAR(1000) | Additional camera features | OIS, Night mode, Pro mode, AI | LTRIM/RTRIM applied |
| Has_OIS | VARCHAR(3) | Optical image stabilization | Yes, No | BIT converted to Yes/No |

**Notes:**
- Camera specifications may include multiple lenses (separated by +)
- Video recording formats include resolution and frame rate
- Camera_Features may contain extensive comma-separated list

---

## Battery & Charging

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Battery_Size | VARCHAR(100) | Battery specification (original) | 5000 mAh, 4500 mAh | Original text preserved |
| Battery_Capacity_mAh | INT | Battery capacity | 5000, 4500, 4000 | Extracted from "5000 mAh" |
| Battery_Type | VARCHAR(100) | Battery chemistry | Li-Polymer, Li-Ion | LTRIM/RTRIM applied |
| Fast_Charging | VARCHAR(255) | Fast charging support | 67W, 45W SuperVOOC, 25W PD | LTRIM/RTRIM applied |
| Wireless_Charging | VARCHAR(3) | Wireless charging support | Yes, No | Standardized to Yes/No |
| Reverse_Charging | VARCHAR(3) | Reverse wired charging | Yes, No | Standardized to Yes/No |
| Reverse_Wireless_Charging | VARCHAR(3) | Reverse wireless charging | Yes, No | Standardized to Yes/No |
| Talk_Time | VARCHAR(100) | Continuous talk duration | Up to 30 hours, 28 hrs | Original text preserved |
| Standby_Time | VARCHAR(100) | Standby duration | Up to 400 hours, 18 days | Original text preserved |
| Music_Playback_Time | VARCHAR(100) | Audio playback duration | 95 hours, 4 days | Original text preserved |
| Video_Playback_Time | VARCHAR(100) | Video playback duration | 20 hours, 24 hrs | Original text preserved |

**Notes:**
- Battery_Capacity_mAh: Removed "mAh", "mah", spaces; converted to integer
- Charging fields (Wireless, Reverse) standardized to Yes/No
- Time fields preserved in original format due to varied units

---

## Connectivity

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Has_5G | VARCHAR(3) | 5G network support | Yes, No | BIT converted to Yes/No |
| Bands_5G | VARCHAR(500) | Supported 5G bands | N1, N3, N5, N7, N8, N28, N78 | LTRIM/RTRIM applied |
| Has_4G | VARCHAR(3) | 4G LTE support | Yes, No | BIT converted to Yes/No |
| Has_3G | VARCHAR(100) | 3G network support | Yes, HSPA+, DC-HSPA | Original text preserved |
| Has_GPRS | VARCHAR(3) | GPRS support | Yes, No | BIT converted to Yes/No |
| Has_EDGE | VARCHAR(3) | EDGE support | Yes, No | BIT converted to Yes/No |
| VoLTE | VARCHAR(100) | Voice over LTE | Yes, No, HD Voice | Original text preserved |
| Vo5G | VARCHAR(100) | Voice over 5G | Yes, No | Original text preserved |
| WiFi | VARCHAR(100) | Wi-Fi support | Yes, Dual-band | LTRIM/RTRIM applied |
| WiFi_Version | VARCHAR(100) | Wi-Fi standard | Wi-Fi 6E (802.11ax), Wi-Fi 6 | LTRIM/RTRIM applied |
| Bluetooth | VARCHAR(100) | Bluetooth version | v5.3, v5.2, v5.0 | LTRIM/RTRIM applied |
| USB_Type | VARCHAR(100) | USB port type | USB Type-C, microUSB | LTRIM/RTRIM applied |
| USB_Features | VARCHAR(255) | USB capabilities | USB 3.2, OTG, DisplayPort | LTRIM/RTRIM applied |
| Has_IR_Blaster | VARCHAR(3) | Infrared blaster | Yes, No | BIT converted to Yes/No |

**Notes:**
- Network support fields standardized to Yes/No for consistency
- Bands_5G contains comma-separated list of supported frequency bands
- WiFi_Version may include technical standard in parentheses

---

## Performance & Technical

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Chipset | VARCHAR(255) | System-on-chip | Snapdragon 8 Gen 2, A17 Pro, Dimensity 9200 | LTRIM/RTRIM applied |
| CPU | VARCHAR(255) | CPU configuration | Octa-core, Hexa-core | LTRIM/RTRIM applied |
| Core_Details | VARCHAR(500) | CPU core breakdown | 1x3.2GHz + 3x2.8GHz + 4x2.0GHz | LTRIM/RTRIM applied |
| GPU | VARCHAR(255) | Graphics processor | Adreno 740, Apple GPU (6-core), Mali-G715 | LTRIM/RTRIM applied |
| NPU | VARCHAR(255) | Neural processing unit | Yes, AI Engine, Hexagon NPU | LTRIM/RTRIM applied |
| Fabrication_Node | VARCHAR(50) | Manufacturing process | 4nm, 3nm, 5nm | LTRIM/RTRIM applied |
| Browser | VARCHAR(100) | Web browser | HTML5, Yes | Original text preserved |
| Java_Support | VARCHAR(100) | Java compatibility | No, Via third party | Original text preserved |
| AnTuTu_Score | INT | AnTuTu benchmark | 1200000, 950000 | Removed commas, converted to INT |
| AnTuTu_Storage_Score | INT | Storage benchmark | 85000, 72000 | Removed commas, converted to INT |
| Geekbench_Score | INT | Geekbench benchmark | 5000, 4200 | Removed commas, converted to INT |
| ThreeDMark_Score | INT | 3DMark graphics score | 15000, 12000 | Removed commas, converted to INT |
| Camera_Score | INT | Camera benchmark rating | 140, 130 | Removed commas, converted to INT |
| Speaker_Score | INT | Audio quality rating | 85, 78 | Removed commas, converted to INT |
| Battery_Test_Result | VARCHAR(100) | Battery endurance test | 120 hours, 4 days | Original text preserved |

**Notes:**
- All benchmark scores cleaned of commas and converted to integers
- Core_Details shows detailed CPU architecture (big.MIDDLE.little)
- NULL benchmark scores indicate test not performed or unavailable

---

## Multimedia

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Has_FM_Radio | VARCHAR(3) | FM radio receiver | Yes, No | BIT converted to Yes/No |
| Has_Email | VARCHAR(3) | Email client support | Yes, No | BIT converted to Yes/No |
| Audio_Jack_Type | VARCHAR(100) | Audio jack specification | 3.5mm, USB-C Audio, None | LTRIM/RTRIM applied |
| Audio_Features | VARCHAR(500) | Audio enhancements | Dolby Atmos, Hi-Res Audio, Stereo speakers | LTRIM/RTRIM applied |
| Speaker_Type | VARCHAR(100) | Speaker configuration | Stereo, Dual, Mono | LTRIM/RTRIM applied |
| Music_Support | VARCHAR(255) | Supported audio formats | MP3, AAC, WAV, FLAC | LTRIM/RTRIM applied |
| Video_Support | VARCHAR(255) | Supported video codecs | MP4, H.264, H.265, VP9 | LTRIM/RTRIM applied |
| Document_Reader | VARCHAR(255) | Document viewer support | Yes, PDF, Word, Excel | LTRIM/RTRIM applied |
| Multimedia_Supports | VARCHAR(500) | Other multimedia features | Screen recording, Video editor | LTRIM/RTRIM applied |

**Notes:**
- Audio and video support fields may contain multiple comma-separated formats
- Has_FM_Radio and Has_Email standardized for consistency

---

## Extra Features

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Has_Headphone_Jack | VARCHAR(3) | 3.5mm audio jack | Yes, No | BIT converted to Yes/No |
| Has_Face_Unlock | VARCHAR(3) | Facial recognition | Yes, No | BIT converted to Yes/No |
| Fingerprint_Sensor | VARCHAR(255) | Fingerprint scanner type | Under Display, Side-mounted, Rear-mounted | LTRIM/RTRIM applied |
| GPS | VARCHAR(255) | GPS capabilities | Yes, A-GPS, GLONASS, Galileo, BeiDou | LTRIM/RTRIM applied |
| NFC | VARCHAR(100) | Near Field Communication | Yes, No, Region specific | LTRIM/RTRIM applied |
| Sensors | VARCHAR(500) | Available sensors | Accelerometer, Gyroscope, Proximity, Compass | LTRIM/RTRIM applied |
| Is_Dust_Resistant | VARCHAR(3) | Dust protection | Yes, No | BIT converted to Yes/No |
| Is_Splash_Resistant | VARCHAR(3) | Splash protection | Yes, No | BIT converted to Yes/No |
| Water_Resistance | VARCHAR(100) | Water protection details | IP68, IP67, IPX8 | LTRIM/RTRIM applied |
| IP_Rating | VARCHAR(50) | Ingress Protection rating | IP68, IP67, IP53, None | LTRIM/RTRIM applied |
| AI_Features | VARCHAR(500) | AI capabilities | AI Camera, AI Assistant, Scene Detection | LTRIM/RTRIM applied |
| Extra_Features | VARCHAR(1000) | Additional features | Wireless DeX, MagSafe, Smart Connector | LTRIM/RTRIM applied |
| Additional_Info | VARCHAR(1000) | Miscellaneous information | Various additional details | LTRIM/RTRIM applied |

**Notes:**
- Sensors field contains comprehensive list of all sensors
- Water_Resistance and IP_Rating may overlap or provide different detail levels
- GPS may include multiple satellite navigation systems

---

## Pricing Information

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Current_Price | DECIMAL(10,2) | Current market price | 49999.00, 79999.00, 15999.00 | Original numeric value |
| Price_Drop_Amount | DECIMAL(10,2) | Absolute discount | 5000.00, 8000.00 | Original numeric value |
| Price_Drop_Percentage | DECIMAL(5,2) | Discount percentage | 10.00, 15.50, 20.00 | Original numeric value |
| Original_Price | DECIMAL(10,2) | Launch price (calculated) | 54999.00, 87999.00 | Current_Price + Price_Drop_Amount |

**Notes:**
- All prices in local currency (typically INR for Smartprix)
- Original_Price calculated field: adds current price and drop amount
- NULL prices indicate pricing information not available
- Price_Drop fields NULL if no discount present

**Calculation Formula:**
```sql
Original_Price = Current_Price + Price_Drop_Amount
```

---

## Metadata

| Column Name | Data Type | Description | Example Values | Transformation Applied |
|-------------|-----------|-------------|----------------|----------------------|
| Last_Modified_Date | DATETIME | Last update timestamp | 2024-11-15 10:30:00 | Original timestamp |
| In_The_Box | VARCHAR(500) | Package contents | Phone, Charger, USB Cable, Case | LTRIM/RTRIM applied |
| SAR_Value | VARCHAR(100) | Specific Absorption Rate | 0.99 W/kg (head), 1.15 W/kg (body) | LTRIM/RTRIM applied |
| Related_Items | VARCHAR(1000) | Related product links | Other variants, accessories | LTRIM/RTRIM applied |

**Notes:**
- Last_Modified_Date reflects when record was last updated in source
- SAR_Value important for radiation exposure information
- In_The_Box varies by region and manufacturer

---

## Data Quality Summary

### Transformation Statistics
- **Total Columns**: 120+
- **Text Columns Cleaned**: 80+ (LTRIM/RTRIM applied)
- **Numeric Extractions**: 15+ fields
- **Boolean Conversions**: 20+ fields (BIT → Yes/No)
- **Date Parsing**: 1 field with year/month extraction
- **Calculated Fields**: 1 (Original_Price)

### Common Data Patterns

**NULL Values:**
- Indicate information not available or not applicable
- Common in: benchmark scores, optional features, older devices

**Comma-Separated Lists:**
- Found in: colors, camera features, sensors, audio/video formats
- Can be parsed for detailed analysis

**Unit Standardization:**
- Weight: All in grams
- Display: All in inches
- Battery: All in mAh
- Memory: All in GB
- Screen ratio: All in percentages

### Data Type Summary

| Data Type | Count | Primary Use |
|-----------|-------|-------------|
| VARCHAR | ~90 | Text descriptions, specifications |
| DECIMAL | ~10 | Prices, measurements, ratios |
| INT | ~8 | Counts, scores, capacities |
| DATE | 1 | Release date |
| DATETIME | 1 | Last modified timestamp |

---

## Usage Examples

### Filtering by Specifications
```sql
-- Find 5G phones with 12GB RAM under 50000
SELECT Brand, Model, Current_Price, RAM_GB
FROM mobiles_cleaned
WHERE Has_5G = 'Yes' 
  AND RAM_GB >= 12
  AND Current_Price < 50000;
```

### Aggregation Analysis
```sql
-- Average price by brand for 2024 releases
SELECT Brand, AVG(Current_Price) as Avg_Price
FROM mobiles_cleaned
WHERE Release_Year = 2024
GROUP BY Brand
ORDER BY Avg_Price DESC;
```

### Feature Comparison
```sql
-- Compare water resistance across brands
SELECT Brand, 
       IP_Rating,
       COUNT(*) as Model_Count
FROM mobiles_cleaned
WHERE IP_Rating IS NOT NULL
GROUP BY Brand, IP_Rating;
```

---

**Document Version**: 1.0  
**Last Updated**: November 2024  
**Dataset Version**: Cleaned Smartprix Mobile Phones Dataset