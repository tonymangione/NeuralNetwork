# Red neuronal de autoregresión

# Buscamos la Librerias
library(forecast)
library(ggplot2)

# Convertimos a Serie de tiempos
demanda <- ts(AZUCAR_DIA$`AZUCAR BLANCO X 2500 G`)

# Usamos la funcion nnetar del paquete forecast
mod_rn <- nnetar(demanda)
mod_rn # en la consola vemos que se ha generado un modelo RN que utiliza los ultimos 22 puntos y tiene 12 neuronasen su capa oculta

# Hacemos un análisis de los errores
checkresiduals(mod_rn)

# Hacemosle forecast
for_rn <- forecast(mod_rn, h=14, PI=TRUE) # 14 periodos ene l futuro y ponemos PI para ver los intervamos de confianza
summary(for_rn)

# Hacemosla grafica
autoplot(for_rn)+autolayer(fitted(for_rn))

# Podemos agregar datos externos, tal como dias festivos. Para esto agregamos un vector
# Esto se encuentra en la columna FESTIVO de los datos. Con xreg indicamos que tenemos un regresor externo
mod_rn <- nnetar(demanda, xreg = AZUCAR_DIA$FESTIVO)
checkresiduals(mod_rn)
for_rn <- forecast(mod_rn, h=14, xreg = c(0,0,0,0,0,1,0,0,0,0,0,0,0,0))
for_rn
autoplot(for_rn)+autolayer(fitted(for_rn))
