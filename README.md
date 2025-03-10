# GWR Downscaling of ERA5-Land using RSAGA

This repository contains an automated workflow for **downscaling ERA5-Land hourly data** using **Geographically Weighted Regression (GWR)** in R with **RSAGA** and Python. The workflow enhances the spatial resolution of meteorological variables using high-resolution **Digital Elevation Models (DEM)** as predictors.

## 📌 Features
- **Extracts and processes ERA5-Land data** (hourly resolution) from NetCDF format.
- **Uses DEM as a predictor** for downscaling variables like temperature, precipitation, and humidity.
- **Applies Geographically Weighted Regression (GWR)** for high-resolution spatial interpolation.
- **Exports results in raster format (GeoTIFF)**.

---

## 🔥 Workflow Overview

### **1️⃣ Preprocessing DEM & Administrative Boundaries (R)**
- Loads multiple **GeoTIFF DEM tiles** and merges them into a single raster.
- Downloads and extracts **administrative boundaries** (Peru, La Libertad).
- Clips and masks the DEM using the selected region.
- Saves the processed **DEM and shapefile**.

### **2️⃣ ERA5-Land Data Processing (Python)**
- Loads ERA5-Land **hourly NetCDF files**.
- Clips and projects the data to match the DEM.
- Converts units:
  - Kelvin → Celsius (temperature)
  - Pa → kPa (surface pressure)
  - Computes wind speed at 2m.
- Computes **daily meteorological variables**:
  - Precipitation (daily sum)
  - Temperature max/min
  - Relative Humidity (RH)
  - Evapotranspiration (ETo, FAO-56)
- Saves results as **NetCDF and GeoTIFF**.

### **3️⃣ Downscaling Using GWR in RSAGA (R)**
- Uses **RSAGA** to apply **Geographically Weighted Regression (GWR)**.
- Uses DEM as a predictor to refine the resolution of meteorological variables.
- Generates downscaled rasters for:
  - **Temperature, Precipitation, ETo, Relative Humidity, Wind Speed**.
- Saves downscaled outputs as **GeoTIFF**.

---

## 🚀 Installation

### **Required Software**
- **R** (≥4.0) + RStudio
- **Python** (≥3.8)
- **SAGA GIS** (≥8.0)  
  _Ensure SAGA is installed at:_ `C:/Program Files/SAGA`

### **Required R Packages**
```r
install.packages(c("terra", "sf", "dplyr", "rgeoboundaries", "RSAGA", "glue", "purrr"))
```
### **Required Python Packages**
```
pip install xarray rioxarray geopandas numpy rasterio
```

