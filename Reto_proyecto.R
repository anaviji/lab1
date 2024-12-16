rm(list = ls())
# Paso 1: configuración inicial
energia <-c(rep("Renovable", 10), rep("No renovable", 10))
consumo <- c(9, 8, 9.5, 9, NA, 8.5, 8, 7.5, 8.5, 7, 7.5, 9, 9.5, NA, 9, 8.5, 9, 9.5, NA, 8)
costo_kwh <- c(rep(0.08, 10), rep(0.15, 10))

# Paso 2: limpieza de datos
sum(is.na(consumo))
consumo[is.na(consumo)] <- median(consumo, na.rm = T)

# Paso 3: creación del dataframe
df_consumo <- data.frame(tipo_energia=energia, consumo_diario=consumo, costo=costo_kwh)

# Paso 4: cálculos
## Agrega una columna llamada costo_total que calcule el costo diario (consumo * costo por kWh).
df_consumo$coste_total <- df_consumo$consumo_diario*df_consumo$costo

## Calcula el total de consumo y el costo total por cada tipo de energía (renovable y no renovable).
consumo_total_renovable <- sum(subset(df_consumo, df_consumo$tipo_energia=='Renovable')$consumo_diario)
consumo_total_no_renovable <- sum(subset(df_consumo, df_consumo$tipo_energia=='No renovable')$consumo_diario)
costo_total_renovable <- sum(subset(df_consumo, df_consumo$tipo_energia=='Renovable')$coste_total)
costo_total_no_renovable <- sum(subset(df_consumo, df_consumo$tipo_energia=='No renovable')$coste_total)

## Calcula la media del consumo diario para cada tipo de energía para analizar el consumo promedio.
consumo_medio_renovable <- mean(subset(df_consumo, df_consumo$tipo_energia=='Renovable')$consumo_diario)
consumo_medio_no_renovable <- mean(subset(df_consumo, df_consumo$tipo_energia=='No renovable')$consumo_diario)

## Agrega una columna llamada ganancia que multiplique el costo_total por 1.1 para simular un aumento de precio del 10%.
df_consumo$ganancia <- df_consumo$coste_total*1.1

# Paso 5: resumen
## Ordena el dataframe por la columna costo_total en orden descendente.
df_consumo <- df_consumo[order(df_consumo$coste_total, decreasing = T),]

## Calcula el total de consumo energético por tipo de energía (renovable y no renovable).
consumo_total_renovable <- sum(subset(df_consumo, df_consumo$tipo_energia=='Renovable')$consumo_diario)
consumo_total_no_renovable <- sum(subset(df_consumo, df_consumo$tipo_energia=='No renovable')$consumo_diario)

## Calcula el costo total por cada tipo de energía (renovable y no renovable).
costo_total_renovable <- sum(subset(df_consumo, df_consumo$tipo_energia=='Renovable')$coste_total)
costo_total_no_renovable <- sum(subset(df_consumo, df_consumo$tipo_energia=='No renovable')$coste_total)

## Extrae las tres filas con el mayor costo_total del dataframe ordenado y guárdalas en un nuevo dataframe llamado top_3_costos.
top_3_costos <- head(df_consumo, 3)

## Muestra la lista resumen_energia.
resumen_energia <- list(df_consumo, c(consumo_total_renovable, consumo_total_no_renovable), c(costo_total_renovable, costo_total_no_renovable), top_3_costos)
resumen_energia
