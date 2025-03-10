# Cargar librerías necesarias
library(terra)            # Manejo de rasters
library(sf)               # Manejo de shapefiles
library(dplyr)            # Manipulación de datos
library(rgeoboundaries)   # Descarga de límites administrativos

# 📌 1. Definir carpeta donde están los archivos TIF
tif_folder <- "D:/TIFS/ASTGTM_003-20250309_171438"

# 📌 2. Listar todos los archivos .tif en la carpeta
tif_files <- list.files(tif_folder, pattern = "\\.tif$", full.names = TRUE)

# 📌 3. Leer y unir los archivos TIF en un solo mosaico
mosaico <- do.call(merge, lapply(tif_files, rast))

# 📌 4. Descargar los límites administrativos de nivel 1 para Perú
peru_departamentos <- rgeoboundaries::gb_adm1("PER")

# 📌 5. Filtrar solo el departamento de La Libertad (evitando problemas con espacios y mayúsculas)
nombre_departamento <- "La Libertad"
la_libertad_sf <- peru_departamentos %>%
  dplyr::filter(tolower(trimws(shapeName)) == tolower(nombre_departamento))

# 📌 6. Convertir el shapefile de La Libertad a SpatVector para compatibilidad con terra
la_libertad_vect <- vect(la_libertad_sf)

# 📌 7. Recortar y enmascarar el raster con el shapefile de La Libertad
mosaico_recortado <- crop(mosaico, la_libertad_vect)  # Recorta el área
mosaico_final <- mask(mosaico_recortado, la_libertad_vect)  # Aplica máscara

# 📌 8. Guardar el raster final
writeRaster(mosaico_final, "D:/TIFS/mosaico_la_libertad.tif", overwrite = TRUE)

# 📌 9. Guardar el shapefile de La Libertad
ruta_shapefile <- "D:/TIFS/la_libertad.shp"
st_write(la_libertad_sf, ruta_shapefile, driver = "ESRI Shapefile", delete_layer = TRUE)

# 📌 10. Visualizar el resultado
plot(mosaico_final)

# 📌 10. Mensaje final
cat("✅ Proceso completado. El raster recortado se ha guardado en 'D:/TIFS/mosaico_la_libertad.tif' 🎉")
